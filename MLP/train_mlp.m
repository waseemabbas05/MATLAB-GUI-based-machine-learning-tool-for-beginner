function [mlp MSE] = train_mlp(Inputs, Targets, Hidden, MaxIterations, LearningRate, Momentum,Tolerance)
    % this is the function that handles all the looping and running of the
    % neural network, it initializes the network based on the number of
    % hidden layers, and presents every item in the input over and over,
    % $iterations$ times.
    % hidden is the only complicated variables.  Like weka, it accepts a
    % list of values (as a row vector), and interprets it as the number of
    % neurons in each hidden layer, so [2 2 2] means there will be an input
    % layer defined by the size of the input, three hidden layers, with 2 
    % neurons each, and the output layer, defined by the target. 
    %
    % initialize the output
    mlp = [];
    mlp.learning_rate = LearningRate;
    mlp.momentum = Momentum; % for some heavy ball action

    % characterize the input and output
    [NTrain InLayer] = size(Inputs);
    [jnk OutLayer] = size(Targets);

    % keep track of how many neurons are in each layer
    NumNeurons = [InLayer Hidden OutLayer];
    NumNeurons(NumNeurons == 0) = []; % remove 0 layers, to allow putting a zero for no hidden layers

    % there are one fewer sets of weights and biases as total layers
    NumTransitions = length(NumNeurons)-1;
%%
    for i = 1:NumTransitions % initialize the weights between layers, and the biases (past the first layer)
        mlp.weights{i} = randn(NumNeurons(i),NumNeurons(i+1)); 
        % the weight matrix has X rows, where X is the number of input
        % neurons to the layer, and Y columns, where Y is the number of
        % output neurons.  multiplication of the input with the weight
        % matrix transforms the dimensionality of the input to that of the
        % output.  Initialization is done here randomly.
        mlp.biases{i} = randn(1,NumNeurons(i+1));
        % biases are random as well
        mlp.lastdelta{i} = 0;  
    end
    %%
    i=1;
    MSE=[1 1];
    h = waitbar(0,'Training...');
    while i <= MaxIterations | (MSE(i-1)>=Tolerance & i>5)% repeat the whole training set over and over
        order = randperm(NTrain);  % randomize the presentations
        for j = 1:NTrain
            % update_mlp is where the training is actually done
            mlp = update_mlp(mlp, Inputs(order(j),:), Targets(order(j),:));
        end
        [Outputs cc] = test_mlp(mlp, Inputs, Targets,0);
        Errors=Outputs-Targets;
        mse1(i)=sqrt(mean(mean(Errors.^2)));
        if i>1
            MSE(i)=abs(mse1(i)-mse1(i-1));
        end
        i=i+1;
%         waitbar(i/MaxIterations,h)
        waitbar(i/MaxIterations,h,sprintf('%s',[num2str(100*(i-1)/MaxIterations) ' %']))
    end
end
