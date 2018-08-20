%%
clear;clc;
rand('state',0)
load('D:\ML Toolbox\Datasets\handWrittenCharactersData.mat')
%%
TrainTestSplit = 0.7; % 70% Training-Testing Split of data
BatchSize = 1000; % batch learning
NumTest=round(size(Inputs,1)*(1-TrainTestSplit));
Indices=randperm(size(Inputs,1));
NumTest=round(size(Inputs,1)*(1-TrainTestSplit));
Indices=randperm(size(Inputs,1));

if size(Targets,2)<2
    ut=unique(Targets);
    Targets1=Targets;
    Targets=zeros(size(Targets1,1),length(ut));
    for i=1:length(ut)
        Targets(find(Targets1==ut(i)),i)=1;
    end
end
Train_X=Inputs(Indices(1:end-NumTest),:);
Train_Y=Targets(Indices(1:end-NumTest),:);


Test_X=Inputs(Indices(end-NumTest+1:end),:);
Test_Y=Targets(Indices(end-NumTest+1:end),:);
Activation_Function='sigmoid';
Number_Of_Hidden_Neurons=500;
%%
tic
[elm,Actual,Expected,Training_Accuracy] = elm_train(Train_X,Train_Y, Number_Of_Hidden_Neurons, Activation_Function);
t=toc

%%
[Actual,Expected, TestingAccuracy] = elm_predict(elm,Test_X,Test_Y);
