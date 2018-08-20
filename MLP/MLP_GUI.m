function varargout = MLP_GUI(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @MLP_GUI_OpeningFcn, ...
    'gui_OutputFcn',  @MLP_GUI_OutputFcn, ...
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


% --- Executes just before MLP_GUI is made visible.
function MLP_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
axes(handles.mlpLogo)
Img=imread('logo.jpg');
imshow(Img)

set(handles.mlpTrainTestSplit,'String',70);

IterStr=num2str([10:10:500]');
set(handles.mlpMaxIterations,'Value',5)
set(handles.mlpMaxIterations,'String',IterStr)

set(handles.mlpLearningRate,'Value',0.1)
set(handles.LearningRateText,'String','0.1')

set(handles.mlpMomentum,'Value',0.1)
set(handles.MomentumText,'String','0.1')

set(handles.mlpTolerance,'Value',0.1)
set(handles.ToleranceText,'String','0.001')

mlpParameters.TrainTestSplit=0.7;
mlpParameters.MaxIterations=50;
mlpParameters.LearningRate=.1;
mlpParameters.Momentum=0.1;
mlpParameters.Nlayers=3;
mlpParameters.Tolerance=.001;
mlpParameters.SizeMatrix=[10 10 10];
delete('mlpParameters.mat')
save('mlpParameters.mat','mlpParameters')


% Choose default command line output for MLP_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);



% --- Outputs from this function are returned to the command line.
function varargout = MLP_GUI_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;


% --- Executes on selection change in mlpWorkspaceList.
function mlpWorkspaceList_Callback(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function mlpWorkspaceList_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in mlpLoadWorkspace.
function mlpLoadWorkspace_Callback(hObject, eventdata, handles)
set(handles.mlpImportInputs,'Visible','on')
set(handles.mlpInputs,'Visible','on')
Vars = evalin('base','who');
set(handles.mlpWorkspaceList,'String',Vars)



% --- Executes on selection change in mlpInputs.
function mlpInputs_Callback(hObject, eventdata, handles)



function mlpInputs_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in mlpImportInputs.
function mlpImportInputs_Callback(hObject, eventdata, handles)
set(handles.mlpImportTargets,'Visible','on')
set(handles.mlpTargets,'Visible','on')
Ind=get(handles.mlpWorkspaceList,'Value');
Str=get(handles.mlpWorkspaceList,'String');
Var = evalin('base',cell2mat(Str(Ind)));
set(handles.mlpInputs,'String',Str(Ind));



% --- Executes on selection change in mlpTargets.
function mlpTargets_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function mlpTargets_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in mlpImportTargets.
function mlpImportTargets_Callback(hObject, eventdata, handles)
set(handles.mlpStep2,'Visible','on')
Ind=get(handles.mlpWorkspaceList,'Value');
Str=get(handles.mlpWorkspaceList,'String');
Var = evalin('base',cell2mat(Str(Ind)));
set(handles.mlpTargets,'String',Str(Ind));

Ind=get(handles.mlpInputs,'Value');
Str=get(handles.mlpInputs,'String');
InputsCheck=length(Str)>0;
if length(Str)==0
    msgbox('Please select Inputs first and then import them')
else
    Inputs = evalin('base',cell2mat(Str(Ind)));
end
if InputsCheck==1
    Ind=get(handles.mlpTargets,'Value');
    Str=get(handles.mlpTargets,'String');
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


% --- Executes on button press in mlpTrainNetwork.
function mlpTrainNetwork_Callback(hObject, eventdata, handles)
CheckString=get(handles.mlpTrainBG,'Title');
if strcmp(CheckString,'Train (A)')==1
    load mlpParameters
    Check1=isfield(mlpParameters,'SizeMatrix');
    if Check1==1
        SizeMatrix=mlpParameters.SizeMatrix;
    else
        msgbox('Please Enter Size and Architecture of Network 1st')
    end
   
    
    Check2=isfield(mlpParameters,'TrainTestSplit');
    if Check2==1
        TrainTestSplit=mlpParameters.TrainTestSplit;
    else
        if Check1==1
            msgbox('Set value of TrainTestSplit')
        end
    end
    
    Check3=isfield(mlpParameters,'MaxIterations');
    if Check3==1
        MaxIterations=mlpParameters.MaxIterations;
    else
        if Check1*Check2==1
            msgbox('Please select maximum iterations 1st')
        end
    end
    
    Check4=isfield(mlpParameters,'Tolerance');
    if Check4==1
        Tolerance=mlpParameters.Tolerance;
    else
        if Check1*Check2*Check3==1
            msgbox('Please select tolerance 1st')
        end
    end
    
    Check5=isfield(mlpParameters,'Momentum');
    if Check5==1
        Momentum=mlpParameters.Momentum;
    else
        if Check1*Check2*Check3*check4==1
            msgbox('Please select momentum 1st')
        end
    end
    
    Check6=isfield(mlpParameters,'LearningRate');
    if Check6==1
        LearningRate=mlpParameters.LearningRate;
    else
        if Check1*Check2*Check3*check4*check5==1
            msgbox('Please select Learning Rate 1st')
        end
    end
    Ind=get(handles.mlpInputs,'Value');
    Str=get(handles.mlpInputs,'String');
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
        Ind=get(handles.mlpTargets,'Value');
        Str=get(handles.mlpTargets,'String');
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
            mlpParameters.Indices=Indices;
            
            Train_X=Inputs(Indices(1:end-NumTest),:);
            Train_Y=Targets(Indices(1:end-NumTest),:);
            
            Test_X=Inputs(Indices(end-NumTest+1:end),:);
            Test_Y=Targets(Indices(end-NumTest+1:end),:);
            
            tic
            [mlp mse] = train_mlp(Train_X, Train_Y, SizeMatrix, MaxIterations, LearningRate, Momentum,Tolerance);
            T=toc;
            mlp.TrainingTime=T;
            save('mlpParameters.mat','mlpParameters')
            save('mlp.mat','mlp')
            
            %%
            [TrainOutputs TrainCorr] = test_mlp(mlp, Train_X, Train_Y);
            
            % estimate class from the output as the unit of maximal activation
            [jnk TrainClass] = max(Train_Y'); % for the traianing data
            [jnk EstClass] = max(TrainOutputs');      % the decision of the model
            [jnk TrueClass] = max(Train_Y');
            [NTrain NClasses] = size(Train_Y);
            ClassificationErrors = TrueClass ~= EstClass;
            TrainingAccuracy = 100 * (1 - sum(ClassificationErrors) / NTrain);
            set(handles.mlpTrainingAccuracy,'String',num2str(TrainingAccuracy))
            
            %%
            
            
            T=zeros(length(unique(TrainClass)),length(TrainClass));
            Y=zeros(length(unique(TrainClass)),length(TrainClass));
            Ue=unique(TrainClass);
            for i=1:size(T,1)
                T(i,find(TrainClass==Ue(i)))=1;
                Y(i,find(TrueClass==Ue(i)))=1;
            end
            
            save('mlpVal.mat','TrainClass','TrueClass','mlp','TrainingAccuracy','Test_X','Test_Y')
            msgbox('Training Complete')
        end
    end
    set(handles.mlpEvaluateTrain,'Visible','on')
    set(handles.mlpResultsBG,'Visible','on')
else
    msgbox('Please Enter Network parameters 1st')
end



function mlpTrainingAccuracy_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function mlpTrainingAccuracy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mlpTrainingAccuracy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Batch_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function NumEpochsE_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function mlpLogo_CreateFcn(hObject, eventdata, handles)



% --- Executes on mouse press over axes background.
function mlpLogo_ButtonDownFcn(hObject, eventdata, handles)



% --- Executes on button press in mlpEvaluateTrain.
function mlpEvaluateTrain_Callback(hObject, eventdata, handles)
cla(handles.mlpPlotROC)
load mlpVal
Expected=TrainClass;
Actual=TrueClass;
Ue=unique(Expected);
Ua=unique(Actual);
TC=length(Ue);
TempE=ones(size(Expected));
TempA=ones(size(Expected));
axes(handles.mlpPlotROC)
PerfCheck=0;
%%
for i=1:TC
    TempE=ones(size(Expected));
    TempA=ones(size(Expected));
    TempA(find(Actual==Ue(i)))=2;
    TempE(find(Expected==Ue(i)))=2;
    if length(unique(TempA))==length(unique(TempE))
        [X,Y] = perfcurve(TempA,TempE,2);
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
    if PerfCheck~=length(Ue)
        msgbox('Some Classes are missing')
    end
else
    msgbox('Performance curve cannot be plotted, there is only one class in predicted data')
end


ColNames=[];
RowNames=[];
for i=1:TC
    ColNames=[ColNames {['Class' num2str(i)]}];
    RowNames=[RowNames;{['Class' num2str(i)]}];
end


for i=1:TC
    Expi=find(Expected==Ue(i));
    TempExpi=ones(length(Expected),1);
    TempExpi(Expi)=-1;
    for j=1:TC
        TempActj=zeros(length(Actual),1);
        Actj=find(Actual==Ue(j));
        TempActj(Actj)=-1;
        dataP(i,j)=100*length(find(TempExpi==TempActj))/length(Expi);
    end
end
       
set(handles.mlpConfusionMatrix,'ColumnName',ColNames)
set(handles.mlpConfusionMatrix,'RowName',RowNames)
set(handles.mlpConfusionMatrix,'data',[dataP])
set(handles.mlpTrainingAccuracy,'String',num2str(TrainingAccuracy))

set(handles.mlpEvaluateTest,'Visible','on')




function mlpTrainTestSplit_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function mlpTrainTestSplit_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mlpTestingAccuracy_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function mlpTestingAccuracy_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in mlpEvaluateTest.
function mlpEvaluateTest_Callback(hObject, eventdata, handles)
cla(handles.mlpPlotROC)
load mlpVal
[TestOutputs TestCorr] = test_mlp(mlp, Test_X, Test_Y);

% estimate class from the output as the unit of maximal activation
[jnk Expected] = max(Test_Y');   % for the testing data
[jnk Actual] = max(TestOutputs');      % the decision of the model

[NTest NClasses] = size(Test_Y);
ClassificationErrors = Expected ~= Actual;
TestingAccuracy = 100 * (1 - sum(ClassificationErrors) / NTest);
axes(handles.mlpPlotROC)
%%
Ue=unique(Expected);
Ua=unique(Actual);
TC=length(Ue);
TempE=ones(size(Expected));
TempA=ones(size(Expected));
WrongClasses=[];
PerfCheck=0;
for i=1:TC
    TempE=ones(size(Expected));
    TempA=ones(size(Expected));
    TempA(find(Actual==Ue(i)))=2;
    TempE(find(Expected==Ue(i)))=2;
    if length(unique(TempA))==length(unique(TempE))
        [X,Y] = perfcurve(TempA,TempE,2);
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
    if PerfCheck~=length(Ue)
        msgbox('Some Classes are missing')
    end
else
    msgbox('Performance curve cannot be plotted, there is only one class in predicted data')
end
%%
TC=length(unique(Expected));

for i=1:TC
    Expi=find(Expected==Ue(i));
    TempExpi=ones(length(Expected),1);
    TempExpi(Expi)=-1;
    for j=1:TC
        TempActj=zeros(length(Actual),1);
        Actj=find(Actual==Ue(j));
        TempActj(Actj)=-1;
        dataP(i,j)=100*length(find(TempExpi==TempActj))/length(Expi);
    end
end
%%
ColNames=[];
RowNames=[];
for i=1:TC
    ColNames=[ColNames {['Class' num2str(i)]}];
    RowNames=[RowNames;{['Class' num2str(i)]}];
end

Data=confusionmat(Actual,Expected);
set(handles.mlpConfusionMatrix,'ColumnName',ColNames)
set(handles.mlpConfusionMatrix,'RowName',RowNames)
set(handles.mlpConfusionMatrix,'data',[dataP])
set(handles.mlpTestingAccuracy,'String',num2str(TestingAccuracy))

set(handles.mlpSaveData,'Visible','on')
set(handles.mlpMatFile,'Visible','on')
set(handles.mlpXlsxFile,'Visible','on')
set(handles.mlpCsvFile,'Visible','on')


% --- Executes on button press in mlpMatFile.
function mlpMatFile_Callback(hObject, eventdata, handles)


% --- Executes on button press in mlpCsvFile.
function mlpCsvFile_Callback(hObject, eventdata, handles)


% --- Executes on button press in mlpXlsxFile.
function mlpXlsxFile_Callback(hObject, eventdata, handles)


% --- Executes on button press in mlpSaveData.
function mlpSaveData_Callback(hObject, eventdata, handles)
load DBNVal
CsvCheck=get(handles.mlpCsvFile,'Value');
MatCheck=get(handles.mlpMatFile,'Value');
XlsxCheck=get(handles.mlpXlsxFile,'Value');
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



% --- Executes on selection change in mlpNumberH.
function mlpNumberH_Callback(hObject, eventdata, handles)
CheckString=get(handles.mlpNetworkBG,'Title');
if strcmp(CheckString,'Network Parameters (A)')==1
    
    set(handles.mlpTolerance,'Visible','on')
    set(handles.ToleranceText,'Visible','on')
    set(handles.mlpToleranceTitle,'Visible','on')
    set(handles.mlpTolStart,'Visible','on')
    set(handles.mlpTolEnd,'Visible','on')
    
    set(handles.mlpMomentum,'Visible','on')
    set(handles.MomentumText,'Visible','on')
    set(handles.mlpMomentumTitle,'Visible','on')
    set(handles.mlpMoStart,'Visible','on')
    set(handles.mlpMoEnd,'Visible','on')
    
    set(handles.mlpLearningRate,'Visible','on')
    set(handles.LearningRateText,'Visible','on')
    set(handles.mlpLearningRateTitle,'Visible','on')
    set(handles.mlpLRStart,'Visible','on')
    set(handles.mlpLREnd,'Visible','on')
    
    Ind=get(handles.mlpNumberH,'Value');
    StrP=get(handles.mlpNumberH,'String');
    Str=cell2mat(StrP(Ind));
    NLayers=0;
    if length(Str)<=32
        NStr=get(handles.mlpNumberH,'String');
        NInd=get(handles.mlpNumberH,'Value');
        NLayers=str2num(cell2mat(NStr(NInd,:)));
    end
    
    if NLayers>0
        set(handles.mlpMaxIterationsText,'Visible','on')
        set(handles.mlpMaxIterations,'Visible','on')
        set(handles.mlpStep3,'String','Step 3 (A)')
%         set(handles.SizeText,'Visible','on')
        
        
        load mlpParameters
        mlpParameters.NLayers=NLayers;
        mlpParameters.SizeMatrix=[];
        save('mlpParameters.mat','mlpParameters')
        if isfield(mlpParameters,'LayersHandle')==1
            delete( handles.NLayersNH(handles.NLayersNH>0));
            handles.NLayersNH(:) = 0;
            delete( handles.SizeName(handles.SizeName>0));
            handles.SizeName(:) = 0;
            mlpParameters.LayersHandle=[];
            mlpParameters.SizeMatrix=[];
            mlpParameters = rmfield(mlpParameters,'LayersHandle');
        end
        save('mlpParameters.mat','mlpParameters')
    
        
        PanelPos = getpixelposition(handles.mlpNetworkBG);
        RefPos = getpixelposition(handles.mlpNumberH);
        Pos=[PanelPos(1)+RefPos(1) PanelPos(2)+RefPos(2) PanelPos(3) PanelPos(4)];
        
        handles.NLayersNH=[];
        handles.SizeName=[];
        
        Dx=10;
        Dy=5;
        Dxx=60;
        for i=1:NLayers
            Dx1=(Dxx+Dx)*(i-1);
            Dy1=55;
            if i>5
                Dy1=100;
                Dx1=(Dxx+Dx)*(i-6);
            end
            Pos1=[Pos(1)+Dx1 Pos(2)-Dy1 60 15];
            
            Dx2=(Dxx+Dx)*(i-1);
            Dy2=80;
            if i>5
                Dy2=125;
                Dx2=(Dxx+Dx)*(i-6);
            end
            Pos2=[Pos(1)+Dx2 Pos(2)-Dy2 60 25];
            
            String={num2str([1:50 i]')};
            pop_menu = uicontrol('Parent', MLP_GUI, 'Style', 'Popupmenu', 'Position', Pos2, 'String',...
                String, 'Value', 10, 'Callback', @popup_bar);
            mlpParameters.SizeMatrix(i)=10;
            handles.NLayersNH(i)=pop_menu;
            
            SizeName(i) = uicontrol(  'Style', 'text','pos',Pos1 );
            handles.SizeName(i) = SizeName(i);
            set(handles.SizeName(i),'String',num2str(i))
            guidata(gca,handles)
            mlpParameters.LayersHandle(i)=i;
        end
    delete('mlpParameters.mat')
    save('mlpParameters.mat','mlpParameters')
        
    else
        msgbox('Please select a valid value for Number of Layers and then hit "Enter" ')
    end
else
    msgbox('Please properly import Inputs and Targets and then hit "Step 2" button')
end


% --- Executes during object creation, after setting all properties.
function mlpNumberH_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function [] = popup_bar(gcbo,handles)

load mlpParameters
Str=get(gcbo,'String');
CurrNumber=str2num(cell2mat(Str(end)));
Ind=(get(gcbo,'Value'));
mlpParameters.SizeMatrix(CurrNumber)=str2num(cell2mat(Str(Ind)));
save('mlpParameters.mat','mlpParameters')



function SizeH_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function SizeH_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in mlpStep2Clear.
function mlpStep2Clear_Callback(hObject, eventdata, handles)
load mlpParameters

if isfield(mlpParameters,'LayersHandle')==1
    delete( handles.NLayersNH(handles.NLayersNH>0));
    handles.NLayersNH(:) = 0;
    delete( handles.SizeName(handles.SizeName>0));
    handles.SizeName(:) = 0;
    mlpParameters.LayersHandle=[];
    mlpParameters.SizeMatrix=[];
    mlpParameters = rmfield(mlpParameters,'LayersHandle');
end
save('mlpParameters.mat','mlpParameters')

set(handles.mlpTolerance,'Visible','off')
set(handles.ToleranceText,'Visible','off')
set(handles.mlpToleranceTitle,'Visible','off')
set(handles.mlpTolStart,'Visible','off')
set(handles.mlpTolEnd,'Visible','off')

set(handles.mlpMomentum,'Visible','off')
set(handles.MomentumText,'Visible','off')
set(handles.mlpMomentumTitle,'Visible','off')
set(handles.mlpMoStart,'Visible','off')
set(handles.mlpMoEnd,'Visible','off')

set(handles.mlpLearningRate,'Visible','off')
set(handles.LearningRateText,'Visible','off')
set(handles.mlpLearningRateTitle,'Visible','off')
set(handles.mlpLRStart,'Visible','off')
set(handles.mlpLREnd,'Visible','off')

set(handles.mlpMaxIterations,'Visible','off')
set(handles.mlpMaxIterationsText,'Visible','off')



% --- Executes on button press in EnterParameters.
function EnterParameters_Callback(hObject, eventdata, handles)


% --- Executes on button press in mlpStep2.
function mlpStep2_Callback(hObject, eventdata, handles)
set(handles.mlpNetworkBG,'Title','Network Parameters (A)')
set(handles.mlpNetworkBG,'Visible','on')


% --- Executes on button press in mlpStep3.
function mlpStep3_Callback(hObject, eventdata, handles)
checkString=get(handles.mlpStep3,'String');
if strcmp(checkString,'Step 3 (A)')==1
    set(handles.mlpTrainBG,'Title','Train (A)')
    set(handles.mlpTrainBG,'Visible','on')
else
    msgbox('Select Number of hidden layers, then enter number of neurons in each layer')
end
% --- Executes on button press in mlpStep1Clear.
function mlpStep1Clear_Callback(hObject, eventdata, handles)
set(handles.mlpImportTargets,'Visible','off')
set(handles.mlpTargets,'Visible','off')

set(handles.mlpImportInputs,'Visible','off')
set(handles.mlpInputs,'Visible','off')
set(handles.mlpStep2,'Visible','off')


% --- Executes on selection change in mlpMaxIterations.
function mlpMaxIterations_Callback(hObject, eventdata, handles)
MaxIterations=get(handles.mlpMaxIterations,'Value');
set(handles.MomentumText,'String',num2str(MaxIterations))
load mlpParameters
mlpParameters.Momentum=MaxIterations;
save('mlpParameters.mat','mlpParameters')


% --- Executes during object creation, after setting all properties.
function mlpMaxIterations_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function mlpMomentum_Callback(hObject, eventdata, handles)
Momentum=get(handles.mlpMomentum,'Value');
set(handles.MomentumText,'String',num2str(Momentum))
load mlpParameters
mlpParameters.Momentum=Momentum;
save('mlpParameters.mat','mlpParameters')
% hObject    handle to mlpMomentum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function mlpMomentum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mlpMomentum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function mlpLearningRate_Callback(hObject, eventdata, handles)
LearningRate=get(handles.mlpLearningRate,'Value');
set(handles.LearningRateText,'String',num2str(LearningRate))
load mlpParameters
mlpParameters.LearningRate=LearningRate;
save('mlpParameters.mat','mlpParameters')
% hObject    handle to mlpLearningRate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function mlpLearningRate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mlpLearningRate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function mlpTolerance_Callback(hObject, eventdata, handles)
Val=linspace(0.0001,0.01,100);
Tolerance=Val(round(get(handles.mlpTolerance,'Value')*99)+1);
set(handles.ToleranceText,'String',num2str(Tolerance))
load mlpParameters
mlpParameters.Tolerance=Tolerance;
save('mlpParameters.mat','mlpParameters')
% hObject    handle to mlpTolerance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function mlpTolerance_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mlpTolerance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
