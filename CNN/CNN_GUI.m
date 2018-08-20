function varargout = CNN_GUI(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @CNN_GUI_OpeningFcn, ...
    'gui_OutputFcn',  @CNN_GUI_OutputFcn, ...
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


% --- Executes just before CNN_GUI is made visible.
function CNN_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
axes(handles.logo)
Img=imread('logo.jpg');
imshow(Img)
set(handles.cnnTrainTestSplit,'String','80');

cnnParameters.TrainTestSplit=0.8;
cnnParameters.NumOfFeatures=[12 12];
cnnParameters.BatchSize=50;
cnnParameters.NumEpochs=2;
cnnParameters.NLayers=2;
cnnParameters.ConvolutionKernelSize=5;
cnnParameters.SubSamplingScale=2;
save('cnnParameters.mat','cnnParameters')


EpochsString=num2str([1:50]');
BatchString=num2str([10:10:500]');
set(handles.cnnBatchSize,'String',BatchString)
set(handles.cnnBatchSize,'Value',5)
set(handles.cnnNumEpochs,'String',EpochsString)
set(handles.cnnNumEpochs,'Value',2)
set(handles.cnnNLayers,'Value',2)
set(handles.ConvolutionKernelSize,'Value',5)
set(handles.cnnSubSamplingScale,'Value',2)
if exist('cnn.mat')==2
    set(handles.cnnTestImageBG,'Title','Image Test (A)')
end


% Choose default command line output for CNN_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);



% --- Outputs from this function are returned to the command line.
function varargout = CNN_GUI_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;


% --------------------------------------------------------------------
function browse_Callback(hObject, eventdata, handles)



% --- Executes on selection change in workspaceList.
function workspaceList_Callback(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function workspaceList_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in LoadWorkspace.
function LoadWorkspace_Callback(hObject, eventdata, handles)
set(handles.ImportInputs,'Visible','on')
set(handles.cnnInputs,'Visible','on')
Vars = evalin('base','who');
set(handles.workspaceList,'String',Vars)



% --- Executes on selection change in cnnInputs.
function cnnInputs_Callback(hObject, eventdata, handles)



function cnnInputs_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ImportInputs.
function ImportInputs_Callback(hObject, eventdata, handles)
set(handles.ImportTargets,'Visible','on')
set(handles.cnnTargets,'Visible','on')
Ind=get(handles.workspaceList,'Value');
Str=get(handles.workspaceList,'String');
Var = evalin('base',cell2mat(Str(Ind)));
set(handles.cnnInputs,'String',Str(Ind));

SelectInputString=[{'Select an Image'};{num2str([1:size(Var,1)]')}];
set(handles.cnnSelectImage,'String',SelectInputString)

% --- Executes on selection change in cnnTargets.
function cnnTargets_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function cnnTargets_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ImportTargets.
function ImportTargets_Callback(hObject, eventdata, handles)
set(handles.cnnStep2,'Visible','on')
Ind=get(handles.workspaceList,'Value');
Str=get(handles.workspaceList,'String');
Var = evalin('base',cell2mat(Str(Ind)));
set(handles.cnnTargets,'String',Str(Ind));

Ind=get(handles.cnnInputs,'Value');
Str=get(handles.cnnInputs,'String');
InputsCheck=length(Str)>0;
if length(Str)==0
    msgbox('Please select Inputs first and then import them')
else
    Inputs = evalin('base',cell2mat(Str(Ind)));
end
if InputsCheck==1
    Ind=get(handles.cnnTargets,'Value');
    Str=get(handles.cnnTargets,'String');
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
load cnnParameters
cnnParameters.RecommendedSize=NLayers-2;
cnnParameters.LowerDim=LowerDim;
cnnParameters.EndDim=EndDim;
save('cnnParameters.mat','cnnParameters')



% --- Executes on button press in cnnTrainNetwork.
function cnnTrainNetwork_Callback(hObject, eventdata, handles)
CheckString=get(handles.cnnTrainBG,'Title');
if strcmp(CheckString,'Train (A)')==1
    load cnnParameters
    set(handles.cnnTrainingAccuracy,'String','')
    set(handles.cnnTestingAccuracy,'String','')
    
    pause(1)
    
    Ind=get(handles.cnnInputs,'Value');
    Str=get(handles.cnnInputs,'String');
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
        Ind=get(handles.cnnTargets,'Value');
        Str=get(handles.cnnTargets,'String');
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
            
            %%
            TrainTestSplit=cnnParameters.TrainTestSplit;
            NumTest=round(size(Inputs,1)*(1-TrainTestSplit));
            Indices=randperm(size(Inputs,1));
            cnnParameters.Indices=Indices;
            save('cnnParameters.mat','cnnParameters')
            
            
            Train_X=Inputs(Indices(1:end-NumTest),:,:);
            Train_Y=Targets(Indices(1:end-NumTest),:);
            
            Test_X=Inputs(Indices(end-NumTest+1:end),:,:);
            Test_Y=Targets(Indices(end-NumTest+1:end),:);
            
            [Train_X,n]  = shiftdim(Train_X,1);
            [Test_X,n]  = shiftdim(Test_X,1);
            
            Train_Y=Train_Y';
            Test_Y=Test_Y';

            %%
            rand('state', 0)
            opts.alpha = 1;
            opts.batchsize = cnnParameters.BatchSize;
            opts.numepochs = cnnParameters.NumEpochs;
            Scale=cnnParameters.SubSamplingScale;
            ConvolutionKernelSize=cnnParameters.ConvolutionKernelSize;
            
            EvenP=[2:2:cnnParameters.NLayers*2]
            OddP=[3:2:cnnParameters.NLayers*2+1]
            cnn.layers(1,1)={struct('type', 'i')};
            for i=1:cnnParameters.NLayers
                cnn.layers(EvenP(i),1)={struct('type', 'c', 'outputmaps', cnnParameters.NumOfFeatures(i),...
                    'kernelsize', ConvolutionKernelSize)};
                cnn.layers(OddP(i),1)={struct('type', 's', 'scale', Scale)};
            end
            %%
            TempD=cnnParameters.EndDim;
            for i=1:cnnParameters.NLayers
                TempD=TempD*Scale;
                TempD=TempD+ConvolutionKernelSize-1;
            end
            if TempD~=cnnParameters.LowerDim
                Train_X=imresize(Train_X,[TempD,TempD]);
                Test_X=imresize(Test_X,[TempD,TempD]);
            end
            %%
            
            cnn = cnnsetup(cnn, Train_X, Train_Y);
            
            
            fprintf('Training the CNN...\n');
            size(Train_X)
            startTime = tic();
            
            % Train the CNN using the training data.
            cnn = cnntrain(cnn, Train_X, Train_Y, opts);
            
            fprintf('...Done. Training took %.2f seconds\n', toc(startTime));
            save('cnn.mat','cnn')
         
            msgbox('Training Complete')
        end
    end
    set(handles.cnnEvaluateTrain,'Visible','on')
    set(handles.cnnResults,'Visible','on')
else
    msgbox('Please Enter Network parameters 1st')
end



function cnnTrainingAccuracy_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function cnnTrainingAccuracy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cnnTrainingAccuracy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Batch_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function NumEpochsE_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function logo_CreateFcn(hObject, eventdata, handles)



% --- Executes on mouse press over axes background.
function logo_ButtonDownFcn(hObject, eventdata, handles)



% --- Executes on button press in cnnEvaluateTrain.
function cnnEvaluateTrain_Callback(hObject, eventdata, handles)
Ind=get(handles.cnnInputs,'Value');
Str=get(handles.cnnInputs,'String');
Inputs = evalin('base',cell2mat(Str(Ind)));
set(handles.cnnTestingAccuracy,'String','')
pause(1)
Ind=get(handles.cnnTargets,'Value');
Str=get(handles.cnnTargets,'String');
Targets = evalin('base',cell2mat(Str(Ind)));
if size(Targets,2)<2
    Ut=unique(Targets);
    Targets1=Targets;
    Targets=zeros(size(Targets1,1),length(Ut));
    for i=1:length(Ut)
        Targets(find(Targets1==Ut(i)),i)=1;
    end
end

load cnnParameters
load('cnn.mat')
Indices=cnnParameters.Indices;

NumTest=round(size(Inputs,1)*(1-cnnParameters.TrainTestSplit));

Train_X=Inputs(Indices(1:end-NumTest),:,:);
Train_Y=Targets(Indices(1:end-NumTest),:);
[Train_X,n]  = shiftdim(Train_X,1);
Train_Y=Train_Y';

%%
Scale=cnnParameters.SubSamplingScale;
ConvolutionKernelSize=cnnParameters.ConvolutionKernelSize;
TempD=cnnParameters.EndDim;
for i=1:cnnParameters.NLayers
    TempD=TempD*Scale;
    TempD=TempD+ConvolutionKernelSize-1;
end
if TempD~=cnnParameters.LowerDim
    Train_X=imresize(Train_X,[TempD,TempD]);
end

%%
[Er, Bad,Predicted,Actual] = cnntest(cnn, Train_X, Train_Y);


NumRight = size(Train_Y, 2) - numel(Bad);
TrainingAccuracy=NumRight / size(Train_Y, 2) * 100;

Ua=unique(Actual);
Up=unique(Predicted);
TC=length(Up);
TempP=ones(size(Predicted));
TempE=ones(size(Actual));

PerfCheck=0;
%%
% for i=1:TC
%     TempP=ones(size(Actual));
%     TempA=ones(size(Actual));
%     TempA(find(Actual==Ua(i)))=2;
%     TempP(find(Predicted==Up(i)))=2;
%     if length(unique(TempA))==length(unique(TempP))
%         [X,Y] = perfcurve(TempA,TempP,2);
%         if length(X)~=0&length(Y)~=0
%             plot(X,Y,'linewidth',3)
%             hold on
%             PerfCheck=PerfCheck+1;
%         else
%             WrongClasses=[WrongClasses i];
%         end
%     end
% end
% %%
% if PerfCheck>0
%     legend('Class 1','Class 2','Class 3','Class 4','Class 5','Class 6','Class 7','Class 8','Class 9','Class 10')
%     set(gca,'fontsize',18)
%     xlabel('False Positive')
%     ylabel('True Positive')
%     if PerfCheck~=length(Ua)
%         msgbox('Some Classes are missing')
%     end
% else
%     msgbox('Performance curve cannot be plotted, there is only one class in predicted data')
% end


ColNames=[];
RowNames=[];
for i=1:TC
    ColNames=[ColNames {['Class' num2str(i)]}];
    RowNames=[RowNames;{['Class' num2str(i)]}];
end


for i=1:TC
    Actpi=find(Actual==Ua(i));
    TempActpi=ones(length(Actual),1);
    TempActpi(Actpi)=-1;
    for j=1:TC
        TempPredj=zeros(length(Predicted),1);
        Predj=find(Predicted==Up(j));
        TempPredj(Predj)=-1;
        dataP(i,j)=100*length(find(TempActpi==TempPredj))/length(Actpi);
    end
end
       
set(handles.cnnConfusionTable,'ColumnName',ColNames)
set(handles.cnnConfusionTable,'RowName',RowNames)
set(handles.cnnConfusionTable,'data',[dataP])
set(handles.cnnTrainingAccuracy,'String',num2str(TrainingAccuracy))

set(handles.cnnEvaluateTest,'Visible','on')




function cnnTrainTestSplit_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function cnnTrainTestSplit_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cnnTestingAccuracy_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function cnnTestingAccuracy_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in cnnEvaluateTest.
function cnnEvaluateTest_Callback(hObject, eventdata, handles)

set(handles.cnnTestingAccuracy,'String','')
pause(1)

Ind=get(handles.cnnInputs,'Value');
Str=get(handles.cnnInputs,'String');
Inputs = evalin('base',cell2mat(Str(Ind)));

Ind=get(handles.cnnTargets,'Value');
Str=get(handles.cnnTargets,'String');
Targets = evalin('base',cell2mat(Str(Ind)));
if size(Targets,2)<2
    Ut=unique(Targets);
    Targets1=Targets;
    Targets=zeros(size(Targets1,1),length(Ut));
    for i=1:length(Ut)
        Targets(find(Targets1==Ut(i)),i)=1;
    end
end

load cnnParameters
load cnn
Indices=cnnParameters.Indices;

NumTest=round(size(Inputs,1)*(1-cnnParameters.TrainTestSplit));

Test_X=Inputs(Indices(NumTest+1:end),:,:);
Test_Y=Targets(Indices(NumTest+1:end),:);
[Test_X,n]  = shiftdim(Test_X,1);
Test_Y=Test_Y';

%%
Scale=cnnParameters.SubSamplingScale;
ConvolutionKernelSize=cnnParameters.ConvolutionKernelSize;
TempD=cnnParameters.EndDim;
for i=1:cnnParameters.NLayers
    TempD=TempD*Scale;
    TempD=TempD+ConvolutionKernelSize-1;
end
if TempD~=cnnParameters.LowerDim
    Test_X=imresize(Test_X,[TempD,TempD]);
end

%%

[Er, Bad,Predicted,Actual] = cnntest(cnn, Test_X, Test_Y);

save('Results.mat','Actual','Predicted')

NumRight = size(Test_Y, 2) - numel(Bad);
TestingAccuracy=NumRight / size(Test_Y, 2) * 100;

Ua=unique(Actual);
Up=unique(Predicted);
TC=length(Up);
TempP=ones(size(Predicted));
TempE=ones(size(Actual));
PerfCheck=0;
%%
% for i=1:TC
%     TempP=ones(size(Actual));
%     TempA=ones(size(Actual));
%     TempA(find(Actual==Ua(i)))=2;
%     TempP(find(Predicted==Up(i)))=2;
%     if length(unique(TempA))==length(unique(TempP))
%         [X,Y] = perfcurve(TempA,TempP,2);
%         if length(X)~=0&length(Y)~=0
%             plot(X,Y,'linewidth',3)
%             hold on
%             PerfCheck=PerfCheck+1;
%         else
%             WrongClasses=[WrongClasses i];
%         end
%     end
% end
% %%
% if PerfCheck>0
%     legend('Class 1','Class 2','Class 3','Class 4','Class 5','Class 6','Class 7','Class 8','Class 9','Class 10')
%     set(gca,'fontsize',18)
%     xlabel('False Positive')
%     ylabel('True Positive')
%     if PerfCheck~=length(Ua)
%         msgbox('Some Classes are missing')
%     end
% else
%     msgbox('Performance curve cannot be plotted, there is only one class in predicted data')
% end


ColNames=[];
RowNames=[];
for i=1:TC
    ColNames=[ColNames {['Class' num2str(i)]}];
    RowNames=[RowNames;{['Class' num2str(i)]}];
end


for i=1:TC
    Actpi=find(Actual==Ua(i));
    TempActpi=ones(length(Actual),1);
    TempActpi(Actpi)=-1;
    for j=1:TC
        TempPredj=zeros(length(Predicted),1);
        Predj=find(Predicted==Up(j));
        TempPredj(Predj)=-1;
        dataP(i,j)=100*length(find(TempActpi==TempPredj))/length(Actpi);
    end
end
set(handles.cnnConfusionTable,'ColumnName',ColNames)
set(handles.cnnConfusionTable,'RowName',RowNames)
set(handles.cnnConfusionTable,'data',[dataP])
set(handles.cnnTestingAccuracy,'String',num2str(TestingAccuracy))

set(handles.cnnSaveData,'Visible','on')
set(handles.cnnMatFile,'Visible','on')
set(handles.cnnXlsxFile,'Visible','on')
set(handles.cnnCsvFile,'Visible','on')


% --- Executes on button press in cnnMatFile.
function cnnMatFile_Callback(hObject, eventdata, handles)


% --- Executes on button press in cnnCsvFile.
function cnnCsvFile_Callback(hObject, eventdata, handles)


% --- Executes on button press in cnnXlsxFile.
function cnnXlsxFile_Callback(hObject, eventdata, handles)


% --- Executes on button press in cnnSaveData.
function cnnSaveData_Callback(hObject, eventdata, handles)
load Results
CsvCheck=get(handles.cnnCsvFile,'Value');
MatCheck=get(handles.cnnMatFile,'Value');
XlsxCheck=get(handles.cnnXlsxFile,'Value');
Predicted(:,1)=Predicted;
Actual(:,1)=Actual;
if XlsxCheck+CsvCheck+MatCheck>1
    msgbox('Uncheck other options')
elseif XlsxCheck+CsvCheck+MatCheck==0 
    msgbox('Select an output format')
else
    if XlsxCheck==1
        Data=[Predicted Actual];
        xlswrite('NetworkOutput.xlsx',Data)
    elseif CsvCheck==1
        Data=[Predicted Actual];
        xlswrite('NetworkOutput.csv',Data)
    else
        save('NetworkOutput.mat','Actual','Predicted')
    end
end




% --- Executes on button press in cnnStep2.
function cnnStep2_Callback(hObject, eventdata, handles)
load cnnParameters
msgbox(['With a kernel size of 5 and scale of 2, recommened layers are ' num2str(cnnParameters.RecommendedSize)])
set(handles.cnnNetworkBG,'Title','Network Parameters (A)')
set(handles.cnnNetworkBG,'Visible','on')


% --- Executes on button press in cnnStep3.
function cnnStep3_Callback(hObject, eventdata, handles)
CheckActiveString=get(handles.cnnNetworkBG,'Title');
if strcmp(CheckActiveString,'Network Parameters (A)')==1
    load cnnParameters
    if isfield(cnnParameters,'NLayers')==0
        NStr=get(handles.cnnNLayers,'String');
        NInd=get(handles.cnnNLayers,'Value');
        NLayers=str2num(NStr(NInd));
        cnnParameters.NLayers=NLayers;
        if isfield(cnnParameters,'ConvolutionKernelSize')==0
            CStr=get(handles.ConvolutionKernelSize,'String');
            CInd=get(handles.ConvolutionKernelSize,'Value');
            ConvolutionKernelSize=str2num(CStr(CInd));
            cnnParameters.ConvolutionKernelSize=ConvolutionKernelSize;
            if isfield(cnnParameters,'SubSamplingScale')==0
                SStr=get(handles.cnnSubSamplingScale,'String');
                SInd=get(handles.cnnSubSamplingScale,'Value');
                SubSamplingScale=str2num(SStr(SInd));
                cnnParameters.SubSamplingScale=SubSamplingScale;
                if isfield(cnnParameters,'NumEpochs')==0
                    NStr=get(handles.cnnNumEpochs,'String');
                    NInd=get(handles.cnnNumEpochs,'Value');
                    NumEpochs=str2num(NStr(NInd));
                    cnnParameters.SubSamplingScale=NumEpochs;
                    if isfield(cnnParameters,'BatchSize')==0
                        BStr=get(handles.cnnBatchSize,'String');
                        BInd=get(handles.cnnBatchSize,'Value');
                        BatchSize=str2num(NStr(NInd));
                        cnnParameters.SubSamplingScale=BatchSize;
                    end
                end
            end
        end
    else
        set(handles.cnnTrainBG,'Title','Train (A)')
    end
else
    msgbox('Import Inputs and Targets Properly, then hit "Step 2"')
end


% --- Executes on button press in cnnStep1Clear.
function cnnStep1Clear_Callback(hObject, eventdata, handles)
set(handles.ImportTargets,'Visible','off')
set(handles.cnnTargets,'Visible','off')

set(handles.ImportInputs,'Visible','off')
set(handles.cnnInputs,'Visible','off')
set(handles.cnnStep2,'Visible','off')


% --- Executes on selection change in ConvolutionKernelSize.
function ConvolutionKernelSize_Callback(hObject, eventdata, handles)
CheckActiveString=get(handles.cnnNetworkBG,'Title');
if strcmp(CheckActiveString,'Network Parameters (A)')==1
    load cnnParameters
    NLayers=cnnParameters.RecommendedSize;
    L=cnnParameters.LowerDim;
    E=cnnParameters.EndDim;
    Str=get(handles.ConvolutionKernelSize,'String');
    Ind=get(handles.ConvolutionKernelSize,'Value');
    C=str2num(Str(Ind));
    cnnParameters.ConvolutionKernelSize=C;
    save('cnnParameters.mat','cnnParameters')
%     SEnd=((L+4)/(E+C))^(1/cnnNLayers);
%     Scale=round(linspace(1,SEnd,10)'*100)/100;
%     set(handles.cnnSubSamplingScale,'String',num2str(Scale))
else
    msgbox('Import Inputs and Targets Properly, then hit "Step 2"')
end

% hObject    handle to ConvolutionKernelSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ConvolutionKernelSize contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ConvolutionKernelSize


% --- Executes during object creation, after setting all properties.
function ConvolutionKernelSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ConvolutionKernelSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in cnnSubSamplingScale.
function cnnSubSamplingScale_Callback(hObject, eventdata, handles)
CheckActiveString=get(handles.cnnNetworkBG,'Title');
if strcmp(CheckActiveString,'Network Parameters (A)')==1
    load cnnParameters
    SStr=get(handles.cnnSubSamplingScale,'String');
    SInd=get(handles.cnnSubSamplingScale,'Value');
    SubSamplingScale=str2num(SStr(SInd,:));
    cnnParameters.SubSamplingScale=SubSamplingScale;
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
CheckActiveString=get(handles.cnnNetworkBG,'Title');
if strcmp(CheckActiveString,'Network Parameters (A)')==1
    set(handles.ConvolutionKernelSizeText,'String','Select Convolution Kernel size (A)')
    NStr=get(handles.cnnNLayers,'String');
    NInd=get(handles.cnnNLayers,'Value');
    NLayers=str2num(NStr(NInd));
    load cnnParameters
    cnnParameters.NLayers=NLayers;
    save('cnnParameters.mat','cnnParameters')
    if isfield(cnnParameters,'FeaturesHandle')==1
        delete( handles.NumOfFeaturesH(handles.NumOfFeaturesH>0));
        handles.NumOfFeaturesH(:) = 0;
        delete( handles.SizeName(handles.SizeName>0));
        handles.SizeName(:) = 0;
    end
    
    PanelPos = getpixelposition(handles.cnnNetworkBG);
    RefPos = getpixelposition(handles.cnnNLayersText);
    Pos=[PanelPos(1)+RefPos(1) PanelPos(2)+RefPos(2)-60 PanelPos(3) PanelPos(4)];
    
    handles.NumOfFeaturesH=[];
    handles.SizeName=[];
    
    Dx=10;
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
        String={num2str([1:round(cnnParameters.LowerDim/2) i]')};
        pop_menu = uicontrol('Parent', CNN_GUI, 'Style', 'Popupmenu', 'Position', Pos2, 'String',...
            String, 'Value', round(cnnParameters.LowerDim/2)-2, 'Callback', @popup_bar);
        handles.NumOfFeaturesH(i)=pop_menu;
        
        set(handles.cnnNumOfFeaturesText,'Visible','on')
        SizeName(i) = uicontrol(  'Style', 'text','pos',Pos1 );
        handles.SizeName(i) = SizeName(i);
        set(handles.SizeName(i),'String',num2str(i))
        guidata(gca,handles)
        cnnParameters.FeaturesHandle(i)=i;
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
cnnParameters.NumOfFeatures(CurrNumber)=str2num(cell2mat(Str(Ind)));
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
CheckActiveString=get(handles.cnnNetworkBG,'Title');
if strcmp(CheckActiveString,'Network Parameters (A)')==1
    load cnnParameters
    EpochsString=get(handles.cnnNumEpochs,'String');
    EpochsValue=get(handles.cnnNumEpochs,'Value');
    cnnParameters.NumEpochs=str2num(EpochsString(EpochsValue,:));
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


% --- Executes on button press in cnnStep3.
function pushbutton30_Callback(hObject, eventdata, handles)
% hObject    handle to cnnStep3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in cnnBatchSize.
function cnnBatchSize_Callback(hObject, eventdata, handles)
CheckActiveString=get(handles.cnnNetworkBG,'Title');
if strcmp(CheckActiveString,'Network Parameters (A)')==1
    load cnnParameters
    BatchString=get(handles.cnnBatchSize,'String');
    BatchValue=get(handles.cnnBatchSize,'Value');
    cnnParameters.BatchSize=str2num(BatchString(BatchValue,:))
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


% --- Executes on selection change in cnnSelectImage.
function cnnSelectImage_Callback(hObject, eventdata, handles)
TestImageString=get(handles.cnnTestImageBG,'Title');
% if strcmp('Image Test (A)',TestImageString)==1
if exist('cnn.mat')==2
    set(handles.cnnTrueLabelText,'Visible','Off')
    set(handles.cnnTrueLabel,'Visible','Off')
    Ind=get(handles.cnnInputs,'Value');
    Str=get(handles.cnnInputs,'String');
    Inputs = evalin('base',cell2mat(Str(Ind)));
    set(handles.cnnTestingAccuracy,'String','')
    
    Ind=get(handles.cnnTargets,'Value');
    Str=get(handles.cnnTargets,'String');
    Targets = evalin('base',cell2mat(Str(Ind)));
    
    ImInd=get(handles.cnnSelectImage,'Value');
    ImStr=get(handles.cnnSelectImage,'String');
    ImNum = str2num(cell2mat(ImStr(ImInd)));
    if length(ImNum>0)
        Img=(reshape(Inputs(ImNum,:,:),[28,28]))';
        axes(handles.cnnPlotImage)
        imagesc(Img),colormap(gray)
        TrueLabel=find(Targets(ImNum,:)==1)-1;
        set(handles.cnnTrueLabel,'Visible','on')
        set(handles.cnnTrueLabel,'String',num2str(TrueLabel))
        
        load cnnParameters
        if exist('cnn.mat')==2
            load('cnn.mat')
            InputImg=Inputs(ImNum:ImNum+2,:,:);
            TargetImg=Targets(ImNum:ImNum+2,:);
            [InputImg,n]  = shiftdim(InputImg,1);
            TargetImg=TargetImg';
            [Er, Bad,PredictedLabel,TrueLabel] = cnntest(cnn, InputImg, TargetImg);
            clear Er Bad
            set(handles.cnnPredictedLabel,'String',num2str(PredictedLabel(1)-1))
        else
            msgbox('Please train network first')
        end

    else
        msgbox('Please select an image')
    end
else
    msgbox('Complete Training First')
end
% hObject    handle to cnnSelectImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns cnnSelectImage contents as cell array
%        contents{get(hObject,'Value')} returns selected item from cnnSelectImage


% --- Executes during object creation, after setting all properties.
function cnnSelectImage_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cnnSelectImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in cnnBrowseImage.
function cnnBrowseImage_Callback(hObject, eventdata, handles)
TestImageString=get(handles.cnnTestImageBG,'Title');
% if strcmp('Image Test (A)',TestImageString)==1
if strcmp('Image Test (A)',TestImageString)==1|exist('cnn.mat')==2
        [f p]=uigetfile('*.jpg','Select an Image file');
        
        Img=imread([p f]);
        
        if length(size(Img))>2
            Img=rgb2gray(Img);
        end
        Img=double(Img/max(max(Img)));
        Img=imresize(Img,[28,28]);
        axes(handles.cnnPlotImage)
        imagesc(Img),colormap(gray)     
        load cnnParameters
        if exist('cnn.mat')==2
            load('cnn.mat')
            InputImg(1,:,:)=Img';
            InputImg(2,:,:)=Img';
            TargetImg=[1 zeros(1,9);1 zeros(1,9)]';
            [InputImg,n]  = shiftdim(InputImg,1);
            [Er, Bad,PredictedLabel,TrueLabel] = cnntest(cnn, InputImg, TargetImg);
            set(handles.cnnTrueLabelText,'Visible','Off')
            set(handles.cnnTrueLabel,'Visible','Off')
            set(handles.cnnPredictedLabel,'String',num2str(PredictedLabel(1)-1))
        else
            msgbox('Please train network first')
        end

else
    msgbox('Complete Training First')
end
% hObject    handle to cnnBrowseImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in cnnDeleteBN.
function cnnDeleteBN_Callback(hObject, eventdata, handles)
% hObject    handle to cnnDeleteBN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
