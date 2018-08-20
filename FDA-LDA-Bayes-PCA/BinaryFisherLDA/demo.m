% Copyright (C) 2010 Quan Wang <wangq10@rpi.edu>
% Signal Analysis and Machine Perception Laboratory
% Department of Electrical, Computer, and Systems Engineering
% Rensselaer Polytechnic Institute, Troy, NY 12180, USA

%% A demo showing how to use this package for binary classification
%    f: (n0+n1)*2 feature matrix, each row being a data point
%    l0: (n0+n1)*1 ground truth of binary label vector, each element being 0 or 1
%    l: (n0+n1)*1 resulting binary label vector, each element being 0 or 1
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

% Ind=randperm(size(Inputs,1));
% N=5000;
% Train_X=Inputs(Ind(1:N),:);
% Train_Y=Targets(Ind(1:N),:);

%%
tic
fisher=fisher_training(Train_X,Train_Y)
t=toc
%%
X=Test_X;
Actual=Test_Y;
[Predicted,Precision,Recall,Accuracy,F1]=fisher_testing(fisher,X,Actual,1);
Accuracy

