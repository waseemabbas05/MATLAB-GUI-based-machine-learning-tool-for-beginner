function varargout = ML_Toolbox_Master_GUI(varargin)
% ML_TOOLBOX_MASTER_GUI MATLAB code for ML_Toolbox_Master_GUI.fig
%      ML_TOOLBOX_MASTER_GUI, by itself, creates a new ML_TOOLBOX_MASTER_GUI or raises the existing
%      singleton*.
%
%      H = ML_TOOLBOX_MASTER_GUI returns the handle to a new ML_TOOLBOX_MASTER_GUI or the handle to
%      the existing singleton*.
%
%      ML_TOOLBOX_MASTER_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ML_TOOLBOX_MASTER_GUI.M with the given input arguments.
%
%      ML_TOOLBOX_MASTER_GUI('Property','Value',...) creates a new ML_TOOLBOX_MASTER_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ML_Toolbox_Master_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All masterinputs are passed to ML_Toolbox_Master_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ML_Toolbox_Master_GUI

% Last Modified by GUIDE v2.5 10-Jun-2016 15:43:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ML_Toolbox_Master_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @ML_Toolbox_Master_GUI_OutputFcn, ...
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


% --- Executes just before ML_Toolbox_Master_GUI is made visible.
function ML_Toolbox_Master_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
Img=imread('logo.jpg');
axes(handles.masterLogo)
imshow(Img)

addpath(genpath(pwd))

if exist('masterParameters.mat')==2
    load masterParameters
end
masterParameters.TrainTestSplit=0.7;
set(handles.masterTrainTestSplit,'Value',0.7)
set(handles.masterTrainTestSplitText,'String','70')
save('masterParameters.mat','masterParameters')

if exist('fisher.mat')==2
    set(handles.compSelectFisher,'ForegroundColor','green')
else
    set(handles.compSelectFisher,'ForegroundColor','red')
end

if exist('lsc.mat')==2
    set(handles.compSelectLSC,'ForegroundColor','green')
else
    set(handles.compSelectLSC,'ForegroundColor','red')
end

if exist('naivebayes.mat')==2
    set(handles.compSelectNB,'ForegroundColor','green')
else
    set(handles.compSelectNB,'ForegroundColor','red')
end

if exist('svm.mat')==2
    set(handles.compSelectSVM,'ForegroundColor','green')
else
    set(handles.compSelectSVM,'ForegroundColor','red')
end

if exist('elm.mat')==2
    set(handles.compSelectELM,'ForegroundColor','green')
else
    set(handles.compSelectELM,'ForegroundColor','red')
end

if exist('dbn.mat')==2
    set(handles.compSelectDBN,'ForegroundColor','green')
else
    set(handles.compSelectDBN,'ForegroundColor','red')
end

if exist('helm.mat')==2
    set(handles.compSelectHELM,'ForegroundColor','green')
else
    set(handles.compSelectHELM,'ForegroundColor','red')
end

if exist('mlp.mat')==2
    set(handles.compSelectMLP,'ForegroundColor','green')
else
    set(handles.compSelectMLP,'ForegroundColor','red')
end

% set(handles.compSelectFisher,'ForegroundColor','green')
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ML_Toolbox_Master_GUI (see VARARGIN)

