% Naive Bayes Testing
% Inputs 
%        naivebayes : Trained Naive Bayesian Classifier structure
%        X : Input Data to be tested
%        Y : True labels of Input Data X
% Outputs 
%         Predicted: Predicted labels for Test Inputs
%         Precision: Fraction of class labels retrieved that are relevant. Range [0 100]
%         Recall: Fraction of relevant class labels that are retrieved. Range [0 100]
%         Accuracy: Fraction of correctly classified labels. Range [0 100] 

function [Predicted, Precision, Recall, Accuracy,F1] = naive_bayes_test(naivebayes,X,Y)
%%
if size(Y,2)==1
    Uy=unique(Y);
    NumClasses=length(Uy);
    Ya=Y;
elseif size(Y,2)==2
    Ya=Y(:,1);
    NumClasses=size(Y,2);
else
    NumClasses=size(Y,2);
    for i=1:NumClasses
        Ya(find(Y(:,i)==1),1)=i;
    end
end
if min(Ya)==0&max(Ya)==1
    Ya(Ya==0)=2;
end
clear Uy i 

%%
[Predicted, Posteriors] = naive_bayes_classify(naivebayes,X);
Actual=Ya;
Up=unique(Predicted);
Uy=unique(Ya);

%%
if nargin<3
    Precision=NaN;
    Recall=NaN;
    Accuracy=NaN;
    F1=NaN;
else
    %%
    if NumClasses==2
        U=unique(Actual);
        Tp= sum( (Actual==U(1)) & (Predicted==U(1)) );
        Fn= sum( (Actual==U(1)) & (Predicted~=U(1)) );
        Fp= sum( (Actual~=U(1)) & (Predicted==U(1)) );
        Tn= sum( (Actual~=U(1)) & (Predicted~=U(1)) );
        Precision=abs(100*Tp/(Tp+Fp));
        Recall=abs(100*Tp/(Tp+Fn));
        E=Actual-Predicted;
        Accuracy=length(find(E==0))/length(Predicted);
        Accuracy=100*Accuracy;
        F1=2*Precision*Recall/(Precision+Recall);
    else
        Tp=0;Fp=0;Tn=0;Fn=0;
        U=unique(Actual);
        for i=1:NumClasses
            Tp= Tp+sum( (Actual==U(i)) & (Predicted==U(i)) );
            Fn= Fn+sum( (Actual==U(i)) & (Predicted~=U(i)) );
            Fp= Fp+sum( (Actual~=U(i)) & (Predicted==U(i)) );
            Tn= Tn+sum( (Actual~=U(i)) & (Predicted~=U(i)) );
        end
        Precision=abs(100*Tp/(Tp+Fp));
        Recall=abs(100*Tp/(Tp+Fn));
        E=Actual-Predicted;
        Accuracy=length(find(E==0))/length(Predicted);
        Accuracy=100*Accuracy;
        F1=2*Precision*Recall/(Precision+Recall);
    end  
end

