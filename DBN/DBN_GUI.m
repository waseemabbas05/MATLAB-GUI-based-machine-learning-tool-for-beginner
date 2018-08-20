function varargout = DBN_GUI(varargin)
% DBN_GUI MATLAB code for DBN_GUI.fig
%      DBN_GUI, by itself, creates a new DBN_GUI or raises the existing
%      singleton*.
%
%      H = DBN_GUI returns the handle to a new DBN_GUI or the handle to
%      the existing singleton*.
%
%      DBN_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DBN_GUI.M with the given input arguments.
%
%      DBN_GUI('Property','Value',...) creates a new DBN_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DBN_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DBN_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DBN_GUI

% Last Modified by GUIDE v2.5 01-Jun-2016 16:53:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @DBN_GUI_OpeningFcn, ...
    'gui_OutputFcn',  @DBN_GUI_OutputFcn, ...
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


% --- Executes just before DBN_GUI is made visible.
function DBN_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
axes(handles.logo)
img=imread('logo.jpg');
imshow(img)
set(handles.dbnTrainTestSplit,'String',70);
if exist('dbnParameters.mat')==2
   load dbnParameters
end
dbnParameters.TrainTestSplit=0.7;
save('dbnParameters.mat','dbnParameters')

delete('sizeCheck.mat')



% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DBN_GUI (see VARARGIN)

% Choose default command line output for DBN_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes DBN_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = DBN_GUI_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function browse_Callback(hObject, eventdata, handles)
% hObject    handle to browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function briwseExcel_Callback(hObject, eventdata, handles)
% hObject    handle to briwseExcel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function browseText_Callback(hObject, eventdata, handles)
% hObject    handle to browseText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function browseDat_Callback(hObject, eventdata, handles)
% hObject    handle to browseDat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in dbnWorkspaceList.
function dbnWorkspaceList_Callback(hObject, eventdata, handles)
% hObject    handle to dbnWorkspaceList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns dbnWorkspaceList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from dbnWorkspaceList


