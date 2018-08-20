function varargout = FisherBayesLeastSquaresPCA_GUI(varargin)
%%
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @FisherBayesLeastSquaresPCA_GUI_OpeningFcn, ...
    'gui_OutputFcn',  @FisherBayesLeastSquaresPCA_GUI_OutputFcn, ...
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


% --- Executes just before FisherBayesLeastSquaresPCA_GUI is made visible.
function FisherBayesLeastSquaresPCA_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
axes(handles.linearLogo)
Img=imread('logo.jpg');
imshow(Img)
set(handles.linearTrainTestSplit,'String',70);
if exist('linearParameters.mat')==2
   load linearParameters
end


TolV=round(999*.4)+1;
V=logspace(1,6,1000)/10e5;
Tol=V(TolV);
set(handles.lscTolVal,'String','.001')
set(handles.lscTol,'Value',.4)

linearParameters.TrainTestSplit=0.7;
if exist('linearParameters.mat')==2
    delete('linearParameters.mat')
end
save('linearParameters.mat','linearParameters')

handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

addpath(genpath(pwd))

if exist('fisher.mat')==2
    delete('fisher.mat')
end

if exist('lsc.mat')==2
    delete('lsc.mat')
end

if exist('NDim.mat')==2
    delete('NDim.mat')
end

if exist('PCAMap.mat')==2
    delete('PCAMap.mat')
end


if exist('naivebayes.mat')==2
    delete('naivebayes.mat')
end
% --- Outputs from this function are returned to the command line.
function varargout = FisherBayesLeastSquaresPCA_GUI_OutputFcn(hObject, eventdata, handles)

varargout{1} = handles.output;


function linearWorkspaceList_Callback(hObject, eventdata, handles)


function linearWorkspaceList_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in loadWorkspace.
function loadWorkspace_Callback(hObject, eventdata, handles)
set(handles.linearImportInputs,'Visible','on')
set(handles.linearInputs,'Visible','on')
Vars = evalin('base','who');
set(handles.linearWorkspaceList,'String',Vars)


% --- Executes on selection change in linearInputs.
function linearInputs_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function linearInputs_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in linearImportInputs.
function linearImportInputs_Callback(hObject, eventdata, handles)
load linearParameters
set(handles.linearImportTargets,'Visible','on')
set(handles.linearTargets,'Visible','on')
Ind=get(handles.linearWorkspaceList,'Value');
Str=get(handles.linearWorkspaceList,'String');
Var = evalin('base',cell2mat(Str(Ind)));
NDim=size(Var,2);
save('NDim.mat','NDim')
linearParameters.NDim=NDim;
save('linearParameters.mat','linearParameters')
set(handles.linearInputs,'String',Str(Ind));


% --- Executes on selection change in linearTargets.
function linearTargets_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function linearTargets_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in linearImportTargets.
function linearImportTargets_Callback(hObject, eventdata, handles)
set(handles.linearStep2,'Visible','on')
set(handles.linearStep2,'String','Step 2 (A)')
Ind=get(handles.linearWorkspaceList,'Value');
Str=get(handles.linearWorkspaceList,'String');
Var = evalin('base',cell2mat(Str(Ind)));
set(handles.linearTargets,'String',Str(Ind));

Ind=get(handles.linearInputs,'Value');
Str=get(handles.linearInputs,'String');
InputsCheck=length(Str)>0;
if length(Str)==0
    msgbox('Please select Inputs first and then import them')
else
    Inputs = evalin('base',cell2mat(Str(Ind)));
end
if InputsCheck==1
    Ind=get(handles.linearTargets,'Value');
    Str=get(handles.linearTargets,'String');
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


function linearPrecision_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function linearPrecision_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function linearLogo_CreateFcn(hObject, eventdata, handles)


% --- Executes on mouse press over axes background.
function linearLogo_ButtonDownFcn(hObject, eventdata, handles)



