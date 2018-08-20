function varargout = CNN_Parameters_GUI(varargin)
% CNN_PARAMETERS_GUI MATLAB code for CNN_Parameters_GUI.fig
%      CNN_PARAMETERS_GUI, by itself, creates a new CNN_PARAMETERS_GUI or raises the existing
%      singleton*.
%
%      H = CNN_PARAMETERS_GUI returns the handle to a new CNN_PARAMETERS_GUI or the handle to
%      the existing singleton*.
%
%      CNN_PARAMETERS_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CNN_PARAMETERS_GUI.M with the given input arguments.
%
%      CNN_PARAMETERS_GUI('Property','Value',...) creates a new CNN_PARAMETERS_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CNN_Parameters_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CNN_Parameters_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CNN_Parameters_GUI

% Last Modified by GUIDE v2.5 12-Jun-2016 16:01:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CNN_Parameters_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @CNN_Parameters_GUI_OutputFcn, ...
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


% --- Executes just before CNN_Parameters_GUI is made visible.
function CNN_Parameters_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
if exist('cnnParameters.mat')==2
    load cnnParameters
end

cnnParameters.NumOfFeatures=[12 12];
cnnParameters.BatchSize=50;
cnnParameters.NumEpochs=2;
cnnParameters.NLayers=2;
cnnParameters.ConvolutionKernelSize=5;
cnnParameters.SubSamplingScale=2;
cnnParameters.LowerDim=28;
cnnParameters.EndDim=4;
save('cnnParameters.mat','cnnParameters')



