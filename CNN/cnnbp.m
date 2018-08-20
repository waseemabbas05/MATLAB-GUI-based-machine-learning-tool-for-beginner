function cnn = cnnbp(cnn, Batch_Y,Out)
    N = numel(cnn.layers);

    %   error
    cnn.e = Out - Batch_Y;
    %  loss function
    cnn.L = 1/2* sum(cnn.e(:) .^ 2) / size(cnn.e, 2);

    %%  backprop deltas
    cnn.od = cnn.e .* (Out .* (1 - Out));   %  output delta
    cnn.fvd = (cnn.ffW' * cnn.od);              %  feature vector delta
    if strcmp(cnn.layers{N}.type, 'c')         %  only conv layers has sigm function
        cnn.fvd = cnn.fvd .* (cnn.fv .* (1 - cnn.fv));
    end

    %  reshape feature vector deltas into output map style
    Sa = size(cnn.layers{N}.a{1});
    Fvnum = Sa(1) * Sa(2);
    for j = 1 : numel(cnn.layers{N}.a)
        cnn.layers{N}.d{j} = reshape(cnn.fvd(((j - 1) * Fvnum + 1) : j * Fvnum, :), Sa(1), Sa(2), Sa(3));
    end

    for l = (N - 1) : -1 : 1
        if strcmp(cnn.layers{l}.type, 'c')
            for j = 1 : numel(cnn.layers{l}.a)
                cnn.layers{l}.d{j} = cnn.layers{l}.a{j} .* (1 - cnn.layers{l}.a{j}) .* (expand(cnn.layers{l + 1}.d{j}, [cnn.layers{l + 1}.scale cnn.layers{l + 1}.scale 1]) / cnn.layers{l + 1}.scale ^ 2);
            end
        elseif strcmp(cnn.layers{l}.type, 's')
            for i = 1 : numel(cnn.layers{l}.a)
                Z = zeros(size(cnn.layers{l}.a{1}));
                for j = 1 : numel(cnn.layers{l + 1}.a)
                     Z = Z + convn(cnn.layers{l + 1}.d{j}, rot180(cnn.layers{l + 1}.k{i}{j}), 'full');
                end
                cnn.layers{l}.d{i} = Z;
            end
        end
    end

    %%  calc gradients
    for l = 2 : N
        if strcmp(cnn.layers{l}.type, 'c')
            for j = 1 : numel(cnn.layers{l}.a)
                for i = 1 : numel(cnn.layers{l - 1}.a)
                    
                    Temp=cnn.layers{l - 1}.a{i};
                    for fi=1:ndims(Temp)
                        Temp = flipdim(Temp,fi);
                    end
                    
                    cnn.layers{l}.dk{i}{j} = convn(Temp, cnn.layers{l}.d{j}, 'valid') / size(cnn.layers{l}.d{j}, 3);
                    
                end
                cnn.layers{l}.db{j} = sum(cnn.layers{l}.d{j}(:)) / size(cnn.layers{l}.d{j}, 3);
            end
        end
    end
    cnn.dffW = cnn.od * (cnn.fv)' / size(cnn.od, 2);
    cnn.dffb = mean(cnn.od, 2);
end

function Y = rot180(X)
    Y = flipdim(flipdim(X, 1), 2);
end