function linearTrainTestSplit_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function linearTrainTestSplit_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function linearRecall_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function linearRecall_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in fisherTrain.
function fisherTrain_Callback(hObject, eventdata, handles)
CheckString=get(handles.fisherLDABG,'Title');
Check=get(handles.fisherSelect,'Value');
if Check==1
    if strcmp(CheckString,'Fisher LDA (A)')==1
        Ind=get(handles.linearInputs,'Value');
        Str=get(handles.linearInputs,'String');
        if length(Str)==0
            msgbox('Please select Inputs first and then import them')
        else
            Inputs = evalin('base',cell2mat(Str(Ind)));
        end
        if size(Inputs,2)>size(Inputs,1)
            msgbox('Warning ! Data is under defined. Number of entries should be greater than or equal to number of features')
        end
        Ind=get(handles.linearTargets,'Value');
        Str=get(handles.linearTargets,'String');
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
        PCACheck=get(handles.pcaYes,'Val');
        if PCACheck==1
            load NDim
            [Inputs, Map] = prin_comp_analysis(Inputs, NDim);
            save('PCAMap.mat','Map')
        end
        load linearParameters
        TrainTestSplit=str2num(get(handles.linearTrainTestSplit,'String'));
        TrainTestSplit=linearParameters.TrainTestSplit;
        NumTest=round(size(Inputs,1)*(1-TrainTestSplit));
        Indices=randperm(size(Inputs,1));
        linearParameters.Indices=Indices;
        save('linearParameters.mat','linearParameters')
        
        Train_X=Inputs(Indices(1:end-NumTest),:,:);
        Train_Y=Targets(Indices(1:end-NumTest),:);
        
        Test_X=Inputs(Indices(end-NumTest+1:end),:,:);
        Test_Y=Targets(Indices(end-NumTest+1:end),:);
        
        tic
        fisher=fisher_training(Train_X,Train_Y);
        T=toc;
        fisher.TrainingTime=T;
        save('fisher.mat','fisher')
        msgbox('Fisher Object Trained')
        
    else
        msgbox('Please Import inputs and targets first')
    end
else
    msgbox('Some or no other model is selected, Please select Fisher')
end
% hObject    handle to fisherTrain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in fisherEvaluateTrain.
function fisherEvaluateTrain_Callback(hObject, eventdata, handles)
if exist('fisher.mat')==2
    load fisher
    if isfield(fisher,'Thresh')==1
    load linearParameters
    
    Ind=get(handles.linearInputs,'Value');
    Str=get(handles.linearInputs,'String');
    if length(Str)==0
        msgbox('Please select Inputs first and then import them')
    else
        Inputs = evalin('base',cell2mat(Str(Ind)));
    end
    if size(Inputs,2)>size(Inputs,1)
        msgbox('Warning ! Data is under defined. Number of entries should be greater than or equal to number of features')
    end
    Ind=get(handles.linearTargets,'Value');
    Str=get(handles.linearTargets,'String');
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
    
    PCACheck=get(handles.pcaYes,'Val');
    if PCACheck==1&exist('PCAMap.mat')==2
        load PCAMap
    end
    
    TrainTestSplit=linearParameters.TrainTestSplit;
    NumTest=round(size(Inputs,1)*(1-TrainTestSplit));
    Indices=linearParameters.Indices;
    
    Train_X=Inputs(Indices(1:end-NumTest),:,:);
    Train_Y=Targets(Indices(1:end-NumTest),:);

    [Predicted,Precision,Recall,Accuracy,F1,Actual]=fisher_testing(fisher,Train_X,Train_Y,1);
    set(handles.linearPrecision,'String',num2str(Precision))
    set(handles.linearRecall,'String',num2str(Recall))
    set(handles.linearAccuracy,'String',num2str(Accuracy))
    
    %%
    Ua=unique(Actual);
    Up=unique(Predicted);
    TC=length(Up);
    TempA=ones(size(Actual));
    TempP=ones(size(Actual));
    axes(handles.linearPlotROC)
    cla(handles.linearPlotROC)
    PerfCheck=0;
    %%
    for i=1:TC
        TempA=ones(size(Actual));
        TempP=ones(size(Actual));
        TempA(find(Actual~=Ua(i)))=2;
        TempP(find(Predicted~=Up(i)))=2;
        if length(unique(TempP))==length(unique(TempA))
            [X,Y] = perfcurve(TempA,TempP,2);
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
    
    
    ColNames=[];
    RowNames=[];
    for i=1:TC
        ColNames=[ColNames {['Class' num2str(i)]}];
        RowNames=[RowNames;{['Class' num2str(i)]}];
    end
    
    
    for i=1:TC
        Acti=find(Actual==Ua(i));
        TempActi=ones(length(Actual),1);
        TempActi(Acti)=-1;
        for j=1:TC
            TempPredj=zeros(length(Predicted),1);
            Predj=find(Predicted==Up(j));
            TempPredj(Predj)=-1;
            dataP(i,j)=100*length(find(TempActi==TempPredj))/length(Acti);
        end
    end
    
    set(handles.linearConfusionMatrix,'ColumnName',ColNames)
    set(handles.linearConfusionMatrix,'RowName',RowNames)
    set(handles.linearConfusionMatrix,'data',[dataP])
    else
        msgbox('Fisher Object not trained properly. Try training again by applying PCA to inputs first')
    end
    