EpochsString=num2str([1:50]');
BatchString=num2str([10:10:500]');
set(handles.cnnBatchSize,'String',BatchString)
set(handles.cnnBatchSize,'Value',5)
set(handles.cnnNumEpochs,'String',EpochsString)
set(handles.cnnNumEpochs,'Value',2)
% set(handles.cnnNLayers,'Value',2)
set(handles.cnnConvolutionKernelSize,'Value',3)
set(handles.cnnSubSamplingScale,'Value',2)

% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CNN_Parameters_GUI (see VARARGIN)

% Choose default command line output for CNN_Parameters_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes CNN_Parameters_GUI wait for user response (see UIRESUME)
% uiwait(handles.cnnParametersFigure);


% --- Outputs from this function are returned to the command line.
function varargout = CNN_Parameters_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in cnnConvolutionKernelSize.
function cnnConvolutionKernelSize_Callback(hObject, eventdata, handles)
CheckActiveString=get(handles.cnnNetworkBG,'Title');
if (1)
    load cnnParameters
%     NLayers=cnnParameters.RecommendedSize;
    Str=get(handles.cnnConvolutionKernelSize,'String');
    Ind=get(handles.cnnConvolutionKernelSize,'Value');
    CVal=Str(Ind);
    if iscell(CVal)==1
        C=str2num(cell2mat(CVal));
    else
        C=str2num((CVal));
    end
    cnnParameters.ConvolutionKernelSize=C;
    
    TempDim=cnnParameters.EndDim;
    ConSize=cnnParameters.ConvolutionKernelSize;
    Scale=cnnParameters.SubSamplingScale;
    NLayers=cnnParameters.NLayers;
    for i=1:NLayers
        TempDim=TempDim*Scale;
        TempDim=TempDim+ConSize-1;
    end
    cnnParameters.ResizeDim=TempDim;
    
    save('cnnParameters.mat','cnnParameters')
%     SEnd=((L+4)/(E+C))^(1/cnnNLayers);
%     Scale=round(linspace(1,SEnd,10)'*100)/100;
%     set(handles.cnnSubSamplingScale,'String',num2str(Scale))
else
    msgbox('Import Inputs and Targets Properly, then hit "Step 2"')
end
% hObject    handle to cnnConvolutionKernelSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns cnnConvolutionKernelSize contents as cell array
%        contents{get(hObject,'Value')} returns selected item from cnnConvolutionKernelSize


% --- Executes during object creation, after setting all properties.
function cnnConvolutionKernelSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cnnConvolutionKernelSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in cnnSubSamplingScale.
function cnnSubSamplingScale_Callback(hObject, eventdata, handles)

if (1)
    load cnnParameters
    SStr=get(handles.cnnSubSamplingScale,'String');
    SInd=get(handles.cnnSubSamplingScale,'Value');
    SVal=SStr(SInd,:);
    if iscell(SVal)==1
        SubSamplingScale=str2num(cell2mat(SVal));
    else
        SubSamplingScale=str2num((SVal));
    end
    cnnParameters.SubSamplingScale=SubSamplingScale;
    
    TempDim=cnnParameters.EndDim;
    ConSize=cnnParameters.ConvolutionKernelSize;
    Scale=cnnParameters.SubSamplingScale;
    NLayers=cnnParameters.NLayers;
    for i=1:NLayers
        TempDim=TempDim*Scale;
        TempDim=TempDim+ConSize-1;
    end
    cnnParameters.ResizeDim=TempDim;
    
    save('cnnParameters.mat','cnnParameters')
else
    msgbox('Import Inputs and Targets Properly, then hit "Step 2"')
end
% hObject    handle to cnnSubSamplingScale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns cnnSubSamplingScale contents as cell array
%        contents{get(hObject,'Value')} returns selected item from cnnSubSamplingScale


% --- Executes during object creation, after setting all properties.
function cnnSubSamplingScale_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cnnSubSamplingScale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in cnnNLayers.
function cnnNLayers_Callback(hObject, eventdata, handles)

if (1)
    set(handles.cnnConvolutionKernelSizeText,'String','Select Convolution Kernel size (A)')
    NStr=get(handles.cnnNLayers,'String');
    NInd=get(handles.cnnNLayers,'Value');
    NVal=NStr(NInd);
    if iscell(NVal)==1
        NLayers=str2num(cell2mat(NVal));
    else
        NLayers=str2num(NVal);
    end
    load cnnParameters
    
    TempDim=cnnParameters.EndDim;
    ConSize=cnnParameters.ConvolutionKernelSize;
    Scale=cnnParameters.SubSamplingScale;
    for i=1:NLayers
        TempDim=TempDim*Scale;
        TempDim=TempDim+ConSize-1;
    end
    cnnParameters.ResizeDim=TempDim;
    
    cnnParameters.NumOfFeatures=[];
    cnnParameters.NLayers=NLayers;
    save('cnnParameters.mat','cnnParameters')
    if isfield(handles,'NumOfFeaturesH')==1
        delete( handles.NumOfFeaturesH(handles.NumOfFeaturesH>0));
        handles.NumOfFeaturesH(:) = 0;
        delete( handles.SizeName(handles.SizeName>0));
        handles.SizeName(:) = 0;
    end
     cnnParameters.FeaturesHandle=[];
    PanelPos = getpixelposition(handles.cnnNetworkBG);
    RefPos = getpixelposition(handles.cnnNLayersText);
    Pos=[PanelPos(1)+RefPos(1) PanelPos(2)+RefPos(2)-80 PanelPos(3) PanelPos(4)];
    
    handles.NumOfFeaturesH=[];
    handles.SizeName=[];
    
    Dx=45;
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
        String={num2str([1:(cnnParameters.LowerDim) i]')};
        pop_menu = uicontrol('Parent', CNN_Parameters_GUI, 'Style', 'Popupmenu', 'Position', Pos2, 'String',...
            String, 'Value', round(cnnParameters.LowerDim/2)-2, 'Callback', @popup_bar);
        handles.NumOfFeaturesH(i)=pop_menu;
        
        set(handles.cnnNumOfFeaturesText,'Visible','on')
        SizeName(i) = uicontrol(  'Style', 'text','pos',Pos1 );
        handles.SizeName(i) = SizeName(i);
        set(handles.SizeName(i),'String',num2str(i))
        guidata(gcf,handles)
        cnnParameters.FeaturesHandle(i)=i;
        cnnParameters.NumOfFeatures(i)=cnnParameters.LowerDim;
    end
    delete('cnnParameters.mat')
    save('cnnParameters.mat','cnnParameters')
else
    msgbox('Import Inputs and Targets Properly, then hit "Step 2"')
end



function [] = popup_bar(gcbo,handles)

load cnnParameters
Str=get(gcbo,'String');
CurrNumber=str2num(cell2mat(Str(end)));
Ind=(get(gcbo,'Value'));
cnnParameters.NumOfFeatures(CurrNumber)=str2num(cell2mat(Str(Ind)))
save('cnnParameters.mat','cnnParameters')
% hObject    handle to cnnNLayers (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns cnnNLayers contents as cell array
%        contents{get(hObject,'Value')} returns selected item from cnnNLayers


% --- Executes during object creation, after setting all properties.
function cnnNLayers_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cnnNLayers (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in cnnNumEpochs.
function cnnNumEpochs_Callback(hObject, eventdata, handles)
if (1)
    load cnnParameters
    EpochsString=get(handles.cnnNumEpochs,'String');
    EpochsValue=get(handles.cnnNumEpochs,'Value');
    EVal=EpochsString(EpochsValue,:);
    if iscell(EVal)==1
        cnnParameters.NumEpochs=str2num(cell2mat(EVal));
    else
        cnnParameters.NumEpochs=str2num((EVal));
    end
    save('cnnParameters.mat','cnnParameters')
else
    msgbox('Import Inputs and Targets Properly, then hit "Step 2"')
end
% hObject    handle to cnnNumEpochs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns cnnNumEpochs contents as cell array
%        contents{get(hObject,'Value')} returns selected item from cnnNumEpochs


% --- Executes during object creation, after setting all properties.
function cnnNumEpochs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cnnNumEpochs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in cnnEnterParameters.
function cnnEnterParameters_Callback(hObject, eventdata, handles)
close(gcf)
% hObject    handle to cnnEnterParameters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in cnnBatchSize.
function cnnBatchSize_Callback(hObject, eventdata, handles)
if (1)
    load cnnParameters
    BatchString=get(handles.cnnBatchSize,'String');
    BatchValue=get(handles.cnnBatchSize,'Value');
    BVal=BatchString(BatchValue,:);
    if iscell(BVal)==1
        cnnParameters.BatchSize=str2num(cell2mat(BVal));
    else
        cnnParameters.BatchSize=str2num(BVal);
    end
else
    msgbox('Import Inputs and Targets Properly, then hit "Step 2"')
end
% hObject    handle to cnnBatchSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns cnnBatchSize contents as cell array
%        contents{get(hObject,'Value')} returns selected item from cnnBatchSize


% --- Executes during object creation, after setting all properties.
function cnnBatchSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cnnBatchSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
