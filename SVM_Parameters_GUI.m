function varargout = SVM_Parameters_GUI(varargin)
% SVM_PARAMETERS_GUI MATLAB code for SVM_Parameters_GUI.fig
%      SVM_PARAMETERS_GUI, by itself, creates a new SVM_PARAMETERS_GUI or raises the existing
%      singleton*.
%
%      H = SVM_PARAMETERS_GUI returns the handle to a new SVM_PARAMETERS_GUI or the handle to
%      the existing singleton*.
%
%      SVM_PARAMETERS_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SVM_PARAMETERS_GUI.M with the given input arguments.
%
%      SVM_PARAMETERS_GUI('Property','Value',...) creates a new SVM_PARAMETERS_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SVM_Parameters_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SVM_Parameters_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SVM_Parameters_GUI

% Last Modified by GUIDE v2.5 12-Jun-2016 21:43:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SVM_Parameters_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @SVM_Parameters_GUI_OutputFcn, ...
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


% --- Executes just before SVM_Parameters_GUI is made visible.
function SVM_Parameters_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
if exist('svmParameters.mat')==2
    load svmParameters
end
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
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SVM_Parameters_GUI (see VARARGIN)

% Choose default command line output for SVM_Parameters_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SVM_Parameters_GUI wait for user response (see UIRESUME)
% uiwait(handles.svmParametersGUI);


% --- Outputs from this function are returned to the command line.
function varargout = SVM_Parameters_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in svmSetParameters.
function svmSetParameters_Callback(hObject, eventdata, handles)
close(gcf)
% hObject    handle to svmSetParameters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on slider movement.
function svmMaxIter_Callback(hObject, eventdata, handles)
if (1)
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
if (1)
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
if (1)
    load svmParameters
    Val=linspace(.0001,1,1000);
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


% --- Executes on selection change in svmKernelFunction.
function svmKernelFunction_Callback(hObject, eventdata, handles)
if (1)
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
if (1)
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
if (1)
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
if (1)
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


% --- Executes on button press in svmDisplayIterYes.
function svmDisplayIterYes_Callback(hObject, eventdata, handles)
if (1)
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
if (1)
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
