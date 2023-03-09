function varargout = GUI_SetDC_MIA(varargin)
% GUI_SETDC_MIA MATLAB code for GUI_SetDC_MIA.fig
%      GUI_SETDC_MIA, by itself, creates a new GUI_SETDC_MIA or raises the existing
%      singleton*.
%
%      H = GUI_SETDC_MIA returns the handle to a new GUI_SETDC_MIA or the handle to
%      the existing singleton*.
%
%      GUI_SETDC_MIA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_SETDC_MIA.M with the given input arguments.
%
%      GUI_SETDC_MIA('Property','Value',...) creates a new GUI_SETDC_MIA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_SetDC_MIA_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_SetDC_MIA_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_SetDC_MIA

% Last Modified by GUIDE v2.5 20-Jan-2023 16:36:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_SetDC_MIA_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_SetDC_MIA_OutputFcn, ...
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


% --- Executes just before GUI_SetDC_MIA is made visible.
function GUI_SetDC_MIA_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_SetDC_MIA (see VARARGIN)

global movs;

% Choose default command line output for GUI_SetDC_MIA
handles.output = hObject;

% prepare figures
handles.p_t(1) = bar(handles.p_1, 1, 0);
handles.p_t(2) = bar(handles.p_2, 1, 0);
set(handles.p_1,'Xticklabel','');
set(handles.p_2,'Xticklabel','');
set(handles.p_1,'Yticklabel','');
set(handles.p_2,'Yticklabel','');
set(handles.p_1,'ylim',[0 1]);
set(handles.p_2,'ylim',[0 1]);
set(handles.ax_open,'Xticklabel','');
set(handles.ax_close,'Xticklabel','');
set(handles.ax_open,'Yticklabel','');
set(handles.ax_close,'Yticklabel','');

set(hObject, 'WindowButtonUpFcn', @(hObject,eventdata)GUI_SetDC_MIA('stopDragFcn',hObject,eventdata,guidata(hObject)));

% movement structure
movs{1}.name = 'open hand';
movs{1}.id = 1;
movs{2}.name = 'close hand';
movs{2}.id = 2;
for i = 1:2
    movs{i}.active = 0;
    movs{i}.motorThresh = 0;
    movs{i}.mvcLevel = 0;