else
    msgbox('No Trained Fisher object found')
end

% hObject    handle to fisherEvaluateTrain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in fisherEvaluateTest.
function fisherEvaluateTest_Callback(hObject, eventdata, handles)
if exist('fisher.mat')==2
    load fisher
    if isfield(fisher,'Thresh')==1
    load linearParameters
    
    Ind=get(handles.linearInputs,'Value');
    Str=get(handles.linearInputs,'String');
    if length(Str)==0
        msgbox('Please select Inputs first and then import them')
    else
        Inputs = evalin('base',cell2mat(Str(Ind)));
    end
    if size(Inputs,2)>size(Inputs,1)
        msgbox('Warning ! Data is under defined. Number of entries should be greater than or equal to number of features')
    end
    Ind=get(handles.linearTargets,'Value');
    Str=get(handles.linearTargets,'String');
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
    
    PCACheck=get(handles.pcaYes,'Val');
    if PCACheck==1&exist('PCAMap.mat')==2
        load PCAMap
%         linearInputs = linearInputs * Map.M;
    end
    
    TrainTestSplit=linearParameters.TrainTestSplit;
    NumTest=round(size(Inputs,1)*(1-TrainTestSplit));
    Indices=linearParameters.Indices;

    Test_X=Inputs(Indices(end-NumTest+1:end),:,:);
    Test_Y=Targets(Indices(end-NumTest+1:end),:);
    [Predicted,Precision,Recall,Accuracy,F1,Actual]=fisher_testing(fisher,Test_X,Test_Y,1);
    set(handles.linearPrecision,'String',num2str(Precision))
    set(handles.linearRecall,'String',num2str(Recall))
    set(handles.linearAccuracy,'String',num2str(Accuracy))
    
    %%   
    Ua=unique(Actual);
    Up=unique(Predicted);
    TC=length(Up);
    TempA=ones(size(Actual));
    TempP=ones(size(Actual));
    axes(handles.linearPlotROC)
    cla(handles.linearPlotROC)
    PerfCheck=0;
    %%
    for i=1:TC
        TempA=ones(size(Actual));
        TempP=ones(size(Actual));
        TempA(find(Actual~=Ua(i)))=2;
        TempP(find(Predicted~=Up(i)))=2;
        if length(unique(TempP))==length(unique(TempA))
            [X,Y] = perfcurve(TempA,TempP,2);
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
    
    
    ColNames=[];
    RowNames=[];
    for i=1:TC
        ColNames=[ColNames {['Class' num2str(i)]}];
        RowNames=[RowNames;{['Class' num2str(i)]}];
    end
    
    
    for i=1:TC
        Acti=find(Actual==Ua(i));
        TempActi=ones(length(Actual),1);
        TempActi(Acti)=-1;
        for j=1:TC
            TempPredj=zeros(length(Predicted),1);
            Predj=find(Predicted==Up(j));
            TempPredj(Predj)=-1;
            dataP(i,j)=100*length(find(TempActi==TempPredj))/length(Acti);
        end
    end
    
    set(handles.linearConfusionMatrix,'ColumnName',ColNames)
    set(handles.linearConfusionMatrix,'RowName',RowNames)
    set(handles.linearConfusionMatrix,'data',[dataP])
    else
        msgbox('Fisher Object not trained properly. Try training again by applying PCA to inputs first')
    end
  
else
    msgbox('No Trained Fisher object found')
