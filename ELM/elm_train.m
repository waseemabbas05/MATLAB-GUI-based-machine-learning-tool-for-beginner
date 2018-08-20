function [elm,Actual,Expected,Training_Accuracy] = elm_train(Train_X,Train_Y, Number_Of_Hidden_Neurons, Activation_Function)
%%
REGRESSION=0;
CLASSIFIER=1;
ElmType=1;
NumberOfOutputNeurons=size(Train_Y,2);
if size(Train_Y,2)==1
    Ut=unique(Train_Y);
    NumberOfOutputNeurons=length(Ut);
end
T=Train_Y';
P=Train_X';

NumberofTrainingData=size(P,2);
NumberofInputNeurons=size(P,1);


%%%%%%%%%%% Random generate input weights InputWeight (w_i) and biases BiasofHiddenNeurons (b_i) of hidden neurons
InputWeight=rand(Number_Of_Hidden_Neurons,NumberofInputNeurons)*2-1;
BiasOfHiddenNeurons=rand(Number_Of_Hidden_Neurons,1);
TempH=InputWeight*P;
clear P;                                            %   Release input of training data 
Ind=ones(1,NumberofTrainingData);
BiasMatrix=BiasOfHiddenNeurons(:,Ind);              %   Extend the bias matrix BiasofHiddenNeurons to match the demention of H
TempH=TempH+BiasMatrix;

%%%%%%%%%%% Calculate hidden neuron output matrix H
switch lower(Activation_Function)
    case {'sig','sigmoid'}
        %%%%%%%% Sigmoid 
        H = 1 ./ (1 + exp(-TempH));
    case {'sin','sine'}
        %%%%%%%% Sine
        H = sin(TempH);    
    case {'hardlim'}
        %%%%%%%% Hard Limit
        H = hardlim(TempH);            
    case {'tribas'}
            %%%%%%%% Triangular basis function
            H = tribas(TempH);
    case {'radbas'}
            %%%%%%%% Radial basis function
            H = radbas(TempH);
            %%%%%%%% More activation functions can be added here               
end
clear TempH;                                        %   Release the temparary array for calculation of hidden neuron output matrix H

%%%%%%%%%%% Calculate output weights OutputWeight (beta_i)
OutputWeight=pinv(H') * T';


%%%%%%%%%%% Calculate the training accuracy
Y=(H' * OutputWeight)';                             %   Y: the actual output of the training data
if ElmType == REGRESSION
    Training_Accuracy=sqrt(mse(T - Y))               %   Calculate training accuracy (RMSE) for regression case
    Output=Y;    
end
clear H;

if ElmType == CLASSIFIER
%%%%%%%%%% Calculate training & testing classification accuracy
    MissClassificationRate_Training=0;

    for i = 1 : size(T, 2)
        [X, Expected(i)]=max(T(:,i));
        [X, Actual(i)]=max(Y(:,i));
        if Actual(i)~=Expected(i)
            MissClassificationRate_Training=MissClassificationRate_Training+1;
        end
    end
    Training_Accuracy=100*(1-MissClassificationRate_Training/NumberofTrainingData);
end

elm.NumberofInputNeurons=NumberofInputNeurons;
elm.InputWeight=InputWeight;
elm.BiasofHiddenNeurons=BiasOfHiddenNeurons;
elm.OutputWeight=OutputWeight;
elm.ActivationFunction=Activation_Function;
elm.NumberofOutputNeurons=NumberOfOutputNeurons;
display(['Training Accuracy on ' num2str(length(unique(Expected))) ' class problem is ' num2str(Training_Accuracy) ' %'])