% --- Executes during object creation, after setting all properties.
function dbnWorkspaceList_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dbnWorkspaceList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in dbnLoadWorkspace.
function dbnLoadWorkspace_Callback(hObject, eventdata, handles)
set(handles.dbnImportInputs,'Visible','on')
set(handles.dbnInputs,'Visible','on')
vars = evalin('base','who');
set(handles.dbnWorkspaceList,'String',vars)
% hObject    handle to dbnLoadWorkspace (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
ind=get(handles.dbnWorkspaceList,'Value');
str=get(handles.dbnWorkspaceList,'String');
str(ind)
var = evalin('base',cell2mat(str(ind)))
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in dbnInputs.
function dbnInputs_Callback(hObject, eventdata, handles)
% hObject    handle to dbnInputs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns dbnInputs contents as cell array
%        contents{get(hObject,'Value')} returns selected item from dbnInputs


% --- Executes during object creation, after setting all properties.
function dbnInputs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dbnInputs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in dbnImportInputs.
function dbnImportInputs_Callback(hObject, eventdata, handles)
set(handles.dbnImportTargets,'Visible','on')
set(handles.dbnTargets,'Visible','on')
ind=get(handles.dbnWorkspaceList,'Value');
str=get(handles.dbnWorkspaceList,'String');
var = evalin('base',cell2mat(str(ind)));
set(handles.dbnInputs,'String',str(ind));
% hObject    handle to dbnImportInputs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in dbnTargets.
function dbnTargets_Callback(hObject, eventdata, handles)
% hObject    handle to dbnTargets (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns dbnTargets contents as cell array
%        contents{get(hObject,'Value')} returns selected item from dbnTargets


% --- Executes during object creation, after setting all properties.
function dbnTargets_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dbnTargets (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in dbnImportTargets.
function dbnImportTargets_Callback(hObject, eventdata, handles)
set(handles.dbnStep2,'Visible','on')
ind=get(handles.dbnWorkspaceList,'Value');
str=get(handles.dbnWorkspaceList,'String');
var = evalin('base',cell2mat(str(ind)));
set(handles.dbnTargets,'String',str(ind));

ind=get(handles.dbnInputs,'Value');
str=get(handles.dbnInputs,'String');
inputsCheck=length(str)>0;
if length(str)==0
    msgbox('Please select Inputs first and then import them')
else
    Inputs = evalin('base',cell2mat(str(ind)));
end
if inputsCheck==1
    ind=get(handles.dbnTargets,'Value');
    str=get(handles.dbnTargets,'String');
    if length(str)==0
        msgbox('Please select Inputs first and then import them')
    else
        Targets = evalin('base',cell2mat(str(ind)));
    end
end
if size(Targets,2)>size(Targets,1)
    msgbox('Targets are in wrong format')
end
if size(Targets,1)~=size(Inputs,1)
    msgbox('Wrong Inputs or Targets')
end

% hObject    handle to dbnImportTargets (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in dbnEnterSizeB.
function dbnEnterSizeB_Callback(hObject, eventdata, handles)
CheckString=get(handles.dbnNetworkBG,'Title');
if strcmp(CheckString,'Network Parameters (A)')==1
    ind=get(handles.dbnNumberH,'Value');
    strP=get(handles.dbnNumberH,'String');
    str=cell2mat(strP(ind));
    N=0;
    if length(str)<=32
        N=str2num(str);
    end
    
    if N>0
        set(handles.dbnNumEpochsText,'Visible','on')
        set(handles.dbnNumEpochs,'Visible','on')
        set(handles.dbnBatchSizeText,'Visible','on')
        set(handles.dbnBatchSize,'Visible','on')
        set(handles.dbnStep3,'String','Step 3 (A)')
        set(handles.dbnSizeText,'Visible','on')
        panelPos = getpixelposition(handles.dbnNetworkBG);
        refPos = getpixelposition(handles.dbnNumberH);
        pos=[panelPos(1)+refPos(1) panelPos(2)+refPos(2) panelPos(3) panelPos(4)];
        
        handles.SizeH=[];
        handles.SizeName=[];
        
        dx=5;
        dy=5;
        for i=1:N
            dX1=(32+dx)*(i-1);
            dY1=55;
            if i>10
                dY1=100;
                dX1=(32+dx)*(i-11);
            end
            pos1=[pos(1)+dX1 pos(2)-dY1 32 15];
            
            dX2=(32+dx)*(i-1);
            dY2=80;
            if i>10
                dY2=125;
                dX2=(32+dx)*(i-11);
            end
            pos2=[pos(1)+dX2 pos(2)-dY2 32 22];
            SizeH(i) =  uicontrol( 'Style', 'edit','pos',pos2 );
            handles.SizeH(i)=SizeH(i);
            SizeName(i) = uicontrol(  'Style', 'text','pos',pos1 );
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



% --- Executes on button press in dbnTrainNetwork.
function dbnTrainNetwork_Callback(hObject, eventdata, handles)
CheckString=get(handles.dbnTrainBG,'Title');
if strcmp(CheckString,'Train (A)')==1
    load dbnParameters
    check1=isfield(dbnParameters,'SizeMatrix');
    if check1==1
        SizeMatrix=dbnParameters.SizeMatrix;
    else
        msgbox('Please Enter Size and Architecture of Network 1st')
    end
    
    check2=isfield(dbnParameters,'BatchSize');
    if check2==1
        BatchSize=dbnParameters.BatchSize;
    else
        if check1==1
            msgbox('Please Enter Batch Size 1st')
        end
    end
    
    check3=isfield(dbnParameters,'TrainTestSplit');
    if check3==1
        TrainTestSplit=dbnParameters.TrainTestSplit;
    else
        if check1*check2==1
            msgbox('Set value of TrainTestSplit')
        end
    end
    
    check4=isfield(dbnParameters,'NumEpochs');
    if check4==1
        NumEpochs=dbnParameters.NumEpochs;
    else
        if check1*check2*check3==1
            msgbox('Please Enter NumEpochs 1st')
        end
    end
    
    Ind=get(handles.dbnInputs,'Value');
    Str=get(handles.dbnInputs,'String');
    inputsCheck=length(Str)>0;
    if length(Str)==0
        msgbox('Please select Inputs first and then import them')
    else
        Inputs = evalin('base',cell2mat(Str(Ind)));
    end
    InputsDimCheck=size(Inputs,1)>size(Inputs,2);
    if InputsDimCheck==0
        msgbox('Warning ! Data is under defined. Number of entries should be greater than or equal to number of features')
    end
    if inputsCheck*InputsDimCheck==1
        Ind=get(handles.dbnTargets,'Value');
        Str=get(handles.dbnTargets,'String');
        targetsCheck=length(Str)>0;
        if targetsCheck==1
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
            
            NumTest=round(length(Inputs)*(1-TrainTestSplit));
            Indices=randperm(size(Inputs,1));
            dbnParameters.Indices=Indices;
            save('dbnParameters.mat','dbnParameters')
            
            Train_X=Inputs(Indices(1:end-NumTest),:);
            Train_Y=Targets(Indices(1:end-NumTest),:);

            Train_L=size(Train_Y,1);
            if rem(length(Train_X),BatchSize)~=0
                Train_L=floor(length(Train_X)/BatchSize)*BatchSize;
            end
            Train_X=Train_X(1:Train_L,:);
            Train_Y=Train_Y(1:Train_L,:);
            
            
            Test_X=Inputs(Indices(end-NumTest+1:end),:);
            Test_Y=Targets(Indices(end-NumTest+1:end),:);
            
            tic
            [dbn,Actual,Predicted,TrainingAccuracy] = createAndTrainDBN(Train_X, Train_Y, SizeMatrix,BatchSize, TrainTestSplit,NumEpochs);
            T=toc;
            dbn.TrainingTime=T;
            set(handles.dbnTrainingAccuracy,'String',num2str(TrainingAccuracy))

            save('dbn.mat','dbn')
            msgbox('Training Complete')
        end
    end
    set(handles.dbnEvaluateTrain,'Visible','on')
    set(handles.dbnResultsBG,'Visible','on')
else
    msgbox('Please Enter Network parameters 1st')
end



function dbnTrainingAccuracy_Callback(hObject, eventdata, handles)
% hObject    handle to dbnTrainingAccuracy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dbnTrainingAccuracy as text
%        str2double(get(hObject,'String')) returns contents of dbnTrainingAccuracy as a double


% --- Executes during object creation, after setting all properties.
function dbnTrainingAccuracy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dbnTrainingAccuracy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function Batch_Callback(hObject, eventdata, handles)
% hObject    handle to dbnNumEpochs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dbnNumEpochs as text
%        str2double(get(hObject,'String')) returns contents of dbnNumEpochs as a double


% --- Executes during object creation, after setting all properties.
function dbnNumEpochs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dbnNumEpochs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function logo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to logo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate logo


% --- Executes on mouse press over axes background.
function logo_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to logo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1


% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function truePositive_Callback(hObject, eventdata, handles)
% hObject    handle to truePositive (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of truePositive as text
%        str2double(get(hObject,'String')) returns contents of truePositive as a double


% --- Executes during object creation, after setting all properties.
function truePositive_CreateFcn(hObject, eventdata, handles)
% hObject    handle to truePositive (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function falseNegative_Callback(hObject, eventdata, handles)
% hObject    handle to falseNegative (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of falseNegative as text
%        str2double(get(hObject,'String')) returns contents of falseNegative as a double


% --- Executes during object creation, after setting all properties.
function falseNegative_CreateFcn(hObject, eventdata, handles)
% hObject    handle to falseNegative (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function falsePositive_Callback(hObject, eventdata, handles)
% hObject    handle to falsePositive (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of falsePositive as text
%        str2double(get(hObject,'String')) returns contents of falsePositive as a double


% --- Executes during object creation, after setting all properties.
function falsePositive_CreateFcn(hObject, eventdata, handles)
% hObject    handle to falsePositive (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function trueNegative_Callback(hObject, eventdata, handles)
% hObject    handle to trueNegative (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of trueNegative as text
%        str2double(get(hObject,'String')) returns contents of trueNegative as a double


% --- Executes during object creation, after setting all properties.
function trueNegative_CreateFcn(hObject, eventdata, handles)
% hObject    handle to trueNegative (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in rb1.
function rb1_Callback(hObject, eventdata, handles)
% hObject    handle to rb1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rb1


% --- Executes on button press in dbnEvaluateTrain.
function dbnEvaluateTrain_Callback(hObject, eventdata, handles)
if exist('dbn.mat')==2
    cla(handles.dbnPlotROC)
    load dbnParameters
    load dbn
    
    
    %%
    Ind=get(handles.dbnInputs,'Value');
    Str=get(handles.dbnInputs,'String');
    inputsCheck=length(Str)>0;
    if length(Str)==0
        msgbox('Please select Inputs first and then import them')
    else
        Inputs = evalin('base',cell2mat(Str(Ind)));
    end
    
    
    Ind=get(handles.dbnTargets,'Value');
    Str=get(handles.dbnTargets,'String');
    targetsCheck=length(Str)>0;
    
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
    
    TrainTestSplit=dbnParameters.TrainTestSplit;
    NumTest=round(length(Inputs)*(1-TrainTestSplit));
    Indices=dbnParameters.Indices;

    
    Train_X=Inputs(Indices(1:end-NumTest),:);
    Train_Y=Targets(Indices(1:end-NumTest),:);
    
    
    
    %%
    [Accuracy,Predicted,Actual]=testDBN(dbn,Train_X,Train_Y);
    axes(handles.dbnPlotROC)
    %%
    Ua=unique(Actual);
    Up=unique(Predicted);
    TC=length(Up);
    tempE=ones(size(Actual));
    tempA=ones(size(Actual));
    wrongClasses=[];
    perfCheck=0;
    for i=1:TC
        tempE=ones(size(Actual));
        tempA=ones(size(Actual));
        tempA(find(Predicted==Ua(i)))=2;
        tempE(find(Actual==Ua(i)))=2;
        if length(unique(tempA))==length(unique(tempE))
            [X,Y] = perfcurve(tempA,tempE,2);
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
            Predj=find(Predicted==Ua(j));
            TempPredj(Predj)=-1;
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

    set(handles.dbnConfusionMatrix,'ColumnName',ColNames)
    set(handles.dbnConfusionMatrix,'RowName',RowNames)
    set(handles.dbnConfusionMatrix,'data',[dataP])
    set(handles.dbnTrainingAccuracy,'String',num2str(Accuracy))
        
    set(handles.dbnSaveData,'Visible','on')
    set(handles.dbnMatFile,'Visible','on')
    set(handles.dbnXlsxFile,'Visible','on')
    set(handles.dbnCsvFile,'Visible','on')
else
    msgbox('No Trained DBN Onject found')
end




% hObject    handle to dbnEvaluateTrain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function dbnTrainTestSplit_Callback(hObject, eventdata, handles)
% hObject    handle to dbnTrainTestSplit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dbnTrainTestSplit as text
%        str2double(get(hObject,'String')) returns contents of dbnTrainTestSplit as a double


% --- Executes during object creation, after setting all properties.
function dbnTrainTestSplit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dbnTrainTestSplit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function dbnTestingAccuracy_Callback(hObject, eventdata, handles)
% hObject    handle to dbnTestingAccuracy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dbnTestingAccuracy as text
%        str2double(get(hObject,'String')) returns contents of dbnTestingAccuracy as a double


% --- Executes during object creation, after setting all properties.
function dbnTestingAccuracy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dbnTestingAccuracy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in dbnEvaluateTest.
function dbnEvaluateTest_Callback(hObject, eventdata, handles)
if exist('dbn.mat')==2
    cla(handles.dbnPlotROC)
    load dbnParameters
    load dbn
    
    
    %%
    Ind=get(handles.dbnInputs,'Value');
    Str=get(handles.dbnInputs,'String');
    inputsCheck=length(Str)>0;
    if length(Str)==0
        msgbox('Please select Inputs first and then import them')
    else
        Inputs = evalin('base',cell2mat(Str(Ind)));
    end
    
    
    Ind=get(handles.dbnTargets,'Value');
    Str=get(handles.dbnTargets,'String');
    targetsCheck=length(Str)>0;
    
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
    
    TrainTestSplit=dbnParameters.TrainTestSplit;
    NumTest=round(length(Inputs)*(1-TrainTestSplit));
    Indices=dbnParameters.Indices;

    
    Test_X=Inputs(Indices(end-NumTest+1:end),:);
    Test_Y=Targets(Indices(end-NumTest+1:end),:);
    
    
    %%
    [Accuracy,Predicted,Actual]=testDBN(dbn,Test_X,Test_Y);
    axes(handles.dbnPlotROC)
    %%
    Ua=unique(Actual);
    Up=unique(Predicted);
    TC=length(Up);
    tempE=ones(size(Actual));
    tempA=ones(size(Actual));
    wrongClasses=[];
    perfCheck=0;
    for i=1:TC
        tempE=ones(size(Actual));
        tempA=ones(size(Actual));
        tempA(find(Predicted==Ua(i)))=2;
        tempE(find(Actual==Ua(i)))=2;
        if length(unique(tempA))==length(unique(tempE))
            [X,Y] = perfcurve(tempA,tempE,2);
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
            Predj=find(Predicted==Ua(j));
            TempPredj(Predj)=-1;
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

    set(handles.dbnConfusionMatrix,'ColumnName',ColNames)
    set(handles.dbnConfusionMatrix,'RowName',RowNames)
    set(handles.dbnConfusionMatrix,'data',[dataP])
    set(handles.dbnTestingAccuracy,'String',num2str(Accuracy))
        
    set(handles.dbnSaveData,'Visible','on')
    set(handles.dbnMatFile,'Visible','on')
    set(handles.dbnXlsxFile,'Visible','on')
    set(handles.dbnCsvFile,'Visible','on')
else
    msgbox('No Trained DBN Onject found')
end
% hObject    handle to dbnEvaluateTest (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in dbnMatFile.
function dbnMatFile_Callback(hObject, eventdata, handles)
% hObject    handle to dbnMatFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of dbnMatFile


% --- Executes on button press in dbnCsvFile.
function dbnCsvFile_Callback(hObject, eventdata, handles)
% hObject    handle to dbnCsvFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of dbnCsvFile


% --- Executes on button press in dbnXlsxFile.
function dbnXlsxFile_Callback(hObject, eventdata, handles)
% hObject    handle to dbnXlsxFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of dbnXlsxFile


% --- Executes on button press in dbnSaveData.
function dbnSaveData_Callback(hObject, eventdata, handles)
load DBNVal
csvCheck=get(handles.dbnCsvFile,'Value');
matCheck=get(handles.dbnMatFile,'Value');
xlsxCheck=get(handles.dbnXlsxFile,'Value');
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
% hObject    handle to dbnSaveData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in dbnNumberH.
function dbnNumberH_Callback(hObject, eventdata, handles)
% hObject    handle to dbnNumberH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns dbnNumberH contents as cell array
%        contents{get(hObject,'Value')} returns selected item from dbnNumberH


% --- Executes during object creation, after setting all properties.
function dbnNumberH_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dbnNumberH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function SizeH_Callback(hObject, eventdata, handles)
% hObject    handle to SizeH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SizeH as text
%        str2double(get(hObject,'String')) returns contents of SizeH as a double


% --- Executes during object creation, after setting all properties.
function SizeH_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SizeH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in dbnStep2Clear.
function dbnStep2Clear_Callback(hObject, eventdata, handles)
load N
clc
delete( handles.SizeH(handles.SizeH>0));
handles.SizeH(:) = 0;
delete( handles.SizeName(handles.SizeName>0));
handles.SizeName(:) = 0;
set(handles.dbnSizeText,'Visible','off')
set(handles.dbnNumEpochs,'String','')
set(handles.dbnBatchSize,'String','')
delete('N.mat')

% hObject    handle to dbnStep2Clear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


function dbnBatchSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dbnBatchSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in EnterParameters.
function EnterParameters_Callback(hObject, eventdata, handles)


% --- Executes on button press in dbnStep2.
function dbnStep2_Callback(hObject, eventdata, handles)
set(handles.dbnNetworkBG,'Title','Network Parameters (A)')
set(handles.dbnNetworkBG,'Visible','on')

% hObject    handle to dbnStep2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in dbnStep3.
function dbnStep3_Callback(hObject, eventdata, handles)
CheckString=get(handles.dbnStep3,'String');
if strcmp(CheckString,'Step 3 (A)')==1
    set(handles.dbnTrainBG,'Title','Train (A)')
    set(handles.dbnTrainBG,'Visible','on')
    SizeMatrix=[];
    NumEpochs=[];
    BatchSize=[];
    LayerCheck=0;
    LayersSizeCheck=0;
    if exist('N.mat')==2&isfield(handles,'SizeH')
        load N
        LayersSizeCheck=zeros(1,N);
        for i=1:N
            str=get(handles.SizeH(i),'String');
            if length(str)>0
                SizeMatrix(i)=str2num(str);
                LayersSizeCheck(i)=1;
            elseif sum(LayersSizeCheck(1:i))==i-1
                msgStr=['Enter a valid value for Number of Hidden Neurons in Layer ' num2str(i)];
                msgbox(msgStr)
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
            str=get(handles.dbnNumEpochs,'String');
            if length(str)>0
                NumEpochs=str2num(str);
            else
                msgStr=['Enter a valid value for Number of Epochs'];
                msgbox(msgStr)
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
        str=get(handles.dbnBatchSize,'String');
        if length(str)>0
            BatchSize=str2num(str);
            BatchCheck=1;
        else
            msgStr=['Enter a valid value for BatchSize'];
            msgbox(msgStr)
        end
    end
    
    if sum(LayersSizeCheck)*EpochsCheck*SizeCheck*BatchCheck==N
        dbnParameters.SizeMatrix=SizeMatrix;
        dbnParameters.NumEpochs=NumEpochs;
        dbnParameters.BatchSize=BatchSize;
        dbnParameters.TrainTestSplit=str2num(get(handles.dbnTrainTestSplit,'String'))/100;
        save('dbnParameters.mat','dbnParameters')
    end
else
    msgbox('Select Number of hidden layers, then enter number of neurons in each layer')
end
% --- Executes on button press in dbnStep1Clear.
function dbnStep1Clear_Callback(hObject, eventdata, handles)
set(handles.dbnImportTargets,'Visible','off')
set(handles.dbnTargets,'Visible','off')

set(handles.dbnImportInputs,'Visible','off')
set(handles.dbnInputs,'Visible','off')
set(handles.dbnStep2,'Visible','off')

% hObject    handle to dbnStep1Clear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton28.
function pushbutton28_Callback(hObject, eventdata, handles)
set(handles.dbnLoadDataBG,'Visible','on')

% hObject    handle to pushbutton28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton29.
function pushbutton29_Callback(hObject, eventdata, handles)
set(handles.dbnLoadDataBG,'Visible','off')
set(handles.dbnNetworkBG,'Visible','off')
set(handles.dbnTrainBG,'Visible','off')
set(handles.dbnResultsBG,'Visible','off')

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
% hObject    handle to pushbutton29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function dbnBatchSize_Callback(hObject, eventdata, handles)
% hObject    handle to dbnBatchSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dbnBatchSize as text
%        str2double(get(hObject,'String')) returns contents of dbnBatchSize as a double



function dbnNumEpochs_Callback(hObject, eventdata, handles)
% hObject    handle to dbnNumEpochs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dbnNumEpochs as text
%        str2double(get(hObject,'String')) returns contents of dbnNumEpochs as a double
