function varargout = ELM_GUI(varargin)
%%
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @ELM_GUI_OpeningFcn, ...
    'gui_OutputFcn',  @ELM_GUI_OutputFcn, ...
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


% --- Executes just before ELM_GUI is made visible.
function ELM_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
axes(handles.elmLogo)
Img=imread('logo.jpg');
imshow(Img)
set(handles.elmTrainTestSplit,'String',70);
if exist('elmParameters.mat')==2
   load elmParameters
end
elmParameters.TrainTestSplit=0.7;
save('elmParameters.mat','elmParameters')

handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = ELM_GUI_OutputFcn(hObject, eventdata, handles)

varargout{1} = handles.output;


function elmWorkspaceList_Callback(hObject, eventdata, handles)


function elmWorkspaceList_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in elmLoadWorkspace.
function elmLoadWorkspace_Callback(hObject, eventdata, handles)
set(handles.elmImportInputs,'Visible','on')
set(handles.elmInputs,'Visible','on')
Vars = evalin('base','who');
set(handles.elmWorkspaceList,'String',Vars)


% --- Executes on selection change in elmInputs.
function elmInputs_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function elmInputs_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in elmImportInputs.
function elmImportInputs_Callback(hObject, eventdata, handles)
set(handles.elmImportTargets,'Visible','on')
set(handles.elmTargets,'Visible','on')
Ind=get(handles.elmWorkspaceList,'Value');
Str=get(handles.elmWorkspaceList,'String');
Var = evalin('base',cell2mat(Str(Ind)));
set(handles.elmInputs,'String',Str(Ind));


% --- Executes on selection change in elmTargets.
function elmTargets_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function elmTargets_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in elmImportTargets.
function elmImportTargets_Callback(hObject, eventdata, handles)
set(handles.elmStep2,'Visible','on')
Ind=get(handles.elmWorkspaceList,'Value');
Str=get(handles.elmWorkspaceList,'String');
Var = evalin('base',cell2mat(Str(Ind)));
set(handles.elmTargets,'String',Str(Ind));

Ind=get(handles.elmInputs,'Value');
Str=get(handles.elmInputs,'String');
InputsCheck=length(Str)>0;
if length(Str)==0
    msgbox('Please select Inputs first and then import them')
else
    Inputs = evalin('base',cell2mat(Str(Ind)));
end
if InputsCheck==1
    Ind=get(handles.elmTargets,'Value');
    Str=get(handles.elmTargets,'String');
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



% --- Executes on button press in elmTrainNetwork.
function elmTrainNetwork_Callback(hObject, eventdata, handles)
CheckString=get(handles.elmTrainBG,'Title');
if strcmp(CheckString,'Train (A)')==1
    load('elmParameters.mat')
    if isfield(elmParameters,'TrainTestSplit')==1
        TrainTestSplit=elmParameters.TrainTestSplit;
    else
        TrainTestSplit=str2num(get(handles.elmTrainTestSplit,'String'))/100;
        elmParameters.TrainTestSplit=TrainTestSplit;
    end
    
    check2=isfield(elmParameters,'ActivationFunction');
    if check2==1
        ActivationFunction=elmParameters.ActivationFunction;
        if iscell(ActivationFunction)==1
            ActivationFunction=cell2mat(ActivationFunction);
        end
    else
        msgbox('Please select activation function')    
    end
    check3=isfield(elmParameters,'HiddenNeurons');
    if check3==1
        NumberofHiddenNeurons=elmParameters.HiddenNeurons;
    else
        if check2==1
            msgbox('Please enter number of hidden neurons')
        end
    end
    
    
    ind=get(handles.elmInputs,'Value');
    str=get(handles.elmInputs,'String');
    inputsCheck=length(str)>0;
    if length(str)==0
        msgbox('Please select Inputs first and then import them')
    else
        Inputs = evalin('base',cell2mat(str(ind)));
    end
    inputsDimCheck=size(Inputs,1)>size(Inputs,2);
    if inputsDimCheck==0
        msgbox('Warning ! Data is under defined. Number of entries should be greater than or equal to number of features')
    end
    if inputsCheck==1
        ind=get(handles.elmTargets,'Value');
        str=get(handles.elmTargets,'String');
        targetsCheck=length(str)>0;
        if targetsCheck==1
            if length(str)==0
                msgbox('Please select Targets first and then import them')
            else
                Targets = evalin('base',cell2mat(str(ind)));
                if size(Targets,2)<2
                    ut=unique(Targets);
                    Targets1=Targets;
                    Targets=zeros(size(Targets1,1),length(ut));
                    for i=1:length(ut)
                        Targets(find(Targets1==ut(i)),i)=1;
                    end
                end
            end
            NumTest=round(size(Inputs,1)*(1-TrainTestSplit));
            Indices=randperm(size(Inputs,1));
            elmParameters.Indices=Indices;
            elmParameters.NumTest=NumTest;
            
            Train_X=Inputs(Indices(1:end-NumTest),:);
            Train_Y=Targets(Indices(1:end-NumTest),:);
            
            Test_X=Inputs(Indices(end-NumTest+1:end),:);
            Test_Y=Targets(Indices(end-NumTest+1:end),:);
            
            
            
            tic
            [elm,Predicted,Actual,TrainingAccuracy] = elm_train(Train_X,Train_Y, NumberofHiddenNeurons, ActivationFunction);
            T=toc;
            elm.TrainingTime=T;
            set(handles.elmTrainingAccuracy,'String',num2str(TrainingAccuracy))
            
            
            save('elm.mat','elm')
            save('elmParameters.mat','elmParameters')
            msgbox('Training Complete')
        end
    end
    set(handles.elmEvaluateTrain,'Visible','on')
    set(handles.elmResultsBG,'Visible','on')
