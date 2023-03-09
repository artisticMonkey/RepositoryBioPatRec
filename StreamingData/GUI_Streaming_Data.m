function varargout = GUI_Streaming_Data(varargin)
% GUI_STREAMING_DATA MATLAB code for GUI_Streaming_Data.fig
%      GUI_STREAMING_DATA, by itself, creates a new GUI_STREAMING_DATA or raises the existing
%      singleton*.
%
%      H = GUI_STREAMING_DATA returns the handle to a new GUI_STREAMING_DATA or the handle to
%      the existing singleton*.
%
%      GUI_STREAMING_DATA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_STREAMING_DATA.M with the given input arguments.
%
%      GUI_STREAMING_DATA('Property','Value',...) creates a new GUI_STREAMING_DATA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_Streaming_Data_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_Streaming_Data_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_Streaming_Data

% Last Modified by GUIDE v2.5 03-Jun-2019 12:47:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @GUI_Streaming_Data_OpeningFcn, ...
    'gui_OutputFcn',  @GUI_Streaming_Data_OutputFcn, ...
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

% --- Executes just before GUI_Streaming_Data is made visible.
function GUI_Streaming_Data_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_Streaming_Data (see VARARGIN)

% Choose default command line output for GUI_Streaming_Data
handles.output = hObject;

% Take useful information from GUI father (if it exists)
if size(varargin,2) > 0
    oldHandles = varargin{1};
    if isfield(oldHandles,'obj')
        handles.obj = oldHandles.obj;
    end
end

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_Streaming_Data wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_Streaming_Data_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --------------------------------------------------------------------
function FileMenu_Callback(hObject, eventdata, handles)
% hObject    handle to FileMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function OpenMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to OpenMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file = uigetfile('*.fig');
if ~isequal(file, 0)
    open(file);
end

% --------------------------------------------------------------------
function PrintMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to PrintMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
printdlg(handles.figure1)

% --------------------------------------------------------------------
function CloseMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to CloseMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selection = questdlg(['Close ' get(handles.figure1,'Name') '?'],...
    ['Close ' get(handles.figure1,'Name') '...'],...
    'Yes','No','Yes');
if strcmp(selection,'No')
    return;
end

delete(handles.figure1)


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu1 contents as cell array
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

