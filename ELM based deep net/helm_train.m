function [stack,Accuracy,Predicted,Actual] = helm_train(Train_X,Train_Y,Size_Matrix,Num_Epochs,Activation_Function)
%%
NL=length(Size_Matrix);
S=0.77;
C = 2^-30 ;
Lam=.001;
stack = cell(NL,1);
stack{1}.iw=2*rand(size(Train_X,2)+1,Size_Matrix(1))-1;
for i=2:NL-1
    stack{i}.iw=2*rand(Size_Matrix(i-1)+1,Size_Matrix(i))-1;   
end
stack{NL}.iw=orth(2*rand(Size_Matrix(NL-1)+1,Size_Matrix(NL))'-1)';
%%

Train_X = zscore(Train_X')';
Input_Data_Layer = [Train_X .1 * ones(size(Train_X,1),1)];
clear train_x;

%%
for i=1:NL-1
    B=stack{i}.iw;
    switch lower(Activation_Function)
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

    A1 = Input_Data_Layer * B;        
    A1 = mapminmax(A1);
    clear b1;
    stack{i}.w  =  sparse_elm_autoencoder(A1,Input_Data_Layer,Lam,Num_Epochs)';
    clear A1;
    
    T = Input_Data_Layer * stack{i}.w;
    fprintf(1,['Layer ' num2str(i) ': Max Val of Output %f Min Val %f\n'],max(T(:)),min(T(:)));
    
    [T,stack{i}.ps]  =  mapminmax(T',0,1);
    T = T';
    clear InputDataLayer;
    Input_Data_Layer = [T .1 * ones(size(T,1),1)];
end

%% Original ELM
switch lower(Activation_Function)
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
clear T;
T = Input_Data_Layer * stack{NL}.iw;
lLast = max(max(T));lLast = S/lLast;
fprintf(1,['Layer ' num2str(NL) ': Max Val of Output %f Min Val %f\n'],lLast,min(T(:)));
stack{NL}.lLast=lLast;
T = tansig(T * lLast);
clear InputDataLayer;
%% Finsh Training
stack{NL}.w = (T'  *  T+eye(size(T',1)) * (C)) \ ( T'  *  Train_Y);

disp('Training has been finished!');
%% Calculate the training accuracy
ELM_Out = T * stack{NL}.w;
clear T;

for i=1:size(ELM_Out,1)
    [~,Predicted(i)]=max(ELM_Out(i,:));
end
Predicted=Predicted';
for i=1:size(Train_Y,1)
    [~,Actual(i)]=max(Train_Y(i,:));
end
Actual=Actual';

Accuracy = 100*length(find(Predicted == Actual))/size(Actual,1);

disp(['Training Accuracy is : ', num2str(Accuracy), ' %' ]);