else
    msgbox('Please Enter Network parameters 1st')
end



function elmTrainingAccuracy_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function elmTrainingAccuracy_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function elmLogo_CreateFcn(hObject, eventdata, handles)


% --- Executes on mouse press over axes background.
function elmLogo_ButtonDownFcn(hObject, eventdata, handles)



% --- Executes on button press in elmEvaluateTrain.
function elmEvaluateTrain_Callback(hObject, eventdata, handles)
CheckString=get(handles.elmTrainBG,'Title');
if strcmp(CheckString,'Train (A)')==1
    if exist('elm.mat')==2
        load('elmParameters.mat')
        load elm
        if isfield(elmParameters,'TrainTestSplit')==1
            TrainTestSplit=elmParameters.TrainTestSplit;
        else
            TrainTestSplit=str2num(get(handles.elmTrainTestSplit,'String'))/100;
            elmParameters.TrainTestSplit=TrainTestSplit;
        end
        
        check2=isfield(elmParameters,'ActivationFunction');
        if check2==1
            ActivationFunction=elmParameters.ActivationFunction;
        else
            msgbox('Please select activation function')
        end
        check3=isfield(elmParameters,'HiddenNeurons');
        if check3==1
            NumberofHiddenNeurons=elmParameters.HiddenNeurons;
        else
            if check2==1
                msgbox('Please enter number of hidden neurons')
            end
        end
        save('elmParameters.mat','elmParameters')
        
        Ind=get(handles.elmInputs,'Value');
        Str=get(handles.elmInputs,'String');
        InputsCheck=length(Str)>0;
        if length(Str)==0
            msgbox('Please select Inputs first and then import them')
        else
            Inputs = evalin('base',cell2mat(Str(Ind)));
        end
        inputsDimCheck=size(Inputs,1)>size(Inputs,2);
        if inputsDimCheck==0
            msgbox('Warning ! Data is under defined. Number of entries should be greater than or equal to number of features')
        end
        if InputsCheck==1
            Ind=get(handles.elmTargets,'Value');
            Str=get(handles.elmTargets,'String');
            TargetsCheck=length(Str)>0;
            if TargetsCheck==1
                if length(Str)==0
                    msgbox('Please select Targets first and then import them')
                else
                    Targets = evalin('base',cell2mat(Str(Ind)));
                    if size(Targets,2)<2
                        ut=unique(Targets);
                        Targets1=Targets;
                        Targets=zeros(size(Targets1,1),length(ut));
                        for i=1:length(ut)
                            Targets(find(Targets1==ut(i)),i)=1;
                        end
                    end
                end
                
                
                NumTest=round(size(Inputs,1)*(1-TrainTestSplit));
                Indices=elmParameters.Indices;
                size(Indices)
                size(Inputs)
                Train_X=Inputs(Indices(1:end-NumTest),:);
                Train_Y=Targets(Indices(1:end-NumTest),:);
                
                %             Test_X=Inputs(Indices(end-NumTest+1:end),:);
                %             Test_Y=Targets(Indices(end-NumTest+1:end),:);
                
                
                [Predicted,Actual, TrainingAccuracy] = elm_predict(elm,Train_X,Train_Y);
                
                cla(handles.elmPlotROC)
                axes(handles.elmPlotROC)
                Ua=unique(Actual);
                Up=unique(Predicted);
                TC=length(Up);
                TempA=ones(size(Actual));
                TempP=ones(size(Actual));
                wrongClasses=[];
                perfCheck=0;
                for i=1:TC
                    TempA=ones(size(Actual));
                    TempP=ones(size(Predicted));
                    TempP(find(Predicted==Ua(i)))=2;
                    TempA(find(Actual==Ua(i)))=2;
                    if length(unique(TempP))==length(unique(TempA))
                        [X,Y] = perfcurve(TempP,TempA,2);
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
                %%
                TC=length(unique(Predicted));
                
                for i=1:TC
                    Acti=find(Actual==Ua(i));
                    TempActi=ones(length(Actual),1);
                    TempActi(Acti)=-1;
                    for j=1:TC
                        TempPredj=zeros(length(Predicted),1);
                        Actj=find(Predicted==Ua(j));
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

                set(handles.elmConfusionMatrix,'ColumnName',ColNames)
                set(handles.elmConfusionMatrix,'RowName',RowNames)
                set(handles.elmConfusionMatrix,'data',[dataP])                
                set(handles.elmTrainingAccuracy,'String',num2str(TrainingAccuracy))
                save('elm.mat','elm')
                msgbox('Training evaluation Complete')
            end
        end
    else
        msgbox('No trained ELM object found')
    end
