function [TrainedDBN,Expected,Actual,TrainingAccuracy,TrainError] = createAndTrainDBN(Train_X, Train_Y, SizeMatrix,BatchSize, TrainTestSplit,NumEpochs)
%%
NumGroups=size(Train_Y,2);
Train_X = double(Train_X);
Train_Y = double(Train_Y);

%%  initialize a deep network
display('Initializing deep network ..........')
rand('state',0)

dbn.sizes = SizeMatrix; 

% number of training runs
opts.numepochs =   NumEpochs;   

% batch size for training
opts.batchsize = BatchSize;

% parameters
opts.momentum  =   0;
opts.alpha     =   1;

%% DBN Setup
n = size(Train_X, 2);

% network size (number of neurons in each layer)
dbn.sizes = [n, dbn.sizes];

% setting individual auto encoder for each layer
for u = 1 : numel(dbn.sizes) - 1 % loop runs N times where N is number of layers
    
    % auto-encoders different parameters
    
    % learning rate
    dbn.rbm{u}.alpha    = opts.alpha;
    
    % momentum
    dbn.rbm{u}.momentum = opts.momentum;
    
    % initialize weights
    dbn.rbm{u}.W  = zeros(dbn.sizes(u + 1), dbn.sizes(u));
    dbn.rbm{u}.vW = zeros(dbn.sizes(u + 1), dbn.sizes(u));
    
    dbn.rbm{u}.b  = zeros(dbn.sizes(u), 1);
    dbn.rbm{u}.vb = zeros(dbn.sizes(u), 1);
    
    dbn.rbm{u}.c  = zeros(dbn.sizes(u + 1), 1);
    dbn.rbm{u}.vc = zeros(dbn.sizes(u + 1), 1);
end


%% train dbn
display('training deep network ..........')
% dbn = dbntrain(dbn, train_x, opts);
X=Train_X;
n = numel(dbn.rbm);

% train first layer on given inputs
dbn.rbm{1} = rbmtrain(dbn.rbm{1}, X, opts,1,1);

for i = 2 : n
    % output of previous layer (which will become input of current layer)
    %         x = rbmup(dbn.rbm{i - 1}, x);
    rbm=dbn.rbm{i - 1};
    TempH=X * rbm.W';
    Bias=repmat(rbm.c', size(X, 1), 1);
    TempH=TempH+Bias;
    X = 1./(1+exp(-TempH));
    % train current auto-coder layer with outputs of previous layer as
    % inputs
    dbn.rbm{i} = rbmtrain(dbn.rbm{i}, X, opts,i,n);
end


%% convert to multi-layer NN for final layer training through back-propgation
outputsize=size(Train_Y,2);
if(exist('outputsize','var'))
    NNSize = [dbn.sizes outputsize];
else
    NNSize = [dbn.sizes];
end
nn = nnsetup(NNSize);
for i = 1 : numel(dbn.rbm)
    nn.W{i} = [dbn.rbm{i}.c dbn.rbm{i}.W];
end


%% Fine Tune Network parameters by back propagation
nn.activation_function = 'sigm';
opts.numepochs =  NumEpochs;
opts.batchsize = BatchSize;

% train again as conventional neural network
[nn,L,TrainError] = nntrain(nn, Train_X, Train_Y, opts);
TrainedDBN=nn;


%% evaluate on test data
display('testing accuracy of deep network ..........')
Actual = nnpredict(nn, Train_X);
[dummy, Expected] = max(Train_Y,[],2);
bad = find(Actual ~= Expected);    
er = numel(bad) / size(Train_X, 1);
TrainingAccuracy=100*(1-er);
display(['Accuracy on train data is ' num2str(TrainingAccuracy) ' % for ' num2str(size(Train_Y,2)) ' class problem'])

