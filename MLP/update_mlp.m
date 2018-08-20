function [mlp] = update_mlp(mlp, Inputs, Targets)
% this function is called once for every pattern presentation, weights are
% updated every time, which is the magical step.

% this holds the activation of every neuron in every layer
    Activations = cell(length(mlp.weights)+1,1);
    Activations{1} = Inputs;
    
    % this loop calculates the activations of all the neuron layers
    for i = 1:length(mlp.weights)
        % activations{i} is a row vector
        % model.weights{i} is a matrix of weights
        % the output of that product is a row vector of length equal to the
        % number of neurons in the next layer
        temp = Activations{i} * mlp.weights{i} + mlp.biases{i}; 
        Activations{i+1} = 1./(1+exp(-(temp))); % squash the output a bit
    end
%%
    % variable for holding the errors at each level
    Errors = cell(length(mlp.weights),1);
    
    % this code propagates the error back through the neural net
    RunError = (Targets - Activations{end}); %keeps track of the error at each loop
    for i = length(mlp.weights):-1:1
        Errors{i} = Activations{i+1} .* (1-Activations{i+1}) .* (RunError);
        RunError = Errors{i} * mlp.weights{i}';
    end
    %%
    % this code updates the weights and biases
    for i = 1:length(mlp.weights)
        % update weights based on the learning rate, the input activation
        % and the error
        mlp.weights{i} = mlp.weights{i} + mlp.learning_rate * Activations{i}' * Errors{i};
        % update the neuron biases as well
        mlp.biases{i} = mlp.biases{i} + mlp.learning_rate * Errors{i};
        % it takes a while to figure out all the matrix operations, but
        % once it's done it's nice.
    end
end