else
    msgbox('Please Enter Network parameters 1st')
end


function elmTrainTestSplit_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function elmTrainTestSplit_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function elmTestingAccuracy_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function elmTestingAccuracy_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in elmEvaluateTest.
function elmEvaluateTest_Callback(hObject, eventdata, handles)
CheckString=get(handles.elmTrainBG,'Title');
if strcmp(CheckString,'Train (A)')==1
    if exist('elm.mat')==2
        load('elmParameters.mat')
        load elm
        if isfield(elmParameters,'TrainTestSplit')==1
            TrainTestSplit=elmParameters.TrainTestSplit;
        else
            TrainTestSplit=str2num(get(handles.elmTrainTestSplit,'String'))/100;
            elmParameters.TrainTestSplit=TrainTestSplit;
        end
        
        check2=isfield(elmParameters,'ActivationFunction');
        if check2==1
            ActivationFunction=elmParameters.ActivationFunction;
        else
            msgbox('Please select activation function')
        end
        check3=isfield(elmParameters,'HiddenNeurons');
        if check3==1
            NumberofHiddenNeurons=elmParameters.HiddenNeurons;
        else
            if check2==1
                msgbox('Please enter number of hidden neurons')
            end
        end
        save('elmParameters.mat','elmParameters')
        
        Ind=get(handles.elmInputs,'Value');
        Str=get(handles.elmInputs,'String');
        InputsCheck=length(Str)>0;
        if length(Str)==0
            msgbox('Please select Inputs first and then import them')
        else
            Inputs = evalin('base',cell2mat(Str(Ind)));
        end
        inputsDimCheck=size(Inputs,1)>size(Inputs,2);
        if inputsDimCheck==0
            msgbox('Warning ! Data is under defined. Number of entries should be greater than or equal to number of features')
        end
        if InputsCheck==1
            Ind=get(handles.elmTargets,'Value');
            Str=get(handles.elmTargets,'String');
            TargetsCheck=length(Str)>0;
            if TargetsCheck==1
                if length(Str)==0
                    msgbox('Please select Targets first and then import them')
                else
                    Targets = evalin('base',cell2mat(Str(Ind)));
                    if size(Targets,2)<2
                        ut=unique(Targets);
                        Targets1=Targets;
                        Targets=zeros(size(Targets1,1),length(ut));
                        for i=1:length(ut)
                            Targets(find(Targets1==ut(i)),i)=1;
                        end
                    end
                end
                
                
                NumTest=round(size(Inputs,1)*(1-TrainTestSplit));
                Indices=randperm(size(Inputs,1));
                elmParameters.Indices=Indices;
                
%                 Train_X=Inputs(Indices(1:end-NumTest),:);
%                 Train_Y=Targets(Indices(1:end-NumTest),:);
%                 
                Test_X=Inputs(Indices(end-NumTest+1:end),:);
                Test_Y=Targets(Indices(end-NumTest+1:end),:);
                
                
                [Predicted,Actual, TestingAccuracy] = elm_predict(elm,Test_X,Test_Y);
                
                cla(handles.elmPlotROC)
                axes(handles.elmPlotROC)
                Ua=unique(Actual);
                Up=unique(Predicted);
                TC=length(Up);
                TempA=ones(size(Actual));
                TempP=ones(size(Actual));
                wrongClasses=[];
                perfCheck=0;
                for i=1:TC
                    TempA=ones(size(Actual));
                    TempP=ones(size(Predicted));
                    TempP(find(Predicted==Ua(i)))=2;
                    TempA(find(Actual==Ua(i)))=2;
                    if length(unique(TempP))==length(unique(TempA))
                        [X,Y] = perfcurve(TempP,TempA,2);
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
                %%
                TC=length(unique(Predicted));
                
                for i=1:TC
                    Acti=find(Actual==Ua(i));
                    TempActi=ones(length(Actual),1);
                    TempActi(Acti)=-1;
                    for j=1:TC
                        TempPredj=zeros(length(Predicted),1);
                        Actj=find(Predicted==Ua(j));
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

                set(handles.elmConfusionMatrix,'ColumnName',ColNames)
                set(handles.elmConfusionMatrix,'RowName',RowNames)
                set(handles.elmConfusionMatrix,'data',[dataP])                
                set(handles.elmTestingAccuracy,'String',num2str(TestingAccuracy))
                save('elm.mat','elm')
                msgbox('Testing evaluation Complete')
            end
        end
    else
        msgbox('No trained ELM object found')
    end
