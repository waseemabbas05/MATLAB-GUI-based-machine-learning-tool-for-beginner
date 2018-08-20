%%
clear;clc
load('D:\ML Toolbox\Master GUI\FDA-LDA-Bayes-PCA\mnist.mat')
%%
TrainTestSplit=0.02;
Hidden = [100 50 20];
MaxIterations = 100;  
LearningRate = 0.1;
Momentum = 0.1;
Tolerance=.001;
%%
Total=size(Targets,1);
TrainLength=round(TrainTestSplit*Total);
RandInd=randperm(Total);

TrainInputs=Inputs(RandInd(1:TrainLength),:);
TrainTargets=Targets(RandInd(1:TrainLength),:);

TestInputs=Inputs(RandInd(TrainLength+1:end),:);
TestTargets=Targets(RandInd(TrainLength+1:end),:);

%%
% initialize and train the model
for i=1:10
tic
[mlp mse] = train_mlp(TrainInputs, TrainTargets, Hidden, MaxIterations, LearningRate, Momentum,Tolerance);
t(i)=toc
end
mean(t)
% test the model on the independent test set
% output is the output of the model, and the cross correlation of the
%%
[TrainOutputs TrainCorr] = test_mlp(mlp, TrainInputs, TrainTargets);

% estimate class from the output as the unit of maximal activation
[jnk TrainClass] = max(TrainTargets'); % for the traianing data
[jnk EstClass] = max(TrainOutputs');      % the decision of the model
[jnk TrueClass] = max(TrainTargets');
[NTrain NClasses] = size(TrainTargets);
ClassificationErrors = TrueClass ~= EstClass;
PercentCorrect_Train = 100 * (1 - sum(ClassificationErrors) / NTrain)

confusion = zeros(NClasses);
for i = 1:NTrain
    confusion(TrueClass(i), EstClass(i)) = confusion(TrueClass(i), EstClass(i)) + 1;
end
TrainConfusion=confusion;
%%
% output to the target output
[TestOutputs TestCorr] = test_mlp(mlp, TestInputs, TestTargets);

% estimate class from the output as the unit of maximal activation
[jnk TrainClass] = max(TrainTargets'); % for the traianing data
[jnk TrueClass] = max(TestTargets');   % for the testing data
[jnk EstClass] = max(TestOutputs');      % the decision of the model

[NTest NClasses] = size(TestTargets);
ClassificationErrors = TrueClass ~= EstClass;
PercentCorrect_Test = 100 * (1 - sum(ClassificationErrors) / NTest)

confusion = zeros(NClasses);
for i = 1:NTest
    confusion(TrueClass(i), EstClass(i)) = confusion(TrueClass(i), EstClass(i)) + 1;
end
TestConfusion=confusion;