set(hObject, 'String', {'plot(rand(5))', 'plot(sin(1:0.01:25))', 'bar(1:.5:10)', 'plot(membrane)', 'surf(peaks)'});


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function eT_samples_Callback(hObject, eventdata, handles)
% hObject    handle to eT_samples (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of eT_samples as text
%        str2double(get(hObject,'String')) returns contents of eT_samples as a double


% --- Executes during object creation, after setting all properties.
function eT_samples_CreateFcn(hObject, eventdata, handles)
% hObject    handle to eT_samples (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Start.
function Start_Callback(hObject, eventdata, handles)
% hObject    handle to Start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global go;
go = 1;
streamingEnable = get(handles.cb_streamingEnable,'Value');
% Get connection object
if isfield(handles,'obj')
    obj = handles.obj;
else
    set(handles.t_msg,'String','No connection obj found');
    return;
end
samples = str2double(get(handles.eT_samples,'String'));
set(handles.pb_stop,'Enable','on');
% Set up receiving buffer
obj.InputBufferSize = samples;
% Open the connection
fopen(obj);
% Read available data and discard it
if obj.BytesAvailable > 0
    fread(obj,obj.BytesAvailable,'uint8');    % Read the samples
end
%Read Stimulation setting
fwrite(obj,hex2dec('B1'),'char');
reply = fread(obj,1,'char');
if reply == hex2dec('B1')
    mode = fread(obj,1,'uint8');
    channel = fread(obj,1,'uint8');
    amplitude = fread(obj,1,'uint8');
    pulseWidth = fread(obj,1,'uint8');
    frequency = fread(obj,1,'uint8');
    repetitions = fread(obj,1,'uint8');
    modAmpTop = fread(obj,1,'uint8');
    modAmpLow = fread(obj,1,'uint8');
    modPWTop = fread(obj,1,'uint8');
    modPWLow = fread(obj,1,'uint8');
    modFreqTop = fread(obj,1,'uint8');
    modFreqLow = fread(obj,1,'uint8');
    DESCenable = fread(obj,1,'uint8');
    DESCchannel = fread(obj,1,'uint8');
    DESCpulseWidth = fread(obj,1,'uint8');
    DESCfrequency = fread(obj,1,'uint8');
    DESCrepetitions = fread(obj,1,'uint8');
    replay = fread(obj,1,'uint8');
    if reply == hex2dec('B1')
        %             status = sprintf('Battery Voltage = %2.3g V\nCPU Temperature = %2.3g °C\nSensor-Hand = %s\nNeurostimulator = %s\nSD-card = %s\niNEMO = %s\nMotors = %s\nFilters = %s\nPost-Control-Algorithm = %s\nControl Algorithm = %s\ntime window samples = %d\noverlapp window samples = %d\nsampling frequency = %d Hz\nnumber of channels = %d\nnumber of features = %d\nramp length = %d\nramp mode = %d\nmajority vote steps = %d\ndelicate grasp = %d\ndelicate grasp threshold = %d\nsensitivity = %d\nhand minimum speed = %d\nhand maximum speed = %d\nHand control mode = %s', battery, temperature, SH, enableSH, SD, IMU, enableM, enableF, PC, CM, tWs, oWs, sF, nChannels, nFeatures, rampLength, rampMode, mvSteps, delicateGrasp, delicateGraspThreshold, sensitivity, min, max, handCtrlMd);
        %             msgbox(status,'System Status')
    else
        set(handles.t_msg,'String','Error, device is not responding or COM port is changed!');
        fclose(obj);
        return
    end
else
    set(handles.t_msg,'String','Error, device is not responding or COM port is changed!');
end
% Read available data and discard it
while (obj.BytesAvailable > 0)
    fread(obj,obj.BytesAvailable,'uint8');    % Read the samples
    pause(0.010);
end
% Start the Control Test
fwrite(obj,'L','char');
%Read channels activation indexes
chActivationIndexes = fread(obj,1,'uint32');
bitget(chActivationIndexes,32:-1:1,'uint32');
%     chActivationIndexes = fread(obj,1,'l');
chActivationIndexes = dec2bin(chActivationIndexes,32);
activeChannels = str2num(chActivationIndexes);
nCh = 0;
if activeChannels ~= 0
    for j = 1:32
        if chActivationIndexes(j) == '1'
            nCh = nCh+1;
        end
    end
end
fwrite(obj,1,'char'); % dummy writes (compatibility with ALC-D1)
replay = char(fread(obj,1,'char'));
%     replay = char(fread(obj,1,'char'));
%     fwrite(obj,'L','char');
%     fwrite(obj,1,'char'); % dummy writes (compatibility with ALC-D1)
%     replay = char(fread(obj,1,'char'));
if strcmp(replay,'L')
    set(handles.t_msg,'String','Control-Test Start');
else
    set(handles.t_msg,'String','Error Start');
    fclose(obj);
    return
end
%Online test
streamMAVAll = [];
streamHandAll = [];
streamStimulationAll = [];
flagFirstSample = 0;
flagOffset = 0;
countOverflowTimer = 0;
singlePointPlot = 1;
windowData = 150;
overFlowHandTime = 32000;
correctionFactor = [-0.018682066,-0.03580729,-0.018682066,0.022194601,0.114889708,-0.03580729];  %new geneva
% correctionFactor = [-0.018682066,-0.03580729,-0.018682066,0.019148283,0.101023709,-0.03580729];
% correctionFactor = [-0.03580729,-0.018682066,-0.03580729,0.101023709,0.019148283,-0.018682066];
% correctionFactor = [0.019148283,0.101023709,-0.03580729,-0.018682066,-0.03580729,-0.018682066];
analogGainFactor = 9;
tic;
for i = 1:samples
    % Read the predicted movement from ALC-D
    % Movements are hardcoded accordingly to this definition:
    % #define REST 			  		0
    % #define OPENHAND 			  	5
    % #define CLOSEHAND			  	3
    % #define PRONATION            	2
    % #define SUPINATION            1
    % #define Bi-DIGITAL            4
    % #define LATERAL               6
    % Conversion of the ALC-D output is needed because:
    %  - zero index
    %  - REST is usually the last one in BioPatRec
    while(fread(obj,1,'char') ~= '+')
    end
    movIdx = fread(obj,1,'char');
    activOffset = fread(obj,1,'char');
    activLevel = fread(obj,1,'char');
    dStep = fread(obj,1,'char');
    PWMg = fread(obj,1,'char');
    set(handles.hand_msg,'String',num2str(movIdx));
    set(handles.txt_activLevel,'String',num2str(activLevel));
    %Show algorithm classification
    switch movIdx
        case 199
            set(handles.t_msg,'String','majority vote step');
        case 0
            set(handles.t_msg,'String','Rest');
        case 1
            set(handles.t_msg,'String','Supination');
        case 2
            set(handles.t_msg,'String','Pronation');
        case 3
            set(handles.t_msg,'String','Close');
        case 4
            set(handles.t_msg,'String','Bi-digital');
        case 5
            set(handles.t_msg,'String','Open');
        case 6
            set(handles.t_msg,'String','Lateral');
            %             case 4
            %                 set(handles.t_msg,'String','flex');
            %             case 5
            %                 set(handles.t_msg,'String','extend');
        otherwise
            set(handles.t_msg,'String','possible error!');
    end
    drawnow;
    outMov(i,:) = [movIdx activLevel];
    if streamingEnable == 1
        % Read Streaming Data
        streamingBuffer = [];
        checkMessage = 0;
        flagMessage = 1;
        while( flagMessage > 0)
            streamingBuffer = [streamingBuffer fread(obj,1,'uint8')];    % Read the samples
            if streamingBuffer(end)=='*'
                checkMessage = checkMessage + 1;
                if checkMessage == 3                                     % If I read 3 tails, then exit
                    flagMessage = 0;
                end
            end
        end
        emptyStream = 2*3+nCh*4+2*(3+3+6+1)+5+3*1;    % expected bytes
        if emptyStream <= length(streamingBuffer)
            streamMAV = [];
            streamMAVfloat32 = [];
            streamHand = [];
            streamHanduint16 = [];
            streamStimulation = [];
            highHeader = find(char(streamingBuffer)=='@');    % find header messages
            if length(highHeader)==3                          % Update structure only if all messages are correctly received
                for j = highHeader
                    % Checking for every type message
                    try
                        if char(streamingBuffer(j+1))=='M' && char(streamingBuffer(j+4*nCh+2))=='*'
                            streamMAV = streamingBuffer(j+2:j+4*nCh+1);
                            for k = 1:nCh
                                streamMAVfloat32(1,k) = typecast(uint8(streamMAV((k-1)*4+4:-1:(k-1)*4+1)), 'single');
                            end
                        elseif char(streamingBuffer(j+1))=='H' && char(streamingBuffer(j+28))=='*'
                            streamHand = streamingBuffer(j+2:j+27);
                            for k = 1:13
                                streamHanduint16(1,k) = typecast(uint8(streamHand((k-1)*2+2:-1:(k-1)*2+1)), 'int16');
                            end
                        elseif char(streamingBuffer(j+1))=='F' && char(streamingBuffer(j+7))=='*'
                            streamStimulation = streamingBuffer(j+2:j+6);
                        end
                    catch
                    end
                end
            end
            
            %Plot Data
            % Offset the plot of the different channels to fit into the main figure
            ampPP     = 5*10^-4;
            offVector = 0:nCh-1;
            offVector = offVector .* ampPP;
            for i = 1 : nCh
                if ~isempty(streamMAVfloat32)
                    streamMAVfloat32(:,i) = streamMAVfloat32(:,i) + offVector(i);
                end
            end
            % If the message is correct then store it
            if ~isempty(streamHanduint16)
                if streamHanduint16(1,1)<1025 && streamHanduint16(1,2)<1025 && streamHanduint16(1,3)<1025 && streamHanduint16(1,4)<1025 && streamHanduint16(1,5)<1025 && streamHanduint16(1,6)<1025 && streamHanduint16(1,7)<257 && streamHanduint16(1,8)<257 && streamHanduint16(1,9)<257 && streamHanduint16(1,10)<257 && streamHanduint16(1,11)<257 && streamHanduint16(1,12)<257 && streamHanduint16(1,13)<32001
                    streamHandAll = [streamHandAll; streamHanduint16];
                    streamHandAll(end,end) = streamHandAll(end,end)+overFlowHandTime*countOverflowTimer;
                    if  size(streamHandAll,1)==1
                        streamMAVAll = [streamMAVAll; streamMAVfloat32];
                        streamStimulationAll = [streamStimulationAll; streamStimulation];
                        flagOffset = 0;
                        flagOverflowTimer = 0;
                    else
                        if streamHandAll(end,end)>=streamHandAll(end-1,end)
                            streamMAVAll = [streamMAVAll; streamMAVfloat32];
                            streamStimulationAll = [streamStimulationAll; streamStimulation];
                            flagOffset = 0;
                            flagOverflowTimer = 0;
                        else
                            streamHandAll = streamHandAll(1:end-1,:);
                            if streamHanduint16(end,end)-streamHandAll(end-1,end) < -30000
                                countOverflowTimer = countOverflowTimer+1;
                            end
                        end
                    end
                end
            end
            % Delete the first samples
            if flagFirstSample==0 && ~isempty(streamHandAll)
                analogOffset = streamHandAll(end,1:6);
                streamMAVAll = [];
                streamStimulationAll = [];
                streamHandAll = [];
                flagFirstSample = 1;
            end
            if flagOffset == 0 && ~isempty(streamHandAll)
                % Force data correction
                streamHandAll(end,1:6) = (streamHandAll(end,1:6)-analogOffset).*correctionFactor*analogGainFactor;
                %             streamHandAll(end,1:6) = (streamHandAll(end,1:6)).*correctionFactor*analogGainFactor;
            end
            % Build hand data offset for plotting
            %         offVectorHand = 0:1024:1024*11;
            offVectorHand = 0:256:256*11;
            for i = 1:12
                if ~isempty(streamHandAll) && flagOffset == 0        % sum the offsets only if there are new data
                    streamHandAll(end,i) = streamHandAll(end,i) + offVectorHand(i);
                end
            end
            flagOffset = 1;
            dtHand = 0.025;  % time between each hand message
            % Plot the data
            if ~isempty(streamMAVAll)
                streamHandAllTime = (streamHandAll(:,end)-streamHandAll(1,end))*dtHand;
                if singlePointPlot == 1
                    if size(streamMAVAll,1)<=windowData
                        % Draw figures
                        set(handles.MAV,'NextPlot','replace');
                        p_MAV = plot(handles.MAV, streamHandAllTime(:,end), streamMAVAll);
                        set(handles.MAV,'XLim',[streamHandAllTime(1,end),streamHandAllTime(end,end)+300*dtHand]);
                        set(handles.MAV,'YTick',offVector);
                        set(handles.MAV,'YTickLabel',1:nCh);
                        set(handles.MAV,'YLim',[-0.0001,(nCh)*ampPP]);
                        
                        set(handles.hand_data,'NextPlot','replace');
                        p_hand= plot(handles.hand_data, streamHandAllTime(:,end), streamHandAll(:,1:end-1));
                        set(handles.hand_data,'XLim',[streamHandAllTime(1,end),streamHandAllTime(end,end)+300*dtHand]);
                        set(handles.hand_data,'YTick',offVectorHand);
                        set(handles.hand_data,'YTickLabel',1:12);
                        %                     set(handles.hand_data,'YLim',[-500,1024*12]);
                        set(handles.hand_data,'YLim',[-100,256*12]);
                    else
                        set(handles.MAV,'NextPlot','replace');
                        p_MAV = plot(handles.MAV, streamHandAllTime(end-windowData:end,end), streamMAVAll(end-windowData:end,:));
                        set(handles.MAV,'XLim',[streamHandAllTime(end-windowData+1,end),streamHandAllTime(end,end)+300*dtHand]);
                        set(handles.MAV,'YTick',offVector);
                        set(handles.MAV,'YTickLabel',1:nCh);
                        set(handles.MAV,'YLim',[-0.0001,(nCh)*ampPP]);
                        
                        set(handles.hand_data,'NextPlot','replace');
                        p_hand = plot(handles.hand_data, streamHandAllTime(end-windowData:end,end), streamHandAll(end-windowData:end,1:end-1));
                        set(handles.hand_data,'XLim',[streamHandAllTime(end-windowData+1,end),streamHandAllTime(end,end)+300*dtHand]);
                        set(handles.hand_data,'YTick',offVectorHand);
                        set(handles.hand_data,'YTickLabel',1:12);
                        %                     set(handles.hand_data,'YLim',[-500,1024*12]);
                        set(handles.hand_data,'YLim',[-100,256*12]);
                    end
                else
                    if size(streamMAVAll,1)<=windowData
                        % Draw figures
                        p_MAV = plot(handles.MAV, streamHandAllTime(:,end), streamMAVAll);
                        set(handles.MAV,'XLim',[streamHandAllTime(1,end),streamHandAllTime(end,end)+300*dtHand]);
                        set(handles.MAV,'YTick',offVector);
                        set(handles.MAV,'YTickLabel',1:nCh);
                        set(handles.MAV,'YLim',[-0.0001,(nCh)*ampPP]);
                        
                        p_hand= plot(handles.hand_data, streamHandAllTime(:,end), streamHandAll(:,1:end-1));
                        set(handles.hand_data,'XLim',[streamHandAllTime(1,end),streamHandAllTime(end,end)+300*dtHand]);
                        set(handles.hand_data,'YTick',offVectorHand);
                        set(handles.hand_data,'YTickLabel',1:12);
                        %                     set(handles.hand_data,'YLim',[-500,1024*12]);
                        set(handles.hand_data,'YLim',[-100,256*12]);
                    else
                        p_MAV = plot(handles.MAV, streamHandAllTime(end-windowData:end,end), streamMAVAll(end-windowData:end,:));
                        set(handles.MAV,'XLim',[streamHandAllTime(end-windowData+1,end),streamHandAllTime(end,end)+300*dtHand]);
                        set(handles.MAV,'YTick',offVector);
                        set(handles.MAV,'YTickLabel',1:nCh);
                        set(handles.MAV,'YLim',[-0.0001,(nCh)*ampPP]);
                        
                        p_hand = plot(handles.hand_data, streamHandAllTime(end-windowData:end,end), streamHandAll(end-windowData:end,1:end-1));
                        set(handles.hand_data,'XLim',[streamHandAllTime(end-windowData+1,end),streamHandAllTime(end,end)+300*dtHand]);
                        set(handles.hand_data,'YTick',offVectorHand);
                        set(handles.hand_data,'YTickLabel',1:12);
                        %                     set(handles.hand_data,'YLim',[-500,1024*12]);
                        set(handles.hand_data,'YLim',[-100,256*12]);
                    end
                end
            end
        end
    end
    if go == 0
        break;
    end
end
toc
% Stop the aquisition
fwrite(obj,'T','char');
% Close connection
fclose(obj);
go = 0;
set(handles.pb_stop,'Enable','off');
set(handles.t_msg,'String','Control-Test session completed');
save('Control-Output.mat','outMov');


% --- Executes on button press in pb_stop.
function pb_stop_Callback(hObject, eventdata, handles)
% hObject    handle to pb_stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global go;
go = 0;

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Get connection object
if isfield(handles,'obj')
    obj = handles.obj;
else
    set(handles.t_msg,'String','No connection obj found');
    return;
end
% Open the connection
fopen(obj);

% ask for battery state
fwrite(obj,hex2dec('21'),'char');
reply = fread(obj,1,'char');
if reply == hex2dec('21')
    battery = fread(obj,1,'float32');
    temperature = fread(obj,1,'float32');
    sensorHand = fread(obj,1,'char');
    if(sensorHand)
        SH = 'present';
    else
        SH = 'not present';
    end
    enableNS1 = fread(obj,1,'char');
    if(enableNS1)
        enableSH = 'enabled';
    else
        enableSH = 'not enabled';
    end
    sdCard = fread(obj,1,'char');
    if(sdCard)
        SD = 'present';
    else
        SD = 'not present';
    end
    iNEMO = fread(obj,1,'char');
    if(iNEMO)
        IMU = 'present';
    else
        IMU = 'not present';
    end
    enableMotor = fread(obj,1,'char');
    if(enableMotor)
        enableM = 'enabled';
    else
        enableM = 'not enabled';
    end
    enableFilter = fread(obj,1,'char');
    if(enableFilter)
        enableF = 'enabled';
    else
        enableF = 'not enabled';
    end
    controlAlgorithm = fread(obj,1,'char');
    switch(controlAlgorithm)
        case 0
            PC = 'none';
        case 1
            PC = 'Majority Vote';
        case 2
            PC = 'Ramp';
        otherwise
            PC = 'not recognized';
    end
    controlMode = fread(obj,1,'char');
    switch(controlMode)
        case 0
            CM = 'Direct Control';
        case 1
            CM = 'Linear Discriminant Analysis';
        case 2
            CM = 'Support Vector Machine';
        otherwise
            CM = 'not recognized';
    end
    tWs = fread(obj,1,'uint32');
    oWs = fread(obj,1,'uint32');
    sF = fread(obj,1,'uint32');
    nChannels = fread(obj,1,'char');
    nFeatures = fread(obj,1,'char');
    rampLength = fread(obj,1,'char');
    rampMode = fread(obj,1,'char');
    mvSteps = fread(obj,1,'char');
    delicateGrasp = fread(obj,1,'char');
    delicateGraspThreshold = fread(obj,1,'char');
    sensitivity = fread(obj,1,'float32');
    min = fread(obj,1,'char');
    max = fread(obj,1,'char');
    handControlMode = fread(obj,1,'char');
    if(handControlMode)
        handCtrlMd = 'Analogic';
    else
        handCtrlMd = 'Digital';
    end
    reply = char(fread(obj,1,'char'));
    if reply == hex2dec('21')
        %             status = sprintf('Battery Voltage = %2.3g V\nCPU Temperature = %2.3g °C\nSensor-Hand = %s\nNeurostimulator = %s\nSD-card = %s\niNEMO = %s\nMotors = %s\nFilters = %s\nPost-Control-Algorithm = %s\nControl Algorithm = %s\ntime window samples = %d\noverlapp window samples = %d\nsampling frequency = %d Hz\nnumber of channels = %d\nnumber of features = %d\nramp length = %d\nramp mode = %d\nmajority vote steps = %d\ndelicate grasp = %d\ndelicate grasp threshold = %d\nsensitivity = %d\nhand minimum speed = %d\nhand maximum speed = %d\nHand control mode = %s', battery, temperature, SH, enableSH, SD, IMU, enableM, enableF, PC, CM, tWs, oWs, sF, nChannels, nFeatures, rampLength, rampMode, mvSteps, delicateGrasp, delicateGraspThreshold, sensitivity, min, max, handCtrlMd);
        %             msgbox(status,'System Status')
        status = sprintf('Control Algorithm = %s\nPost-Control-Algorithm = %s\nMajority vote steps = %d\nNumber of channels = %d\nSensitivity = %d\n', CM, PC, mvSteps, nChannels, sensitivity);
        set(handles.ctrl_msg,'String',status);
    else
        set(handles.t_msg,'String','Error, device is not responding or COM port is changed!');
        fclose(obj);
        return
    end
else
    set(handles.t_msg,'String','Error, device is not responding or COM port is changed!');
end
%Read Stimulation setting
fwrite(obj,hex2dec('B1'),'char');
reply = fread(obj,1,'char');
if reply == hex2dec('B1')
    mode = fread(obj,1,'uint8');
    switch(mode)
        case 0
            mode = 'Fixed';
        case 1
            mode = 'Freqeuncy';
        case 2
            mode = 'PW & Frequency';
        case 3
            mode = 'Amplitude';
        case 4
            mode = 'Pulse Width';
        otherwise
            mode = 'Not Recognised';
    end
    channel = fread(obj,1,'uint8');
    amplitude = fread(obj,1,'uint8');
    pulseWidth = fread(obj,1,'uint8');
    frequency = fread(obj,1,'uint8');
    repetitions = fread(obj,1,'uint8');
    modAmpTop = fread(obj,1,'uint8');
    modAmpLow = fread(obj,1,'uint8');
    modPWTop = fread(obj,1,'uint8');
    modPWLow = fread(obj,1,'uint8');
    modFreqTop = fread(obj,1,'uint8');
    modFreqLow = fread(obj,1,'uint8');
    DESCenable = fread(obj,1,'uint8');
    if(DESCenable)
        DESCenable = 'enabled';
    else
        DESCenable = 'not enabled';
    end
    DESCchannel = fread(obj,1,'uint8');
    DESCpulseWidth = fread(obj,1,'uint8');
    DESCfrequency = fread(obj,1,'uint8');
    DESCrepetitions = fread(obj,1,'uint8');
    replay = fread(obj,1,'uint8');
    if reply == hex2dec('B1')
        %             status = sprintf('Battery Voltage = %2.3g V\nCPU Temperature = %2.3g °C\nSensor-Hand = %s\nNeurostimulator = %s\nSD-card = %s\niNEMO = %s\nMotors = %s\nFilters = %s\nPost-Control-Algorithm = %s\nControl Algorithm = %s\ntime window samples = %d\noverlapp window samples = %d\nsampling frequency = %d Hz\nnumber of channels = %d\nnumber of features = %d\nramp length = %d\nramp mode = %d\nmajority vote steps = %d\ndelicate grasp = %d\ndelicate grasp threshold = %d\nsensitivity = %d\nhand minimum speed = %d\nhand maximum speed = %d\nHand control mode = %s', battery, temperature, SH, enableSH, SD, IMU, enableM, enableF, PC, CM, tWs, oWs, sF, nChannels, nFeatures, rampLength, rampMode, mvSteps, delicateGrasp, delicateGraspThreshold, sensitivity, min, max, handCtrlMd);
        %             msgbox(status,'System Status')
        status = sprintf('Neurostimulator = %s\nStimulation Mode = %s\nAmplitude = %2.3g mA\nPulse Width = %2.3g ms\nFrequency = %2.3g Hz\nRepetition = %2.3g\nDESC enable = %s\nDESC PW = %2.3g ms\nDESC Frequency = %2.3g Hz\nDESC Repetition %2.3g', enableSH, mode, amplitude, pulseWidth, frequency, repetitions, DESCenable, DESCpulseWidth, DESCfrequency, DESCrepetitions);
        set(handles.stm_msg,'String',status);
    else
        set(handles.t_msg,'String','Error, device is not responding or COM port is changed!');
        fclose(obj);
        return
    end
else
    set(handles.t_msg,'String','Error, device is not responding or COM port is changed!');
end

fclose(obj);


% --- Executes on button press in cb_motorsEnable.
function cb_motorsEnable_Callback(hObject, eventdata, handles)
% hObject    handle to cb_motorsEnable (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of cb_motorsEnable
motorsEnable = get(handles.cb_motorsEnable,'Value');
% Get connection object
if isfield(handles,'obj')
    obj = handles.obj;
else
    set(handles.t_msg,'String','No connection obj found');
    if motorsEnable
        set(handles.cb_motorEnable,'Value',0);
    else
        set(handles.cb_motorEnable,'Value',1);
    end
    return;
end
% Open the connection
fopen(obj);
% Set up the filters enable
fwrite(obj,'e','char');
replay = char(fread(obj,1,'char'));
if strcmp(replay,'e')
    fwrite(obj,motorsEnable,'char');
    replay = char(fread(obj,1,'char'));
    if strcmp(replay,'e');
        if(motorsEnable)
            set(handles.t_msg,'String','Motors enabled');
        else
            set(handles.t_msg,'String','Motors disabled');
        end
    else
        set(handles.t_msg,'String','Error Setting Motors enable');
        fclose(obj);
        return
    end
else
    set(handles.t_msg,'String','Error Setting Motors enable');
    fclose(obj);
    return
end
fclose(obj);

% --------------------------------------------------------------------
function menu_connect_Callback(hObject, eventdata, handles)
% hObject    handle to menu_connect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Ask for connection settings
prompt = {'Enter COM Port:','Enter baudrate:'};
dlg_title = 'Connect';
num_lines = 1;
def = {'15','460800'};
set(handles.t_msg,'String','Testing connection...');
answer = inputdlg(prompt,dlg_title,num_lines,def);
ComPortName = ['COM',num2str(char(answer(1)))];
BaudRate = str2num(char(answer(2)));
%     delete(instrfindall);
obj = serial (ComPortName, 'baudrate', BaudRate, 'databits', 8, 'byteorder', 'bigEndian');
%     %WiFi = get(handles.cb_WiFi,'Value');
%     WiFi = 0;
%     if ispc
%         ComPortName = strcat('COM',ComPortName);
%     end
%     if isfield(handles,'obj')
%         obj = handles.obj;
%         fclose(obj);
%     else
%          if WiFi
%             obj = tcpip('192.168.100.10',65100,'NetworkRole','client');        % WIICOM
%          else
%             obj = serial (ComPortName, 'baudrate', baud, 'databits', 8, 'byteorder', 'bigEndian');
%          end
%     end
% Open connection
fclose(obj);
fopen(obj);
fwrite(obj,'A','char');
fwrite(obj,'C','char');
replay = char(fread(obj,1,'char'));
if strcmp(replay,'C')
    set(handles.t_msg,'String','Connection Established');
else
    set(handles.t_msg,'String','Error, device is not responding or COM port is changed!');
end
fclose(obj);
handles.obj = obj;
guidata(hObject,handles);


% --- Executes on button press in cb_streamingEnable.
function cb_streamingEnable_Callback(hObject, eventdata, handles)
% hObject    handle to cb_streamingEnable (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global streamingEnable;
streamingEnable = get(handles.cb_streamingEnable,'Value');
% Get connection object
if isfield(handles,'obj')
    obj = handles.obj;
else
    set(handles.t_msg,'String','No connection obj found');
    if streamingEnable
        set(handles.cb_streamingEnable,'Value',0);
    else
        set(handles.cb_streamingEnable,'Value',1);
    end
    return;
end
% Open the connection
fopen(obj);
% Set up the filters enable
fwrite(obj,'k','char');
replay = char(fread(obj,1,'char'));
if strcmp(replay,'k')
    fwrite(obj,streamingEnable,'char');
    replay = char(fread(obj,1,'char'));
    if strcmp(replay,'k');
        if(streamingEnable)
            set(handles.t_msg,'String','Streaming enabled');
        else
            set(handles.t_msg,'String','Streaming disabled');
        end
    else
        set(handles.t_msg,'String','Error Setting Motors enable');
        fclose(obj);
        return
    end
else
    set(handles.t_msg,'String','Error Setting Streaming enable');
    fclose(obj);
    return
end
fclose(obj);
