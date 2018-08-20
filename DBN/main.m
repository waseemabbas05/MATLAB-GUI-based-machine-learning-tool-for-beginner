%% Load Data and pass to function
clear;clc
addpath(genpath(pwd))
load('mnist.mat')
% Inputs=Inputs(12001:end,:);
% Targets=Targets(12001:end,:);
%%
addpath(genpath(pwd))
TrainTestSplit = 0.7; % 70% Training-Testing Split of data
BatchSize = 100; % batch learning
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
train_x=Inputs(Indices(1:end-NumTest),:);
train_y=Targets(Indices(1:end-NumTest),:);


if rem(size(train_x,1),BatchSize)~=0
    trl=floor(size(train_x,1)/BatchSize)*BatchSize;
    train_x=train_x(1:trl,:);
    train_y=train_y(1:trl,:);
end



test_x=Inputs(Indices(end-NumTest+1:end),:);
test_y=Targets(Indices(end-NumTest+1:end),:);

%%
NumEpochs=5; % number of Training Runs
% NumGroups=2; % Number of Target Groups

SizeMatrix=[ 100 100];
% size matrix for DBN; number of column represent number of layers (number
% of auto-encoder) while value of each column represent number of neurons
% in each layer 
% For sizeMatrix=[80 60 40 20 10 5], there are total 6 layers, number of
% neurons in 1st layer : 80, 2nd layer : 60, 3rd layer : 40, 4th layer : 20
% 5th layer : 10, 6th layer : 5
% It is to be noted that number of neurons in input layer are equal to
% number of features, and number of neurons in output layer is equal to
% number of output (classes)
%%
tic
[TrainedDBN,Expected,Actual,TrainingAccuracy,TrainError] = createAndTrainDBN(train_x, train_y, SizeMatrix,BatchSize, TrainTestSplit,NumEpochs);
T=toc
%%

[Accuracy,Actual,Expected]=testDBN(TrainedDBN,test_x,test_y);

%%
t=zeros(length(unique(Expected)),length(Expected));
y=zeros(length(unique(Expected)),length(Expected));
ue=unique(Expected);
for i=1size(t,1)
    t(i,find(Expected==ue(i)))=1;
    y(i,find(Actual==ue(i)))=1;
end



conMat=confusionmat(t(1,:),y(1,:));

labels=[];
for j=1:length(ue)
    labels=[labels {['class' num2str(j)]}];
end
heatmap(conMat, labels, labels, 1,'Colormap','red','ShowAllTicks',1,'UseLogColorMap',true,'Colorbar',true);
% hObject    handle to TrainNetwork (see GCBO)
plotconfusion(t,y)