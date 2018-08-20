%%
clear;clc
load('D:\ML Toolbox\Benchmark Codes\Data\ProfLeeData.mat')

TrainTestSplit = 0.7; % 70% Training-Testing Split of data

NumTest=round(size(Inputs,1)*(1-TrainTestSplit));
Indices=randperm(size(Inputs,1));

% if size(Targets,2)<2
%     ut=unique(Targets);
%     Targets1=Targets;
%     Targets=zeros(size(Targets1,1),length(ut));
%     for i=1:length(ut)
%         Targets(find(Targets1==ut(i)),i)=1;
%     end
% end
train_x=Inputs(Indices(1:end-NumTest),:);
train_y=Targets(Indices(1:end-NumTest),:);





test_x=Inputs(Indices(end-NumTest+1:end),:);
test_y=Targets(Indices(end-NumTest+1:end),:);

tic
[naivebayes] = naive_bayes_train(train_x, train_x)
t=toc
%%
[Predicted, Precision, Recall, Accuracy,F1] = naive_bayes_test(naivebayes,test_x,test_y);
%%

X=Train_X;
Y=textread('labels.txt');
naive_bayes_demo(X,Y)

%%
clear;clc
load('demoData2.mat')
Ind=randperm(size(Inputs,1));
N=5000;
Train_X=Inputs(Ind(1:N),1:15);
Train_Y=Targets(Ind(1:N),:);
%%
[naivebayes] = naive_bayes_train(Train_X,Train_Y)
[Predicted, Precision, Recall, Accuracy] = naive_bayes_test(naivebayes,Inputs(Ind(N+1:end),1:15),Targets(Ind(N+1:end),:));