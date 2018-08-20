%%=========================================================================
%%  Load the MNIST dataset
%%=========================================================================
clear;clc
load mnist_uint8;

train_x = double(reshape(train_x',28,28,60000))/255;
test_x = double(reshape(test_x',28,28,10000))/255;
train_y = double(train_y');
test_y = double(test_y');
%%
TrainTestSplit=0.7;
NumTest=round(size(Inputs,1)*(1-TrainTestSplit));
Indices=randperm(size(Inputs,1));

%%
Train_X=train_x;;
Train_Y=train_y;


Test_X=test_x;
Test_Y=test_y;

% [Train_X,n]  = shiftdim(Train_X,1);
% [Test_X,n]  = shiftdim(Test_X,1);
% 
% Train_Y=Train_Y';
% Test_Y=Test_Y';

%%=========================================================================
%%  Define and Train the CNN
%%=========================================================================

% Define the architecture of our CNN.
% Our CNN will have six layers: an input layer, 2 convolution layers,
% 2 subsampling (or "pooling") layers, and an output layer which performs
% the classification. 
% 
% The CNN will be stored in the structure 'cnn'. It will have a field 
% named 'layers' which is a cell array containing each of the five feature
% extraction layers of the CNN. The output layer parameters are stored 
% directly in the top level 'cnn' object rather than as another layer in 
% the 'layers' array.
%
% Each layer is defined by a structure with the following fields
%
%   'type' - The type of the layer: 
%              'i' for "input layer" 
%              'c' for "convolution layer"
%              's' for "subsampling layer" (or "pooling" layer)
%
%   For convolutional layers:
%     'outputmaps' - The number of features / filters to learn.
%     'kernelsize' - The size of the filter kernel.
%
%   For subsampling layers:
%     'scale'      - The factor by which to scale down the image.
%
cnn.layers = {
    struct('type', 'i') %input layer
    struct('type', 'c', 'outputmaps', 6, 'kernelsize', 5) %convolution layer
    struct('type', 's', 'scale', 2) %sub sampling layer
    struct('type', 'c', 'outputmaps', 12, 'kernelsize', 5) %convolution layer
    struct('type', 's', 'scale', 2) %subsampling layer
};

% Reset the seed generator. This will make your results reproducible.
rand('state', 0)

% Options for training.
% IMPORTANT: The number of epochs (passes over the training set) is
% important. 
%   - If you run just 1 epoch, it should only take a few minutes (~90 
%     seconds on my desktop) and get about 89% accuracy on the test set.
%   - If you run 100 epochs (about 2.5 hours on my desktop), you should get
%     about 98.8% on the test set.
opts.alpha = 1;
opts.batchsize = 100;
opts.numepochs = 10;
 
% Create all of the parameters for the network and randomly initialize
% them.
cnn = cnnsetup(cnn, Train_X, Train_Y);

fprintf('Training the CNN...\n');

startTime = tic();

% Train the CNN using the training data.
[cnn,error2] = cnntrain(cnn, Train_X, Train_Y, opts);

fprintf('...Done. Training took %.2f seconds\n', toc(startTime));

%%=========================================================================
%%  Test the CNN on the test set
%%=========================================================================

fprintf('Evaluating test set...\n');

% Evaluate the trained CNN over the test samples.
[er, bad] = cnntest(cnn, Train_X, Train_Y);

% Calculate the number of correctly classified examples.
numRight = size(Test_Y, 2) - numel(bad);

fprintf('Accuracy: %.2f%%\n', numRight / size(Test_Y, 2) * 100); 

% Plot mean squared error over the course of the training.
figure(1); 
plot(cnn.rL);
title('Mean Squared Error');
xlabel('Training Batch');
ylabel('Mean Squared Error');

% Verify the accuracy is at least 88%.
assert(er < 0.12, 'Too big error');
