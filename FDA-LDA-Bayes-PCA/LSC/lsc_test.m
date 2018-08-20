function [Predicted, Precision, Recall, Accuracy,F1] = lsc_test(lsc,X,Y)

%%
if size(Y,2)==1
    Uy=unique(Y);
    NumClasses=length(Uy);
    if NumClasses>2
        Ya=zeros(length(Y),NumClasses);
        for i=1:NumClasses
            Ya(find(Y==Uy(i)),i)=1;
        end
    else
        Ya=Y;
    end
elseif size(Y,2)==2
    Ya=Y(:,1);
    NumClasses=size(Y,2);
else
    NumClasses=size(Y,2);
    Ya=Y;
end
clear Uy i 

%%
Actual=zeros(size(Ya,1),1);


if NumClasses==2
    Pred=(X*lsc.P)*lsc.B*lsc.Q';
    Thresh=mean(Pred);
    Predicted=round(Pred);

    Actual(find(Ya==1))=1;
    Actual(find(Ya==0))=2;
else
    for i=1:NumClasses
        P=lsc.P{i};
        if iscell(P)==1
            P=cell2mat(P);
        end
        
        B=lsc.B{i};
        if iscell(B)==1
            B=cell2mat(B);
        end
        
        Q=lsc.Q{i};
        if iscell(Q)==1
            Q=cell2mat(Q);
        end
        
        Y1=round((X*P)*B*Q');
        Thresh=graythresh(Y1);
        Predicted(:,1)=round(Y1);
        
        Actual(find(Ya(:,i)==1),1)=i;
    end
end


%%
%%
Actual=Y;
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