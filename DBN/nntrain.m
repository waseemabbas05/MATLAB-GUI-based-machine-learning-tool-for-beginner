function [nn, L,TrainError]  = nntrain(nn, train_x, train_y, opts, val_x, val_y)
%NNTRAIN trains a neural net
% [nn, L] = nnff(nn, x, y, opts) trains the neural network nn with input x and
% output y for opts.numepochs epochs, with minibatches of size
% opts.batchsize. Returns a neural network nn with updated activations,
% errors, weights and biases, (nn.a, nn.e, nn.W, nn.b) and L, the sum
% squared error for each training minibatch.

assert(isfloat(train_x), 'train_x must be a float');
% assert(nargin == 4 || nargin == 6,'number ofinput arguments must be 4 or 6')

loss.train.e               = [];
loss.train.e_frac          = [];
loss.val.e                 = [];
loss.val.e_frac            = [];
opts.validation = 0;
if nargin == 6
    opts.validation = 1;
end

fhandle = [];
if isfield(opts,'plot') && opts.plot == 1
    fhandle = figure();
end

m = size(train_x, 1);

Batchsize = opts.batchsize;
NumEpochs = opts.numepochs;

NumBatches = m / Batchsize;

assert(rem(NumBatches, 1) == 0, 'numbatches must be a integer');

L = zeros(NumEpochs*NumBatches,1);
n = 1;

%%
h = waitbar(0,'Training...');
MaxIterations=NumEpochs*NumBatches;
k=1;
for i = 1 : NumEpochs
    
    
    kk = randperm(m);
    for l = 1 : NumBatches
        batch_x = train_x(kk((l - 1) * Batchsize + 1 : l * Batchsize), :);
        
        %Add noise to input (for use in denoising autoencoder)
        %         if(nn.inputZeroMaskedFraction ~= 0)
        %             batch_x = batch_x.*(rand(size(batch_x))>nn.inputZeroMaskedFraction);
        %         end
        
        batch_y = train_y(kk((l - 1) * Batchsize + 1 : l * Batchsize), :);
        
        % forward (input) propagation pass (Input is passed through thr network)
        nn = nnff(nn, batch_x, batch_y);
        
        % Errors are propagated backward towards the input layer
        nn = nnbp(nn);
        
        % resulting error gradient is being applied to weights of layers
        nn = nnapplygrads(nn);
        
        L(n) = nn.L;
        
        n = n + 1;
        
        k=NumBatches*(i-1)+l;
        waitbar(k/MaxIterations,h,sprintf('%s',[num2str(100*(k-1)/MaxIterations) ' % backpropagation done']))
    end
    
    
    
    if opts.validation == 1
        loss = nneval(nn, loss, train_x, train_y, val_x, val_y);
        str_perf = sprintf('; Full-batch train mse = %f, val mse = %f', loss.train.e(end), loss.val.e(end));
    else
        loss = nneval(nn, loss, train_x, train_y);
        str_perf = sprintf('; Full-batch train err = %f', loss.train.e(end));
    end
    if ishandle(fhandle)
        nnupdatefigures(nn, fhandle, loss, opts, i);
    end
    TrainError(i)=loss.train.e(end);
    disp(['epoch ' num2str(i) '/' num2str(opts.numepochs) '. Mini-batch mean squared error on training set is ' num2str(nanmean(L((n-NumBatches):(n-1)))) str_perf]);
    nn.learningRate = nn.learningRate * nn.scaling_learningRate;

end
close (h)
end

