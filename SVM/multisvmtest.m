function [Predicted,Actual,Accuracy,Precision,Recall,F1]=multisvmtest(X,Y,models)
if isreal(X)==0
    X=abs(X);
end
L=numel(models);
if size(Y,2)>1
    for i=1:size(Y,1)
        [jnk Y2(i,1)]=max(Y(i,:));
    end
    Y=Y2;
    clear Y2
end
Actual=Y;
U=unique(Y);
NumClasses=length(U);
%%
if L>1
    h = waitbar(0,'Evaluating SVM...');
    for j=1:size(X,1)
        for k=1:NumClasses
            if(svmclassify(models(k),X(j,:)))
                break;
            end
        end
        Predicted(j) = k;
        waitbar(j/size(X,1),h,sprintf('%s',['Evaluating SVM, ' num2str(round(100*(j-1)/size(X,1))) ' % done ...' ]))
    end
else
    Pred=svmclassify(models,X);
    Predicted(find(Pred==0))=2;
    Predicted(find(Pred==1))=1;
end

if size(Y,1)~=size(Predicted,1)
    Predicted=Predicted';
end

Accuracy=100*length(find(Predicted==Y))/length(Y);


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