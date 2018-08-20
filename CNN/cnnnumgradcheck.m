function cnnnumgradcheck(cnn, X, Y)
    Epsilon = 1e-4;
    Er      = 1e-8;
    n = numel(cnn.layers);
    for j = 1 : numel(cnn.ffb)
        Netm = cnn; Netp = cnn;
        Netp.ffb(j) = Netm.ffb(j) + Epsilon;
        Netm.ffb(j) = Netm.ffb(j) - Epsilon;
        Netm = cnnff(Netm, X); Netm = cnnbp(Netm, Y);
        Netp = cnnff(Netp, X); Netp = cnnbp(Netp, Y);
        d = (Netp.L - Netm.L) / (2 * Epsilon);
        E = abs(d - cnn.dffb(j));
        if E > Er
            error('numerical gradient checking failed');
        end
    end

    for i = 1 : size(cnn.ffW, 1)
        for u = 1 : size(cnn.ffW, 2)
            Netm = cnn; Netp = cnn;
            Netp.ffW(i, u) = Netm.ffW(i, u) + Epsilon;
            Netm.ffW(i, u) = Netm.ffW(i, u) - Epsilon;
            Netm = cnnff(Netm, X); Netm = cnnbp(Netm, Y);
            Netp = cnnff(Netp, X); Netp = cnnbp(Netp, Y);
            d = (Netp.L - Netm.L) / (2 * Epsilon);
            E = abs(d - cnn.dffW(i, u));
            if E > Er
                error('numerical gradient checking failed');
            end
        end
    end

    for l = n : -1 : 2
        if strcmp(cnn.layers{l}.type, 'c')
            for j = 1 : numel(cnn.layers{l}.a)
                Netm = cnn; Netp = cnn;
                Netp.layers{l}.b{j} = Netm.layers{l}.b{j} + Epsilon;
                Netm.layers{l}.b{j} = Netm.layers{l}.b{j} - Epsilon;
                Netm = cnnff(Netm, X); Netm = cnnbp(Netm, Y);
                Netp = cnnff(Netp, X); Netp = cnnbp(Netp, Y);
                d = (Netp.L - Netm.L) / (2 * Epsilon);
                E = abs(d - cnn.layers{l}.db{j});
                if E > Er
                    error('numerical gradient checking failed');
                end
                for i = 1 : numel(cnn.layers{l - 1}.a)
                    for u = 1 : size(cnn.layers{l}.k{i}{j}, 1)
                        for v = 1 : size(cnn.layers{l}.k{i}{j}, 2)
                            Netm = cnn; Netp = cnn;
                            Netp.layers{l}.k{i}{j}(u, v) = Netp.layers{l}.k{i}{j}(u, v) + Epsilon;
                            Netm.layers{l}.k{i}{j}(u, v) = Netm.layers{l}.k{i}{j}(u, v) - Epsilon;
                            Netm = cnnff(Netm, X); Netm = cnnbp(Netm, Y);
                            Netp = cnnff(Netp, X); Netp = cnnbp(Netp, Y);
                            d = (Netp.L - Netm.L) / (2 * Epsilon);
                            E = abs(d - cnn.layers{l}.dk{i}{j}(u, v));
                            if E > Er
                                error('numerical gradient checking failed');
                            end
                        end
                    end
                end
            end
        elseif strcmp(cnn.layers{l}.type, 's')

        end
    end
%    keyboard
end
