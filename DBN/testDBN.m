function [Accuracy,Predicted,Actual,Precision,Recall,F1]=testDBN(dbn,X,Y)
%% evaluate on test data
display('testing deep network ..........')
if nargin<3
    Predicted = nnpredict(dbn, X);
    [dummy, Actual] = max(Y,[],2);
else
    NumClasses=length(unique(Y));
    Predicted = nnpredict(dbn, X);
    [dummy, Actual] = max(Y,[],2);
    bad = find(Predicted ~= Actual);
    er = numel(bad) / size(X, 1);
    Accuracy=100*(1-er);
    display(['Number of test files is ' num2str(length(Y))])
    
    display(['Prediction Accuracy for ' num2str(NumClasses) ' class problem is ' num2str(Accuracy) ' % '])
end

%%
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