function varargout = SVM_GUI(varargin)
%%
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @SVM_GUI_OpeningFcn, ...
    'gui_OutputFcn',  @SVM_GUI_OutputFcn, ...
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


% --- Executes just before SVM_GUI is made visible.
function SVM_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
axes(handles.svmLogo)
Img=imread('logo.jpg');
imshow(Img)
set(handles.svmTrainTestSplit,'String',70);
if exist('svmParameters.mat')==2
    load svmParameters
end
svmParameters.TrainTestSplit=0.7;
svmParameters.MaxIter=100000;
svmParameters.TolFun=.01;
svmParameters.StopCrit=.1;
svmParameters.DisplayIter=1;
svmParameters.RBF_Sigma=1;
svmParameters.KernelFunction='quadrratic';
svmParameters.Method='QP';
svmParameters.PolynomialOrder=1;

save('svmParameters.mat','svmParameters')

set(handles.svmMaxIterText,'String',10000)
set(handles.svmMaxIter,'Value',.01)

set(handles.svmTolFunText,'String',.001)
set(handles.svmTolFun,'Value',.1)

set(handles.svmStopCritText,'String',.01)
set(handles.svmStopCrit,'Value',.1)

set(handles.svmDisplayIterYes,'Value',0)
set(handles.svmDisplayIterNo,'Value',1)

set(handles.svmRBF_Sigma,'Value',1)
set(handles.svmRBF_SigmaText,'String','1')

set(handles.svmKernelFunction,'Value',2)

set(handles.svmMethod,'Value',2)

set(handles.svmPolynomialOrder,'Value',3)

handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = SVM_GUI_OutputFcn(hObject, eventdata, handles)

varargout{1} = handles.output;


function svmWorkspaceList_Callback(hObject, eventdata, handles)


function svmWorkspaceList_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in svmLoadWorkspace.
function svmLoadWorkspace_Callback(hObject, eventdata, handles)
set(handles.svmImportInputs,'Visible','on')
set(handles.svmInputs,'Visible','on')
Vars = evalin('base','who');
set(handles.svmWorkspaceList,'String',Vars)


% --- Executes on selection change in svmInputs.
function svmInputs_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function svmInputs_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in svmImportInputs.
function svmImportInputs_Callback(hObject, eventdata, handles)
set(handles.svmImportTargets,'Visible','on')
set(handles.svmTargets,'Visible','on')
Ind=get(handles.svmWorkspaceList,'Value');
Str=get(handles.svmWorkspaceList,'String');
Var = evalin('base',cell2mat(Str(Ind)));
set(handles.svmInputs,'String',Str(Ind));


% --- Executes on selection change in svmTargets.
function svmTargets_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function svmTargets_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in svmImportTargets.
function svmImportTargets_Callback(hObject, eventdata, handles)
set(handles.svmStep2,'Visible','on')
Ind=get(handles.svmWorkspaceList,'Value');
Str=get(handles.svmWorkspaceList,'String');
Var = evalin('base',cell2mat(Str(Ind)));
set(handles.svmTargets,'String',Str(Ind));

Ind=get(handles.svmInputs,'Value');
Str=get(handles.svmInputs,'String');
InputsCheck=length(Str)>0;
if length(Str)==0
    msgbox('Please select Inputs first and then import them')
else
    Inputs = evalin('base',cell2mat(Str(Ind)));
end
if InputsCheck==1
    Ind=get(handles.svmTargets,'Value');
    Str=get(handles.svmTargets,'String');
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






function svmTrainingAccuracy_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function svmTrainingAccuracy_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function svmLogo_CreateFcn(hObject, eventdata, handles)


% --- Executes on mouse press over axes background.
function svmLogo_ButtonDownFcn(hObject, eventdata, handles)



% --- Executes on button press in svmEvaluateTrain.
function svmEvaluateTrain_Callback(hObject, eventdata, handles)
cla(handles.svmPlotROC)
load svmParameters
load svm

Ind=get(handles.svmInputs,'Value');
Str=get(handles.svmInputs,'String');
Inputs = evalin('base',cell2mat(Str(Ind)));
set(handles.svmTestingAccuracy,'String','')
pause(1)
Ind=get(handles.svmTargets,'Value');
Str=get(handles.svmTargets,'String');
Targets = evalin('base',cell2mat(Str(Ind)));

