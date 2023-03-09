function varargout = GUI_Settings(varargin)
% GUI_SETTINGS MATLAB code for GUI_Settings.fig
%      GUI_SETTINGS, by itself, creates a new GUI_SETTINGS or raises the existing
%      singleton*.
%
%      H = GUI_SETTINGS returns the handle to a new GUI_SETTINGS or the handle to
%      the existing singleton*.
%
%      GUI_SETTINGS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_SETTINGS.M with the given input arguments.
%
%      GUI_SETTINGS('Property','Value',...) creates a new GUI_SETTINGS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_Settings_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_Settings_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_Settings

% Last Modified by GUIDE v2.5 11-Oct-2022 14:41:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_Settings_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_Settings_OutputFcn, ...
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


% --- Executes just before GUI_Settings is made visible.
function GUI_Settings_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_Settings (see VARARGIN)

% Choose default command line output for GUI_Settings
handles.output = hObject;

% Take useful information from GUI father (if it exists)
if size(varargin,2) > 0
    oldHandles = varargin{1};
    if isfield(oldHandles,'obj')
        handles.obj = oldHandles.obj;
        set(handles.t_msg,'String','Connection Established');
    end
end

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_Settings wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_Settings_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function menu_connect_Callback(hObject, eventdata, handles)
% hObject    handle to menu_connect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    % Ask for connection settings
    prompt = {'Enter COM Port:','Enter baudrate:'};
    dlg_title = 'Connect';
    num_lines = 1;
    def = {'5','460800'};
    answer = inputdlg(prompt,dlg_title,num_lines,def);
    ComPortName = num2str(char(answer(1)));
    baud = str2num(char(answer(2)));

    %WiFi = get(handles.cb_WiFi,'Value');
    WiFi = 0;
    if ispc
        ComPortName = strcat('COM',ComPortName);
    end
    set(handles.t_msg,'String','Testing connection...');   
    if isfield(handles,'obj')
        obj = handles.obj;
        fclose(obj);
    else
         if WiFi
            obj = tcpip('192.168.100.10',65100,'NetworkRole','client');        % WIICOM
         else
            obj = serial (ComPortName, 'baudrate', baud, 'databits', 8, 'byteorder', 'bigEndian');
         end
    end
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
    

% --- Executes on button press in pb_read.
function pb_read_Callback(hObject, eventdata, handles)
% hObject    handle to pb_read (see GCBO)
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
    if obj.BytesAvailable > 0
        fread(obj,obj.BytesAvailable,'uint8');    % Read the samples        
    end    
    % read settings
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
            case 3
                PC = 'Delicate Grasp';
            case 4
                PC = 'Inertial';
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
            case 3
                CM = 'Linear Regression';
            case 4
                CM = 'Transient';
            case 5
                CM = 'Neural Network';
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
        handInertia = fread(obj,1,'char');
        wristInertia = fread(obj,1,'char');
        elbowInertia = fread(obj,1,'char');
        mvSteps = fread(obj,1,'char');
        delicateGrasp = fread(obj,1,'char');
        delicateGraspThreshold = fread(obj,1,'char');        
        sensitivity = fread(obj,1,'float32');
        minH = fread(obj,1,'char');
        maxH = fread(obj,1,'char');     
        handControlMode = fread(obj,1,'char');
        if(handControlMode)
            handCtrlMd = 'Analogic';
        else
            handCtrlMd = 'Digital';
        end
        minW = fread(obj,1,'char');
        maxW = fread(obj,1,'char'); 
        minE = fread(obj,1,'char');
        maxE = fread(obj,1,'char');
        pauseCounter = fread(obj,1,'char');
        replay = char(fread(obj,1,'char'));
        if reply == hex2dec('21')
            status = sprintf('Battery Voltage = %2.3g V\nCPU Temperature = %2.3g C\nSensor-Hand = %s\nNeurostimulator = %s\nSD-card = %s\niNEMO = %s\nMotors = %s\nFilters = %s\nPost-Control-Algorithm = %s\nControl Algorithm = %s\ntime window samples = %d\noverlap window samples = %d\nsampling frequency = %d Hz\nnumber of channels = %d\nnumber of features = %d\nramp length = %d\nramp mode = %d\nmajority vote steps = %d\ndelicate grasp = %d\ndelicate grasp threshold = %d\nsensitivity = %d\nhand minimum speed = %d\nhand maximum speed = %d\nHand control mode = %s\nwrist minimum speed = %d\nwrist maximum speed = %d\nelbow minimum speed = %d\nelbow maximum speed = %d\nLock/unlock pause counter = %d', battery, temperature, SH, enableSH, SD, IMU, enableM, enableF, PC, CM, tWs, oWs, sF, nChannels, nFeatures, rampLength, rampMode, mvSteps, delicateGrasp, delicateGraspThreshold, sensitivity, minH, maxH, handCtrlMd, minW, maxW, minE, maxE, pauseCounter);
            msgbox(status,'System Status')
        else
            set(handles.t_msg,'String','Error, device is not responding or COM port is changed!'); 
            fclose(obj);
            return
        end
    else
        set(handles.t_msg,'String','Error, device is not responding or COM port is changed!');        
    end
    
    fclose(obj);


