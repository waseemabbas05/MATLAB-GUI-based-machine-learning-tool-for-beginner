function varargout = ELM_DeepNet_GUI(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @ELM_DeepNet_GUI_OpeningFcn, ...
    'gui_OutputFcn',  @ELM_DeepNet_GUI_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before ELM_DeepNet_GUI is made visible.
function ELM_DeepNet_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
axes(handles.helmLogo)
Img=imread('logo.jpg');
imshow(Img)
set(handles.helmTrainTestSplit,'String',70);
if exist('helmParameters.mat')==2
   load helmParameters
end
helmParameters.TrainTestSplit=0.7;
save('helmParameters.mat','helmParameters')

delete('sizeCheck.mat')

% Choose default command line output for ELM_DeepNet_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);



% --- Outputs from this function are returned to the command line.
function varargout = ELM_DeepNet_GUI_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;


% --------------------------------------------------------------------
function browse_Callback(hObject, eventdata, handles)



% --- Executes on selection change in helmWorkspaceList.
function helmWorkspaceList_Callback(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function helmWorkspaceList_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in helmLoadWorkspace.
function helmLoadWorkspace_Callback(hObject, eventdata, handles)
set(handles.helmImportInputs,'Visible','on')
set(handles.helmInputs,'Visible','on')
Vars = evalin('base','who');
set(handles.helmWorkspaceList,'String',Vars)



% --- Executes on selection change in helmInputs.
function helmInputs_Callback(hObject, eventdata, handles)



function helmInputs_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in helmImportInputs.
function helmImportInputs_Callback(hObject, eventdata, handles)
set(handles.helmImportTargets,'Visible','on')
set(handles.helmTargets,'Visible','on')
Ind=get(handles.helmWorkspaceList,'Value');
Str=get(handles.helmWorkspaceList,'String');
Var = evalin('base',cell2mat(Str(Ind)));
set(handles.helmInputs,'String',Str(Ind));



% --- Executes on selection change in helmTargets.
function helmTargets_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function helmTargets_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in helmImportTargets.
function helmImportTargets_Callback(hObject, eventdata, handles)
set(handles.helmStep2,'Visible','on')
Ind=get(handles.helmWorkspaceList,'Value');
Str=get(handles.helmWorkspaceList,'String');
Var = evalin('base',cell2mat(Str(Ind)));
set(handles.helmTargets,'String',Str(Ind));

Ind=get(handles.helmInputs,'Value');
Str=get(handles.helmInputs,'String');
InputsCheck=length(Str)>0;
if length(Str)==0
    msgbox('Please select Inputs first and then import them')
else
    Inputs = evalin('base',cell2mat(Str(Ind)));
end
if InputsCheck==1
    Ind=get(handles.helmTargets,'Value');
    Str=get(handles.helmTargets,'String');
    if length(Str)==0
        msgbox('Please select Inputs first and then import them')
    else
        Targets = evalin('base',cell2mat(Str(Ind)));
    end
end
if size(Targets,2)>size(Targets,1)
    msgbox('Targets are in wrong format')
end
if size(Targets,1)~=size(Inputs,1)
    msgbox('Wrong Inputs or Targets')
end


function edit1_Callback(hObject, eventdata, handles)



function edit1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in helmEnterSizeB.
function helmEnterSizeB_Callback(hObject, eventdata, handles)
CheckString=get(handles.helmNetworkBG,'Title');
if strcmp(CheckString,'Network Parameters (A)')==1
    Ind=get(handles.helmNumberH,'Value');
    StrP=get(handles.helmNumberH,'String');
    Str=cell2mat(StrP(Ind));
    N=0;
    if length(Str)<=32
        N=str2num(Str);
    end
    
    if N>0
        set(handles.helmNumEpochsText,'Visible','on')
        set(handles.helmNumEpochs,'Visible','on')
        set(handles.helmActivationFunctionText,'Visible','on')
        set(handles.helmActivationFunction,'Visible','on')
        set(handles.helmStep3,'String','Step 3 (A)')
        set(handles.helmSizeText,'Visible','on')
        PanelPos = getpixelposition(handles.helmNetworkBG);
        RefPos = getpixelposition(handles.helmNumberH);
        Pos=[PanelPos(1)+RefPos(1) PanelPos(2)+RefPos(2) PanelPos(3) PanelPos(4)];
        
        handles.SizeH=[];
        handles.SizeName=[];
        
        Dx=5;
        Dy=5;
        for i=1:N
            Dx1=(32+Dx)*(i-1);
            Dy1=55;
            if i>10
                Dy1=100;
                Dx1=(32+Dx)*(i-11);
            end
            Pos1=[Pos(1)+Dx1 Pos(2)-Dy1 32 15];
            
            Dx2=(32+Dx)*(i-1);
            Dy2=80;
            if i>10
                Dy2=125;
                Dx2=(32+Dx)*(i-11);
            end
            Pos2=[Pos(1)+Dx2 Pos(2)-Dy2 32 22];
            SizeH(i) =  uicontrol( 'Style', 'edit','pos',Pos2 );
            handles.SizeH(i)=SizeH(i);
            SizeName(i) = uicontrol(  'Style', 'text','pos',Pos1 );
            handles.SizeName(i) = SizeName(i);
            set(handles.SizeName(i),'String',num2str(i))
            guidata(gca,handles)
            
        end
        save('N.mat','N')
        
    else
        msgbox('Please select a valid value for Number of Layers and then hit "Enter" ')
    end
else
    msgbox('Please properly import Inputs and Targets and then hit "Step 2" button')
end



% --- Executes on button press in helmTrainNetwork.
function helmTrainNetwork_Callback(hObject, eventdata, handles)
CheckString=get(handles.helmTrainBG,'Title');
if strcmp(CheckString,'Train (A)')==1
    load helmParameters
    TrainTestSplit=str2num(get(handles.helmTrainTestSplit,'String'))/100;
    helmParameters.TrainTestSplit=TrainTestSplit;
    Check1=isfield(helmParameters,'SizeMatrix');
    if Check1==1
        SizeMatrix=helmParameters.SizeMatrix;
    else
        msgbox('Please Enter Size and Architecture of Network 1st')
    end
    
    Check2=isfield(helmParameters,'ActivationFunction');
    if Check2==1
        ActivationFunction=helmParameters.ActivationFunction;
    else
        if Check1==1
            msgbox('Please select activation function')
        end
    end
    
    Check3=isfield(helmParameters,'TrainTestSplit');
    if Check3==1
        TrainTestSplit=helmParameters.TrainTestSplit;
    else
        if Check1*Check2==1
            msgbox('Set value of TrainTestSplit')
        end
    end
    
    Check4=isfield(helmParameters,'NumEpochs');
    if Check4==1
        NumEpochs=helmParameters.NumEpochs;
    else
        if Check1*Check2*Check3==1
            msgbox('Please Enter NumEpochs 1st')
        end
    end
    
    Ind=get(handles.helmInputs,'Value');
    Str=get(handles.helmInputs,'String');
    InputsCheck=length(Str)>0;
    if length(Str)==0
        msgbox('Please select Inputs first and then import them')
    else
        Inputs = evalin('base',cell2mat(Str(Ind)));
    end
    InputsDimCheck=size(Inputs,1)>size(Inputs,2);
    if InputsDimCheck==0
        msgbox('Warning ! Data is under defined. Number of entries should be greater than or equal to number of features')
    end
    if InputsCheck==1
        Ind=get(handles.helmTargets,'Value');
        Str=get(handles.helmTargets,'String');
        TargetsCheck=length(Str)>0;
        if TargetsCheck==1
            if length(Str)==0
                msgbox('Please select Targets first and then import them')
            else
                Targets = evalin('base',cell2mat(Str(Ind)));
                if size(Targets,2)<2
                    Ut=unique(Targets);
                    Targets1=Targets;
                    Targets=zeros(size(Targets1,1),length(Ut));
                    for i=1:length(Ut)
                        Targets(find(Targets1==Ut(i)),i)=1;
                    end
                end
            end
            NumTest=round(size(Inputs,1)*(1-TrainTestSplit));
            Indices=randperm(size(Inputs,1));
            helmParameters.Indices=Indices;
            
            Train_X=Inputs(Indices(1:end-NumTest),:);
            Train_Y=Targets(Indices(1:end-NumTest),:);
            
            Test_X=Inputs(Indices(end-NumTest+1:end),:);
            Test_Y=Targets(Indices(end-NumTest+1:end),:);
            
            tic
            [helm,TrainingAccuracy,Actual,Expected] = helm_train(Train_X,Train_Y,SizeMatrix,NumEpochs,ActivationFunction);
            T=toc;
            helm{helmParameters.NLayers+1}.TrainingTime=T;
            set(handles.helmTrainingAccuracy,'String',num2str(TrainingAccuracy))
            
            T=zeros(length(unique(Expected)),length(Expected));
            Y=zeros(length(unique(Expected)),length(Expected));
            Ue=unique(Expected);
            for i=1:size(T,1)
                T(i,find(Expected==Ue(i)))=1;
                Y(i,find(Actual==Ue(i)))=1;
            end
            stack{1}.ActivationFunction=ActivationFunction;
            save('helm.mat','helm')
            save('helmParameters.mat','helmParameters')
            msgbox('Training Complete')
        end
    end
    set(handles.helmEvaluateTrain,'Visible','on')
    set(handles.helmResultsBG,'Visible','on')
else
    msgbox('Please Enter Network parameters 1st')
end




function helmTrainingAccuracy_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function helmTrainingAccuracy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to helmTrainingAccuracy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Batch_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function helmNumEpochs_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function helmLogo_CreateFcn(hObject, eventdata, handles)



% --- Executes on mouse press over axes background.
function helmLogo_ButtonDownFcn(hObject, eventdata, handles)



% --- Executes on button press in helmEvaluateTrain.
function helmEvaluateTrain_Callback(hObject, eventdata, handles)
if exist('helm.mat')==2
    load helmParameters
    load helm
    TrainTestSplit=helmParameters.TrainTestSplit;
    Activation_Function=helmParameters.ActivationFunction;
    TrainTestSplit=helmParameters.TrainTestSplit;
    
    Ind=get(handles.helmInputs,'Value');
    Str=get(handles.helmInputs,'String');
    Inputs = evalin('base',cell2mat(Str(Ind)));
    
    
    Ind=get(handles.helmTargets,'Value');
    Str=get(handles.helmTargets,'String');
    
    if length(Str)==0
        msgbox('Please select Targets first and then import them')
    else
        Targets = evalin('base',cell2mat(Str(Ind)));
        if size(Targets,2)<2
            Ut=unique(Targets);
            Targets1=Targets;
            Targets=zeros(size(Targets1,1),length(Ut));
            for i=1:length(Ut)
                Targets(find(Targets1==Ut(i)),i)=1;
            end
        end
    end
    
    NumTest=round(size(Inputs,1)*(1-TrainTestSplit));
    Indices=helmParameters.Indices;
    
    Train_X=Inputs(Indices(1:end-NumTest),:);
    Train_Y=Targets(Indices(1:end-NumTest),:);
    
    
    %%
    [Predicted, TrainingAccuracy, Actual] = helm_test(Train_X, Train_Y, helm,helmParameters.ActivationFunction);
    cla(handles.helmPlotROC)
    axes(handles.helmPlotROC)
    Ua=unique(Actual);
    Up=unique(Predicted);
    TC=length(Up);
    TempA=ones(size(Actual));
    TempP=ones(size(Actual));
    WrongClasses=[];
    PerfCheck=0;
    for i=1:TC
        TempA=ones(size(Actual));
        TempP=ones(size(Actual));
        TempP(find(Predicted==Up(i)))=2;
        TempA(find(Actual==Ua(i)))=2;
        if length(unique(TempP))==length(unique(TempA))
            [X,Y] = perfcurve(TempP,TempA,2);
            if length(X)~=0&length(Y)~=0
                plot(X,Y,'linewidth',3)
                hold on
                PerfCheck=PerfCheck+1;
            else
                WrongClasses=[WrongClasses i];
            end
        end
    end
    %%
    if PerfCheck>0
        legend('Class 1','Class 2','Class 3','Class 4','Class 5','Class 6','Class 7','Class 8','Class 9','Class 10')
        set(gca,'fontsize',18)
        xlabel('False Positive')
        ylabel('True Positive')
        if PerfCheck~=length(Up)
            msgbox('Some Classes are missing')
        end
    else
        msgbox('Performance curve cannot be plotted, there is only one class in predicted data')
    end
    %%
    TC=length(unique(Actual));
    
    for i=1:TC
        Acti=find(Actual==Ua(i));
        TempActi=ones(length(Actual),1);
        TempActi(Acti)=-1;
        for j=1:TC
            TempPredj=zeros(length(Predicted),1);
            Actj=find(Predicted==Up(j));
            TempPredj(Actj)=-1;
            dataP(i,j)=100*length(find(TempActi==TempPredj))/length(Acti);
        end
    end
    %%
    ColNames=[];
    RowNames=[];
    for i=1:TC
        ColNames=[ColNames {['Class' num2str(i)]}];
        RowNames=[RowNames;{['Class' num2str(i)]}];
    end
    
%     Data=confusionmat(Predicted,Actual);
    set(handles.helmConfusionMatrix,'ColumnName',ColNames)
    set(handles.helmConfusionMatrix,'RowName',RowNames)
    set(handles.helmConfusionMatrix,'data',[dataP])
    set(handles.helmTrainingAccuracy,'String',num2str(TrainingAccuracy))
    set(handles.helmEvaluateTest,'Visible','On')

else
    msgbox('Trained H-ELM object not found')
end



function helmTrainTestSplit_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function helmTrainTestSplit_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function helmTestingAccuracy_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function helmTestingAccuracy_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in helmEvaluateTest.

function helmEvaluateTest_Callback(hObject, eventdata, handles)
if exist('helm.mat')==2
    load helmParameters
    load helm
    TrainTestSplit=helmParameters.TrainTestSplit;
    Activation_Function=helmParameters.ActivationFunction;
    TrainTestSplit=helmParameters.TrainTestSplit;
    
    Ind=get(handles.helmInputs,'Value');
    Str=get(handles.helmInputs,'String');
    Inputs = evalin('base',cell2mat(Str(Ind)));
    
    
    Ind=get(handles.helmTargets,'Value');
    Str=get(handles.helmTargets,'String');
    
    if length(Str)==0
        msgbox('Please select Targets first and then import them')
    else
        Targets = evalin('base',cell2mat(Str(Ind)));
        if size(Targets,2)<2
            Ut=unique(Targets);
            Targets1=Targets;
            Targets=zeros(size(Targets1,1),length(Ut));
            for i=1:length(Ut)
                Targets(find(Targets1==Ut(i)),i)=1;
            end
        end
    end
    
    NumTest=round(size(Inputs,1)*(1-TrainTestSplit));
    Indices=helmParameters.Indices;
    
    Test_X=Inputs(Indices(end-NumTest+1:end),:);
    Test_Y=Targets(Indices(end-NumTest+1:end),:);
    
    
    %%
    [Predicted, TestingAccuracy, Actual] = helm_test(Test_X, Test_Y, helm,helmParameters.ActivationFunction);
    cla(handles.helmPlotROC)
    axes(handles.helmPlotROC)
    Ua=unique(Actual);
    Up=unique(Predicted);
    TC=length(Up);
    TempA=ones(size(Actual));
    TempP=ones(size(Actual));
    WrongClasses=[];
    PerfCheck=0;
    for i=1:TC
        TempA=ones(size(Actual));
        TempP=ones(size(Actual));
        TempP(find(Predicted==Up(i)))=2;
        TempA(find(Actual==Ua(i)))=2;
        if length(unique(TempP))==length(unique(TempA))
            [X,Y] = perfcurve(TempP,TempA,2);
            if length(X)~=0&length(Y)~=0
                plot(X,Y,'linewidth',3)
                hold on
                PerfCheck=PerfCheck+1;
            else
                WrongClasses=[WrongClasses i];
            end
        end
    end
    %%
    if PerfCheck>0
        legend('Class 1','Class 2','Class 3','Class 4','Class 5','Class 6','Class 7','Class 8','Class 9','Class 10')
        set(gca,'fontsize',18)
        xlabel('False Positive')
        ylabel('True Positive')
        if PerfCheck~=length(Up)
            msgbox('Some Classes are missing')
        end
    else
        msgbox('Performance curve cannot be plotted, there is only one class in predicted data')
    end
    %%
    TC=length(unique(Actual));
    
    for i=1:TC
        Acti=find(Actual==Ua(i));
        TempActi=ones(length(Actual),1);
        TempActi(Acti)=-1;
        for j=1:TC
            TempPredj=zeros(length(Predicted),1);
            Actj=find(Predicted==Up(j));
            TempPredj(Actj)=-1;
            dataP(i,j)=100*length(find(TempActi==TempPredj))/length(Acti);
        end
    end
    %%
    ColNames=[];
    RowNames=[];
    for i=1:TC
        ColNames=[ColNames {['Class' num2str(i)]}];
        RowNames=[RowNames;{['Class' num2str(i)]}];
    end
    
%     Data=confusionmat(Predicted,Actual);
    set(handles.helmConfusionMatrix,'ColumnName',ColNames)
    set(handles.helmConfusionMatrix,'RowName',RowNames)
    set(handles.helmConfusionMatrix,'data',[dataP])
    set(handles.helmTestingAccuracy,'String',num2str(TestingAccuracy))
    set(handles.helmSaveData,'Visible','On')
    set(handles.helmCsvFile,'Visible','On')
    set(handles.helmMatFile,'Visible','On')
    set(handles.helmXlsxFile,'Visible','On')

else
    msgbox('Trained H-ELM object not found')
end



% --- Executes on button press in helmMatFile.
function helmMatFile_Callback(hObject, eventdata, handles)


% --- Executes on button press in helmCsvFile.
function helmCsvFile_Callback(hObject, eventdata, handles)


% --- Executes on button press in helmXlsxFile.
function helmXlsxFile_Callback(hObject, eventdata, handles)


% --- Executes on button press in helmSaveData.
function helmSaveData_Callback(hObject, eventdata, handles)
load DBNVal
CsvCheck=get(handles.helmCsvFile,'Value');
MatCheck=get(handles.helmMatFile,'Value');
XlsxCheck=get(handles.helmXlsxFile,'Value');
if XlsxCheck+CsvCheck+MatCheck>1
    msgbox('Uncheck other options')
elseif XlsxCheck+CsvCheck+MatCheck==0 
    msgbox('Select an output format')
else
    if XlsxCheck==1
        Data=[Expected Actual];
        xlswrite('NetworkOutput.xlsx',Data)
    elseif CsvCheck==1
        Data=[Expected Actual];
        xlswrite('NetworkOutput.csv',Data)
    else
        save('NetworkOutput.mat','Test_X','Actual','Expected')
    end
end



% --- Executes on selection change in helmNumberH.
function helmNumberH_Callback(hObject, eventdata, handles)
load helmParameters
Str=get(handles.helmNumberH,'String');
Val=get(handles.helmNumberH,'Value');
Strv=strtrim(Str(Val,:));
if iscell(Strv)==1
    Strv=cell2mat(Strv);
    NLayers=str2num(strtrim(Strv));
else
    NLayers=str2num(strtrim(Strv));
end
helmParameters.NLayers=NLayers;
save('helmParameters.mat','helmParameters')


% --- Executes during object creation, after setting all properties.
function helmNumberH_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function SizeH_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function SizeH_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in helmClearStep2.
function helmClearStep2_Callback(hObject, eventdata, handles)
load N
clc
delete( handles.SizeH(handles.SizeH>0));
handles.SizeH(:) = 0;
delete( handles.SizeName(handles.SizeName>0));
handles.SizeName(:) = 0;
set(handles.helmSizeText,'Visible','off')
set(handles.helmNumEpochs,'String','')
delete('N.mat')



% --- Executes on button press in EnterParameters.
function EnterParameters_Callback(hObject, eventdata, handles)


% --- Executes on button press in helmStep2.
function helmStep2_Callback(hObject, eventdata, handles)
set(handles.helmNetworkBG,'Title','Network Parameters (A)')
set(handles.helmNetworkBG,'Visible','on')


% --- Executes on button press in helmStep3.
function helmStep3_Callback(hObject, eventdata, handles)
checkString=get(handles.helmStep3,'String');
if strcmp(checkString,'Step 3 (A)')==1
    load helmParameters
    set(handles.helmTrainBG,'Title','Train (A)')
    set(handles.helmTrainBG,'Visible','on')
    SizeMatrix=[];
    NumEpochs=[];
    BatchSize=[];
    LayerCheck=0;
    LayersSizeCheck=0;
    if exist('N.mat')==2&isfield(handles,'SizeH')
        load N
        LayersSizeCheck=zeros(1,N);
        for i=1:N
            Str=get(handles.SizeH(i),'String');
            if length(Str)>0
                SizeMatrix(i)=str2num(Str);
                LayersSizeCheck(i)=1;
            elseif sum(LayersSizeCheck(1:i))==i-1
                MsgStr=['Enter a valid value for Number of Hidden Neurons in Layer ' num2str(i)];
                msgbox(MsgStr)
            end
            if i>1&&SizeMatrix(i)<SizeMatrix(i-1)
                msgbox('This is an auto-encoder based network, Number of neurons in a layer should be more than previous layer')
            end
            LayerCheck=1;
        end
    else
        msgbox('Please Select Number of Layers')
    end
    if exist('N.mat')
        load N
    end
    SizeCheck=0;
    if length(SizeMatrix)>0
        SizeCheck=1;
    end
    if SizeCheck*LayerCheck==1
        if sum(LayersSizeCheck)==N
            Str=get(handles.helmNumEpochs,'String');
            if length(Str)>0
                NumEpochs=str2num(Str);
            else
                MsgStr=['Enter a valid value for Number of Epochs'];
                msgbox(MsgStr)
            end
        elseif LayerCheck==0&sum(LayersSizeCheck)==N
            msgbox('Enter Number of Neurons in each layer')
        end
    end
    
    EpochsCheck=0;
    if length(NumEpochs)>0
        EpochsCheck=1;
    end
    
    BatchCheck=0;
    if EpochsCheck*SizeCheck==1
            Ind=get(handles.helmActivationFunction,'Value');
            StrP=get(handles.helmActivationFunction,'String');
            ActivationFunction=(StrP(Ind,:));
            helmParameters.ActivationFunction=strtrim(ActivationFunction);
            BatchCheck=1;
    end
    
    if sum(LayersSizeCheck)*EpochsCheck*SizeCheck*BatchCheck==N
        helmParameters.SizeMatrix=SizeMatrix;
        helmParameters.NumEpochs=NumEpochs;
        helmParameters.BatchSize=BatchSize;
        helmParameters.TrainTestSplit=str2num(get(handles.helmTrainTestSplit,'String'))/100;
        save('helmParameters.mat','helmParameters')
    end
else
    msgbox('Select Number of hidden layers, then enter number of neurons in each layer')
end
% --- Executes on button press in helmClearStep1.
function helmClearStep1_Callback(hObject, eventdata, handles)
set(handles.helmImportTargets,'Visible','off')
set(handles.helmTargets,'Visible','off')

set(handles.helmImportInputs,'Visible','off')
set(handles.helmInputs,'Visible','off')
set(handles.helmStep2,'Visible','off')


% --- Executes on button press in pushbutton28.
function pushbutton28_Callback(hObject, eventdata, handles)
set(handles.helmLoadDataBG,'Visible','on')



% --- Executes on button press in pushbutton29.
function pushbutton29_Callback(hObject, eventdata, handles)
set(handles.helmLoadDataBG,'Visible','off')
set(handles.helmNetworkBG,'Visible','off')
set(handles.helmTrainBG,'Visible','off')
set(handles.helmResultsBG,'Visible','off')

if exist('N.mat')==2
    load N
    clc
    if isfield(handles,'SizeH')>0
        delete( handles.SizeH(handles.SizeH>0));
        handles.SizeH(:) = 0;
        delete( handles.SizeName(handles.SizeName>0));
        handles.SizeName(:) = 0;
    end
end


function helmNumEpochs_Callback(hObject, eventdata, handles)


% --- Executes on selection change in helmActivationFunction.
function helmActivationFunction_Callback(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function helmActivationFunction_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
