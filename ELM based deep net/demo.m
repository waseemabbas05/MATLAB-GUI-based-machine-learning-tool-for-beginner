%%
clear;clc;
rand('state',0)
load('D:\ML Toolbox\Datasets\handWrittenCharactersData.mat')
%%
TrainTestSplit = 0.5; % 70% Training-Testing Split of data
BatchSize = 1000; % batch learning
NumTest=round(size(Inputs,1)*(1-TrainTestSplit));
Indices=randperm(size(Inputs,1));
NumTest=round(size(Inputs,1)*(1-TrainTestSplit));
Indices=randperm(size(Inputs,1));

if size(Targets,2)<2
    Ut=unique(Targets);
    Targets1=Targets;
    Targets=zeros(size(Targets1,1),length(Ut));
    for i=1:length(Ut)
        Targets(find(Targets1==Ut(i)),i)=1;
    end
end
Train_X=Inputs(Indices(1:end-NumTest),:);
Train_Y=Targets(Indices(1:end-NumTest),:);


Test_X=Inputs(Indices(end-NumTest+1:end),:);
Test_Y=Targets(Indices(end-NumTest+1:end),:);
Activation_Function='sigmoid';
Size_Matrix=[500 1000 2000];
Num_Epochs=30;
%%
tic
[stack,Training_Accuracy,Actual,Expected] = helm_train(Train_X,Train_Y,Size_Matrix,Num_Epochs,Activation_Function);
t=toc
%%
[Actual, Testing_Accuracy, Expected] = helm_test(Test_X, Test_Y, stack,Activation_Function);