% --- Executes on button press in pb_write.
function pb_write_Callback(hObject, eventdata, handles)
% hObject    handle to pb_write (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    sF = str2double(get(handles.et_sF,'String'));
    tW = str2double(get(handles.et_tW,'String'));
    oW = str2double(get(handles.et_oW,'String'));
     
    % Get connection object
    if isfield(handles,'obj')
        obj = handles.obj;
    else
        set(handles.t_msg,'String','No connection obj found');   
        return;
    end

    % Open the connection
    fopen(obj);
    % Read available data and discard it
    if obj.BytesAvailable > 1
        fread(obj,obj.BytesAvailable,'uint8');    % Read the samples        
    end    
    
    % Set up the sampling frequency
    fwrite(obj,'r','char');
    replay = char(fread(obj,1,'char'));
    if strcmp(replay,'r')
        fwrite(obj,sF,'uint32');
        replay = char(fread(obj,1,'char'));
        if strcmp(replay,'r');
            set(handles.t_msg,'String','sampling frequency set');
        else
            set(handles.t_msg,'String','Error Setting sampling frequency'); 
            fclose(obj);
            return
        end
    else
        set(handles.t_msg,'String','Error Setting sampling frequency'); 
        fclose(obj);
        return
    end
    drawnow;
    pause(0.5)
    set(handles.t_msg,'String','');
    
    % Set the parameters for features extraction
    tWs = sF*tW;
    oWs = sF*oW;
    FeaturesEnables(1) = get(handles.cb_mabs,'Value');
    FeaturesEnables(2) = get(handles.cb_wl,'Value');
    FeaturesEnables(3) = get(handles.cb_zc,'Value');
    FeaturesEnables(4) = get(handles.cb_slpch,'Value');
    FeaturesEnables(5) = get(handles.cb_std,'Value');
    error = SetFeaturesExtractionParametersALCD(handles, tWs, oWs, FeaturesEnables);
    if error == 0
        set(handles.t_msg,'String','Time windows and features settings set'); 
    else
        set(handles.t_msg,'String','Error Setting time windows and features settings'); 
    end
    % Close connection
    fclose(obj);
    

function et_sF_Callback(hObject, eventdata, handles)
% hObject    handle to et_sF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_sF as text
%        str2double(get(hObject,'String')) returns contents of et_sF as a double


% --- Executes during object creation, after setting all properties.
function et_sF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_sF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_tW_Callback(hObject, eventdata, handles)
% hObject    handle to et_tW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_tW as text
%        str2double(get(hObject,'String')) returns contents of et_tW as a double


% --- Executes during object creation, after setting all properties.
function et_tW_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_tW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_oW_Callback(hObject, eventdata, handles)
% hObject    handle to et_oW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_oW as text
%        str2double(get(hObject,'String')) returns contents of et_oW as a double


% --- Executes during object creation, after setting all properties.
function et_oW_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_oW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in cb_zc.
function cb_zc_Callback(hObject, eventdata, handles)
% hObject    handle to cb_zc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_zc


% --- Executes on button press in cb_slpch.
function cb_slpch_Callback(hObject, eventdata, handles)
% hObject    handle to cb_slpch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_slpch


% --- Executes on button press in cb_mabs.
function cb_mabs_Callback(hObject, eventdata, handles)
% hObject    handle to cb_mabs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_mabs


% --- Executes on button press in cb_std.
function cb_std_Callback(hObject, eventdata, handles)
% hObject    handle to cb_std (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_std


% --- Executes on button press in cb_wl.
function cb_wl_Callback(hObject, eventdata, handles)
% hObject    handle to cb_wl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_wl


% --- Executes on button press in cb_filters.
function cb_filters_Callback(hObject, eventdata, handles)
% hObject    handle to cb_filters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    % Hint: get(hObject,'Value') returns toggle state of cb_filters
    FiltersEnable = get(handles.cb_filters,'Value');
    
    % Get connection object
    if isfield(handles,'obj')
        obj = handles.obj;
    else
        set(handles.t_msg,'String','No connection obj found');   
        return;
    end
    % Open the connection
    fopen(obj);

    % Set up the filters enable
    fwrite(obj,'H','char');
    replay = char(fread(obj,1,'char'));
    if strcmp(replay,'H')
        fwrite(obj,FiltersEnable,'char');
        replay = char(fread(obj,1,'char'));
        if strcmp(replay,'H');
            if(FiltersEnable)
                set(handles.t_msg,'String','Filters enabled');
            else
                set(handles.t_msg,'String','Filters disabled');
            end
        else
            set(handles.t_msg,'String','Error Setting Filters enable'); 
            fclose(obj);
            return
        end
    else
        set(handles.t_msg,'String','Error Setting Filters enable'); 
        fclose(obj);
        return
    end
    
    fclose(obj);


% --- Executes on button press in cb_combEnable.
function cb_combEnable_Callback(hObject, eventdata, handles)
% hObject    handle to cb_combEnable (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_combEnable
% Hint: get(hObject,'Value') returns toggle state of cb_filters
    



function et_combOrder_Callback(hObject, eventdata, handles)
% hObject    handle to et_combOrder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_combOrder as text
%        str2double(get(hObject,'String')) returns contents of et_combOrder as a double


% --- Executes during object creation, after setting all properties.
function et_combOrder_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_combOrder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_combVal1_Callback(hObject, eventdata, handles)
% hObject    handle to et_combVal1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_combVal1 as text
%        str2double(get(hObject,'String')) returns contents of et_combVal1 as a double


% --- Executes during object creation, after setting all properties.
function et_combVal1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_combVal1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_combVal2_Callback(hObject, eventdata, handles)
% hObject    handle to et_combVal2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_combVal2 as text
%        str2double(get(hObject,'String')) returns contents of et_combVal2 as a double


% --- Executes during object creation, after setting all properties.
function et_combVal2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_combVal2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_combVal3_Callback(hObject, eventdata, handles)
% hObject    handle to et_combVal3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_combVal3 as text
%        str2double(get(hObject,'String')) returns contents of et_combVal3 as a double


% --- Executes during object creation, after setting all properties.
function et_combVal3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_combVal3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in pb_combWrite.
function pb_combWrite_Callback(hObject, eventdata, handles)
% hObject    handle to pb_combWrite (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
combEnable = get(handles.cb_combEnable,'Value');

    
combOrder = str2double(get(handles.et_combOrder,'String'));
combVal1 = str2double(get(handles.et_combVal1,'String'));
combVal2 = str2double(get(handles.et_combVal2,'String'));
combVal3 = str2double(get(handles.et_combVal3,'String'));


% Get connection object
if isfield(handles,'obj')
    obj = handles.obj;
else
    set(handles.t_msg,'String','No connection obj found');   
    return;
end
% Open the connection
fopen(obj);

% Set up the filters enable
fwrite(obj,hex2dec('C1'),'char');
reply = char(fread(obj,1,'char'));
if reply == 193 %0xC1
    fwrite(obj,combEnable,'char');
    fwrite(obj,combOrder,'char');
    fwrite(obj,combVal1,'float32');
    fwrite(obj,combVal2,'float32');
    fwrite(obj,combVal3,'float32');
    
    
    reply = char(fread(obj,1,'char'));
    if reply == 193 %0xC1
        if(combEnable)
            set(handles.t_msg,'String','First comb filter enabled and parameters set');          
        else
            set(handles.t_msg,'String','Comb filter disabled');
        end
    else
        set(handles.t_msg,'String','Error Setting Comb Filter'); 
        fclose(obj);
        return
    end
else
    set(handles.t_msg,'String','Error Setting Filters enable'); 
    fclose(obj);
    return
end

fclose(obj);

% --- Executes on button press in pc_combRead.
function pc_combRead_Callback(hObject, eventdata, handles)
% hObject    handle to pc_combRead (see GCBO)
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
fwrite(obj,hex2dec('C2'),'char');
reply = char(fread(obj,1,'char'));
if reply == 194 %0xC2
    combEnabled = fread(obj,1,'char');
    combOrder = fread(obj,1,'char');
    combVal1 = fread(obj,1,'float32');
    combVal2 = fread(obj,1,'float32');
    combVal3 = fread(obj,1,'float32');
    
    
    if reply == 194 %0xC2
        status = sprintf('Comb\nFilter Enabled = %d\nFilter order = %u\nFilter Value 1 = %f\nFilter Value 2 = %f\nFilter Value 3 %f\n\n', ...
            combEnabled, combOrder, combVal1, combVal2, combVal3);
        msgbox(status,'System Status')
    else
        set(handles.t_msg,'String','Error Setting Comb Filter'); 
        fclose(obj);
        return
    end

else
    set(handles.t_msg,'String','Error, device is not responding or COM port is changed!');        
end

fclose(obj);


% --- Executes on button press in pb_readCompression.
function pb_readCompression_Callback(hObject, eventdata, handles)
% hObject    handle to pb_readCompression (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pb_writeCompression.
function pb_writeCompression_Callback(hObject, eventdata, handles)
% hObject    handle to pb_writeCompression (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Get connection object
compressData = get(handles.cb_Compression,'Value');

if isfield(handles,'obj')
    obj = handles.obj;
else
    set(handles.t_msg,'String','No connection obj found');   
    return;
end
% Open the connection
fopen(obj);

fwrite(obj,'b','char')
replay = char(fread(obj,1,'char'));
if strcmp(replay,'b')
    fwrite(obj,compressData,'char');
    replay = char(fread(obj,1,'char'));
    if strcmp(replay,'b');
        set(handles.t_msg,'String','Compression Flag Set');
    else
        set(handles.t_msg,'String','Error Setting Compression Flag'); 
        fclose(obj);
        return
    end
else
    set(handles.t_msg,'String','Error Setting Compression Flag'); 
    fclose(obj);
    return
end


% --- Executes on button press in cb_Compression.
function cb_Compression_Callback(hObject, eventdata, handles)
% hObject    handle to cb_Compression (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_Compression
