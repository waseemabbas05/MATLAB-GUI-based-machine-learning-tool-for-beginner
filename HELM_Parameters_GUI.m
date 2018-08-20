function varargout = HELM_Parameters_GUI(varargin)
% HELM_PARAMETERS_GUI MATLAB code for HELM_Parameters_GUI.fig
%      HELM_PARAMETERS_GUI, by itself, creates a new HELM_PARAMETERS_GUI or raises the existing
%      singleton*.
%
%      H = HELM_PARAMETERS_GUI returns the handle to a new HELM_PARAMETERS_GUI or the handle to
%      the existing singleton*.
%
%      HELM_PARAMETERS_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HELM_PARAMETERS_GUI.M with the given input arguments.
%
%      HELM_PARAMETERS_GUI('Property','Value',...) creates a new HELM_PARAMETERS_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before HELM_Parameters_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to HELM_Parameters_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help HELM_Parameters_GUI

% Last Modified by GUIDE v2.5 10-Jun-2016 17:10:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @HELM_Parameters_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @HELM_Parameters_GUI_OutputFcn, ...
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


% --- Executes just before HELM_Parameters_GUI is made visible.
function HELM_Parameters_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
if exist('helmParameters.mat')==2
   load helmParameters
end
helmParameters.NLayers=2;
helmParameters.SizeMatrix=[50 100];
helmParameters.ActivationFunction='sigmoid';
helmParameters.NumEpochs=10;
set(handles.helmNumberH,'Value',1)
set(handles.helmNumEpochs,'Value',6)
set(handles.helmActivationFunction,'Value',1)
save('helmParameters.mat','helmParameters')
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to HELM_Parameters_GUI (see VARARGIN)

% Choose default command line output for HELM_Parameters_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes HELM_Parameters_GUI wait for user response (see UIRESUME)
% uiwait(handles.helmParametersGUI);


% --- Outputs from this function are returned to the command line.
function varargout = HELM_Parameters_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in helmNumberH.
function helmNumberH_Callback(hObject, eventdata, handles)
if (1)
    NStr=get(handles.helmNumberH,'String');
    NInd=get(handles.helmNumberH,'Value');
    NVal=NStr(NInd,:);
    if iscell(NVal)==1
        NLayers=str2num(strtrim(cell2mat(NVal)));
    else
        NLayers=strtrim(str2num(NVal));
    end
    load helmParameters
    helmParameters.SizeMatrix=[];
    helmParameters.NLayers=NLayers;
    save('helmParameters.mat','helmParameters')
    if isfield(handles,'NumOfFeaturesH')==1
        delete( handles.NumOfFeaturesH(handles.NumOfFeaturesH>0));
        handles.NumOfFeaturesH(:) = 0;
        delete( handles.SizeName(handles.SizeName>0));
        handles.SizeName(:) = 0;
    end
    helmParameters.FeaturesHandle=[];
    PanelPos = getpixelposition(handles.helmNetworkBG);
    RefPos = getpixelposition(handles.helmSizeText);
    Pos=[PanelPos(1)+RefPos(1) PanelPos(2)+RefPos(2)+40 PanelPos(3) PanelPos(4)];
    
    handles.NumOfFeaturesH=[];
    handles.SizeName=[];
    
    Dx=25;
    Dy=5;
    for i=1:NLayers
        Dx1=(55+Dx)*(i-1);
        Dy1=55;
        if i>5
            Dy1=100;
            Dx1=(55+Dx)*(i-6);
        end
        Pos1=[Pos(1)+Dx1 Pos(2)-Dy1 32 15];
        
        Dx2=(55+Dx)*(i-1);
        Dy2=80;
        if i>5
            Dy2=125;
            Dx2=(55+Dx)*(i-6);
        end
        Pos2=[Pos(1)+Dx2 Pos(2)-Dy2 55 22];
        %     SizeH(i) =  uicontrol( 'Style', 'popupmenu','pos',Pos2 );
        String={num2str([5:5:5000 i]')};
        pop_menu = uicontrol('Parent', HELM_Parameters_GUI, 'Style', 'Popupmenu', 'Position', Pos2, 'String',...
            String, 'Value', 10, 'Callback', @popup_bar);
        handles.NumOfFeaturesH(i)=pop_menu;

        SizeName(i) = uicontrol(  'Style', 'text','pos',Pos1 );
        handles.SizeName(i) = SizeName(i);
        set(handles.SizeName(i),'String',num2str(i))
        
        helmParameters.FeaturesHandle(i)=i;
        helmParameters.SizeMatrix(i)=50;
        guidata(gcf,handles)
    end
    delete('helmParameters.mat')
    save('helmParameters.mat','helmParameters')
else
    msgbox('Import Inputs and Targets Properly, then hit "Step 2"')
end


function [] = popup_bar(gcbo,handles)
load helmParameters
Str=get(gcbo,'String');
CurrNumber=str2num(cell2mat(Str(end)));
Ind=(get(gcbo,'Value'));
helmParameters.SizeMatrix(CurrNumber)=str2num(cell2mat(Str(Ind)))
save('helmParameters.mat','helmParameters')

% hObject    handle to helmNumberH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns helmNumberH contents as cell array
%        contents{get(hObject,'Value')} returns selected item from helmNumberH


% --- Executes during object creation, after setting all properties.
function helmNumberH_CreateFcn(hObject, eventdata, handles)
% hObject    handle to helmNumberH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in helmNumEpochs.
function helmNumEpochs_Callback(hObject, eventdata, handles)
load helmParameters
Str=get(handles.helmNumEpochs,'String');
Val=get(handles.helmNumEpochs,'Value');
EVal=Str(Val,:);
if iscell(EVal)==1
    helmParameters.NumEpochs=str2num(strtrim(cell2mat(EVal)));
else
    helmParameters.NumEpochs=str2num(strtrim((EVal)));
end
save('helmParameters.mat','helmParameters')

% hObject    handle to helmNumEpochs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns helmNumEpochs contents as cell array
%        contents{get(hObject,'Value')} returns selected item from helmNumEpochs


% --- Executes during object creation, after setting all properties.
function helmNumEpochs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to helmNumEpochs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in helmSetParameters.
function helmSetParameters_Callback(hObject, eventdata, handles)
close(gcf)
% hObject    handle to helmSetParameters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in helmActivationFunction.
function helmActivationFunction_Callback(hObject, eventdata, handles)
load helmParameters
Str=get(handles.helmActivationFunction,'String');
Val=get(handles.helmActivationFunction,'Value');
EVal=Str(Val,:);
if iscell(EVal)==1
    helmParameters.ActivationFunction=(strtrim(cell2mat(EVal)));
else
    helmParameters.ActivationFunction=(strtrim((EVal)));
end
save('helmParameters.mat','helmParameters')
% hObject    handle to helmActivationFunction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns helmActivationFunction contents as cell array
%        contents{get(hObject,'Value')} returns selected item from helmActivationFunction


% --- Executes during object creation, after setting all properties.
function helmActivationFunction_CreateFcn(hObject, eventdata, handles)
% hObject    handle to helmActivationFunction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