else
    msgbox('Please Enter Network parameters 1st')
end


% --- Executes on button press in elmMatFile.
function elmMatFile_Callback(hObject, eventdata, handles)


% --- Executes on button press in elmCsvFile.
function elmCsvFile_Callback(hObject, eventdata, handles)


% --- Executes on button press in elmXlsxFile.
function elmXlsxFile_Callback(hObject, eventdata, handles)


% --- Executes on button press in elmSaveData.
function elmSaveData_Callback(hObject, eventdata, handles)
load elmVal
csvCheck=get(handles.elmCsvFile,'Value');
matCheck=get(handles.elmMatFile,'Value');
xlsxCheck=get(handles.elmXlsxFile,'Value');
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





% --- Executes on button press in elmStep2Clear.
function elmStep2Clear_Callback(hObject, eventdata, handles)
set(handles.elmHiddenNeurons,'String','')
ind=get(handles.elmActivationFunction,'Value');
strP=get(handles.elmActivationFunction,'String');
ActivationFunction=(strP(ind,:));
set(handles.elmActivationFunction,'Value',1)


% --- Executes on button press in elmStep2.
function elmStep2_Callback(hObject, eventdata, handles)
set(handles.elmNetworkBG,'Title','Network Parameters (A)')
set(handles.elmNetworkBG,'Visible','on')
set(handles.elmStep3,'String','Step 3 (A)')


% --- Executes on button press in elmStep3.
function elmStep3_Callback(hObject, eventdata, handles)
checkString=get(handles.elmStep3,'String');
if strcmp(checkString,'Step 3 (A)')==1
    CheckString=get(handles.elmNetworkBG,'Title');
    if strcmp(CheckString,'Network Parameters (A)')==1     
        
        set(handles.elmTrainBG,'Title','Train (A)')
        set(handles.elmTrainBG,'Visible','on')
        
        ind=get(handles.elmActivationFunction,'Value');
        strP=get(handles.elmActivationFunction,'String');
        ActivationFunction=(strP(ind,:));
        elmParameters.ActivationFunction=strtrim(ActivationFunction);
        StrN=get(handles.elmHiddenNeurons,'String');
        if length(StrN)>0
            HiddenNeurons=str2num(StrN);
            elmParameters.HiddenNeurons=HiddenNeurons;
            NCheck=1;
        else
            msgbox('Enter a valid value for number of hidden neurons')
            NCheck=0;
        end
        if NCheck==1
            TrainTestSplit=str2num(get(handles.elmTrainTestSplit,'String'))/100;
            elmParameters.TrainTestSplit=TrainTestSplit;
        end
        save('elmParameters.mat','elmParameters')
        
    else
        msgbox('Please properly import Inputs and Targets and then hit "Step 2" button')
    end
else
    msgbox('Select Number of hidden layers, then enter number of neurons in each layer')
end


% --- Executes on button press in elmStep1Clear.
function elmStep1Clear_Callback(hObject, eventdata, handles)
set(handles.elmImportTargets,'Visible','off')
set(handles.elmTargets,'Visible','off')

set(handles.elmImportInputs,'Visible','off')
set(handles.elmInputs,'Visible','off')
set(handles.elmStep2,'Visible','off')




function elmActivationFunction_Callback(hObject, eventdata, handles)
load elmParameters
ind=get(handles.elmActivationFunction,'Value');
strP=get(handles.elmActivationFunction,'String');
ActivationFunction=(strP(ind,:));
elmParameters.ActivationFunction=strtrim(ActivationFunction)
save('elmParameters.mat','elmParameters');


% --- Executes during object creation, after setting all properties.
function elmActivationFunction_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function elmHiddenNeurons_Callback(hObject, eventdata, handles)
load elmParameters
StrN=get(handles.elmHiddenNeurons,'String');
if length(StrN)>0
    HiddenNeurons=str2num(StrN);
    elmParameters.HiddenNeurons=HiddenNeurons;
    NCheck=1;
else
    msgbox('Enter a valid value for number of hidden neurons')
    NCheck=0;
end
elmParameters.HiddenNeurons=HiddenNeurons;
save('elmParameters.mat','elmParameters')



% --- Executes during object creation, after setting all properties.
function elmHiddenNeurons_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