end
% hObject    handle to fisherEvaluateTest (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in lscTrain.
function lscTrain_Callback(hObject, eventdata, handles)
CheckString=get(handles.lscBG,'Title');
Check=get(handles.lscSelect,'Value');
if Check==1
    if strcmp(CheckString,'LSC (A)')==1
        Ind=get(handles.linearInputs,'Value');
        Str=get(handles.linearInputs,'String');
        if length(Str)==0
            msgbox('Please select Inputs first and then import them')
        else
            Inputs = evalin('base',cell2mat(Str(Ind)));
        end
        if size(Inputs,2)>size(Inputs,1)
            msgbox('Warning ! Data is under defined. Number of entries should be greater than or equal to number of features')
        end
        Ind=get(handles.linearTargets,'Value');
        Str=get(handles.linearTargets,'String');
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
        
        PCACheck=get(handles.pcaYes,'Val');
        if PCACheck==1
            load NDim
            [Inputs, Map] = prin_comp_analysis(Inputs, NDim);
            save('PCAMap.mat','Map')
        end

        load linearParameters
        TrainTestSplit=linearParameters.TrainTestSplit;
        
        NumTest=round(size(Inputs,1)*(1-TrainTestSplit));
        Indices=randperm(size(Inputs,1));
        linearParameters.Indices=Indices;
        save('linearParameters.mat','linearParameters')
        
        Train_X=Inputs(Indices(1:end-NumTest),:);
        Train_Y=Targets(Indices(1:end-NumTest),:);
        
        Test_X=Inputs(Indices(end-NumTest+1:end),:);
        Test_Y=Targets(Indices(end-NumTest+1:end),:);
        
        Tol=linearParameters.Tol;
        tic
        [lsc] = lsc_train(Train_X,Train_Y,Tol)
        T=toc;
        lsc.TrainingTime=T;
        save('lsc.mat','lsc')

        msgbox('LSC Object Trained')

    else
        msgbox('Please Import inputs and targets first')
    end
else
    msgbox('Some or no other model is selected, Please Select LSC')
end
% hObject    handle to lscTrain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in lscEvaluateTrain.
function lscEvaluateTrain_Callback(hObject, eventdata, handles)
if exist('lsc.mat')==2
    load lsc
    load linearParameters
    
    Ind=get(handles.linearInputs,'Value');
    Str=get(handles.linearInputs,'String');
    if length(Str)==0
        msgbox('Please select Inputs first and then import them')
    else
        Inputs = evalin('base',cell2mat(Str(Ind)));
    end
    if size(Inputs,2)>size(Inputs,1)
        msgbox('Warning ! Data is under defined. Number of entries should be greater than or equal to number of features')
    end
    Ind=get(handles.linearTargets,'Value');
    Str=get(handles.linearTargets,'String');
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
    
    PCACheck=get(handles.pcaYes,'Val');
    if PCACheck==1&exist('PCAMap.mat')==2
        load PCAMap
        size(Inputs)
%         linearInputs = linearInputs * Map.M;
    end
    
    TrainTestSplit=linearParameters.TrainTestSplit;
    NumTest=round(size(Inputs,1)*(1-TrainTestSplit));
    Indices=linearParameters.Indices;
    
    Train_X=Inputs(Indices(1:end-NumTest),:,:);
    Train_Y=Targets(Indices(1:end-NumTest),:);

    [Predicted, Precision, Recall, Accuracy] = lsc_test(lsc,Train_X,Train_Y);
    set(handles.linearPrecision,'String',num2str(Precision))
    set(handles.linearRecall,'String',num2str(Recall))
    set(handles.linearAccuracy,'String',num2str(Accuracy))
    
    %%
    Actual=ones(size(Train_Y,1),1);
    for i=1:size(Train_Y,2)
        Ind=find(Train_Y(:,i)==1);
        Actual(Ind,1)=i;
    end
    save('data.mat','Actual','Predicted')
    Ua=unique(Actual);
    Up=unique(Predicted);
    TC=length(Up);
    TempA=ones(size(Actual));
    TempP=ones(size(Actual));
    axes(handles.linearPlotROC)
    cla
    PerfCheck=0;
    %%
    for i=1:TC
        TempA=ones(size(Actual));
        TempP=ones(size(Actual));
        TempA(find(Actual~=Ua(i)))=2;
        TempP(find(Predicted~=Up(i)))=2;
        if length(unique(TempP))==length(unique(TempA))
            [X,Y] = perfcurve(TempA,TempP,2);
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
    
    
    ColNames=[];
    RowNames=[];
    for i=1:TC
        ColNames=[ColNames {['Class' num2str(i)]}];
        RowNames=[RowNames;{['Class' num2str(i)]}];
    end
    
    
    for i=1:TC
        Acti=find(Actual==Ua(i));
        TempActi=ones(length(Actual),1);
        TempActi(Acti)=-1;
        for j=1:TC
            TempPredj=zeros(length(Predicted),1);
            Predj=find(Predicted==Up(j));
            TempPredj(Predj)=-1;
            dataP(i,j)=100*length(find(TempActi==TempPredj))/length(Acti);
        end
    end
    
    set(handles.linearConfusionMatrix,'ColumnName',ColNames)
    set(handles.linearConfusionMatrix,'RowName',RowNames)
    set(handles.linearConfusionMatrix,'data',[dataP])

    
else
    msgbox('No Trained LSC object found')
end
% hObject    handle to lscEvaluateTrain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in lscEvaluateTest.
function lscEvaluateTest_Callback(hObject, eventdata, handles)
if exist('lsc.mat')==2
    load lsc
    load linearParameters
    
    Ind=get(handles.linearInputs,'Value');
    Str=get(handles.linearInputs,'String');
    if length(Str)==0
        msgbox('Please select Inputs first and then import them')
    else
        Inputs = evalin('base',cell2mat(Str(Ind)));
    end
    if size(Inputs,2)>size(Inputs,1)
        msgbox('Warning ! Data is under defined. Number of entries should be greater than or equal to number of features')
    end
    Ind=get(handles.linearTargets,'Value');
    Str=get(handles.linearTargets,'String');
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

    PCACheck=get(handles.pcaYes,'Val');
    if PCACheck==1&exist('PCAMap.mat')==2
        load PCAMap
%         linearInputs = linearInputs * Map.M;
    end
    
    TrainTestSplit=linearParameters.TrainTestSplit;
    NumTest=round(size(Inputs,1)*(1-TrainTestSplit));
    Indices=linearParameters.Indices;
    
    Test_X=Inputs(Indices(end-NumTest+1:end),:,:);
    Test_Y=Targets(Indices(end-NumTest+1:end),:);

    [Predicted, Precision, Recall, Accuracy] = lsc_test(lsc,Test_X,Test_Y);
    set(handles.linearPrecision,'String',num2str(Precision))
    set(handles.linearRecall,'String',num2str(Recall))
    set(handles.linearAccuracy,'String',num2str(Accuracy))
    
    %%
    Actual=ones(size(Test_Y,1),1);
    for i=1:size(Test_Y,2)
        Ind=find(Test_Y(:,i)==1);
        Actual(Ind,1)=i;
    end
    Ua=unique(Actual);
    Up=unique(Predicted);
    TC=length(Ua);
    TempA=ones(size(Actual));
    TempP=ones(size(Actual));
    axes(handles.linearPlotROC)
    cla
    PerfCheck=0;
    %%
    for i=1:TC
        TempA=ones(size(Actual));
        TempP=ones(size(Actual));
        TempA(find(Actual~=Ua(i)))=2;
        TempP(find(Predicted~=Ua(i)))=2;
        if length(unique(TempP))==length(unique(TempA))
            [X,Y] = perfcurve(TempA,TempP,2);
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
    
    
    ColNames=[];
    RowNames=[];
    for i=1:TC
        ColNames=[ColNames {['Class' num2str(i)]}];
        RowNames=[RowNames;{['Class' num2str(i)]}];
    end
    
    
    for i=1:TC
        Acti=find(Actual==Ua(i));
        TempActi=ones(length(Actual),1);
        TempActi(Acti)=-1;
        for j=1:TC
            TempPredj=zeros(length(Predicted),1);
            Predj=find(Predicted==Ua(j));
            TempPredj(Predj)=-1;
            dataP(i,j)=100*length(find(TempActi==TempPredj))/length(Acti);
        end
    end
    
    set(handles.linearConfusionMatrix,'ColumnName',ColNames)
    set(handles.linearConfusionMatrix,'RowName',RowNames)
    set(handles.linearConfusionMatrix,'data',[dataP])

    %%
    
    
else
    msgbox('No Trained LSC object found')
end
% hObject    handle to lscEvaluateTest (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in nbTrain.
function nbTrain_Callback(hObject, eventdata, handles)
CheckString=get(handles.nbBG,'Title');
Check=get(handles.nbSelect,'Value');
if Check==1
    if strcmp(CheckString,'Naive Bayes (A)')==1
        Ind=get(handles.linearInputs,'Value');
        Str=get(handles.linearInputs,'String');
        if length(Str)==0
            msgbox('Please select Inputs first and then import them')
        else
            Inputs = evalin('base',cell2mat(Str(Ind)));
        end
        if size(Inputs,2)>size(Inputs,1)
            msgbox('Warning ! Data is under defined. Number of entries should be greater than or equal to number of features')
        end
        Ind=get(handles.linearTargets,'Value');
        Str=get(handles.linearTargets,'String');
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
        
        PCACheck=get(handles.pcaYes,'Val');
        if PCACheck==1
            load NDim
            [Inputs, Map] = prin_comp_analysis(Inputs, NDim);
            save('PCAMap.mat','Map')
        end
        
        load linearParameters
        TrainTestSplit=linearParameters.TrainTestSplit;
        
        NumTest=round(size(Inputs,1)*(1-TrainTestSplit));
        Indices=randperm(size(Inputs,1));
        linearParameters.Indices=Indices;
        save('linearParameters.mat','linearParameters')
        
        Train_X=Inputs(Indices(1:end-NumTest),:);
        Train_Y=Targets(Indices(1:end-NumTest),:);
        
        Test_X=Inputs(Indices(end-NumTest+1:end),:);
        Test_Y=Targets(Indices(end-NumTest+1:end),:);
        tic
        [naivebayes] = naive_bayes_train(Train_X, Train_Y);
        T=toc;
        naivebayes.TrainingTime=T;
        save('naivebayes.mat','naivebayes')
        msgbox('Naive Bayes object trained')
    else
        msgbox('Please Import inputs and targets first')
    end
else
    msgbox('Some or no other model is selected, Please select Naive Bayes')
end
% hObject    handle to nbTrain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in nbEvaluateTrain.
function nbEvaluateTrain_Callback(hObject, eventdata, handles)
if exist('naivebayes.mat')==2
    load naivebayes
    load linearParameters
    
    Ind=get(handles.linearInputs,'Value');
    Str=get(handles.linearInputs,'String');
    if length(Str)==0
        msgbox('Please select Inputs first and then import them')
    else
        Inputs = evalin('base',cell2mat(Str(Ind)));
    end
    if size(Inputs,2)>size(Inputs,1)
        msgbox('Warning ! Data is under defined. Number of entries should be greater than or equal to number of features')
    end
    Ind=get(handles.linearTargets,'Value');
    Str=get(handles.linearTargets,'String');
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

    PCACheck=get(handles.pcaYes,'Val');
    if PCACheck==1&exist('PCAMap.mat')==2
        load PCAMap
%         linearInputs = linearInputs - repmat(Map.mean, [size(linearInputs, 1) 1]);
%         linearInputs = linearInputs * Map.M;
    end
    
    TrainTestSplit=linearParameters.TrainTestSplit;
    NumTest=round(size(Inputs,1)*(1-TrainTestSplit));
    Indices=linearParameters.Indices;
    
    Train_X=Inputs(Indices(1:end-NumTest),:,:);
    Train_Y=Targets(Indices(1:end-NumTest),:);

    [Predicted, Precision, Recall, Accuracy] = naive_bayes_test(naivebayes,Train_X,Train_Y);
    set(handles.linearPrecision,'String',num2str(Precision))
    set(handles.linearRecall,'String',num2str(Recall))
    set(handles.linearAccuracy,'String',num2str(Accuracy))
    
    %%
    [Xa,Ya,ColNames,RowNames,dataP] = perfEvaluate(Train_Y,Predicted,handles.linearPlotROC);
    
    %%
%     Actual=ones(size(Train_Y,1),1);
%     for i=1:size(Train_Y,2)
%         Ind=find(Train_Y(:,i)==1);
%         Actual(Ind,1)=i;
%     end
%     Ua=unique(Actual);
%     Up=unique(Predicted);
%     TC=length(Up);
%     TempA=ones(size(Actual));
%     TempP=ones(size(Actual));
%     axes(handles.linearPlotROC)
%     cla
%     PerfCheck=0;
%     %%
%     for i=1:TC
%         TempA=ones(size(Actual));
%         TempP=ones(size(Actual));
%         TempA(find(Actual~=Ua(i)))=2;
%         TempP(find(Predicted~=Up(i)))=2;
%         if length(unique(TempP))==length(unique(TempA))
%             [X,Y] = perfcurve(TempA,TempP,2);
%             if length(X)~=0&length(Y)~=0
%                 plot(X,Y,'linewidth',3)
%                 hold on
%                 PerfCheck=PerfCheck+1;
%             else
%                 WrongClasses=[WrongClasses i];
%             end
%         end
%     end
%     %%
%     if PerfCheck>0
%         legend('Class 1','Class 2','Class 3','Class 4','Class 5','Class 6','Class 7','Class 8','Class 9','Class 10')
%         set(gca,'fontsize',18)
%         xlabel('False Positive')
%         ylabel('True Positive')
%         if PerfCheck~=length(Up)
%             msgbox('Some Classes are missing')
%         end
%     else
%         msgbox('Performance curve cannot be plotted, there is only one class in predicted data')
%     end
%     
%     
%     ColNames=[];
%     RowNames=[];
%     for i=1:TC
%         ColNames=[ColNames {['Class' num2str(i)]}];
%         RowNames=[RowNames;{['Class' num2str(i)]}];
%     end
%     
%     
%     for i=1:TC
%         Acti=find(Actual==Ua(i));
%         TempActi=ones(length(Actual),1);
%         TempActi(Acti)=-1;
%         for j=1:TC
%             TempPredj=zeros(length(Predicted),1);
%             Predj=find(Predicted==Up(j));
%             TempPredj(Predj)=-1;
%             dataP(i,j)=100*length(find(TempActi==TempPredj))/length(Acti);
%         end
%     end
    
    set(handles.linearConfusionMatrix,'ColumnName',ColNames)
    set(handles.linearConfusionMatrix,'RowName',RowNames)
    set(handles.linearConfusionMatrix,'data',[dataP])

    
else
    msgbox('No Trained Naive Bayes object found')
end

% hObject    handle to nbEvaluateTrain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in nbEvaluateTest.
function nbEvaluateTest_Callback(hObject, eventdata, handles)
if exist('naivebayes.mat')==2
    load naivebayes
    load linearParameters
    
    Ind=get(handles.linearInputs,'Value');
    Str=get(handles.linearInputs,'String');
    if length(Str)==0
        msgbox('Please select Inputs first and then import them')
    else
        Inputs = evalin('base',cell2mat(Str(Ind)));
    end
    if size(Inputs,2)>size(Inputs,1)
        msgbox('Warning ! Data is under defined. Number of entries should be greater than or equal to number of features')
    end
    Ind=get(handles.linearTargets,'Value');
    Str=get(handles.linearTargets,'String');
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
    
    PCACheck=get(handles.pcaYes,'Val');
    if PCACheck==1&exist('PCAMap.mat')==2
        load PCAMap
%         linearInputs = linearInputs * Map.M;
    end
    
    TrainTestSplit=linearParameters.TrainTestSplit;
    NumTest=round(size(Inputs,1)*(1-TrainTestSplit));
    Indices=linearParameters.Indices;
    
    Test_X=Inputs(Indices(end-NumTest+1:end),:,:);
    Test_Y=Targets(Indices(end-NumTest+1:end),:);

    [Predicted, Precision, Recall, Accuracy] = naive_bayes_test(naivebayes,Test_X,Test_Y);
    set(handles.linearPrecision,'String',num2str(Precision))
    set(handles.linearRecall,'String',num2str(Recall))
    set(handles.linearAccuracy,'String',num2str(Accuracy))
    
    %%
    Actual=ones(size(Test_Y,1),1);
    for i=1:size(Test_Y,2)
        Ind=find(Test_Y(:,i)==1);
        Actual(Ind,1)=i;
    end
    Ua=unique(Actual);
    Up=unique(Predicted);
    TC=length(Ua);
    TempA=ones(size(Actual));
    TempP=ones(size(Actual));
    axes(handles.linearPlotROC)
    cla
    PerfCheck=0;
    %%
    for i=1:TC
        TempA=ones(size(Actual));
        TempP=ones(size(Actual));
        TempA(find(Actual~=Ua(i)))=2;
        TempP(find(Predicted~=Ua(i)))=2;
        if length(unique(TempP))==length(unique(TempA))
            [X,Y] = perfcurve(TempA,TempP,2);
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
    
    
    ColNames=[];
    RowNames=[];
    for i=1:TC
        ColNames=[ColNames {['Class' num2str(i)]}];
        RowNames=[RowNames;{['Class' num2str(i)]}];
    end
    
    
    for i=1:TC
        Acti=find(Actual==Ua(i));
        TempActi=ones(length(Actual),1);
        TempActi(Acti)=-1;
        for j=1:TC
            TempPredj=zeros(length(Predicted),1);
            Predj=find(Predicted==Ua(j));
            TempPredj(Predj)=-1;
            dataP(i,j)=100*length(find(TempActi==TempPredj))/length(Acti);
        end
    end
    
    set(handles.linearConfusionMatrix,'ColumnName',ColNames)
    set(handles.linearConfusionMatrix,'RowName',RowNames)
    set(handles.linearConfusionMatrix,'data',[dataP])

    %%
    
    
else
    msgbox('No Trained Naive Bayes object found')
end



% --- Executes on button press in fisherSelect.
function fisherSelect_Callback(hObject, eventdata, handles)
set(handles.nbSelect,'value',0)
set(handles.lscSelect,'value',0)
% hObject    handle to fisherSelect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of fisherSelect



% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of PCARB


% --- Executes on button press in nbSelect.
function nbSelect_Callback(hObject, eventdata, handles)
set(handles.lscSelect,'value',0)
set(handles.fisherSelect,'value',0)
% hObject    handle to nbSelect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of nbSelect


% --- Executes on button press in lscSelect.
function lscSelect_Callback(hObject, eventdata, handles)
set(handles.nbSelect,'value',0)
set(handles.fisherSelect,'value',0)
% hObject    handle to lscSelect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of lscSelect


% --- Executes on button press in linearStep2.
function linearStep2_Callback(hObject, eventdata, handles)
CheckString=get(handles.linearStep2,'String');
if strcmp(CheckString,'Step 2 (A)')==1
    set(handles.fisherLDABG,'Title','Fisher LDA (A)')
    set(handles.lscBG,'Title','LSC (A)')
    set(handles.nbBG,'Title','Naive Bayes (A)')
    set(handles.pcaBG,'Title','PCA (A)')
else
    msgbox('Import Inputs and Targets first')
end
% hObject    handle to linearStep2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function linearAccuracy_Callback(hObject, eventdata, handles)
% hObject    handle to linearAccuracy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of linearAccuracy as text
%        str2double(get(hObject,'String')) returns contents of linearAccuracy as a double


% --- Executes during object creation, after setting all properties.
function linearAccuracy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to linearAccuracy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function lscTol_Callback(hObject, eventdata, handles)
load linearParameters
TolV=round(999*get(handles.lscTol,'Value'))+1;
V=logspace(1,6,1000)/10e5;
Tol=V(TolV);
set(handles.lscTolVal,'String',num2str(Tol))
linearParameters.Tol=Tol;
save('linearParameters.mat','linearParameters')

% hObject    handle to lscTol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function lscTol_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lscTol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pcaYes.
function pcaYes_Callback(hObject, eventdata, handles)
CheckString=get(handles.pcaBG,'Title');
if strcmp(CheckString,'PCA (A)')==1
    set(handles.pcaNo,'Value',0)
    Ind=get(handles.linearInputs,'Value');
    Str=get(handles.linearInputs,'String');
    if length(Str)==0
        msgbox('Please select Inputs first and then import them')
    else
        Inputs = evalin('base',cell2mat(Str(Ind)));
    end
    NDim=size(Inputs,2);
    if NDim<=2
        NDef=2;
    else
        NDef=round(NDim*0.5)
    end
    Dim=(1:NDim)';
    set(handles.pcaNDims,'String',num2str(Dim))
    set(handles.pcaNDims,'Value',NDef)
else
    set(handles.pcaYes,'Value',0)
    set(handles.pcaNo,'Value',0)
    msgbox('Please import inputs and targets')
end

% hObject    handle to pcaYes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of pcaYes


% --- Executes on button press in pcaNo.
function pcaNo_Callback(hObject, eventdata, handles)
CheckString=get(handles.pcaBG,'Title');
if strcmp(CheckString,'PCA (A)')==1
    set(handles.pcaYes,'Value',0)
else
    set(handles.pcaYes,'Value',0)
    set(handles.pcaNo,'Value',0)
    msgbox('Please import inputs and targets')
end
% hObject    handle to pcaNo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of pcaNo


% --- Executes on selection change in NDim.
function NDim_Callback(hObject, eventdata, handles)
% hObject    handle to NDim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns NDim contents as cell array
%        contents{get(hObject,'Value')} returns selected item from NDim


% --- Executes during object creation, after setting all properties.
function NDim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NDim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on selection change in pcaNDims.
function pcaNDims_Callback(hObject, eventdata, handles)
Str=get(handles.pcaNDims,'String');
Ind=get(handles.pcaNDims,'Value');
NDim=str2num(Str(Ind,:));
save('NDim.mat','NDim')
% hObject    handle to pcaNDims (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pcaNDims contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pcaNDims


% --- Executes during object creation, after setting all properties.
function pcaNDims_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pcaNDims (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in A.
function A_Callback(hObject, eventdata, handles)
% hObject    handle to A (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns A contents as cell array
%        contents{get(hObject,'Value')} returns selected item from A


% --- Executes during object creation, after setting all properties.
function A_CreateFcn(hObject, eventdata, handles)
% hObject    handle to A (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
