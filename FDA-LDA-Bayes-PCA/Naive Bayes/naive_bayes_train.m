% Naive Bayes Classifier Training
% Inputs Train_X : Training inputs (N * p , N being the number of instances, p being number of features)
%        Train_Y : Training targets (N * c for binary class coding or N * 1 for multilabel coding)
%
% Outputs naiebayes : naive bayesian classifer
%
% example Train_X=rand(100,20);
%         Train_Y=round(rand(100,1));
%         naivebayes=naive_bayes_train(Train_X,Train_Y);

function [naivebayes] = naive_bayes_train(Train_X, Train_Y)

if size(Train_Y,2)==1
    Uy=unique(Train_Y);
    NumClasses=length(Uy);
else
    NumClasses=size(Train_Y,2);
    for i=1:NumClasses
        Tr(find(Train_Y(:,i)==1),1)=i;
    end
    Train_Y=Tr;
end
%%

N=round(size(Train_X,1)*.8);
Indices=randperm(size(Train_X,1));
CrossVal_X=Train_X(Indices(N+1:end),:);
CrossVal_Y=Train_Y(Indices(N+1:end),:);

Train_X=Train_X(Indices(1:N),:);
Train_Y=Train_Y(Indices(1:N),:);

Likelihood_Matrix = zeros(NumClasses, size(Train_X,2));
Priors = zeros(NumClasses, 1);
Evidence = zeros(size(Train_X,2), 1);
%%
K = 0.0;
K_values = [0.01, 0.03, 0.1, 0.3, 1, 3, 10, 30];
Accuracy=0;
for i=1:length(K_values)
    for Class=1:NumClasses
        Fm = Train_X(find(Train_Y == Class), :);
        
        % calc and store likelihoods
        Likelihoods = (sum(Fm,1) + K) ./ (size(Fm,1) + K * size(Train_X,2)); % laplacan smoothing
        Likelihood_Matrix(Class, :) = Likelihoods;
        
        % calc and store priors
        Priors(Class) = (size(Fm,1) + K) / (size(Train_X,1) + K*NumClasses); % laplactian smoothing
    end
    
    % calc evidences
    Evidence = ( (sum(Train_X,1)+K) ./ (size(Train_X,1)+K*2) )'; % laplacian smoothing
    
    naivebayes.Likelihood_Matrix=Likelihood_Matrix;
    naivebayes.Priors=Priors;
    naivebayes.Evidence=Evidence;
    
    [Crossval_predicted_classes, Crossval_posteriors] = naive_bayes_classify(naivebayes,CrossVal_X);
    C_Accuracy = sum(Crossval_predicted_classes == CrossVal_Y)/length(CrossVal_Y)*100.0;
    
    if C_Accuracy>Accuracy
        Accuracy = C_Accuracy;
        K = K_values(i);
        Likelihood_Matrix = Likelihood_Matrix;
        Priors = Priors;
        Evidence = Evidence;
    end
    
end
naivebayes.Likelihood_Matrix=Likelihood_Matrix;
naivebayes.Priors=Priors;
naivebayes.Evidence=Evidence;
end
