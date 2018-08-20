function varargout = LSC_Parameters_GUI(varargin)
% LSC_PARAMETERS_GUI MATLAB code for LSC_Parameters_GUI.fig
%      LSC_PARAMETERS_GUI, by itself, creates a new LSC_PARAMETERS_GUI or raises the existing
%      singleton*.
%
%      H = LSC_PARAMETERS_GUI returns the handle to a new LSC_PARAMETERS_GUI or the handle to
%      the existing singleton*.
%
%      LSC_PARAMETERS_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LSC_PARAMETERS_GUI.M with the given input arguments.
%
%      LSC_PARAMETERS_GUI('Property','Value',...) creates a new LSC_PARAMETERS_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before LSC_Parameters_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to LSC_Parameters_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help LSC_Parameters_GUI

% Last Modified by GUIDE v2.5 12-Jun-2016 23:23:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @LSC_Parameters_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @LSC_Parameters_GUI_OutputFcn, ...
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


% --- Executes just before LSC_Parameters_GUI is made visible.
function LSC_Parameters_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
if exist('masterParameters.mat')==2
    load masterParameters
    TolV=round(999*.4)+1;
    V=logspace(1,6,1000)/10e5;
    Tol=V(TolV);
    set(handles.lscTolText,'String','.001')
    set(handles.lscTol,'Value',.4)
    linearParameters.Tol=Tol;
end

if exist('linearParameters.mat')==2
    load linearParameters
        TolV=round(999*.4)+1;
    V=logspace(1,6,1000)/10e5;
    Tol=V(TolV);
    set(handles.lscTolText,'String','.001')
    set(handles.lscTol,'Value',.4)
    linearParameters.Tol=Tol;
end
save('linearParameters.mat','linearParameters')



% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to LSC_Parameters_GUI (see VARARGIN)

% Choose default command line output for LSC_Parameters_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes LSC_Parameters_GUI wait for user response (see UIRESUME)
% uiwait(handles.lscParameters);


% --- Outputs from this function are returned to the command line.
function varargout = LSC_Parameters_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function lscTol_Callback(hObject, eventdata, handles)
load linearParameters
load masterParameters
TolV=round(999*get(handles.lscTol,'Value'))+1;
V=logspace(1,6,1000)/10e5;
Tol=V(TolV);
set(handles.lscTolText,'String',num2str(Tol))
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


% --- Executes on button press in lscSetParameters.
function lscSetParameters_Callback(hObject, eventdata, handles)
close(gcf)
% hObject    handle to lscSetParameters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
