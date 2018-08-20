function varargout = ELM_Parameters_GUI(varargin)
% ELM_PARAMETERS_GUI MATLAB code for ELM_Parameters_GUI.fig
%      ELM_PARAMETERS_GUI, by itself, creates a new ELM_PARAMETERS_GUI or raises the existing
%      singleton*.
%
%      H = ELM_PARAMETERS_GUI returns the handle to a new ELM_PARAMETERS_GUI or the handle to
%      the existing singleton*.
%
%      ELM_PARAMETERS_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ELM_PARAMETERS_GUI.M with the given input arguments.
%
%      ELM_PARAMETERS_GUI('Property','Value',...) creates a new ELM_PARAMETERS_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ELM_Parameters_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ELM_Parameters_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ELM_Parameters_GUI

% Last Modified by GUIDE v2.5 12-Jun-2016 21:59:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ELM_Parameters_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @ELM_Parameters_GUI_OutputFcn, ...
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


% --- Executes just before ELM_Parameters_GUI is made visible.
function ELM_Parameters_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
if exist('elmParameters.mat')==2
   load elmParameters
end
elmParameters.ActivationFunction={'sigmoid'};
elmParameters.HiddenNeurons=50;
save('elmParameters.mat','elmParameters')

set(handles.elmActivationFunction,'Value',1)
set(handles.elmHiddenNeurons,'Value',8)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ELM_Parameters_GUI (see VARARGIN)

% Choose default command line output for ELM_Parameters_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ELM_Parameters_GUI wait for user response (see UIRESUME)
% uiwait(handles.elmParameters);


% --- Outputs from this function are returned to the command line.
function varargout = ELM_Parameters_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in elmSetParameters.
function elmSetParameters_Callback(hObject, eventdata, handles)
close(gcf)
% hObject    handle to elmSetParameters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in elmActivationFunction.
function elmActivationFunction_Callback(hObject, eventdata, handles)
load elmParameters
Ind=get(handles.elmActivationFunction,'Value');
StrP=get(handles.elmActivationFunction,'String');
ActivationFunction=(StrP(Ind,:));
elmParameters.ActivationFunction=strtrim(ActivationFunction)
save('elmParameters.mat','elmParameters');
% hObject    handle to elmActivationFunction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns elmActivationFunction contents as cell array
%        contents{get(hObject,'Value')} returns selected item from elmActivationFunction


% --- Executes during object creation, after setting all properties.
function elmActivationFunction_CreateFcn(hObject, eventdata, handles)
% hObject    handle to elmActivationFunction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in elmHiddenNeurons.
function elmHiddenNeurons_Callback(hObject, eventdata, handles)
load elmParameters
Ind=get(handles.elmHiddenNeurons,'Value');
StrP=get(handles.elmHiddenNeurons,'String');
AVal=(StrP(Ind,:));
if iscell(AVal)==1
    elmParameters.HiddenNeurons=str2num(strtrim(cell2mat(AVal)));
else
    elmParameters.HiddenNeurons=str2num(strtrim((AVal)));
end
save('elmParameters.mat','elmParameters');
% hObject    handle to elmHiddenNeurons (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns elmHiddenNeurons contents as cell array
%        contents{get(hObject,'Value')} returns selected item from elmHiddenNeurons


% --- Executes during object creation, after setting all properties.
function elmHiddenNeurons_CreateFcn(hObject, eventdata, handles)
% hObject    handle to elmHiddenNeurons (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
