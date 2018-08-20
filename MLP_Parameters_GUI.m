function varargout = MLP_Parameters_GUI(varargin)
% MLP_PARAMETERS_GUI MATLAB code for MLP_Parameters_GUI.fig
%      MLP_PARAMETERS_GUI, by itself, creates a new MLP_PARAMETERS_GUI or raises the existing
%      singleton*.
%
%      H = MLP_PARAMETERS_GUI returns the handle to a new MLP_PARAMETERS_GUI or the handle to
%      the existing singleton*.
%
%      MLP_PARAMETERS_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MLP_PARAMETERS_GUI.M with the given input arguments.
%
%      MLP_PARAMETERS_GUI('Property','Value',...) creates a new MLP_PARAMETERS_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MLP_Parameters_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MLP_Parameters_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MLP_Parameters_GUI

% Last Modified by GUIDE v2.5 12-Jun-2016 22:29:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MLP_Parameters_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @MLP_Parameters_GUI_OutputFcn, ...
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


% --- Executes just before MLP_Parameters_GUI is made visible.
function MLP_Parameters_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
IterStr=num2str([10:10:500]');
set(handles.mlpMaxIterations,'Value',5)
set(handles.mlpMaxIterations,'String',IterStr)

set(handles.mlpLearningRate,'Value',0.1)
set(handles.mlpLearningRateText,'String','0.1')

set(handles.mlpMomentum,'Value',0.1)
set(handles.mlpMomentumText,'String','0.1')

set(handles.mlpTolerance,'Value',0.1)
set(handles.mlpToleranceText,'String','0.001')

if exist('mlpParameters.mat')==2
    load mlpParameters
end
mlpParameters.MaxIterations=50;
mlpParameters.LearningRate=.1;
mlpParameters.Momentum=0.1;
mlpParameters.Nlayers=3;
mlpParameters.Tolerance=.001;
mlpParameters.SizeMatrix=[10 10 10];
delete('mlpParameters.mat')
save('mlpParameters.mat','mlpParameters')
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MLP_Parameters_GUI (see VARARGIN)

% Choose default command line output for MLP_Parameters_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MLP_Parameters_GUI wait for user response (see UIRESUME)
% uiwait(handles.helmParametersGUI);


% --- Outputs from this function are returned to the command line.
function varargout = MLP_Parameters_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in helmNumberH.
function helmNumberH_Callback(hObject, eventdata, handles)
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
% hObject    handle to helmSetParameters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in helmActivationFunction.
function helmActivationFunction_Callback(hObject, eventdata, handles)
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


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in mlpMaxIterations.
function mlpMaxIterations_Callback(hObject, eventdata, handles)
MaxIterations=get(handles.mlpMaxIterations,'Value');
load mlpParameters
mlpParameters.Momentum=MaxIterations
save('mlpParameters.mat','mlpParameters')
% hObject    handle to mlpMaxIterations (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns mlpMaxIterations contents as cell array
%        contents{get(hObject,'Value')} returns selected item from mlpMaxIterations


% --- Executes during object creation, after setting all properties.
function mlpMaxIterations_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mlpMaxIterations (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in mlpNumberH.
function mlpNumberH_Callback(hObject, eventdata, handles)
if (1)
    Ind=get(handles.mlpNumberH,'Value');
    StrP=get(handles.mlpNumberH,'String');
    Str=cell2mat(StrP(Ind));
    NLayers=0;
    if length(Str)<=32
        NStr=get(handles.mlpNumberH,'String');
        NInd=get(handles.mlpNumberH,'Value');
        NLayers=str2num(cell2mat(NStr(NInd,:)));
    end
    
    if NLayers>0
        load mlpParameters
        mlpParameters.NLayers=NLayers;
        mlpParameters.SizeMatrix=[];
        save('mlpParameters.mat','mlpParameters')
        if isfield(handles,'NLayersNH')==1
            delete( handles.NLayersNH(handles.NLayersNH>0));
            handles.NLayersNH(:) = 0;
            delete( handles.SizeName(handles.SizeName>0));
            handles.SizeName(:) = 0;
            mlpParameters.LayersHandle=[];
            mlpParameters.SizeMatrix=[];
            mlpParameters = rmfield(mlpParameters,'LayersHandle');
        end
        save('mlpParameters.mat','mlpParameters')
    
        
        PanelPos = getpixelposition(handles.mlpNetworkBG);
        RefPos = getpixelposition(handles.mlpNumberH);
        Pos=[PanelPos(1)+RefPos(1) PanelPos(2)+RefPos(2)+10 PanelPos(3) PanelPos(4)];
        
        handles.NLayersNH=[];
        handles.SizeName=[];
        mlpParameters.LayersHandle=[];
        
        Dx=20;
        Dy=5;
        Dxx=60;
        for i=1:NLayers
            Dx1=(Dxx+Dx)*(i-1);
            Dy1=55;
            if i>5
                Dy1=100;
                Dx1=(Dxx+Dx)*(i-6);
            end
            Pos1=[Pos(1)+Dx1 Pos(2)-Dy1 60 15];
            
            Dx2=(Dxx+Dx)*(i-1);
            Dy2=80;
            if i>5
                Dy2=125;
                Dx2=(Dxx+Dx)*(i-6);
            end
            Pos2=[Pos(1)+Dx2 Pos(2)-Dy2 60 25];
            
            String={num2str([5:5:5000 i]')};
            pop_menu = uicontrol('Parent', MLP_Parameters_GUI, 'Style', 'Popupmenu', 'Position', Pos2, 'String',...
                String, 'Value', 10, 'Callback', @popup_bar);
            mlpParameters.SizeMatrix(i)=10;
            handles.NLayersNH(i)=pop_menu;
            
            SizeName(i) = uicontrol(  'Style', 'text','pos',Pos1 );
            handles.SizeName(i) = SizeName(i);
            set(handles.SizeName(i),'String',num2str(i))
            guidata(gcf,handles)
            mlpParameters.LayersHandle(i)=i;
        end
    delete('mlpParameters.mat')
    save('mlpParameters.mat','mlpParameters')
        
    else
        msgbox('Please select a valid value for Number of Layers and then hit "Enter" ')
    end
else
    msgbox('Please properly import Inputs and Targets and then hit "Step 2" button')
end



function [] = popup_bar(gcbo,handles)
load mlpParameters
Str=get(gcbo,'String');
CurrNumber=str2num(cell2mat(Str(end)));
Ind=(get(gcbo,'Value'));
mlpParameters.SizeMatrix(CurrNumber)=str2num(cell2mat(Str(Ind)));
save('mlpParameters.mat','mlpParameters')

% hObject    handle to mlpNumberH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns mlpNumberH contents as cell array
%        contents{get(hObject,'Value')} returns selected item from mlpNumberH


% --- Executes during object creation, after setting all properties.
function mlpNumberH_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mlpNumberH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function mlpMomentum_Callback(hObject, eventdata, handles)
Momentum=get(handles.mlpMomentum,'Value');
set(handles.mlpMomentumText,'String',num2str(Momentum))
load mlpParameters
mlpParameters.Momentum=Momentum
save('mlpParameters.mat','mlpParameters')
% hObject    handle to mlpMomentum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function mlpMomentum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mlpMomentum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function mlpLearningRate_Callback(hObject, eventdata, handles)
LearningRate=get(handles.mlpLearningRate,'Value');
set(handles.mlpLearningRateText,'String',num2str(LearningRate))
load mlpParameters
mlpParameters.LearningRate=LearningRate;
save('mlpParameters.mat','mlpParameters')
% hObject    handle to mlpLearningRate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function mlpLearningRate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mlpLearningRate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function mlpTolerance_Callback(hObject, eventdata, handles)
Val=linspace(0.0001,0.01,100);
Tolerance=Val(round(get(handles.mlpTolerance,'Value')*99)+1);
set(handles.mlpToleranceText,'String',num2str(Tolerance))
load mlpParameters
mlpParameters.Tolerance=Tolerance;
save('mlpParameters.mat','mlpParameters')
% hObject    handle to mlpTolerance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function mlpTolerance_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mlpTolerance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in mlpSetParameters.
function mlpSetParameters_Callback(hObject, eventdata, handles)
close(gcf)
% hObject    handle to mlpSetParameters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