TrainTestSplit=svmParameters.TrainTestSplit;
NumTest=round(size(Inputs,1)*(1-TrainTestSplit));
Indices=svmParameters.Indices;

Train_X=Inputs(Indices(1:end-NumTest),:,:);
Train_Y=Targets(Indices(1:end-NumTest),:);

[Predicted,Actual,TrainingAccuracy]=multisvmtest(Train_X,Train_Y,models);

Ua=unique(Actual);
Up=unique(Predicted);
TC=length(Ua);
tempA=ones(size(Actual));
tempP=ones(size(Actual));
axes(handles.svmPlotROC)
perfCheck=0;
%%
for i=1:TC
    tempA=ones(size(Actual));
    tempP=ones(size(Actual));
    tempP(find(Predicted==Up(i)))=2;
    tempA(find(Actual==Ua(i)))=2;
    if length(unique(tempP))==length(unique(tempA))
        [X,Y] = perfcurve(tempP,tempA,2);
        if length(X)~=0&length(Y)~=0
            plot(X,Y,'linewidth',3)
            hold on
            perfCheck=perfCheck+1;
        else
            wrongClasses=[wrongClasses i];
        end
    end
end
%%
if perfCheck>0
    legend('Class 1','Class 2','Class 3','Class 4','Class 5','Class 6','Class 7','Class 8','Class 9','Class 10')
    set(gca,'fontsize',18)
    xlabel('False Positive')
    ylabel('True Positive')
    if perfCheck~=length(Ua)
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
    Actpi=find(Actual==Ua(i));
    TempActpi=ones(length(Actual),1);
    TempActpi(Actpi)=-1;
    for j=1:TC
        TempPredj=zeros(length(Predicted),1);
        Predj=find(Predicted==Up(j));
        TempPredj(Predj)=-1;
        dataP(i,j)=100*length(find(TempActpi==TempPredj))/length(Actpi);
    end
end

set(handles.svmConfusionMatrix,'ColumnName',ColNames)
set(handles.svmConfusionMatrix,'RowName',RowNames)
set(handles.svmConfusionMatrix,'data',[dataP])
set(handles.svmTrainingAccuracy,'String',num2str(TrainingAccuracy))

set(handles.svmEvaluateTest,'Visible','on')



function svmTrainTestSplit_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function svmTrainTestSplit_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function svmTestingAccuracy_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function svmTestingAccuracy_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in svmEvaluateTest.
function svmEvaluateTest_Callback(hObject, eventdata, handles)
cla(handles.svmPlotROC)
load svmParameters
load svm
Ind=get(handles.svmInputs,'Value');
Str=get(handles.svmInputs,'String');
Inputs = evalin('base',cell2mat(Str(Ind)));
set(handles.svmTestingAccuracy,'String','')
pause(1)
Ind=get(handles.svmTargets,'Value');
Str=get(handles.svmTargets,'String');
Targets = evalin('base',cell2mat(Str(Ind)));

TrainTestSplit=svmParameters.TrainTestSplit;
NumTest=round(size(Inputs,1)*(1-TrainTestSplit));
Indices=svmParameters.Indices;

Test_X=Inputs(Indices(NumTest+1:end),:,:);
Test_Y=Targets(Indices(NumTest+1:end),:);

[Predicted,Actual,TestingAccuracy]=multisvmtest(Test_X,Test_Y,models);

Ua=unique(Actual);
Up=unique(Predicted);
TC=length(Ua);
tempA=ones(size(Actual));
tempP=ones(size(Actual));
axes(handles.svmPlotROC)
perfCheck=0;
%%
for i=1:TC
    tempA=ones(size(Actual));
    tempP=ones(size(Actual));
    tempP(find(Predicted==Up(i)))=2;
    tempA(find(Actual==Ua(i)))=2;
    if length(unique(tempP))==length(unique(tempA))
        [X,Y] = perfcurve(tempP,tempA,2);
        if length(X)~=0&length(Y)~=0
            plot(X,Y,'linewidth',3)
            hold on
            perfCheck=perfCheck+1;
        else
            wrongClasses=[wrongClasses i];
        end
    end
