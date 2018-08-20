%%
clear;clc;close all;
load('D:\ML Toolbox\Benchmark Codes\Data\ProfLeeData.mat')

Inputs=abs(Inputs);

Class1i=find(Targets==1);
Class2i=find(Targets==2);

N1=length(Class1i);
N2=length(Class2i);

N=min([N1 N2]);
NumTest=round(N*0.7);

Ind=randperm(2*N);
Inputs1=[Inputs(Class1i(1:N),:);Inputs(Class2i(1:N),:)];
Targets1=[Targets(Class1i(1:N),:);Targets(Class2i(1:N),:)];
%%
Train_X=Inputs1(Ind(1:end-NumTest),:);
Train_Y=Targets1(Ind(1:end-NumTest),:);

Test_X=Inputs1(Ind(end-NumTest+1:end),:);
Test_Y=Targets1(Ind(end-NumTest+1:end),:);

%%
options=optimset('MaxIter',1000000,'Display','iter','TolFun',.001);
options.StopCrit=0.01;
options.RBF_Sigma= 0.9;
options.PolynomialOrder=6;
options.Method='SMO';
options.KernelFunction='linear';
tic
[models] = multisvmtrain(Train_X,Train_Y,options);
t=toc
%%
[Predicted,Actual, Accuracy]=multisvmtest(Train_X,Train_Y,models);
Accuracy
%%
[Predicted,Actual, Accuracy]=multisvmtest(Test_X,Test_Y,models);
Accuracy