end

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_SetDC_MIA wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_SetDC_MIA_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in pm_ComPort.
function pm_ComPort_Callback(hObject, eventdata, handles)
% hObject    handle to pm_ComPort (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pm_ComPort contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pm_ComPort


% --- Executes during object creation, after setting all properties.
function pm_ComPort_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pm_ComPort (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

if ~verLessThan('matlab', '9.7')
    ports = serialportlist;
    if ~isempty(ports)
        set(hObject,'String',ports);
    else
        set(hObject,'String','None Available');
    end
    
else
    ports = instrhwinfo('serial');
    if ~isempty(ports.AvailableSerialPorts)
        ports = ports.SerialPorts;
        set(hObject,'String',ports);
    else
        set(hObject,'String','None Available');
    end
end


% --- Executes on button press in pb_connect.
function pb_connect_Callback(hObject, eventdata, handles)
% hObject    handle to pb_connect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    try
        compath_idx = get(handles.pm_ComPort,'Value');
        ComPortName     = get(handles.pm_ComPort,'string');
        if iscell(ComPortName)
            ComPortName     = ComPortName(compath_idx);
        end
        BaudRate    = 115200; 
        set(handles.t_msg,'String','Testing connection...');
        drawnow();
        delete(instrfindall);
        obj = serial (ComPortName, 'baudrate', BaudRate, 'databits', 8, 'byteorder', 'bigEndian');
%         obj = serialport(ComPortName, BaudRate, 'Databits', 8,'Byteorder', 'big-endian');
        % Open connection
        fclose(obj);
        fopen(obj);
        stopStreaming(obj); % stop any streaming happening to be able to check the connection
        % Check if the hand is present
        comm = MIAmsg;
        comm(2:3) = 'SR';
        for i = 1:18
            fwrite(obj,comm(i),'char');
        end
        reply = fread(obj,17,'char');
        reply = [];
        for i = 1:29
            reply(i) = char(fread(obj,1,'char'));
        end
        assert(strcmp(char(reply(1:6)),'Mia Ma'),'NCALfit:pb_connect_readbackerror','Error, device is not responding or COM port is changed!');
        
        set(handles.t_msg,'String',' ');
        pause(0.5)
        set(handles.t_msg,'String','Connection established');

    catch exception
        switch exception.identifier
            case 'MATLAB:serial:fopen:opfailed'
                set(handles.t_msg,'String','Invalid COM port');
            otherwise
                set(handles.t_msg,'String',exception.message);
        end
    end
    fclose(obj);
    handles.obj = obj;
    guidata(hObject,handles);

% --- Executes on button press in pb_refresh.
function pb_refresh_Callback(hObject, eventdata, handles)
% hObject    handle to pb_refresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~verLessThan('matlab', '9.7')
    ports = serialportlist;
    if ~isempty(ports)
        set(handles.pm_ComPort,'String',ports);
    else
        set(handles.pm_ComPort,'String','None Available');
    end
    
else
    ports = instrhwinfo('serial');
    if ~isempty(ports.AvailableSerialPorts)
        ports = ports.SerialPorts;
        set(handles.pm_ComPort,'String',ports);
    else
        set(handles.pm_ComPort,'String','None Available');
    end
end


% --- Executes on button press in pb_start.
function pb_start_Callback(hObject, eventdata, handles)
% hObject    handle to pb_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    global movs 

    movs{1}.active = 1;
    movs{1}.data = 0;
    movs{1}.mvcLevel = 0;

    movs{2}.active = 1;
    movs{2}.data = 0;
    movs{2}.mvcLevel = 0;

    sF = 100; % the hand gives messages every 10ms
    samples = str2double(get(handles.et_time,'String'));
    maxCount = samples;
    samples = samples*sF;
    refreshBarsCount = 0;

    % Initialization of progress bar
    set(handles.p_1,'YLimMode','manual');
    set(handles.p_2,'YLimMode','manual');

    % Get connection object
    if isfield(handles,'obj')
        obj = handles.obj;
    else
        set(handles.t_msg,'String','No connection obj found');   
        return;
    end
    % Set up receiving buffer
    obj.InputBufferSize = 2*samples*1000;

    % Open the connection
    fopen(obj);
    % Read available data and discard it
    if obj.BytesAvailable > 0
        fread(obj,obj.BytesAvailable,'uint8');    % Read the samples        
    end  

    pause(0.5);

    setEmgDecoder(handles,obj,'s','0'); % disable the EMG decoder, so the hand won't move during the EMG acquisition

    % start the EMG streaming
    comm = MIAmsg;
    comm(2:5) = 'ADE1';
    for i = 1:18
        fwrite(obj,comm(i),'char');
    end

    reply = fread(obj,17,'char');
    if strcmp(char(reply(1:5)'),'<ADE1')
        set(handles.t_msg,'String','Features reception Start');
    else
        set(handles.t_msg,'String','Error Start'); 
        fclose(obj);
        return
    end
    drawnow;
    
    tic;
    for i = 1:samples
        reply = [];
        reply = fread(obj,10,'char');
        % Checking if the streaming is EMG
        if strcmp(char(reply(1:3)'),'emg')
            reply = fread(obj,6,'char')';
            movs{1}.data(i) = str2double(char(reply)); 
            for j = 1:3
                reply = fread(obj,1,'char');
            end
            reply = fread(obj,6,'char')';
            movs{2}.data(i) = str2double(char(reply)); 
            % update the MVC level
            for j = 1 : 2
                if movs{j}.data(i) >= movs{j}.mvcLevel
                    movs{j}.mvcLevel = movs{j}.data(i);
                end
            end 
            % Discard the rest part of the message
            reply = fread(obj,39,'char'); 

            refreshBarsCount = refreshBarsCount + 1;
            % get the plot routines faster
            if refreshBarsCount == maxCount
                UpdateBars(handles);   
                refreshBarsCount = 0;
            end   
        end
    end
    disp(toc)

    % stop EMG streaming
    comm = MIAmsg;
    comm(2:5) = 'ADE0';
    for i = 1:18
        fwrite(obj,comm(i),'char');
    end
    fclose(obj);

    set(handles.t_msg,'String','Features Received');
    fileName = 'FeaturesThresholdCalibration';
    save(fileName,'movs');

    % Update the GUI
    for i = 1 : 2
        if movs{i}.active
            message = num2str(movs{i}.mvcLevel);
            set(eval(strcat('handles.et_MVC',num2str(i))),'String',message);
            set(eval(strcat('handles.s_thresh',num2str(i))),'Max',movs{i}.mvcLevel,'Min',0,'SliderStep',[movs{i}.mvcLevel/1000 movs{i}.mvcLevel/1000]);
        end
    end
    drawnow;

    % update plot for open hand channel recording
    if (movs{1}.active)
        recTime = samples/sF;
        axes(handles.ax_open)
        plot(linspace(0,recTime,samples),movs{1}.data)
        hold on
        handles.openLineMVC = plot(linspace(0,recTime,samples),ones(1,samples)*movs{1}.mvcLevel,'-r','LineWidth',2.5,'ButtonDownFcn', @(hObject,eventdata)GUI_SetDC_MIA('startDragOpenLineMVC_Fcn',hObject,eventdata,guidata(hObject)));
        handles.openLineThresh = plot(linspace(0,recTime,samples),ones(1,samples)*movs{1}.mvcLevel/2,'-b','LineWidth',2.5,'ButtonDownFcn',@(hObject,eventdata)GUI_SetDC_MIA('startDragOpenLineThresh_Fcn',hObject,eventdata,guidata(hObject)));
        hold off
    end

    % update plot for close hand channel recording
    if (movs{2}.active)
        recTime = samples/sF;
        axes(handles.ax_close)
        plot(linspace(0,recTime,samples),movs{2}.data)
        hold on
        handles.closeLineMVC = plot(linspace(0,recTime,samples),ones(1,samples)*movs{2}.mvcLevel,'-r','LineWidth',2.5,'ButtonDownFcn', @(hObject,eventdata)GUI_SetDC_MIA('startDragCloseLineMVC_Fcn',hObject,eventdata,guidata(hObject)));
        handles.closeLineThresh = plot(linspace(0,recTime,samples),ones(1,samples)*movs{2}.mvcLevel/2,'-b','LineWidth',2.5,'ButtonDownFcn',@(hObject,eventdata)GUI_SetDC_MIA('startDragCloseLineThresh_Fcn',hObject,eventdata,guidata(hObject)));
        hold off
    end

    % Update handles structure
    guidata(hObject, handles);

function et_time_Callback(hObject, eventdata, handles)
% hObject    handle to et_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_time as text
%        str2double(get(hObject,'String')) returns contents of et_time as a double


% --- Executes during object creation, after setting all properties.
function et_time_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_thresh2_Callback(hObject, eventdata, handles)
% hObject    handle to et_thresh2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_thresh2 as text
%        str2double(get(hObject,'String')) returns contents of et_thresh2 as a double


% --- Executes during object creation, after setting all properties.
function et_thresh2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_thresh2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function s_thresh2_Callback(hObject, eventdata, handles)
% hObject    handle to s_thresh2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function s_thresh2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to s_thresh2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function et_MVC2_Callback(hObject, eventdata, handles)
% hObject    handle to et_MVC2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_MVC2 as text
%        str2double(get(hObject,'String')) returns contents of et_MVC2 as a double


% --- Executes during object creation, after setting all properties.
function et_MVC2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_MVC2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_thresh1_Callback(hObject, eventdata, handles)
% hObject    handle to et_thresh1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_thresh1 as text
%        str2double(get(hObject,'String')) returns contents of et_thresh1 as a double


% --- Executes during object creation, after setting all properties.
function et_thresh1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_thresh1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function s_thresh1_Callback(hObject, eventdata, handles)
% hObject    handle to s_thresh1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function s_thresh1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to s_thresh1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function et_MVC1_Callback(hObject, eventdata, handles)
% hObject    handle to et_MVC1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_MVC1 as text
%        str2double(get(hObject,'String')) returns contents of et_MVC1 as a double


% --- Executes during object creation, after setting all properties.
function et_MVC1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_MVC1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in pb_write.
function pb_write_Callback(hObject, eventdata, handles)
% hObject    handle to pb_write (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global movs
for j = 1:2
    movs{j}.active = 1;
    movs{j}.motorThresh = str2num(get(eval(strcat('handles.et_thresh',num2str(j))),'String'));
    movs{j}.mvcLevel = str2num(get(eval(strcat('handles.et_MVC',num2str(j))),'String'));
end

% Get connection object
if isfield(handles,'obj')
    obj = handles.obj;
else
    set(handles.t_msg,'String','No connection obj found');
    return;
end
% Open the connection
fopen(obj);
setEmgDecoder(handles,obj,'o',round(movs{1}.motorThresh)); % open hand threshold
setEmgDecoder(handles,obj,'c',round(movs{2}.motorThresh)); % close hand threshold
setEmgDecoder(handles,obj,'p',str2num(get(handles.et_PWM,'String'))); % PWM
setEmgDecoder(handles,obj,'k',str2num(get(handles.et_K,'String')));   % EMG gain
setEmgDecoder(handles,obj,'d',str2num(get(handles.et_holdToSwitch,'String'))); % time for "hold open to switch"
setEmgDecoder(handles,obj,'g',get(handles.et_grasps,'String')); % set of grasps
fclose(obj);


% --- Executes on button press in pb_read.
function pb_read_Callback(hObject, eventdata, handles)
% hObject    handle to pb_read (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global movs;

% Get connection object
if isfield(handles,'obj')
    obj = handles.obj;
else
    set(handles.t_msg,'String','No connection obj found');
    return;
end
% Open the connection
comm = MIAmsg;
comm(2:4) = 'Aer';
fopen(obj);
% Send command to read the parameters
for i = 1:18
    fwrite(obj,comm(i),'char');
end
reply = [];
reply = fread(obj,17,'char');
if ~strcmp(char(reply(1:4)'),'<Aer')
    set(handles.t_msg,'String','Error reading Control settings'); 
    fclose(obj);
    return
end
reply = [];
% Read the entire message
for i = 1:24
    reply(i) = fread(obj,1,'char');
end
if ~(strcmp(char(reply(1)),'E') && (reply(end)==10))
    set(handles.t_msg,'String','Error reading Control settings'); 
    fclose(obj);
    return
end
movs{1}.motorThresh = str2double(char(reply(6:8)));
movs{2}.motorThresh = str2double(char(reply(10:12)));
set(handles.t_msg,'String','Control settings read from MIA hand');
fclose(obj);

set(handles.et_thresh1,'string',num2str(movs{1}.motorThresh));
set(handles.et_thresh2,'string',num2str(movs{2}.motorThresh));
set(handles.et_K,'string',char(reply(3:4)));
set(handles.et_PWM,'string',char(reply(17:18)));
set(handles.et_holdToSwitch,'string',char(reply(14:15)));
set(handles.et_grasps,'string',regexprep(char(reply(19:23)),'[.]','')); % For grasps which are not present the '.' is put, so it should be removed before putting on GUI

%==========================================================================    
%% Update bar handles
%==========================================================================                    
function UpdateBars(handles)    
    global movs
    for j = 1 : 2
        if movs{j}.active
            if movs{j}.mvcLevel ~= 0
                set(eval(strcat('handles.p_',num2str(j))),'YLim',[0 movs{j}.mvcLevel]);
            end
            set(handles.p_t(j),'YData', movs{j}.data(end));
        end
    end
    drawnow expose

%==========================================================================    
%% Code for dragable MVC and threshold lines
%==========================================================================
% Open hand
%--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function startDragOpenLineMVC_Fcn(hObject, eventdata, handles)
        set(handles.figure1, 'WindowButtonMotionFcn', @(hObject,eventdata)GUI_SetDC_MIA('draggingOpenLineMVC_Fcn',hObject,eventdata,guidata(hObject))); 
    
function draggingOpenLineMVC_Fcn(hObject, eventdata, handles)
        global movs;
        pt = get(handles.ax_open, 'CurrentPoint');
        set(handles.openLineMVC, 'YData', ones(1,length(get(handles.openLineThresh,'XData')))*pt(1,2)); 
        % update parameters for that channel according to new position of the line
        movs{1}.mvcLevel = pt(1,2);
        set(eval(strcat('handles.et_MVC',num2str(1))),'String',num2str( pt(1,2)));
        set(eval(strcat('handles.s_thresh',num2str(1))),'min',0);
        set(eval(strcat('handles.s_thresh',num2str(1))),'max',pt(1,2));
        
function startDragOpenLineThresh_Fcn(hObject, eventdata, handles)
        set(handles.figure1, 'WindowButtonMotionFcn', @(hObject,eventdata)GUI_SetDC_MIA('draggingOpenLineThresh_Fcn',hObject,eventdata,guidata(hObject))); 

function draggingOpenLineThresh_Fcn(hObject, eventdata, handles)
        global movs;
        pt = get(handles.ax_open, 'CurrentPoint');
        set(handles.openLineThresh, 'YData', ones(1,length(get(handles.openLineThresh,'XData')))*pt(1,2));
        % update parameters for that channel according to new position of the line
        movs{1}.motorThresh = pt(1,2);
        set(eval(strcat('handles.et_thresh',num2str(1))),'String',num2str( pt(1,2)));
        set(eval(strcat('handles.s_thresh',num2str(1))),'Value',pt(1,2)); 

% Close hand
%--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function startDragCloseLineMVC_Fcn(hObject, eventdata, handles)
        set(handles.figure1, 'WindowButtonMotionFcn', @(hObject,eventdata)GUI_SetDC_MIA('draggingCloseLineMVC_Fcn',hObject,eventdata,guidata(hObject))); 
    
function draggingCloseLineMVC_Fcn(hObject, eventdata, handles)
        global movs;
        pt = get(handles.ax_close, 'CurrentPoint');
        set(handles.closeLineMVC, 'YData', ones(1,length(get(handles.closeLineThresh,'XData')))*pt(1,2)); 
        % update parameters for that channel according to new position of the line
        movs{2}.mvcLevel = pt(1,2);
        set(eval(strcat('handles.et_MVC',num2str(2))),'String',num2str( pt(1,2)));
        set(eval(strcat('handles.s_thresh',num2str(2))),'min',0);
        set(eval(strcat('handles.s_thresh',num2str(2))),'max',pt(1,2));
        
function startDragCloseLineThresh_Fcn(hObject, eventdata, handles)
        set(handles.figure1, 'WindowButtonMotionFcn', @(hObject,eventdata)GUI_SetDC_MIA('draggingCloseLineThresh_Fcn',hObject,eventdata,guidata(hObject))); 
    
function draggingCloseLineThresh_Fcn(hObject, eventdata, handles)
        global movs;
        pt = get(handles.ax_close, 'CurrentPoint');
        set(handles.closeLineThresh, 'YData', ones(1,length(get(handles.closeLineThresh,'XData')))*pt(1,2));
        % update parameters for that channel according to new position of the line
        movs{2}.motorThresh = pt(1,2);
        set(eval(strcat('handles.et_thresh',num2str(2))),'String',num2str( pt(1,2)));
        set(eval(strcat('handles.s_thresh',num2str(2))),'Value',pt(1,2));   

function stopDragFcn(hObject, eventdata, handles)
    set(handles.figure1, 'WindowButtonMotionFcn', '');

% Sending a message to set EMG decoder parameters
function correct = setEmgDecoder(handles,obj,code,value)
valueLength = 0;
correct = 0;
switch code
    case 'o' % open threshold
        valueLength = 3;
    case 'c' % close threshold
        valueLength = 3;
    case 'p' % PWM
        valueLength = 2;
    case 'k' % EMG gain
        valueLength = 2;
    case 'd' % hold-open to switch time
        valueLength = 2;
    case 's' % enable/disable EMG decoder
        valueLength = 1;
    case 'g' % grasps
        valueLength = 0; % value is not a number
end
value = num2str(value);
% In case the value is of shorter length than it should be, add zeros in
% front of it
while (valueLength > length(value))
    value = [48 value];
end
comm = MIAmsg;
comm(2:4) = ['Ae' code];
for i = 1:length(value)
    comm(4+i) = value(i);
end
for i = 1:18
    fwrite(obj,comm(i),'char');
end
reply = [];
reply = fread(obj,17,'char');

if strcmp(char(reply(1:3)'),'<Ae')
    set(handles.t_msg,'String','Control setting sent');
    correct = 1; % the command is sent properly
else
    set(handles.t_msg,'String','Error sending Control settings'); 
    fclose(obj);
    return
end
drawnow;

% Disable all streaming
function stopStreaming(obj)
comm = MIAmsg;
comm(2:3) = 'Ad';
for i = 1:18
    fwrite(obj,comm(i),'char');
end
reply = [];
reply = fread(obj,17,'char');
if strcmp(char(reply(1:3)'),'<Ad')
    disp('All streaming stopped')
else
    disp('Error in stoppping the streaming');
    fclose(obj);
    return
end
drawnow;

function et_holdToSwitch_Callback(hObject, eventdata, handles)
% hObject    handle to et_holdToSwitch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_holdToSwitch as text
%        str2double(get(hObject,'String')) returns contents of et_holdToSwitch as a double


% --- Executes during object creation, after setting all properties.
function et_holdToSwitch_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_holdToSwitch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_PWM_Callback(hObject, eventdata, handles)
% hObject    handle to et_PWM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_PWM as text
%        str2double(get(hObject,'String')) returns contents of et_PWM as a double


% --- Executes during object creation, after setting all properties.
function et_PWM_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_PWM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_K_Callback(hObject, eventdata, handles)
% hObject    handle to et_K (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_K as text
%        str2double(get(hObject,'String')) returns contents of et_K as a double


% --- Executes during object creation, after setting all properties.
function et_K_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_K (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% A toggle button which enables/disables EMG decoder
function tb_emg_Callback(hObject, eventdata, handles)
button_state = get(hObject,'Value');
if button_state == get(hObject,'Max')
    % toggle button is pressed
    value = '1';
    msg = 'EMG option is turned on';
elseif button_state == get(hObject,'Min')
    % toggle button is not pressed
    value = '0';
    msg = 'EMG option is turned off';
end
% Get connection object
if isfield(handles,'obj')
    obj = handles.obj;
else
    set(handles.t_msg,'String','No connection obj found');   
    return;
end
% Open the connection
fopen(obj);
msgV = setEmgDecoder(handles,obj,'s',value);
fclose(obj);
if msgV
    set(handles.t_msg,'String',msg);
else
    set(handles.t_msg,'String','Error on turning on/off EMG');
end
drawnow

% Save all parameters on the hand's eeprom
function pb_save_Callback(hObject, eventdata, handles)
% Get connection object
if isfield(handles,'obj')
    obj = handles.obj;
else
    set(handles.t_msg,'String','No connection obj found');   
    return;
end
% Open the connection
fopen(obj);
comm = MIAmsg;
comm(2:3) = 'ES';
for i = 1:18
    fwrite(obj,comm(i),'char');
end
reply = fread(obj,17,'char');
if strcmp(char(reply(1:3)'),'<ES')
    set(handles.t_msg,'String','Parameters stored successfully');
else
    set(handles.t_msg,'String','Error with storing parameters');
end
fclose(obj);

% MIA hand's command
function comm = MIAmsg
comm = ['@000000000000000*' 13];