end
%%
if perfCheck>0
    legend('Class 1','Class 2','Class 3','Class 4','Class 5','Class 6','Class 7','Class 8','Class 9','Class 10')
    set(gca,'fontsize',18)
    xlabel('False Positive')
    ylabel('True Positive')
    if perfCheck~=length(Ua)
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
    Actpi=find(Actual==Ua(i));
    TempActpi=ones(length(Actual),1);
    TempActpi(Actpi)=-1;
    for j=1:TC
        TempPredj=zeros(length(Predicted),1);
        Predj=find(Predicted==Up(j));
        TempPredj(Predj)=-1;
        dataP(i,j)=100*length(find(TempActpi==TempPredj))/length(Actpi);
    end
end

set(handles.svmConfusionMatrix,'ColumnName',ColNames)
set(handles.svmConfusionMatrix,'RowName',RowNames)
set(handles.svmConfusionMatrix,'data',[dataP])
set(handles.svmTestingAccuracy,'String',num2str(TestingAccuracy))

set(handles.svmSaveData,'Visible','on')
set(handles.svmMatFile,'Visible','on')
set(handles.svmXlsxFile,'Visible','on')
set(handles.svmCsvFile,'Visible','on')



% --- Executes on button press in svmMatFile.
function svmMatFile_Callback(hObject, eventdata, handles)


% --- Executes on button press in svmCsvFile.
function svmCsvFile_Callback(hObject, eventdata, handles)


% --- Executes on button press in svmXlsxFile.
function svmXlsxFile_Callback(hObject, eventdata, handles)


% --- Executes on button press in svmSaveData.
function svmSaveData_Callback(hObject, eventdata, handles)
load DBNVal
csvCheck=get(handles.svmCsvFile,'Value');
matCheck=get(handles.svmMatFile,'Value');
xlsxCheck=get(handles.svmXlsxFile,'Value');
if xlsxCheck+csvCheck+matCheck>1
    msgbox('Uncheck other options')
elseif xlsxCheck+csvCheck+matCheck==0
    msgbox('Select an output format')
else
    if xlsxCheck==1
        data=[Expected Actual];
        xlswrite('NetworkOutput.xlsx',data)
    elseif csvCheck==1
        data=[Expected Actual];
        xlswrite('NetworkOutput.csv',data)
    else
        save('NetworkOutput.mat','test_x','Actual','Expected')
    end
end



% --- Executes on button press in svmStep2Clear.
function svmStep2Clear_Callback(hObject, eventdata, handles)
% set(handles.hiddenNeurons,'String','')
% ind=get(handles.ActivationFunction,'Value');
% strP=get(handles.ActivationFunction,'String');
% ActivationFunction=(strP(ind,:));
% set(handles.ActivationFunction,'Value',1)


% --- Executes on button press in svmStep2.
function svmStep2_Callback(hObject, eventdata, handles)
set(handles.svmNetworkBG,'Title','Network Parameters (A)')
set(handles.svmNetworkBG,'Visible','on')
set(handles.svmStep3,'String','Step 3 (A)')


% --- Executes on button press in svmStep3.
function svmStep3_Callback(hObject, eventdata, handles)
CheckString=get(handles.svmStep3,'String');
if strcmp(CheckString,'Step 3 (A)')==1
    CheckString=get(handles.svmNetworkBG,'Title');
    if strcmp(CheckString,'Network Parameters (A)')==1
        
        set(handles.svmTrainBG,'Title','Train (A)')
        set(handles.svmTrainBG,'Visible','on')
    else
        msgbox('Please properly import Inputs and Targets and then hit "Step 2" button')
    end
else
    msgbox('Set SVM Parameters')
end


% --- Executes on slider movement.
function svmMaxIter_Callback(hObject, eventdata, handles)
CheckString=get(handles.svmNetworkBG,'Title');
if strcmp(CheckString,'Network Parameters (A)')==1
    load svmParameters
    Val=linspace(1000,1000000,1000);
    Ind=round(get(handles.svmMaxIter,'Value')*999)+1;
    svmParameters.MaxIter=Val(Ind);
    set(handles.svmMaxIterText,'String',num2str(Val(Ind)))
    save('svmParameters.mat','svmParameters')
else
    msgbox('Import Inputs and Targets and then hit "Step 2" first')
