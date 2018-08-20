%% The training of  Fisher's linear discriminant
% Inputs
%   fisher : Trained fisher pbject. A fisher object contains weights for
%   optimal one dimensional hyper plane and the separating threshold
%    X: N*p Input matrix, each row being a data point (N rows and p features)
%    Actual : Actual labels matrix of X N*M (binary coding for each row) or N*1 (actual class number as label) label vector
% Outputs 
%         Predicted: Predicted labels for Test Inputs
%         Precision: Fraction of class labels retrieved that are relevant. Range [0 100]
%         Recall: Fraction of relevant class labels that are retrieved. Range [0 100]
%         Accuracy: Fraction of correctly classified labels. Range [0 100] 
%         Actual : Actual labels matrix of X 
%         F1 : harmonic mean of precision and recall
function [Predicted,Precision,Recall,Accuracy,F1,Actual]=fisher_testing(fisher,X,Actual,display)

if size(Actual,2)==1
    Uy=unique(Actual);
    NumClasses=length(Uy);
    Ya=Actual;
elseif size(Actual,2)==2
    Ya=Actual(:,1);
    NumClasses=size(Actual,2);
else
    NumClasses=size(Actual,2);
    for i=1:NumClasses
        Ya(find(Actual(:,i)==1),1)=i;
    end
end
if min(Ya)==0&max(Ya)==1
    Ya(Ya==0)=2;
end
clear Uy i 

%%
Predicted=zeros(size(Actual,1),1);
if NumClasses==2
    W=fisher.W;
    Fp=X*W;
    Thresh=fisher.Thresh;
    Predicted((Fp>Thresh))=1;
    
else
    for i=1:NumClasses
        W=fisher.W{i};
        if iscell(W)==1
            W=cell2mat(W);
        end
        Fp=X*W;
        Thresh=fisher.Thresh(i);
        P=(Fp>Thresh);
        Predicted(find(P==1),1)=i-1;
    end
end
P=double(Predicted);
P(find(Predicted==0),:)=2;
Predicted=P;
clear P;
%%
A=Actual;
if size(A,2)==1
    A=ones(size(Actual,1),1);
    Ua=unique(Actual);
    for i=1:NumClasses
        A(find(Actual==Ua(i)),1)=i;
    end
    Actual=A;
else
    A=ones(size(Actual,1),1);
    for i=1:size(Actual,2)
        A(find(Actual(:,i)==1),1)=i;
    end
    Actual=A;
end
if size(Predicted,2)==1
    P=ones(size(Predicted,1),1);
    Up=unique(Actual);
    for i=1:NumClasses
        P(find(Predicted==Up(i)),1)=i;
    end
    Predicted=P;
else
    P=ones(size(Predicted,1),1);
    for i=1:size(Predicted,2)
        P(find(Predicted(:,i)==1),1)=i;
    end
    Predicted=P;
end
%%
    
if nargin<4
    display=1;
end

%%
save('d.mat','Actual','Predicted')
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