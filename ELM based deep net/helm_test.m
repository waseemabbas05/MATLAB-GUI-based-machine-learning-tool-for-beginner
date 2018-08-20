function [Predicted, Accuracy, Actual,Precision,Recall,F1] = helm_test(Test_X, Test_Y, stack,ActivationFunction)
%%
display(['Testing the deep network . . . . .'])
NL=length(stack)-1;
Test_X = zscore(Test_X')';
Input_Data_Layer = [Test_X .1 * ones(size(Test_X,1),1)];
for i=1:NL-1
    switch lower(ActivationFunction)
        case {'sig','sigmoid'}
            %%%%%%%% Sigmoid
            Input_Data_Layer = 1 ./ (1 + exp(-Input_Data_Layer));
        case {'sin','sine'}
            %%%%%%%% Sine
            Input_Data_Layer = sin(Input_Data_Layer);
        case {'hardlim'}
            %%%%%%%% Hard Limit
            Input_Data_Layer = double(hardlim(Input_Data_Layer));
        case {'tribas'}
            %%%%%%%% Triangular basis function
            Input_Data_Layer = tribas(Input_Data_Layer);
        case {'radbas'}
            %%%%%%%% Radial basis function
            Input_Data_Layer = radbas(Input_Data_Layer);
            %%%%%%%% More activation functions can be added here
    end
    TT = Input_Data_Layer * stack{i}.w;
    TT  =  mapminmax('apply',TT',stack{i}.ps)';
    clear InputDataLayer;
    Input_Data_Layer = [TT .1 * ones(size(TT,1),1)];
end

%% Last layer feedforward
Input_Data_Layer = [TT .1 * ones(size(TT,1),1)];
switch lower(ActivationFunction)
    case {'sig','sigmoid'}
        %%%%%%%% Sigmoid
        Input_Data_Layer = 1 ./ (1 + exp(-Input_Data_Layer));
    case {'sin','sine'}
        %%%%%%%% Sine
        Input_Data_Layer = sin(Input_Data_Layer);
    case {'hardlim'}
        %%%%%%%% Hard Limit
        Input_Data_Layer = double(hardlim(Input_Data_Layer));
    case {'tribas'}
        %%%%%%%% Triangular basis function
        Input_Data_Layer = tribas(Input_Data_Layer);
    case {'radbas'}
        %%%%%%%% Radial basis function
        Input_Data_Layer = radbas(Input_Data_Layer);
        %%%%%%%% More activation functions can be added here
end
clear TT;
lLast=stack{NL}.lLast;
TT = tansig(Input_Data_Layer * stack{NL}.iw * lLast);

ELM_Out = TT * stack{NL}.w;

for i=1:size(ELM_Out,1)
    [~,Predicted(i)]=max(ELM_Out(i,:));
end
Predicted=Predicted';

for i=1:size(Test_Y,1)
    [~,Actual(i)]=max(Test_Y(i,:));
end
Actual=Actual';

Accuracy = 100*length(find(Predicted == Actual))/size(Actual,1);
clear TT;
%% Calculate the testing accuracy
disp('Testing has been finished!');
disp(['Testing Accuracy is : ', num2str(Accuracy), ' %' ]);

%%
NumClasses=length(unique(Actual));
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