end
% hObject    handle to svmMaxIter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function svmMaxIter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to svmMaxIter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function svmTolFun_Callback(hObject, eventdata, handles)
CheckString=get(handles.svmNetworkBG,'Title');
if strcmp(CheckString,'Network Parameters (A)')==1
    load svmParameters
    Val=linspace(.0001,.1,1000);
    Ind=round(get(handles.svmTolFun,'Value')*999)+1;
    svmarameters.TolFun=Val(Ind);
    set(handles.svmTolFunText,'String',num2str(Val(Ind)))
    save('svmParameters.mat','svmParameters')
else
    msgbox('Import Inputs and Targets and then hit "Step 2" first')
end
% hObject    handle to svmTolFun (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function svmTolFun_CreateFcn(hObject, eventdata, handles)
% hObject    handle to svmTolFun (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function svmStopCrit_Callback(hObject, eventdata, handles)
CheckString=get(handles.svmNetworkBG,'Title');
if strcmp(CheckString,'Network Parameters (A)')==1
    load svmParameters
    Val=linspace(.0001,.1,1000);
    Ind=round(get(handles.svmStopCrit,'Value')*999)+1;
    svmParameters.StopCrit=Val(Ind);
    set(handles.svmStopCritText,'String',num2str(Val(Ind)))
    save('svmParameters.mat','svmParameters')
else
    msgbox('Import Inputs and Targets and then hit "Step 2" first')
end
% hObject    handle to svmStopCrit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function svmStopCrit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to svmStopCrit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in svmDisplayIterYes.
function svmDisplayIterYes_Callback(hObject, eventdata, handles)
CheckString=get(handles.svmNetworkBG,'Title');
if strcmp(CheckString,'Network Parameters (A)')==1
    load svmParameters
    Val=get(handles.svmDisplayIterYes,'Value');
    svmParameters.DisplayIter=Val;
    save('svmParameters.mat','svmParameters')
else
    msgbox('Import Inputs and Targets and then hit "Step 2" first')
end
% hObject    handle to svmDisplayIterYes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of svmDisplayIterYes


% --- Executes on button press in svmDisplayIterNo.
function svmDisplayIterNo_Callback(hObject, eventdata, handles)
CheckString=get(handles.svmNetworkBG,'Title');
if strcmp(CheckString,'Network Parameters (A)')==1
    load svmParameters
    Val=get(handles.svmDisplayIterNo,'Value');
    svmParameters.DisplayIter=~Val;
    save('svmParameters.mat','svmParameters')
    set(handles.svmDisplayIterYes,'Value',0)
else
    msgbox('Import Inputs and Targets and then hit "Step 2" first')
end
% hObject    handle to svmDisplayIterNo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of svmDisplayIterNo


% --- Executes on button press in svmTrain.
function svmTrain_Callback(hObject, eventdata, handles)
CheckString=get(handles.svmTrainBG,'Title');
if strcmp(CheckString,'Train (A)')==1
    load svmParameters
    if exist('scmStruct.mat')==2
        delete('svmStruct.mat')
    end
    Ind=get(handles.svmInputs,'Value');
    Str=get(handles.svmInputs,'String');
    Inputs = evalin('base',cell2mat(Str(Ind)));
    set(handles.svmTestingAccuracy,'String','')
    pause(1)
    Ind=get(handles.svmTargets,'Value');
    Str=get(handles.svmTargets,'String');
    Targets = evalin('base',cell2mat(Str(Ind)));
    
    TrainTestSplit=svmParameters.TrainTestSplit;
    NumTest=round(size(Inputs,1)*(1-TrainTestSplit));
    Indices=randperm(size(Inputs,1));
    svmParameters.Indices=Indices;
    
    Train_X=Inputs(Indices(1:end-NumTest),:,:);
    Train_Y=Targets(Indices(1:end-NumTest),:);
    
    Test_X=Inputs(Indices(end-NumTest+1:end),:,:);
    Test_Y=Targets(Indices(end-NumTest+1:end),:);
    
    MaxIter=svmParameters.MaxIter;
    TolFun=svmParameters.TolFun;
    StopCrit=svmParameters.StopCrit;
    DisplayIter=svmParameters.DisplayIter;
    RBF_Sigma=svmParameters.RBF_Sigma;
    PolynomialOrder=svmParameters.PolynomialOrder;
    Method=svmParameters.Method;
    KernelFunction=svmParameters.KernelFunction;
    
    if DisplayIter==1
        options=optimset('MaxIter',MaxIter,'Display','iter','TolFun',TolFun);
    else
        options=optimset('MaxIter',MaxIter,'TolFun',TolFun);
    end
    options.StopCrit=StopCrit;
    options.RBF_Sigma= RBF_Sigma;
    options.PolynomialOrder=PolynomialOrder;
    options.Method=Method;
    options.KernelFunction=KernelFunction;
    
    tic
    [models] = multisvmtrain(Train_X,Train_Y,options);
    T=toc;
    models.TrainingTime=T;
    msgbox('Training Complete')
    save('svm.mat','models')
    save('svmParameters.mat','svmParameters')
    
    set(handles.svmEvaluateTrain,'visible','on')
    set(handles.svmResultsBG,'visible','on')
else
    msgbox('Please set SVM parameters 1st')
end

    % hObject    handle to svmTrain (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in svmKernelFunction.
function svmKernelFunction_Callback(hObject, eventdata, handles)
CheckString=get(handles.svmNetworkBG,'Title');
if strcmp(CheckString,'Network Parameters (A)')==1
    load svmParameters
    Str=get(handles.svmKernelFunction,'String');
    Ind=get(handles.svmKernelFunction,'Value');
    svmParameters.KernelFunction=strtrim(Str(Ind,:))
    save('svmParameters.mat','svmParameters')
else
    msgbox('Import Inputs and Targets and then hit "Step 2" first')
end
% hObject    handle to svmKernelFunction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns svmKernelFunction contents as cell array
%        contents{get(hObject,'Value')} returns selected item from svmKernelFunction


% --- Executes during object creation, after setting all properties.
function svmKernelFunction_CreateFcn(hObject, eventdata, handles)
% hObject    handle to svmKernelFunction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function svmRBF_Sigma_Callback(hObject, eventdata, handles)
CheckString=get(handles.svmNetworkBG,'Title');
if strcmp(CheckString,'Network Parameters (A)')==1
    load svmParameters
    Val=linspace(.1,1,1000);
    Ind=round(get(handles.svmRBF_Sigma,'Value')*999)+1;
    svmParameters.RBF_Sigma=Val(Ind);
    set(handles.svmRBF_SigmaText,'String',num2str(Val(Ind)));
    save('svmParameters.mat','svmParameters')
else
    msgbox('Import Inputs and Targets and then hit "Step 2" first')
end
% hObject    handle to svmRBF_Sigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function svmRBF_Sigma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to svmRBF_Sigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on selection change in svmMethod.
function svmMethod_Callback(hObject, eventdata, handles)
CheckString=get(handles.svmNetworkBG,'Title');
if strcmp(CheckString,'Network Parameters (A)')==1
    load svmParameters
    Str=get(handles.svmMethod,'String');
    Ind=get(handles.svmMethod,'Value');
    svmParameters.Method=strtrim(Str(Ind,:));
    save('svmParameters.mat','svmParameters')
else
    msgbox('Import Inputs and Targets and then hit "Step 2" first')
end
% hObject    handle to svmMethod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns svmMethod contents as cell array
%        contents{get(hObject,'Value')} returns selected item from svmMethod


% --- Executes during object creation, after setting all properties.
function svmMethod_CreateFcn(hObject, eventdata, handles)
% hObject    handle to svmMethod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in svmPolynomialOrder.
function svmPolynomialOrder_Callback(hObject, eventdata, handles)
CheckString=get(handles.svmNetworkBG,'Title');
if strcmp(CheckString,'Network Parameters (A)')==1
    load svmParameters
    Str=get(handles.svmPolynomialOrder,'String');
    Ind=get(handles.svmPolynomialOrder,'Value');
    svmParameters.PolynomialOrder=str2num(strtrim(Str(Ind,:)))
    save('svmParameters.mat','svmParameters')
else
    msgbox('Import Inputs and Targets and then hit "Step 2" first')
end
% hObject    handle to svmPolynomialOrder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns svmPolynomialOrder contents as cell array
%        contents{get(hObject,'Value')} returns selected item from svmPolynomialOrder


% --- Executes during object creation, after setting all properties.
function svmPolynomialOrder_CreateFcn(hObject, eventdata, handles)
% hObject    handle to svmPolynomialOrder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in svmStep1Clear.
function svmStep1Clear_Callback(hObject, eventdata, handles)
% hObject    handle to svmStep1Clear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
