function [Predicted,Actual, Accuracy,Precision,Recall,F1] = elm_predict(elm,Test_X,Test_Y)
%%
REGRESSION=0;
CLASSIFIER=1;
Elm_Type=1;

TV.T=Test_Y';
TV.P=Test_X';

NumberofTestingData=size(TV.P,2);
NumberofOutputNeurons=elm.NumberofOutputNeurons;


%%%%%%%%%%% Calculate the output of testing input
InputWeight=elm.InputWeight;
TempH_test=InputWeight*TV.P;
clear TV.P;             %   Release input of testing data             
Ind=ones(1,NumberofTestingData);
BiasofHiddenNeurons=elm.BiasofHiddenNeurons;
BiasMatrix=BiasofHiddenNeurons(:,Ind);              %   Extend the bias matrix BiasofHiddenNeurons to match the demention of H
TempH_test=TempH_test + BiasMatrix;
ActivationFunction=elm.ActivationFunction;
switch lower(ActivationFunction)
    case {'sig','sigmoid'}
        %%%%%%%% Sigmoid 
        H_test = 1 ./ (1 + exp(-TempH_test));
    case {'sin','sine'}
        %%%%%%%% Sine
        H_test = sin(TempH_test);        
    case {'hardlim'}
        %%%%%%%% Hard Limit
        H_test = hardlim(TempH_test);        
        %%%%%%%% More activation functions can be added here    
    case {'tribas'}
            %%%%%%%% Triangular basis function
            H_test = tribas(TempH_test);
    case {'radbas'}
            %%%%%%%% Radial basis function
            H_test = radbas(TempH_test);
            %%%%%%%% More activation functions can be added here        
end
OutputWeight=elm.OutputWeight;
TY=(H_test' * OutputWeight)';                       %   TY: the actual output of the testing data

if Elm_Type == REGRESSION
    Accuracy=sqrt(mse(TV.T - TY))            %   Calculate testing accuracy (RMSE) for regression case
    Output=TY;
end

if Elm_Type == CLASSIFIER
%%%%%%%%%% Calculate training & testing classification accuracy
    MissClassificationRate_Testing=0;

    for i = 1 : size(TV.T, 2)
        [x, Actual1(i,1)]=max(TV.T(:,i));
        [x, Predicted(i,1)]=max(TY(:,i));     
        if Predicted(i)~=Actual1(i)
            MissClassificationRate_Testing=MissClassificationRate_Testing+1;
        end
    end
    Accuracy=100*(1-MissClassificationRate_Testing/NumberofTestingData);  
end
display(['Testing Accuracy on ' num2str(length(unique(Actual1))) ' class problem is ' num2str(Accuracy)])

%%
Actual=Test_Y;

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