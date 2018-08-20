function [cnn , error2]= cnntrain(cnn, Train_X, Train_Y, opts)
%CNNTRAIN Trains a CNN.
%
%  The CNN should already be set up (parameters created and initialized)
%  using the 'cnnsetup' function.
%%
    % 'm' is the number of training examples.
    M = size(Train_X, 3);
    
    % Calculate the number of batches.
    NumBatches = M / opts.batchsize;
    
    % Assert that the batch size divides evenly into the number of training
    % examples.
    if rem(NumBatches, 1) ~= 0
        error('numbatches not integer');
    end
    
    cnn.rL = [];
    
    % For each of the training epochs (one training epoch is one pass over
    % the dataset)...
    %%
    Total=NumBatches*opts.numepochs;
    K=1;
    h = waitbar(0,'Training...');
    for i = 1 : opts.numepochs

        % Print the current epoch.
        disp(['epoch ' num2str(i) '/' num2str(opts.numepochs)]);
        
        % Create a row vector containing the values 1 to 'm' in random 
        % order. We'll use these as indeces to take the training examples 
        % in random order.
        %
        % Note that we'll be using a different random order for each epoch.
        KK = randperm(M);
        %%
        % For each batch...

        for l = 1 : NumBatches
            %%
            % Select the training examples for the current batch. Use the
            % randomly sorted indeces in 'kk'. 
            Batch_X = Train_X(:, :, KK((l - 1) * opts.batchsize + 1 : l * opts.batchsize));
            Batch_Y = Train_Y(:,    KK((l - 1) * opts.batchsize + 1 : l * opts.batchsize));
%%
            % Perform a feed-forward evaluation of the current network on
            % the training batch. This will populate all of the output
            % variables in the 'net' structure.
            [cnn ,Out]= cnnff(cnn, Batch_X);
            
            % Calculate gradients using back-propagation.
            cnn = cnnbp(cnn, Batch_Y,Out);
            
            % Update the parameters by applying the gradients.
            cnn = cnnapplygrads(cnn, opts);
            
            if isempty(cnn.rL)
                cnn.rL(1) = cnn.L;
            end
            error1(l)=cnn.L;
            % Append a new loss value.
            % net.L only holds the mean-squared error for this batch.
            % We don't know the exact loss over the full training set...
            cnn.rL(end + 1) = 0.99 * cnn.rL(end) + 0.01 * cnn.L;
            waitbar(K/Total,h,sprintf('%s',[num2str(round(100*(K-1)/Total)) ' % , Epoch ' num2str(i) '/' num2str(opts.numepochs)]))
            K=K+1;
            
        end
	error2(i)=mean(error1);
    end

    
end
