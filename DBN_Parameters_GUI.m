function varargout = DBN_Parameters_GUI(varargin)
% DBN_PARAMETERS_GUI MATLAB code for DBN_Parameters_GUI.fig
%      DBN_PARAMETERS_GUI, by itself, creates a new DBN_PARAMETERS_GUI or raises the existing
%      singleton*.
%
%      H = DBN_PARAMETERS_GUI returns the handle to a new DBN_PARAMETERS_GUI or the handle to
%      the existing singleton*.
%
%      DBN_PARAMETERS_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DBN_PARAMETERS_GUI.M with the given input arguments.
%
%      DBN_PARAMETERS_GUI('Property','Value',...) creates a new DBN_PARAMETERS_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DBN_Parameters_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DBN_Parameters_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DBN_Parameters_GUI

% Last Modified by GUIDE v2.5 10-Jun-2016 16:22:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DBN_Parameters_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @DBN_Parameters_GUI_OutputFcn, ...
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


% --- Executes just before DBN_Parameters_GUI is made visible.
function DBN_Parameters_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
if exist('dbnParameters.mat')==2
    load dbnParameters
end
dbnParameters.SizeMatrix=[20 10];
dbnParameters.NLayers=2;
dbnParameters.NumEpochs=5;
save('dbnParameters.mat','dbnParameters')
set(handles.dbnNumEpochs,'Value',5)
set(handles.dbnBatchSize,'Value',5)

% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DBN_Parameters_GUI (see VARARGIN)

% Choose default command line output for DBN_Parameters_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes DBN_Parameters_GUI wait for user response (see UIRESUME)
% uiwait(handles.dbnParameters);


% --- Outputs from this function are returned to the command line.
function varargout = DBN_Parameters_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in dbnNumberH.
function dbnNumberH_Callback(hObject, eventdata, handles)
if (1)
    NStr=get(handles.dbnNumberH,'String');
    NInd=get(handles.dbnNumberH,'Value');
    NVal=NStr(NInd,:);
    if iscell(NVal)==1
        NLayers=str2num(strtrim(cell2mat(NVal)));
    else
        NLayers=strtrim(str2num(NVal));
    end
    load dbnParameters
    dbnParameters.SizeMatrix=[];
    dbnParameters.NLayers=NLayers;
    save('dbnParameters.mat','dbnParameters')
    if isfield(handles,'NumOfFeaturesH')==1
        delete( handles.NumOfFeaturesH(handles.NumOfFeaturesH>0));
        handles.NumOfFeaturesH(:) = 0;
        delete( handles.SizeName(handles.SizeName>0));
        handles.SizeName(:) = 0;
    end
    dbnParameters.FeaturesHandle=[];
    PanelPos = getpixelposition(handles.dbnNetworkBG);
    RefPos = getpixelposition(handles.dbnSizeText);
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
        String={num2str([5:5:10000 i]')};
        pop_menu = uicontrol('Parent', DBN_Parameters_GUI, 'Style', 'Popupmenu', 'Position', Pos2, 'String',...
            String, 'Value', 10, 'Callback', @popup_bar);
        handles.NumOfFeaturesH(i)=pop_menu;

        SizeName(i) = uicontrol(  'Style', 'text','pos',Pos1 );
        handles.SizeName(i) = SizeName(i);
        set(handles.SizeName(i),'String',num2str(i))
        guidata(gcf,handles)
        dbnParameters.FeaturesHandle(i)=i;
        dbnParameters.SizeMatrix(i)=10;
    end
    delete('dbnParameters.mat')
    save('dbnParameters.mat','dbnParameters')
else
    msgbox('Import Inputs and Targets Properly, then hit "Step 2"')
end

function [] = popup_bar(gcbo,handles)
load dbnParameters
Str=get(gcbo,'String');
CurrNumber=str2num(cell2mat(Str(end)));
Ind=(get(gcbo,'Value'));
dbnParameters.SizeMatrix(CurrNumber)=str2num(cell2mat(Str(Ind)));
save('dbnParameters.mat','dbnParameters')

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



function dbnNumEpochs_Callback(hObject, eventdata, handles)
load dbnParameters
Str=get(handles.dbnNumEpochs,'String');
Val=get(handles.dbnNumEpochs,'Value');
EVal=Str(Val,:);
if iscell(EVal)==1
    dbnParameters.NumEpochs=str2num(strtrim(cell2mat(EVal)));
else
    dbnParameters.NumEpochs=str2num(strtrim((EVal)));
end
save('dbnParameters.mat','dbnParameters')
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



function dbnBatchSize_Callback(hObject, eventdata, handles)
load dbnParameters
Str=get(handles.dbnBatchSize,'String');
Val=get(handles.dbnBatchSize,'Value');
BVal=Str(Val,:);
if iscell(BVal)==1
    dbnParameters.BatchSize=str2num(strtrim(cell2mat(BVal)));
else
    dbnParameters.BatchSize=str2num(strtrim((BVal)));
end
save('dbnParameters.mat','dbnParameters')
% hObject    handle to dbnBatchSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dbnBatchSize as text
%        str2double(get(hObject,'String')) returns contents of dbnBatchSize as a double


% --- Executes during object creation, after setting all properties.
function dbnBatchSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dbnBatchSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in dbnEnterParameters.
function dbnEnterParameters_Callback(hObject, eventdata, handles)
close(gcf)
% hObject    handle to dbnEnterParameters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