% Choose default command line output for ML_Toolbox_Master_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ML_Toolbox_Master_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ML_Toolbox_Master_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in LoadWorkspace.
function LoadWorkspace_Callback(hObject, eventdata, handles)
set(handles.masterImportInputs,'Visible','on')
set(handles.masterInputs,'Visible','on')
Vars = evalin('base','who');
set(handles.masterWorkspace,'String',Vars)
% hObject    handle to LoadWorkspace (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in masterImportInputs.
function masterImportInputs_Callback(hObject, eventdata, handles)
set(handles.masterImportTargets,'Visible','on')
set(handles.masterTargets,'Visible','on')
Ind=get(handles.masterWorkspace,'Value');
Str=get(handles.masterWorkspace,'String');
Var = evalin('base',cell2mat(Str(Ind)));
set(handles.masterInputs,'String',Str(Ind));
% hObject    handle to masterImportInputs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in masterImportTargets.
function masterImportTargets_Callback(hObject, eventdata, handles)
load masterParameters
Ind=get(handles.masterWorkspace,'Value');
Str=get(handles.masterWorkspace,'String');
Var = evalin('base',cell2mat(Str(Ind)));
set(handles.masterTargets,'String',Str(Ind));

Ind=get(handles.masterInputs,'Value');
Str=get(handles.masterInputs,'String');
InputsCheck=length(Str)>0;
if length(Str)==0
    msgbox('Please select Inputs first and then import them')
else
    Inputs = evalin('base',cell2mat(Str(Ind)));
    Str=num2str((1:size(Inputs,2))');
    set(handles.masterSelectX1,'String',Str);
    set(handles.masterSelectX2,'String',Str);
end
if InputsCheck==1
    Ind=get(handles.masterTargets,'Value');
    Str=get(handles.masterTargets,'String');
    if length(Str)==0
        msgbox('Please select Inputs first and then import them')
    else
        Targets = evalin('base',cell2mat(Str(Ind)));
        if size(Targets,2)==1
            Uy=unique(Targets);
            NumClasses=length(Uy);
            if NumClasses>2
                Ya=zeros(length(Targets),NumClasses);
                for i=1:NumClasses
                    Ya(find(Targets==Uy(i)),i)=1;
                end
            else
                Ya=Targets;
            end
        elseif size(Targets,2)==2
            Ya=Targets(:,1);
            NumClasses=size(Targets,2);
        else
            NumClasses=size(Targets,2);
            Ya=Targets;
        end
        masterParameters.NormVal=norm(Ya);
        save('masterParameters.mat','masterParameters')
    end
end
if size(Targets,2)>size(Targets,1)
    msgbox('Targets are in wrong format')
end

NObservations=size(Inputs,1);
NFeatures=size(Inputs,2);
if length(size(Inputs))>2
    NFeatures=size(Inputs,2)*size(Inputs,3);
end
set(handles.masterTotalObervations,'String',num2str(NObservations))
set(handles.masterNumberOfFeatures,'String',num2str(NFeatures))
set(handles.masterParametersBG,'Title','Parameters (A)')


% hObject    handle to masterImportTargets (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in masterWorkspace.
function masterWorkspace_Callback(hObject, eventdata, handles)
% hObject    handle to masterWorkspace (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns masterWorkspace contents as cell array
%        contents{get(hObject,'Value')} returns selected item from masterWorkspace


% --- Executes during object creation, after setting all properties.
function masterWorkspace_CreateFcn(hObject, eventdata, handles)
% hObject    handle to masterWorkspace (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in masterInputs.
function masterInputs_Callback(hObject, eventdata, handles)
% hObject    handle to masterInputs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns masterInputs contents as cell array
%        contents{get(hObject,'Value')} returns selected item from masterInputs


% --- Executes during object creation, after setting all properties.
function masterInputs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to masterInputs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in masterTargets.
function masterTargets_Callback(hObject, eventdata, handles)
% hObject    handle to masterTargets (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns masterTargets contents as cell array
%        contents{get(hObject,'Value')} returns selected item from masterTargets


% --- Executes during object creation, after setting all properties.
function masterTargets_CreateFcn(hObject, eventdata, handles)
% hObject    handle to masterTargets (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function masterTrainTestSplit_Callback(hObject, eventdata, handles)
load masterParameters
masterParameters.TrainTestSplit=get(handles.masterTrainTestSplit,'Value');
set(handles.masterTrainTestSplitText,'String',num2str(round(masterParameters.TrainTestSplit*100)));
save('masterParameters.mat','masterParameters');
% hObject    handle to masterTrainTestSplit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function masterTrainTestSplit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to masterTrainTestSplit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in masterSetParameters.
function masterSetParameters_Callback(hObject, eventdata, handles)
CheckString=get(handles.masterParametersBG,'Title');
if strcmp(CheckString,'Parameters (A)')==1
    if(get(handles.masterSelectFisher,'Value'))==1
    end
    
    if(get(handles.masterSelectLSC,'Value'))==1
        LSC_Parameters_GUI
    end
    
    if(get(handles.masterSelectNB,'Value'))==1
    end
    
    if(get(handles.masterSelectSVM,'Value'))==1
        SVM_Parameters_GUI
    end
    
    if(get(handles.masterSelectELM,'Value'))==1
        ELM_Parameters_GUI
    end
    
    if(get(handles.masterSelectDBN,'Value'))==1
        DBN_Parameters_GUI
    end
    
    if(get(handles.masterSelectHELM,'Value'))==1
        HELM_Parameters_GUI
    end
    
    if(get(handles.masterSelectCNN,'Value'))==1
        Ind=get(handles.masterInputs,'Value');
        Str=get(handles.masterInputs,'String');
        InputsCheck=length(Str)>0;
        if length(Str)==0
            msgbox('Please select Inputs first and then import them')
        else
            Inputs = evalin('base',cell2mat(Str(Ind)));
        end
        if length(size(Inputs))==3
        ImRows=size(Inputs,2);
        ImCols=size(Inputs,3);
        LowerDim=min([ImRows ImCols]);
        EndDim=4;
        TempDim=LowerDim;
        
        ConvSize=5;
        Scale=2;
        NLayers=1;
        while TempDim>=EndDim
            D(NLayers)=TempDim;
            TempDim=TempDim-ConvSize+1;
            TempDim=round(TempDim/Scale);
            NLayers=NLayers+1;
        end
        
        if exist('cnnParameters.mat')==2
            load cnnParameters
        end
        cnnParameters.ResizeDim=LowerDim;
        cnnParameters.RecommendedSize=NLayers-2;
        cnnParameters.LowerDim=LowerDim;
        cnnParameters.EndDim=EndDim;
        save('cnnParameters.mat','cnnParameters')
        msgbox(['With a kernel size of 5 and scale of 2, recommened layers are ' num2str(cnnParameters.RecommendedSize)])
        CNN_Parameters_GUI
        else
            msgbox('Inputs are in wrong format: Dimension : Number of Images * Image Height * Image Width')
        end
    end
    
    if(get(handles.masterSelectMLP,'Value'))==1
        MLP_Parameters_GUI
    end
    
    set(handles.masterTrainEvaluateBG,'Title','Train and Evaluate (A)')
    
else
    msgbox('Inputs or Targets not imported properly')
end
% hObject    handle to masterSetParameters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in masterSaveResults.
function masterSaveResults_Callback(hObject, eventdata, handles)
CheckString=get(handles.masterTrainEvaluateBG,'Title');
if strcmp(CheckString,'Train and Evaluate (A)')==1
    load masterParameters
    Ind=get(handles.masterInputs,'Value');
    Str=get(handles.masterInputs,'String');
    if length(Str)==0
        msgbox('Please select Inputs first and then import them')
    else
        Inputs = evalin('base',cell2mat(Str(Ind)));
    end
    if size(Inputs,2)>size(Inputs,1)
        msgbox('Warning ! Data is under defined. Number of entries should be greater than or equal to number of features')
    end
    Ind=get(handles.masterTargets,'Value');
    Str=get(handles.masterTargets,'String');
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

    TrainTestSplit=masterParameters.TrainTestSplit;
    NumTest=round(size(Inputs,1)*(1-TrainTestSplit));
    Indices=masterParameters.Indices;
    
    Test_X=Inputs(Indices(end-NumTest+1:end),:,:);
    Test_Y=Targets(Indices(end-NumTest+1:end),:);
    
    if get(handles.masterSelectNB,'Value')==1
        if exist('naivebayes.mat')==2
            load naivebayes
            [Predicted, Precision, Recall, Accuracy,F1] = naive_bayes_test(naivebayes,Test_X,Test_Y);
            
        else
            msgbox('No Trained Naive Bayes object found')
        end
    end
    
    if get(handles.masterSelectLSC,'Value')==1
        if exist('lsc.mat')==2
            load lsc
            [Predicted, Precision, Recall, Accuracy,F1] = lsc_test(lsc,Test_X,Test_Y);
        else
            msgbox('No Trained Naive Bayes object found')
        end
        
    end
    
    if get(handles.masterSelectFisher,'Value')==1
        
        if exist('fisher.mat')==2
            load fisher
            [Predicted,Precision,Recall,Accuracy,F1,Actual]=fisher_testing(fisher,Test_X,Test_Y,1);
                      
        else
            msgbox('No Trained Naive Bayes object found')
        end
    end
    
    
    if get(handles.masterSelectSVM,'Value')==1
        if exist('svm.mat')==2
            load svm
            
        else
            msgbox('No Trained Naive Bayes object found')
        end
    end
    
    if get(handles.masterSelectELM,'Value')==1
        
        if exist('elm.mat')==2
            load elm
            load elmParameters
            [Predicted,Actual, Accuracy,Precision,Recall,F1] = elm_predict(elm,Test_X,Test_Y);
            
        else
            msgbox('No Trained Naive Bayes object found')
        end
        
    end
    
    
    
    if get(handles.masterSelectDBN,'Value')==1
        if exist('dbn.mat')==2
            load dbn
            load dbnParameters
            [Accuracy,Predicted,Actual,Precision,Recall,F1]=testDBN(dbn,Test_X,Test_Y);
            
        else
            msgbox('No Trained Naive Bayes object found')
        end
    end
    

    if get(handles.masterSelectHELM,'Value')==1
        if exist('helm.mat')==2
            load helm
            load helmParameters
            [Predicted, Accuracy, Actual,Precision,Recall,F1] = helm_test(Test_X, Test_Y, helm,helmParameters.ActivationFunction);
            
        else
            msgbox('No Trained Naive Bayes object found')
        end
    end

    
    if get(handles.masterSelectMLP,'Value')==1
        if exist('mlp.mat')==2
            load mlp
            load mlpParameters
            [TO,TC,Predicted,Actual,Precision,Recall,Accuracy,F1] = test_mlp(mlp, Test_X, Test_Y,1);
            
        else
            msgbox('No Trained Naive Bayes object found')
        end
    end
    

    if get(handles.masterSelectCNN,'Value')==1
        if exist('cnn.mat')==2
            load cnn
            load cnnParameters
            [Er, Bad,Predicted,Actual,Precision,Recall,Accuracy,F1] = cnntest(cnn, Test_X, Test_Y);
            
        else
            msgbox('No Trained Naive Bayes object found')
        end
    end
    if get(handles.masterMatFile,'Value')==1
        save('PredictionResults.mat','Predicted','Actual','Precision','Recall','Accuracy','F1')
        msgbox('data saved')
    end
    
    if get(handles.masterCsvFile,'Value')==1
        Data(:,1)=cellstr(num2str(Predicted));
        Data(:,2)=cellstr(num2str(Actual));
        Data=[{'Predicted'} {'Actual'};Data];
        xlswrite('PredictionResults.csv',Data)
        msgbox('data saved')
    end

    if get(handles.masterXlsxFile,'Value')==1
        Data(:,1)=cellstr(num2str(Predicted));
        Data(:,2)=cellstr(num2str(Actual));
        Data=[{'Predicted'} {'Actual'};Data];
        xlswrite('PredictionResults.xlsx',Data)
        msgbox('data saved')
    end

else
    msgbox('Complete training 1st')
end

% hObject    handle to masterSaveResults (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in masterEvaluateTrain.
function masterEvaluateTrain_Callback(hObject, eventdata, handles)
CheckString=get(handles.masterTrainEvaluateBG,'Title');
if strcmp(CheckString,'Train and Evaluate (A)')==1
    load masterParameters
    Ind=get(handles.masterInputs,'Value');
    Str=get(handles.masterInputs,'String');
    if length(Str)==0
        msgbox('Please select Inputs first and then import them')
    else
        Inputs = evalin('base',cell2mat(Str(Ind)));
    end
    if size(Inputs,2)>size(Inputs,1)
        msgbox('Warning ! Data is under defined. Number of entries should be greater than or equal to number of features')
    end
    Ind=get(handles.masterTargets,'Value');
    Str=get(handles.masterTargets,'String');
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

    TrainTestSplit=masterParameters.TrainTestSplit;
    NumTest=round(size(Inputs,1)*(1-TrainTestSplit));
    Indices=masterParameters.Indices;
    
    Train_X=Inputs(Indices(1:end-NumTest),:,:);
    Train_Y=Targets(Indices(1:end-NumTest),:);
    
    if get(handles.masterSelectNB,'Value')==1
        if exist('naivebayes.mat')==2
            load naivebayes
            [Predicted, Precision, Recall, Accuracy,F1] = naive_bayes_test(naivebayes,Train_X,Train_Y);
            set(handles.masterPrecision,'String',num2str(Precision))
            set(handles.masterRecall,'String',num2str(Recall))
            set(handles.masterAccuracy,'String',num2str(Accuracy))
            set(handles.masterF1Measure,'String',num2str(F1))
            
            %%
            [Xa,Ya,ColNames,RowNames,dataP] = perfEvaluate(Train_Y,Predicted,handles.masterPlotROC);
            set(handles.masterConfusionMatrix,'ColumnName',ColNames)
            set(handles.masterConfusionMatrix,'RowName',RowNames)
            set(handles.masterConfusionMatrix,'data',[dataP])
            
        else
            msgbox('No Trained Naive Bayes object found')
        end
    end
    
    if get(handles.masterSelectLSC,'Value')==1
        if exist('lsc.mat')==2
            load lsc
            [Predicted, Precision, Recall, Accuracy,F1] = lsc_test(lsc,Train_X,Train_Y);
            set(handles.masterPrecision,'String',num2str(Precision))
            set(handles.masterRecall,'String',num2str(Recall))
            set(handles.masterAccuracy,'String',num2str(Accuracy))
            set(handles.masterF1Measure,'String',num2str(F1))
            
            %%
            [Xa,Ya,ColNames,RowNames,dataP] = perfEvaluate(Train_Y,Predicted,handles.masterPlotROC);
            set(handles.masterConfusionMatrix,'ColumnName',ColNames)
            set(handles.masterConfusionMatrix,'RowName',RowNames)
            set(handles.masterConfusionMatrix,'data',[dataP])
            
        else
            msgbox('No Trained Naive Bayes object found')
        end
        
    end
    
    if get(handles.masterSelectFisher,'Value')==1
        
        if exist('fisher.mat')==2
            load fisher
            if isfield(fisher,'W')==1
                [Predicted,Precision,Recall,Accuracy,F1,Actual]=fisher_testing(fisher,Train_X,Train_Y,1);
                set(handles.masterPrecision,'String',num2str(Precision))
                set(handles.masterRecall,'String',num2str(Recall))
                set(handles.masterAccuracy,'String',num2str(Accuracy))
                set(handles.masterF1Measure,'String',num2str(F1))
                
                %%
                [Xa,Ya,ColNames,RowNames,dataP] = perfEvaluate(Train_Y,Predicted,handles.masterPlotROC);
                set(handles.masterConfusionMatrix,'ColumnName',ColNames)
                set(handles.masterConfusionMatrix,'RowName',RowNames)
                set(handles.masterConfusionMatrix,'data',[dataP])
            else
                msgbox('Fisher object was not trained properly')
            end
            
        else
            msgbox('No Trained Naive Bayes object found')
        end
    end
    
    
    if get(handles.masterSelectSVM,'Value')==1
        if exist('svm.mat')==2
            load svm
            size(Train_X)
            [Predicted,Actual,Accuracy,Precision,Recall,F1]=multisvmtest(Train_X,Train_Y,models);
            set(handles.masterPrecision,'String',num2str(Precision))
            set(handles.masterRecall,'String',num2str(Recall))
            set(handles.masterAccuracy,'String',num2str(Accuracy))
            set(handles.masterF1Measure,'String',num2str(F1))
            
            %%
            [Xa,Ya,ColNames,RowNames,dataP] = perfEvaluate(Train_Y,Predicted,handles.masterPlotROC);
            set(handles.masterConfusionMatrix,'ColumnName',ColNames)
            set(handles.masterConfusionMatrix,'RowName',RowNames)
            set(handles.masterConfusionMatrix,'data',[dataP])
            
        else
            msgbox('No Trained Naive Bayes object found')
        end
    end
    
    if get(handles.masterSelectELM,'Value')==1
        
        if exist('elm.mat')==2
            load elm
            load elmParameters
            [Predicted,Actual, Accuracy,Precision,Recall,F1] = elm_predict(elm,Train_X,Train_Y);
            set(handles.masterPrecision,'String',num2str(Precision))
            set(handles.masterRecall,'String',num2str(Recall))
            set(handles.masterAccuracy,'String',num2str(Accuracy))
            set(handles.masterF1Measure,'String',num2str(F1))
            

            [Xa,Ya,ColNames,RowNames,dataP] = perfEvaluate(Train_Y,Predicted,handles.masterPlotROC);
            set(handles.masterConfusionMatrix,'ColumnName',ColNames)
            set(handles.masterConfusionMatrix,'RowName',RowNames)
            set(handles.masterConfusionMatrix,'data',[dataP])
            
        else
            msgbox('No Trained Naive Bayes object found')
        end
        
    end
    
    
    
    if get(handles.masterSelectDBN,'Value')==1
        if exist('dbn.mat')==2
            load dbn
            load dbnParameters
            [Accuracy,Predicted,Actual,Precision,Recall,F1]=testDBN(dbn,Train_X,Train_Y);
            set(handles.masterPrecision,'String',num2str(Precision))
            set(handles.masterRecall,'String',num2str(Recall))
            set(handles.masterAccuracy,'String',num2str(Accuracy))
            set(handles.masterF1Measure,'String',num2str(F1))
            
            
            [Xa,Ya,ColNames,RowNames,dataP] = perfEvaluate(Train_Y,Predicted,handles.masterPlotROC);
            set(handles.masterConfusionMatrix,'ColumnName',ColNames)
            set(handles.masterConfusionMatrix,'RowName',RowNames)
            set(handles.masterConfusionMatrix,'data',[dataP])
            
        else
            msgbox('No Trained Naive Bayes object found')
        end
    end
    

    if get(handles.masterSelectHELM,'Value')==1
        if exist('helm.mat')==2
            load helm
            load helmParameters
            [Predicted, Accuracy, Actual,Precision,Recall,F1] = helm_test(Train_X, Train_Y, helm,helmParameters.ActivationFunction);
            set(handles.masterPrecision,'String',num2str(Precision))
            set(handles.masterRecall,'String',num2str(Recall))
            set(handles.masterAccuracy,'String',num2str(Accuracy))
            set(handles.masterF1Measure,'String',num2str(F1))
            
            
            [Xa,Ya,ColNames,RowNames,dataP] = perfEvaluate(Train_Y,Predicted,handles.masterPlotROC);
            set(handles.masterConfusionMatrix,'ColumnName',ColNames)
            set(handles.masterConfusionMatrix,'RowName',RowNames)
            set(handles.masterConfusionMatrix,'data',[dataP])
            
        else
            msgbox('No Trained Naive Bayes object found')
        end
    end

    
    if get(handles.masterSelectMLP,'Value')==1
        if exist('mlp.mat')==2
            load mlp
            load mlpParameters
            [TO,TC,Predicted,Actual,Precision,Recall,Accuracy,F1] = test_mlp(mlp, Train_X, Train_Y,1);
            set(handles.masterPrecision,'String',num2str(Precision))
            set(handles.masterRecall,'String',num2str(Recall))
            set(handles.masterAccuracy,'String',num2str(Accuracy))
            set(handles.masterF1Measure,'String',num2str(F1))
            
            
            [Xa,Ya,ColNames,RowNames,dataP] = perfEvaluate(Train_Y,Predicted,handles.masterPlotROC);
            set(handles.masterConfusionMatrix,'ColumnName',ColNames)
            set(handles.masterConfusionMatrix,'RowName',RowNames)
            set(handles.masterConfusionMatrix,'data',[dataP])
            
        else
            msgbox('No Trained Naive Bayes object found')
        end
    end
    
    
    if get(handles.masterSelectCNN,'Value')==1
        if exist('cnn.mat')==2
            load cnn
            load cnnParameters
            a=cnn.layers{1}.a{1};
            R=size(a,1);
            C=size(a,2);
            R1=size(Train_X,2);
            C1=size(Train_X,3);
            if R==R1&C==C1

                [Train_X,n]  = shiftdim(Train_X,1);
                Train_Y=Train_Y';
                if cnnParameters.LowerDim~=cnnParameters.ResizeDim
                    TempD=cnnParameters.ResizeDim;
                    Train_X=imresize(Train_X,[TempD,TempD]);
                end
                
                [Er, Bad,Predicted,Actual,Precision,Recall,Accuracy,F1] = cnntest(cnn, Train_X, Train_Y);
                save('data','Actual','Predicted')
                set(handles.masterPrecision,'String',num2str(Precision))
                set(handles.masterRecall,'String',num2str(Recall))
                set(handles.masterAccuracy,'String',num2str(Accuracy))
                set(handles.masterF1Measure,'String',num2str(F1))
                
                
                [Xa,Ya,ColNames,RowNames,dataP] = perfEvaluate(Train_Y',Predicted',handles.masterPlotROC);
                set(handles.masterConfusionMatrix,'ColumnName',ColNames)
                set(handles.masterConfusionMatrix,'RowName',RowNames)
                set(handles.masterConfusionMatrix,'data',[dataP])
            else
                msgbox('CNN not trained for this data')
            end
            
        else
            msgbox('No Trained Naive Bayes object found')
        end
    end

else
    msgbox('Complete training 1st')
end


% hObject    handle to masterEvaluateTrain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in masterEvaluateTest.
function masterEvaluateTest_Callback(hObject, eventdata, handles)
CheckString=get(handles.masterTrainEvaluateBG,'Title');
if strcmp(CheckString,'Train and Evaluate (A)')==1
    load masterParameters
    Ind=get(handles.masterInputs,'Value');
    Str=get(handles.masterInputs,'String');
    if length(Str)==0
        msgbox('Please select Inputs first and then import them')
    else
        Inputs = evalin('base',cell2mat(Str(Ind)));
    end
    if size(Inputs,2)>size(Inputs,1)
        msgbox('Warning ! Data is under defined. Number of entries should be greater than or equal to number of features')
    end
    Ind=get(handles.masterTargets,'Value');
    Str=get(handles.masterTargets,'String');
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

    TrainTestSplit=masterParameters.TrainTestSplit;
    NumTest=round(size(Inputs,1)*(1-TrainTestSplit));
    Indices=masterParameters.Indices;
    
    Test_X=Inputs(Indices(end-NumTest+1:end),:,:);
    Test_Y=Targets(Indices(end-NumTest+1:end),:);
    
    if get(handles.masterSelectNB,'Value')==1
        if exist('naivebayes.mat')==2
            load naivebayes
            [Predicted, Precision, Recall, Accuracy,F1] = naive_bayes_test(naivebayes,Test_X,Test_Y);
            set(handles.masterPrecision,'String',num2str(Precision))
            set(handles.masterRecall,'String',num2str(Recall))
            set(handles.masterAccuracy,'String',num2str(Accuracy))
            set(handles.masterF1Measure,'String',num2str(F1))
            
            %%
            [Xa,Ya,ColNames,RowNames,dataP] = perfEvaluate(Test_Y,Predicted,handles.masterPlotROC);
            set(handles.masterConfusionMatrix,'ColumnName',ColNames)
            set(handles.masterConfusionMatrix,'RowName',RowNames)
            set(handles.masterConfusionMatrix,'data',[dataP])
            
        else
            msgbox('No Trained Naive Bayes object found')
        end
    end
    
    if get(handles.masterSelectLSC,'Value')==1
        if exist('lsc.mat')==2
            load lsc
            [Predicted, Precision, Recall, Accuracy,F1] = lsc_test(lsc,Test_X,Test_Y);
            set(handles.masterPrecision,'String',num2str(Precision))
            set(handles.masterRecall,'String',num2str(Recall))
            set(handles.masterAccuracy,'String',num2str(Accuracy))
            set(handles.masterF1Measure,'String',num2str(F1))
            
            %%
            [Xa,Ya,ColNames,RowNames,dataP] = perfEvaluate(Test_Y,Predicted,handles.masterPlotROC);
            set(handles.masterConfusionMatrix,'ColumnName',ColNames)
            set(handles.masterConfusionMatrix,'RowName',RowNames)
            set(handles.masterConfusionMatrix,'data',[dataP])
            
        else
            msgbox('No Trained Naive Bayes object found')
        end
        
    end
    
    if get(handles.masterSelectFisher,'Value')==1
        
        if exist('fisher.mat')==2
            load fisher
            if isfield(fisher,'W')==1
                [Predicted,Precision,Recall,Accuracy,F1,Actual]=fisher_testing(fisher,Test_X,Test_Y,1);
                set(handles.masterPrecision,'String',num2str(Precision))
                set(handles.masterRecall,'String',num2str(Recall))
                set(handles.masterAccuracy,'String',num2str(Accuracy))
                set(handles.masterF1Measure,'String',num2str(F1))
                
                %%
                [Xa,Ya,ColNames,RowNames,dataP] = perfEvaluate(Test_Y,Predicted,handles.masterPlotROC);
                set(handles.masterConfusionMatrix,'ColumnName',ColNames)
                set(handles.masterConfusionMatrix,'RowName',RowNames)
                set(handles.masterConfusionMatrix,'data',[dataP])
            else
                msgbox('Fisher object was not trained properly')
            end
        else
            msgbox('No Trained Naive Bayes object found')
        end
    end
    
    
    if get(handles.masterSelectSVM,'Value')==1
        if exist('svm.mat')==2
            load svm
            [Predicted,Actual,Accuracy,Precision,Recall,F1]=multisvmtest(Test_X,Test_Y,models);
            set(handles.masterPrecision,'String',num2str(Precision))
            set(handles.masterRecall,'String',num2str(Recall))
            set(handles.masterAccuracy,'String',num2str(Accuracy))
            set(handles.masterF1Measure,'String',num2str(F1))
            
            %%
            [Xa,Ya,ColNames,RowNames,dataP] = perfEvaluate(Test_Y,Predicted,handles.masterPlotROC);
            set(handles.masterConfusionMatrix,'ColumnName',ColNames)
            set(handles.masterConfusionMatrix,'RowName',RowNames)
            set(handles.masterConfusionMatrix,'data',[dataP])
            
        else
            msgbox('No Trained Naive Bayes object found')
        end
    end
    
    if get(handles.masterSelectELM,'Value')==1
        
        if exist('elm.mat')==2
            load elm
            load elmParameters
            [Predicted,Actual, Accuracy,Precision,Recall,F1] = elm_predict(elm,Test_X,Test_Y);
            set(handles.masterPrecision,'String',num2str(Precision))
            set(handles.masterRecall,'String',num2str(Recall))
            set(handles.masterAccuracy,'String',num2str(Accuracy))
            set(handles.masterF1Measure,'String',num2str(F1))
            

            [Xa,Ya,ColNames,RowNames,dataP] = perfEvaluate(Test_Y,Predicted,handles.masterPlotROC);
            set(handles.masterConfusionMatrix,'ColumnName',ColNames)
            set(handles.masterConfusionMatrix,'RowName',RowNames)
            set(handles.masterConfusionMatrix,'data',[dataP])
            
        else
            msgbox('No Trained Naive Bayes object found')
        end
        
    end
    
    
    
    if get(handles.masterSelectDBN,'Value')==1
        if exist('dbn.mat')==2
            load dbn
            load dbnParameters
            [Accuracy,Predicted,Actual,Precision,Recall,F1]=testDBN(dbn,Test_X,Test_Y);
            set(handles.masterPrecision,'String',num2str(Precision))
            set(handles.masterRecall,'String',num2str(Recall))
            set(handles.masterAccuracy,'String',num2str(Accuracy))
            set(handles.masterF1Measure,'String',num2str(F1))
            
            
            [Xa,Ya,ColNames,RowNames,dataP] = perfEvaluate(Test_Y,Predicted,handles.masterPlotROC);
            set(handles.masterConfusionMatrix,'ColumnName',ColNames)
            set(handles.masterConfusionMatrix,'RowName',RowNames)
            set(handles.masterConfusionMatrix,'data',[dataP])
            
        else
            msgbox('No Trained Naive Bayes object found')
        end
    end
    

    if get(handles.masterSelectHELM,'Value')==1
        if exist('helm.mat')==2
            load helm
            load helmParameters
            [Predicted, Accuracy, Actual,Precision,Recall,F1] = helm_test(Test_X, Test_Y, helm,helmParameters.ActivationFunction);
            set(handles.masterPrecision,'String',num2str(Precision))
            set(handles.masterRecall,'String',num2str(Recall))
            set(handles.masterAccuracy,'String',num2str(Accuracy))
            set(handles.masterF1Measure,'String',num2str(F1))
            
            
            [Xa,Ya,ColNames,RowNames,dataP] = perfEvaluate(Test_Y,Predicted,handles.masterPlotROC);
            set(handles.masterConfusionMatrix,'ColumnName',ColNames)
            set(handles.masterConfusionMatrix,'RowName',RowNames)
            set(handles.masterConfusionMatrix,'data',[dataP])
            
        else
            msgbox('No Trained Naive Bayes object found')
        end
    end

    
    if get(handles.masterSelectMLP,'Value')==1
        if exist('mlp.mat')==2
            load mlp
            load mlpParameters
            [TO,TC,Predicted,Actual,Precision,Recall,Accuracy,F1] = test_mlp(mlp, Test_X, Test_Y,1);
            set(handles.masterPrecision,'String',num2str(Precision))
            set(handles.masterRecall,'String',num2str(Recall))
            set(handles.masterAccuracy,'String',num2str(Accuracy))
            set(handles.masterF1Measure,'String',num2str(F1))
            
            
            [Xa,Ya,ColNames,RowNames,dataP] = perfEvaluate(Test_Y,Predicted,handles.masterPlotROC);
            set(handles.masterConfusionMatrix,'ColumnName',ColNames)
            set(handles.masterConfusionMatrix,'RowName',RowNames)
            set(handles.masterConfusionMatrix,'data',[dataP])
            
        else
            msgbox('No Trained Naive Bayes object found')
        end
    end
    

    if get(handles.masterSelectCNN,'Value')==1
        if exist('cnn.mat')==2
            load cnn
            load cnnParameters
            a=cnn.layers{1}.a{1};
            R=size(a,1);
            C=size(a,2);
            R1=size(Test_X,2);
            C1=size(Test_X,3);
            if R==R1&C==C1
                [Test_X,n]  = shiftdim(Test_X,1);
                Test_Y=Test_Y';
                
                if cnnParameters.LowerDim~=cnnParameters.ResizeDim
                    TempD=cnnParameters.ResizeDim;
                    Test_X=imresize(Test_X,[TempD,TempD]);
                end
                
                [Er, Bad,Predicted,Actual,Precision,Recall,Accuracy,F1] = cnntest(cnn, Test_X, Test_Y);
                set(handles.masterPrecision,'String',num2str(Precision))
                set(handles.masterRecall,'String',num2str(Recall))
                set(handles.masterAccuracy,'String',num2str(Accuracy))
                set(handles.masterF1Measure,'String',num2str(F1))
                
                
                [Xa,Ya,ColNames,RowNames,dataP] = perfEvaluate(Test_Y',Predicted',handles.masterPlotROC);
                set(handles.masterConfusionMatrix,'ColumnName',ColNames)
                set(handles.masterConfusionMatrix,'RowName',RowNames)
                set(handles.masterConfusionMatrix,'data',[dataP])
            else
                msgbox('CNN not trained for this data')
            end
            
        else
            msgbox('No Trained Naive Bayes object found')
        end
    end

else
    msgbox('Complete training 1st')
end


% hObject    handle to masterEvaluateTest (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in masterTrainClassifier.
function masterTrainClassifier_Callback(hObject, eventdata, handles)
CheckString=get(handles.masterTrainEvaluateBG,'Title');
if strcmp(CheckString,'Train and Evaluate (A)')==1
    load('masterParameters.mat')
    if isfield(masterParameters,'TrainTestSplit')==1
        TrainTestSplit=masterParameters.TrainTestSplit;
    else
        msgbox('Please set percentage of training data')
    end
    
    Ind=get(handles.masterInputs,'Value');
    Str=get(handles.masterInputs,'String');
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
        Ind=get(handles.masterTargets,'Value');
        Str=get(handles.masterTargets,'String');
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
            masterParameters.Indices=Indices;
            masterParameters.NumTest=NumTest;
            save('masterParameters.mat','masterParameters')
            Train_X=Inputs(Indices(1:end-NumTest),:,:);
            Train_Y=Targets(Indices(1:end-NumTest),:);
            
            Test_X=Inputs(Indices(end-NumTest+1:end),:,:);
            Test_Y=Targets(Indices(end-NumTest+1:end),:);
            
            if get(handles.masterSelectFisher,'Value')==1
                if exist('linearParameters.mat')==2
                    load linearParameters
                end
                linearParameters.NDim=size(Inputs,2);
                save('linearParameters.mat','linearParameters')
                tic
                fisher=fisher_training(Train_X,Train_Y);
                T=toc;
                fisher.TrainingTime=T;
                save('fisher.mat','fisher')
                if isfield(fisher,'W')
                    msgbox('Fisher Object Trained')
                    set(handles.masterTrainingTime,'String',num2str(T))
                else
                    msgbox('Fisher Object was not trained properly for this dataset')
                end
                set(handles.compSelectFisher,'ForegroundColor','green')
            end
            
            
            
            if get(handles.masterSelectLSC,'Value')==1
                if exist('linearParameters.mat')==2
                    load linearParameters
                end
                linearParameters.NDim=size(Inputs,2);
                save('linearParameters.mat','linearParameters')
                Tol=linearParameters.Tol;
                tic
                [lsc] = lsc_train(Train_X,Train_Y,Tol)
                T=toc;
                lsc.TrainingTime=T;
                set(handles.masterTrainingTime,'String',num2str(T))
                save('lsc.mat','lsc')
                msgbox('LSC Object Trained')
                set(handles.compSelectLSC,'ForegroundColor','green')
            end
            
            
            
            if get(handles.masterSelectNB,'Value')==1
                tic
                [naivebayes] = naive_bayes_train(Train_X, Train_Y);
                T=toc;
                naivebayes.TrainingTime=T;
                
                if exist('linearParameters.mat')==2
                    load linearParameters
                end
                linearParameters.NDim=size(Inputs,2);
                save('linearParameters.mat','linearParameters')
                
                set(handles.masterTrainingTime,'String',num2str(T))
                save('naivebayes.mat','naivebayes')
                msgbox('Naive Bayes object trained')
                set(handles.compSelectNB,'ForegroundColor','green')
            end
            
            
            
            if get(handles.masterSelectSVM,'Value')==1
                load svmParameters
                if exist('svm.mat')==2
                    delete('svm.mat')
                end
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
                svmParameters.TrainingTime=T;
                set(handles.masterTrainingTime,'String',num2str(T))
                msgbox('Training Complete')
                save('svm.mat','models')
                save('svmParameters.mat','svmParameters')
                set(handles.compSelectSVM,'ForegroundColor','green')
                
            end
            
            
            
            if get(handles.masterSelectELM,'Value')==1
                load('elmParameters.mat')
                
                ActivationFunction=elmParameters.ActivationFunction;
                if iscell(ActivationFunction)==1
                    ActivationFunction=cell2mat(ActivationFunction);
                end
                NumberofHiddenNeurons=elmParameters.HiddenNeurons;
                
                tic
                [elm,Predicted,Actual,TrainingAccuracy] = elm_train(Train_X,Train_Y, NumberofHiddenNeurons, ActivationFunction);
                T=toc;
                elm.TrainingTime=T;
                set(handles.masterTrainingTime,'String',num2str(T))
                save('elm.mat','elm')
                save('elmParameters.mat','elmParameters')
                msgbox('Training Complete')
                set(handles.compSelectELM,'ForegroundColor','green')
                
            end
            
            
            
            if get(handles.masterSelectDBN,'Value')==1
                load dbnParameters
                SizeMatrix=dbnParameters.SizeMatrix;
                BatchSize=dbnParameters.BatchSize;
                NumEpochs=dbnParameters.NumEpochs;

                NumBatches=floor(size(Train_X,1)/BatchSize);
                Trl=NumBatches*BatchSize;
                Train_X=Train_X(1:Trl,:);
                Train_Y=Train_Y(1:Trl,:);

                tic
                [dbn,Actual,Predicted,TrainingAccuracy,MSE] = createAndTrainDBN(Train_X, Train_Y, SizeMatrix,BatchSize, TrainTestSplit,NumEpochs);
                axes(handles.masterMSE)
                plot(MSE,'linewidth',3)
                xlabel('Epochs')
                ylabel('MSE')
                set(gca,'fontsize',10)
                T=toc;
                dbn.TrainingTime=T;
                set(handles.masterTrainingTime,'String',num2str(T))
                
                save('dbn.mat','dbn')
                msgbox('Training Complete')
                set(handles.compSelectDBN,'ForegroundColor','green')
            end
            
            
            
            if get(handles.masterSelectHELM,'Value')==1
                load helmParameters
                SizeMatrix=helmParameters.SizeMatrix;
                ActivationFunction=helmParameters.ActivationFunction;
                NumEpochs=helmParameters.NumEpochs;
                
                tic
                [helm,TrainingAccuracy,Actual,Expected] = helm_train(Train_X,Train_Y,SizeMatrix,NumEpochs,ActivationFunction);
                T=toc;
                helm{helmParameters.NLayers+1}.TrainingTime=T;
                set(handles.masterTrainingTime,'String',num2str(T))
                save('helm.mat','helm')
                save('helmParameters.mat','helmParameters')
                msgbox('Training Complete')
                set(handles.compSelectHELM,'ForegroundColor','green')
                
            end
            
            if get(handles.masterSelectCNN,'Value')==1
                load cnnParameters
                NumBatches=floor(size(Train_X,1)/cnnParameters.BatchSize)
                Train_X=Train_X(1:NumBatches*cnnParameters.BatchSize,:,:);
                Train_Y=Train_Y(1:NumBatches*cnnParameters.BatchSize,:);
                [Train_X,n]  = shiftdim(Train_X,1);
                [Test_X,n]  = shiftdim(Test_X,1);
                
                Train_Y=Train_Y';
                Test_Y=Test_Y';
                
                if cnnParameters.LowerDim~=cnnParameters.ResizeDim
                    TempD=cnnParameters.ResizeDim;
                    Train_X=imresize(Train_X,[TempD,TempD]);
                end
                size(Train_X)
                
                rand('state', 0)
                opts.alpha = 1;
                opts.batchsize = cnnParameters.BatchSize;
                opts.numepochs = cnnParameters.NumEpochs;
                Scale=cnnParameters.SubSamplingScale;
                ConvolutionKernelSize=cnnParameters.ConvolutionKernelSize;
                
                EvenP=[2:2:cnnParameters.NLayers*2];
                OddP=[3:2:cnnParameters.NLayers*2+1];
                cnn.layers(1,1)={struct('type', 'i')};
                for i=1:cnnParameters.NLayers
                    cnn.layers(EvenP(i),1)={struct('type', 'c', 'outputmaps', cnnParameters.NumOfFeatures(i),...
                        'kernelsize', ConvolutionKernelSize)};
                    cnn.layers(OddP(i),1)={struct('type', 's', 'scale', Scale)};
                end
              
                
                TempD=cnnParameters.EndDim;
                for i=1:cnnParameters.NLayers
                    TempD=TempD*Scale;
                    TempD=TempD+ConvolutionKernelSize-1;
                end
                if TempD~=cnnParameters.LowerDim
                    Train_X=imresize(Train_X,[TempD,TempD]);
                    Test_X=imresize(Test_X,[TempD,TempD]);
                end
                
                
                cnn = cnnsetup(cnn, Train_X, Train_Y);
                
                
                fprintf('Training the CNN...\n');
                StartTime = tic();
                
                % Train the CNN using the training data.
                [cnn,MSE] = cnntrain(cnn, Train_X, Train_Y, opts);
                
                axes(handles.masterMSE)
                plot(MSE,'linewidth',3)
                xlabel('Epochs')
                ylabel('MSE')
                set(gca,'fontsize',10)
                T=toc(StartTime);
                fprintf('...Done. Training took %.2f seconds\n', T);
                save('cnn.mat','cnn')
                set(handles.masterTrainingTime,'String',num2str(T))
                
                msgbox('Training Complete')

                
            end
            
            
            
            if get(handles.masterSelectMLP,'Value')==1
                load mlpParameters
                SizeMatrix=mlpParameters.SizeMatrix;
                MaxIterations=mlpParameters.MaxIterations;
                Tolerance=mlpParameters.Tolerance;
                Momentum=mlpParameters.Momentum;
                LearningRate=mlpParameters.LearningRate;
                
                tic
                [mlp MSE] = train_mlp(Train_X, Train_Y, SizeMatrix, MaxIterations, LearningRate, Momentum,Tolerance);

                axes(handles.masterMSE)
                plot(MSE,'linewidth',3)
                xlabel('Epochs')
                ylabel('MSE')
                set(gca,'fontsize',10)

                T=toc;
                mlp.TrainingTime=T;
                set(handles.masterTrainingTime,'String',num2str(T))
                save('mlpParameters.mat','mlpParameters')
                save('mlp.mat','mlp')
                set(handles.compSelectMLP,'ForegroundColor','green')
            end
        end
    end
else
    msgbox('Please Enter Network parameters 1st')
end
% hObject    handle to masterTrainClassifier (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in masterCompare.
function masterCompare_Callback(hObject, eventdata, handles)
Check=get(handles.compClassifierSelectBG,'Title')
if (1)
    Ind=get(handles.masterInputs,'Value');
    Str=get(handles.masterInputs,'String');
    InputsCheck=length(Str)>0;
    if length(Str)==0
        msgbox('Please select Inputs first and then import them')
    else
        Inputs = evalin('base',cell2mat(Str(Ind)));
    end
    Ind=get(handles.masterTargets,'Value');
    Str=get(handles.masterTargets,'String');
    
    Targets = evalin('base',cell2mat(Str(Ind)));
    if size(Targets,2)<2
        Ut=unique(Targets);
        Targets1=Targets;
        Targets=zeros(size(Targets1,1),length(Ut));
        for i=1:length(Ut)
            Targets(find(Targets1==Ut(i)),i)=1;
        end
    end
    
    
    fisherAccuracyTrain=NaN;
    fisherAccuracyTest=NaN;
    
    lscAccuracyTrain=NaN;
    lscAccuracyTest=NaN;
    
    nbAccuracyTrain=NaN;
    nbAccuracyTest=NaN;
    
    elmAccuracyTrain=NaN;
    elmAccuracyTest=NaN;
    
    svmAccuracyTrain=NaN;
    svmAccuracyTest=NaN;
    
    dbnAccuracyTrain=NaN;
    dbnAccuracyTest=NaN;
    
    helmAccuracyTrain=NaN;
    helmAccuracyTest=NaN;
    
    mlpAccuracyTrain=NaN;
    mlpAccuracyTest=NaN;
    
    KFun=ones(8,1)*NaN;
    KFun=cellstr(num2str(KFun));
    
    NumLayers=ones(8,1)*NaN;
    NumLayers=cellstr(num2str(NumLayers));
    
    NumNodes=ones(8,1)*NaN;
    NumNodes=cellstr(num2str(NumNodes));
    
    TrainTime=ones(8,1)*NaN;
    TrainTime=cellstr(num2str(TrainTime));
    
    if get(handles.compSelectFisher,'Value')==1
        load masterParameters
        load linearParameters
        Indices=masterParameters.Indices;
        TrainTestSplit=masterParameters.TrainTestSplit;
        NumTest=round(size(Inputs,1)*(1-TrainTestSplit));
        if exist('fisher.mat')==2
            load fisher
            if isfield(fisher,'TrainingTime')==1
                TrainTime(1)={num2str(fisher.TrainingTime)};
            end
            if size(Inputs,2)==linearParameters.NDim && isfield(fisher,'W')==1&&length(size(Inputs))<3
                Train_X=Inputs(Indices(1:end-NumTest),:);
                Train_Y=Targets(Indices(1:end-NumTest),:);
                Test_X=Inputs(Indices(end-NumTest+1:end),:);
                Test_Y=Targets(Indices(end-NumTest+1:end),:);
                [Predicted,Precision,Recall,fisherAccuracyTrain,F1,Actual]=fisher_testing(fisher,Train_X,Train_Y,1);
                [Predicted,Precision,Recall,fisherAccuracyTest,F1,Actual]=fisher_testing(fisher,Test_X,Test_Y,1);
            else
                msgbox('Fisher Object is not trained for this data')
            end
        end
    end

    if get(handles.compSelectLSC,'Value')==1
        load masterParameters
        load linearParameters
        Indices=masterParameters.Indices;
        TrainTestSplit=masterParameters.TrainTestSplit;
        NumTest=round(size(Inputs,1)*(1-TrainTestSplit));
        if exist('lsc.mat')==2
            load lsc
            if isfield(lsc,'TrainingTime')==1
                TrainTime(2)={num2str(lsc.TrainingTime)};
            end
            if size(Inputs,2)==linearParameters.NDim&&length(size(Inputs))<3
                Train_X=Inputs(Indices(1:end-NumTest),:);
                Train_Y=Targets(Indices(1:end-NumTest),:);
                Test_X=Inputs(Indices(end-NumTest+1:end),:);
                Test_Y=Targets(Indices(end-NumTest+1:end),:);
                [Predicted, Precision, Recall, lscAccuracyTrain] = lsc_test(lsc,Train_X,Train_Y);
                [Predicted, Precision, Recall, lscAccuracyTest] = lsc_test(lsc,Test_X,Test_Y);
            else
                msgbox('LSC Object is not trained for this data')
            end
        end
    end
    
    if get(handles.compSelectNB,'Value')==1
        load masterParameters
        load linearParameters
        Indices=masterParameters.Indices;
        TrainTestSplit=masterParameters.TrainTestSplit;
        NumTest=round(size(Inputs,1)*(1-TrainTestSplit));
        if exist('naivebayes.mat')==2
            load naivebayes
            if isfield(naivebayes,'TrainingTime')==1
                TrainTime(3)={num2str(naivebayes.TrainingTime)};
            end
            if size(Inputs,2)==linearParameters.NDim&&length(size(Inputs))<3
                Train_X=Inputs(Indices(1:end-NumTest),:);
                Train_Y=Targets(Indices(1:end-NumTest),:);
                Test_X=Inputs(Indices(end-NumTest+1:end),:);
                Test_Y=Targets(Indices(end-NumTest+1:end),:);
                [Predicted, Precision, Recall, nbAccuracyTrain] = naive_bayes_test(naivebayes,Train_X,Train_Y);
                [Predicted, Precision, Recall, nbAccuracyTest] = naive_bayes_test(naivebayes,Test_X,Test_Y);
            else
                msgbox('Naive Bayesian Object is not trained for this data')
            end
        end
    end

    
    
    if get(handles.compSelectELM,'Value')==1
        load elmParameters
        load masterParameters
        load elm
        if isfield(elm,'TrainingTime')==1
            TrainTime(4)={num2str(elm.TrainingTime)};
        end
        Indices=masterParameters.Indices;
        TrainTestSplit=masterParameters.TrainTestSplit;
        NumTest=round(size(Inputs,1)*(1-TrainTestSplit));
        if elm.NumberofInputNeurons==size(Inputs,2)&&length(size(Inputs))<3
            Train_X=Inputs(Indices(1:end-NumTest),:);
            Train_Y=Targets(Indices(1:end-NumTest),:);
            Test_X=Inputs(Indices(end-NumTest+1:end),:);
            Test_Y=Targets(Indices(end-NumTest+1:end),:);
            NumNodes(4,1)={num2str(elm.NumberofInputNeurons)};
            [Predicted,Actual, elmAccuracyTrain] = elm_predict(elm,Train_X,Train_Y);
            [Predicted,Actual, elmAccuracyTest] = elm_predict(elm,Test_X,Test_Y);
        else
            msgbox('ELM not trained for this data')
        end
    end
    
    if get(handles.compSelectSVM,'Value')==1
        load svmParameters
        load masterParameters
        svmParameters.KernelFunction
        KFun(5,1)={svmParameters.KernelFunction};
        
        load svm
        if isfield(svmParameters,'TrainingTime')==1
            TrainTime(5)={num2str(svmParameters.TrainingTime)};
        end
        Indices=masterParameters.Indices;
        TrainTestSplit=masterParameters.TrainTestSplit;
        NumTest=round(size(Inputs,1)*(1-TrainTestSplit));
        SV=models.SupportVectors;
        if size(SV,2)==size(Inputs,2)&&length(size(Inputs))<3
            Train_X=Inputs(Indices(1:end-NumTest),:);
            Train_Y=Targets(Indices(1:end-NumTest),:);
            Test_X=Inputs(Indices(end-NumTest+1:end),:);
            Test_Y=Targets(Indices(end-NumTest+1:end),:);
            [Predicted,Actual,svmAccuracyTrain]=multisvmtest(Train_X,Train_Y,models);
            [Predicted,Actual,svmAccuracyTest]=multisvmtest(Test_X,Test_Y,models);
        else
            msgbox('SVM not trained for this data')
        end
    end
    
    
    if get(handles.compSelectHELM,'Value')==1
        load helmParameters
        load masterParameters
        load helm
        
        if isfield(helm{helmParameters.NLayers+1},'TrainingTime')==1
            TrainTime(7)={num2str(helm{helmParameters.NLayers+1}.TrainingTime)};
        end
        
        NumNodes(7,1)={num2str(helmParameters.SizeMatrix)};
        NumLayers(7,1)={num2str(helmParameters.NLayers)};
        
        Indices=masterParameters.Indices;
        TrainTestSplit=masterParameters.TrainTestSplit;
        NumTest=round(size(Inputs,1)*(1-TrainTestSplit));
        H=helm{1};
        if (size(H.iw,1)-1)==size(Inputs,2)&&length(size(Inputs))<3
            Train_X=Inputs(Indices(1:end-NumTest),:);
            Train_Y=Targets(Indices(1:end-NumTest),:);
            Test_X=Inputs(Indices(end-NumTest+1:end),:);
            Test_Y=Targets(Indices(end-NumTest+1:end),:);
            [Predicted, helmAccuracyTrain, Actual] = helm_test(Train_X, Train_Y, helm,helmParameters.ActivationFunction);
            [Predicted, helmAccuracyTest, Actual] = helm_test(Test_X, Test_Y, helm,helmParameters.ActivationFunction);
        else
            msgbox('HELM not trained for this data')
        end
    end
    
    if get(handles.compSelectDBN,'Value')==1
        load dbnParameters
        load masterParameters
        load dbn
        
        if isfield(dbn,'TrainingTime')==1
            TrainTime(6)={num2str(dbn.TrainingTime)};
        end
        
        NumNodes(6,1)={num2str(dbnParameters.SizeMatrix)};
        NumLayers(6,1)={num2str(size(dbnParameters.SizeMatrix,2))};
        Indices=masterParameters.Indices;
        TrainTestSplit=masterParameters.TrainTestSplit;
        NumTest=round(size(Inputs,1)*(1-TrainTestSplit));
        H=dbn.W{1};
        if (size(H,2)-1)==size(Inputs,2)&&length(size(Inputs))<3
            Train_X=Inputs(Indices(1:end-NumTest),:);
            Train_Y=Targets(Indices(1:end-NumTest),:);
            Test_X=Inputs(Indices(end-NumTest+1:end),:);
            Test_Y=Targets(Indices(end-NumTest+1:end),:);
            [dbnAccuracyTrain,Predicted,Actual]=testDBN(dbn,Train_X,Train_Y);
            [dbnAccuracyTest,Predicted,Actual]=testDBN(dbn,Test_X,Test_Y);
        else
            msgbox('DBN not trained for this data')
        end
    end
    
    if get(handles.compSelectMLP,'Value')==1
        load mlpParameters
        load masterParameters
        load mlp
        
        if isfield(mlp,'TrainingTime')==1
            TrainTime(8)={num2str(mlp.TrainingTime)};
        end
        
        NumNodes(8,1)={num2str(mlpParameters.SizeMatrix)};
        NumLayers(8,1)={num2str(mlpParameters.Nlayers)};
        Indices=masterParameters.Indices;
        TrainTestSplit=masterParameters.TrainTestSplit;
        NumTest=round(size(Inputs,1)*(1-TrainTestSplit));
%         H=dbn.W{1};
        if size(mlp.weights{1},1)==size(Inputs,2)&&length(size(Inputs))<3
            Train_X=Inputs(Indices(1:end-NumTest),:);
            Train_Y=Targets(Indices(1:end-NumTest),:);
            Test_X=Inputs(Indices(end-NumTest+1:end),:);
            Test_Y=Targets(Indices(end-NumTest+1:end),:);
            [Out C] = test_mlp(mlp, Train_X, Train_Y,1);
            mlpAccuracyTrain=C*100;
            [Out C] = test_mlp(mlp, Test_X, Test_Y,1);
            mlpAccuracyTest=C*100;
        else
            msgbox('DBN not trained for this data')
        end
    end
    
    A1=[fisherAccuracyTrain lscAccuracyTrain nbAccuracyTrain elmAccuracyTrain ...
        svmAccuracyTrain dbnAccuracyTrain helmAccuracyTrain mlpAccuracyTrain]';
    A2=[fisherAccuracyTest lscAccuracyTest nbAccuracyTest elmAccuracyTest ...
        svmAccuracyTest dbnAccuracyTest helmAccuracyTest mlpAccuracyTest]';
    AccuracyTr=cellstr(num2str(A1 ));
    AccuracyTe=cellstr(num2str(A2));
    Accuracy=[AccuracyTr AccuracyTe];
    
    
    RowNames=[{'Fisher'} {'LSC'} {'Naive Bayes'} {'ELM'} {'SVM'} {'DBN'} {'HELM'} {'MLP'}]';
    ColNames=[{'Training Accuracy'} {'Test Accuracy'} {'Kernel Function'} {'Number of layers'} {'No of Nodes'} {'Training Time'}];
    
    
    Data=[Accuracy KFun NumLayers NumNodes TrainTime];
    clc
    save('d.mat','Data')
    % Data=cell2table(Data)
    set(handles.masterComparisonMatrix,'ColumnName',ColNames)
    set(handles.masterComparisonMatrix,'RowName',RowNames)
    set(handles.masterComparisonMatrix,'data',Data)
else
    msgbox('Import Iinputs and Targets first')
end
% hObject    handle to masterCompare (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in compSelectFisher.
function compSelectFisher_Callback(hObject, eventdata, handles)
% hObject    handle to compSelectFisher (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of compSelectFisher


% --- Executes on button press in compSelectLSC.
function compSelectLSC_Callback(hObject, eventdata, handles)
% hObject    handle to compSelectLSC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of compSelectLSC


% --- Executes on button press in compSelectNB.
function compSelectNB_Callback(hObject, eventdata, handles)
% hObject    handle to compSelectNB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of compSelectNB


% --- Executes on button press in compSelectSVM.
function compSelectSVM_Callback(hObject, eventdata, handles)
% hObject    handle to compSelectSVM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of compSelectSVM


% --- Executes on button press in compSelectELM.
function compSelectELM_Callback(hObject, eventdata, handles)
% hObject    handle to compSelectELM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of compSelectELM


% --- Executes on button press in compSelectDBN.
function compSelectDBN_Callback(hObject, eventdata, handles)
% hObject    handle to compSelectDBN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of compSelectDBN


% --- Executes on button press in compSelectHELM.
function compSelectHELM_Callback(hObject, eventdata, handles)
% hObject    handle to compSelectHELM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of compSelectHELM


% --- Executes on button press in compSelectMLP.
function compSelectMLP_Callback(hObject, eventdata, handles)
% hObject    handle to compSelectMLP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of compSelectMLP


% --- Executes on selection change in masterSelectX1.
function masterSelectX1_Callback(hObject, eventdata, handles)
Ind=get(handles.masterInputs,'Value');
Str=get(handles.masterInputs,'String');
InputsCheck=length(Str)>0;
if length(Str)==0
    msgbox('Please select Inputs first and then import them')
else
    Inputs = evalin('base',cell2mat(Str(Ind)));
    Str1=get(handles.masterSelectX1,'String');
    Val1=get(handles.masterSelectX1,'Value');
    FVal=Str1(Val1,:);
    if iscell(FVal)==1
        Feat1=str2num(cell2mat(FVal));
    else
        Feat1=str2num((FVal));
    end
    
    Str2=get(handles.masterSelectX2,'String');
    Val2=get(handles.masterSelectX2,'Value');
    FVal=Str2(Val2,:);
    if iscell(FVal)==1
        Feat2=str2num(cell2mat(FVal));
    else
        Feat2=str2num((FVal));
    end

    axes(handles.masterPlotFeatures)
    cla(handles.masterPlotFeatures)
    Ind=get(handles.masterTargets,'Value');
    Str=get(handles.masterTargets,'String');
    if length(Str)==0
        msgbox('Please select Inputs first and then import them')
        return
    else
        Targets = evalin('base',cell2mat(Str(Ind)));
    end

    colors=[{'red'},{'green'},{'blue'},{'black'},{'cyan'},{'yellow'}];
    Ut=unique(Targets(:,1));
    for i=1:length(Ut)
        Ind=find(Targets(:,1)==Ut(i));
        scatter(Inputs(Ind,Feat1),Inputs(Ind,Feat2),'MarkerEdgeColor',cell2mat(colors(i)))
        if i==1
            hold on
        end
    end
    legend('class 1','class 2','class 3','class 4','class 5','class 6')
    
end
% hObject    handle to masterSelectX1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns masterSelectX1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from masterSelectX1


% --- Executes during object creation, after setting all properties.
function masterSelectX1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to masterSelectX1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in masterSelectX2.
function masterSelectX2_Callback(hObject, eventdata, handles)
Ind=get(handles.masterInputs,'Value');
Str=get(handles.masterInputs,'String');
InputsCheck=length(Str)>0;
if length(Str)==0
    msgbox('Please select Inputs first and then import them')
else
    Inputs = evalin('base',cell2mat(Str(Ind)));
    Str1=get(handles.masterSelectX1,'String');
    Val1=get(handles.masterSelectX1,'Value');
    FVal=Str1(Val1,:);
    if iscell(FVal)==1
        Feat1=str2num(cell2mat(FVal));
    else
        Feat1=str2num((FVal));
    end
    
    Str2=get(handles.masterSelectX2,'String');
    Val2=get(handles.masterSelectX2,'Value');
    FVal=Str2(Val2,:);
    if iscell(FVal)==1
        Feat2=str2num(cell2mat(FVal));
    else
        Feat2=str2num((FVal));
    end

    axes(handles.masterPlotFeatures)
    cla(handles.masterPlotFeatures)
    Ind=get(handles.masterTargets,'Value');
    Str=get(handles.masterTargets,'String');
    if length(Str)==0
        msgbox('Please select Inputs first and then import them')
        return
    else
        Targets = evalin('base',cell2mat(Str(Ind)));
    end

    colors=[{'red'},{'green'},{'blue'},{'black'},{'cyan'},{'yellow'}];
    Ut=unique(Targets(:,1));
    for i=1:length(Ut)
        Ind=find(Targets(:,1)==Ut(i));
        scatter(Inputs(Ind,Feat1),Inputs(Ind,Feat2),'MarkerEdgeColor',cell2mat(colors(i)))
        if i==1
            hold on
        end
    end
    legend('class 1','class 2','class 3','class 4','class 5','class 6')
    
end
% hObject    handle to masterSelectX2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns masterSelectX2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from masterSelectX2


% --- Executes during object creation, after setting all properties.
function masterSelectX2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to masterSelectX2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
