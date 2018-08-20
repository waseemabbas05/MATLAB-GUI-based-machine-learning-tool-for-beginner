function [Output,CC,Predicted,Actual,Precision,Recall,Accuracy,F1] = test_mlp(mlp, Inputs, Targets,Check)
% this function calculates the output of the model, and compares it to the
% target output
[NTest NOutLayer] = size(Targets);

if size(Targets,2)==1
    NumClasses=length(unique(Targets));
    Ut=unique(Targets);
    T=zeros(size(Targets,1),NumClasses);
    for i=1:NumClasses
        T(find(Ut==Ut(i)),i)=1;
    end
    Targets=T;
end

% this variable is for the final output of the neural net
Output = zeros(NTest, NOutLayer);
for i = 1:NTest
    Temp = Inputs(i,:); % output at each layer, gets updated
    for j = 1:length(mlp.weights)
        Temp = Temp * mlp.weights{j} + mlp.biases{j}; % calculate the output
        Temp = 1./(1+exp(-Temp)); % squashit
    end
    Output(i,:) = Temp; % keep only the last output value
end
warning('off', 'all') % corrcoef gives some divide by zero errors, this is the laziest fix possible


[jnk Actual] = max(Targets'); % for the traianing data
if (size(Actual,1)<size(Actual,2))
    Actual=Actual';
end
Predicted=Output;


CC = corrcoef(Actual, Predicted);
if(numel(CC)>1)
    CC = CC(2,1);
end


%%
if Check==1
    [jnk Actual] = max(Targets'); % for the traianing data
    if (size(Actual,1)<size(Actual,2))
        Actual=Actual';
    end
    [jnk Predicted] = max(Output');      % the decision of the model
    if (size(Predicted,1)<size(Predicted,2))
        Predicted=Predicted';
    end
    [NTrain NumClasses] = size(Targets);
    ClassificationErrors = Actual ~= Predicted;
    TrainingAccuracy = 100 * (1 - sum(ClassificationErrors) / NTrain);
    
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
end
