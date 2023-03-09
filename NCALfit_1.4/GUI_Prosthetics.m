function varargout = GUI_Prosthetics(varargin)
% GUI_PROSTHETICS MATLAB code for GUI_Prosthetics.fig
%      GUI_PROSTHETICS, by itself, creates a new GUI_PROSTHETICS or raises the existing
%      singleton*.
%
%      H = GUI_PROSTHETICS returns the handle to a new GUI_PROSTHETICS or the handle to
%      the existing singleton*.
%
%      GUI_PROSTHETICS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_PROSTHETICS.M with the given input arguments.
%
%      GUI_PROSTHETICS('Property','Value',...) creates a new GUI_PROSTHETICS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_Prosthetics_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_Prosthetics_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_Prosthetics

% Last Modified by GUIDE v2.5 23-Jun-2020 20:21:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_Prosthetics_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_Prosthetics_OutputFcn, ...
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


% --- Executes just before GUI_Prosthetics is made visible.
function GUI_Prosthetics_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_Prosthetics (see VARARGIN)

% Choose default command line output for GUI_Prosthetics
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

% UIWAIT makes GUI_Prosthetics wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_Prosthetics_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function et_maxH_Callback(hObject, eventdata, handles)
% hObject    handle to et_maxH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_maxH as text
%        str2double(get(hObject,'String')) returns contents of et_maxH as a double


% --- Executes during object creation, after setting all properties.
function et_maxH_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_maxH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function et_sens_Callback(hObject, eventdata, handles)
% hObject    handle to et_sens (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_sens as text
%        str2double(get(hObject,'String')) returns contents of et_sens as a double


% --- Executes during object creation, after setting all properties.
function et_sens_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_sens (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function et_minH_Callback(hObject, eventdata, handles)
% hObject    handle to et_minH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function et_minH_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_minH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


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
    

function eT_samples_Callback(hObject, eventdata, handles)
% hObject    handle to eT_samples (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


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


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pm_control.
function pm_control_Callback(hObject, eventdata, handles)
% hObject    handle to pm_control (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    menu = get(handles.pm_control,'string');
    menu = menu{get(handles.pm_control,'Value')}; 
    switch menu
        case 'select control algorithm'
            algorithm.mode = 0; % None
        case 'Majority Vote'
            algorithm.mode = 1; % MV
            prompt = {'Majority-Vote Steps:'};
            def = {'3'};
            % Ask for parameters
            dlg_title = 'Post-Algorithm Parameters';
            num_lines = 1;
            answer = inputdlg(prompt,dlg_title,num_lines,def);
            if size(answer,1) == 0
                return
            end
            algorithm.param(1) = str2num(char(answer(1)));
        case 'Ramp'
            algorithm.mode = 2; % RAMP
            prompt = {'Ramp Length','Proportional?'};
            def = {'5','1'};
            % Ask for parameters
            dlg_title = 'Post-Algorithm Parameters';
            num_lines = 1;
            answer = inputdlg(prompt,dlg_title,num_lines,def);
            if size(answer,1) == 0
                return
            end
            algorithm.param(1) = str2num(char(answer(1)));  
            algorithm.param(2) = str2num(char(answer(2)));
        case 'Delicate Grasp'
            algorithm.mode = 3; % DELICATE GRASP
            prompt = {'Enable','Threshold'};
            def = {'1','35'};
            % Ask for parameters
            dlg_title = 'Post-Algorithm Parameters';
            num_lines = 1;
            answer = inputdlg(prompt,dlg_title,num_lines,def);
            if size(answer,1) == 0
                return
            end
            algorithm.param(1) = str2num(char(answer(1)));  
            algorithm.param(2) = str2num(char(answer(2))); 
        case 'Inertial'
            algorithm.mode = 4; % RAMP
            prompt = {'Inertial Coef Hand', 'Inertial Coef Wrist', 'Inertial Coef Elbow', 'Proportional?'};
            def = {'3','3','3','1'};
            % Ask for parameters
            dlg_title = 'Post-Algorithm Parameters';
            num_lines = 1;
            answer = inputdlg(prompt,dlg_title,num_lines,def);
            if size(answer,1) == 0
                return
            end
            algorithm.param(1) = str2num(char(answer(1)));  
            algorithm.param(2) = str2num(char(answer(2)));
            algorithm.param(3) = str2num(char(answer(3)));  
            algorithm.param(4) = str2num(char(answer(4)));
        otherwise
            set(handles.t_msg,'String','Error, it is not a proper algorithm');
            return
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
    fwrite(obj,'a','char');
    replay = char(fread(obj,1,'char'));
    if strcmp(replay,'a')
        fwrite(obj,algorithm.mode,'char');
        if algorithm.mode ~= 0
            for i = 1:size(algorithm.param,2)
                fwrite(obj,algorithm.param(i),'char');
            end
        end
        replay = char(fread(obj,1,'char'));
        set(handles.t_msg,'String','');
        pause(0.5)
        if strcmp(replay,'a');
            set(handles.t_msg,'String','control algorithm set');
        else
            set(handles.t_msg,'String','Error Setting Control Algorithm'); 
            fclose(obj);
            return
        end
    else
        set(handles.t_msg,'String','Error Setting Control Algorithm'); 
        fclose(obj);
        return
    end
    fclose(obj);


% --- Executes during object creation, after setting all properties.
function pm_control_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pm_control (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pm_movement.
function pm_movement_Callback(hObject, eventdata, handles)
% hObject    handle to pm_movement (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function pm_movement_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pm_movement (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function et_speedMov_Callback(hObject, eventdata, handles)
% hObject    handle to et_speedMov (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function et_speedMov_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_speedMov (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function et_timeMov_Callback(hObject, eventdata, handles)
% hObject    handle to et_timeMov (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function et_timeMov_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_timeMov (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% JZ 
% --- Executes on button press in cb_motorEnable.
function cb_motorEnable_Callback(hObject, eventdata, handles)
% hObject    handle to cb_motorEnable (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    motorsEnable = get(handles.cb_motorEnable,'Value');    
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

    
% --- Executes on button press in pb_executeMov.
function pb_executeMov_Callback(hObject, eventdata, handles)
% hObject    handle to pb_executeMov (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    set(handles.pb_executeMov,'Enable','off');
    speed = str2double(get(handles.et_speedMov,'String'));
    time = str2double(get(handles.et_timeMov,'String'));
    mov = get(handles.pm_movement,'Value') - 1; 
    if mov == 0
        errordlg('Select a movement!');
        return
    end
    % Get connection object
    if isfield(handles,'obj')
        obj = handles.obj;
    else
        set(handles.t_msg,'String','No connection obj found');   
%         return;
    end   
    % Open connection
    if ~strcmp(obj.status,'open')
        fopen(obj);
    end   
    switch mov
        case 1
            % open hand
            SendMotorCommand(obj, 0, 'A', 1, speed);
            pause(time);
            SendMotorCommand(obj, 0, 'R', 1, 0);
        case 2 
            % close hand
            SendMotorCommand(obj, 0, 'A', 0, speed);
            pause(time);  
            SendMotorCommand(obj, 0, 'R', 1, 0);
        case 3
            % pronation
            SendMotorCommand(obj, 0, 'B', 0, speed);
            pause(time);
            SendMotorCommand(obj, 0, 'R', 1, 0);
        case 4
            % supination
            SendMotorCommand(obj, 0, 'B', 1, speed);
            pause(time);
            SendMotorCommand(obj, 0, 'R', 1, 0);
        case 5
            % flex elbow
            SendMotorCommand(obj, 0, 'C', 0, speed);
            pause(time);
            SendMotorCommand(obj, 0, 'R', 1, 0);
        case 6
            % extend elbow
            SendMotorCommand(obj, 0, 'C', 1, speed);
            pause(time);
            SendMotorCommand(obj, 0, 'R', 1, 0);
        case 7 
            % SWITCH
            SendMotorCommand(obj, 0, 'S', 0, 0);  
            pause(time);  
    end
    % Close connection
    fclose(obj);
    %ActivateSP_FixedTime(obj,'B',speed,time);
    set(handles.pb_executeMov,'Enable','on');

    
% --- Executes on button press in pb_Start.
function pb_Start_Callback(hObject, eventdata, handles)
% hObject    handle to pb_Start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    global go; 
    go = 1;
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
    if obj.BytesAvailable > 1
        fread(obj,obj.BytesAvailable,'uint8');    % Read the samples        
    end     
    % Start the Control Test
    fwrite(obj,'L','char');
    fwrite(obj,1,'char'); % dummy writes (compatibility with ALC-D1)
    replay = char(fread(obj,1,'char'));
    if strcmp(replay,'L')
        set(handles.t_msg,'String','Control-Test Start');
    else
        set(handles.t_msg,'String','Error Start'); 
        fclose(obj);
        return
    end
    tic;
    for i = 1:samples
        
        % Read the predicted movement from ALC
        % Movements are hardcoded accordingly to this definition:
        % #define REST 			  		0
        % #define OPENHAND 			  	1
        % #define CLOSEHAND			  	2
        % #define PRONATION            	4
        % #define SUPINATION            8
        % #define FLEXELBOW            16
        % #define EXTENDELBOW          32
        % #define SWITCH1             129
        % #define COCONTRACTION       130
        % Conversion of the ALC output is needed because:
        %  - zero index
        %  - REST is usually the last one in BioPatRec
        movIdx = fread(obj,1,'char');
        activLevel1 = fread(obj,1,'char');
        activLevel2 = fread(obj,1,'char');
        activLevel3 = fread(obj,1,'char');
        
        % Disregard mia hand information
        fread(obj,6,'char');
        
        set(handles.txt_predict,'String',num2str(movIdx));
        set(handles.txt_activLevel1,'String',num2str(activLevel1));
        set(handles.txt_activLevel2,'String',num2str(activLevel2));
        set(handles.txt_activLevel3,'String',num2str(activLevel3));
        movStr = '';
        if bitand(movIdx,1)
            movStr = 'open hand';
        elseif bitand(movIdx,2)
            movStr = 'close hand';
        end
        if bitand(movIdx,4)
            if isempty(movStr)
                movStr = 'pronation';
            else
                movStr = strcat(movStr,' & ',' pronation');
            end
        elseif bitand(movIdx,8)
            if isempty(movStr)
                movStr = 'supination';
            else
                movStr = strcat(movStr,' & ',' supination');
            end
        end
        if bitand(movIdx,16)
            if isempty(movStr)
                movStr = 'flex elbow';
            else
                movStr = strcat(movStr,' & ',' flex elbow');
            end
        elseif bitand(movIdx,32)
            if isempty(movStr)
                movStr = 'extend elbow';
            else
                movStr = strcat(movStr,' & ',' extend elbow');
            end
        end
        set(handles.t_msg,'String',movStr);   
        switch movIdx
            case 0
                set(handles.t_msg,'String','rest');
            case 128
                set(handles.t_msg,'String','majority vote step');
            case 129
                set(handles.t_msg,'String','switch1');
            case 130
                set(handles.t_msg,'String','co-contraction');
            otherwise
                if isempty(movStr)
                    set(handles.t_msg,'String','unkwown value, possible error');
                end
        end
        drawnow;
        outMov(i,:) = [movIdx activLevel1 activLevel2 activLevel3];
        if go == 0
            break;
        end
    end
    toc   
    % Stop the aquisition
    fwrite(obj,'T','char');
    % Close connection
    fclose(obj);
    set(handles.pb_stop,'Enable','off');
    go = 0;
    set(handles.t_msg,'String','Control-Test session completed');
    set(handles.txt_predict,'String','');
    set(handles.txt_activLevel1,'String','');
    set(handles.txt_activLevel2,'String','');
    set(handles.txt_activLevel3,'String','');
    save('Control-Output.mat','outMov');                            

   
% --- Executes on button press in pb_stop.
function pb_stop_Callback(hObject, eventdata, handles)
% hObject    handle to pb_stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    global go;
    go = 0;
    
    
% --- Executes on button press in pb_writeSettings.
function pb_writeSettings_Callback(hObject, eventdata, handles)
% hObject    handle to pb_writeSettings (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    % Get connection object
    if isfield(handles,'obj')
        obj = handles.obj;
    else
        set(handles.t_msg,'String','No connection obj found');   
        return;
    end    
    maxH = str2double(get(handles.et_maxH,'String'));
    minH = str2double(get(handles.et_minH,'String'));
    maxW = str2double(get(handles.et_maxW,'String'));
    minW = str2double(get(handles.et_minW,'String'));
    maxE = str2double(get(handles.et_maxE,'String'));
    minE = str2double(get(handles.et_minE,'String'));
    
    if maxH>100 || maxW>100 || maxE>100
        errordlg('HWrong maximum value! Please insert a value below 100')
        return
    end
    if minH<0 || minW<0 || minW<0
        errordlg('Wrong minimum value! Please insert a positive value')
        return
    end
    if maxH<minH || maxW<minW || maxE<minE
        errordlg('Wrong selection of maximum and minimum! Please insert correct values')
        return
    end   
    sensitivity = str2double(get(handles.et_sens,'String'));
    pauseFlag = str2double(get(handles.et_pauseFlag,'String'));
    % Open the connection
    fopen(obj);
    % Write new settings 
    fwrite(obj,'D','char');
    replay = char(fread(obj,1,'char'));
    if strcmp(replay,'D')
        fwrite(obj,sensitivity,'float32');
        fwrite(obj,minH,'char');
        fwrite(obj,maxH,'char');
        fwrite(obj,minW,'char');
        fwrite(obj,maxW,'char');
        fwrite(obj,minE,'char');
        fwrite(obj,maxE,'char');
        fwrite(obj,pauseFlag,'char');
        replay = char(fread(obj,1,'char'));
        set(handles.t_msg,'String','');
        pause(0.5)
        if strcmp(replay,'D');
            set(handles.t_msg,'String','Settings written correctly');
        else
            set(handles.t_msg,'String','Error writing the settings'); 
            fclose(obj);
            return
        end
    else
        set(handles.t_msg,'String','Error writing the settings'); 
        fclose(obj);
        return
    end 
    fclose(obj);


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
    % read settings
    fwrite(obj,hex2dec('21'),'char');
    replay = fread(obj,1,'char');
    if replay == hex2dec('21')
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
        if replay == hex2dec('21')
            status = sprintf('Sensor-Hand = %s\nMotors = %s\nPost-Control-Algorithm = %s\nramp length = %d\nramp mode = %d\nHand Inertia = %d\nWrist Inertia = %d\nElbow Inertia = %d\nmajority vote steps = %d\ndelicate grasp = %d\ndelicate grasp threshold = %d\nsensitivity = %d\nhand minimum speed = %d\nhand maximum speed = %d\nHand control mode = %s\nwrist minimum speed = %d\nwrist maximum speed = %d\nelbow minimum speed = %d\nelbow maximum speed = %d\nLock/unlock pause counter = %d', SH, enableM, PC, rampLength, rampMode, handInertia, wristInertia, elbowInertia, mvSteps, delicateGrasp, delicateGraspThreshold, sensitivity, minH, maxH, handCtrlMd, minW, maxW, minE, maxE, pauseCounter);
            msgbox(status,'System Status')       
            set(handles.et_maxH,'String',num2str(maxH));
            set(handles.et_minH,'String',num2str(minH));
            set(handles.et_maxW,'String',num2str(maxW));
            set(handles.et_minW,'String',num2str(minW));
            set(handles.et_maxE,'String',num2str(maxE));
            set(handles.et_minE,'String',num2str(minE));
            set(handles.cb_analogicControl,'Value',handControlMode);
            set(handles.et_sens,'String',num2str(sensitivity));
            set(handles.et_pauseFlag,'String',num2str(pauseCounter));
        else
            set(handles.t_msg,'String','Error, device is not responding or COM port is changed!'); 
            fclose(obj);
            return
        end
    else
        set(handles.t_msg,'String','Error, device is not responding or COM port is changed!');        
    end
    
    fclose(obj);

%% JZ 
% --- Executes on button press in cb_analogicControl.
function cb_analogicControl_Callback(hObject, eventdata, handles)
% hObject    handle to cb_analogicControl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    handControlMode = get(handles.cb_analogicControl,'Value');    
    % Get connection object
    if isfield(handles,'obj')
        obj = handles.obj;
    else
        set(handles.t_msg,'String','No connection obj found');   
        if handControlMode
            set(handles.cb_analogicControl,'Value',0);
        else
            set(handles.cb_analogicControl,'Value',1);
        end
        return;
    end
    % Open the connection
    fopen(obj);
    % Set up the hand control mode
    fwrite(obj,'E','char');
    replay = char(fread(obj,1,'char'));
    if strcmp(replay,'E')
        fwrite(obj,handControlMode,'char');
        replay = char(fread(obj,1,'char'));
        if strcmp(replay,'E')
            if(handControlMode)
                set(handles.t_msg,'String','ANALOGIC hand control mode enabled');
            else
                set(handles.t_msg,'String','DIGITAL hand control mode enabled');
            end
        else
            set(handles.t_msg,'String','Error Setting hand control mode'); 
            fclose(obj);
            return
        end
    else
        set(handles.t_msg,'String','Error Setting Motors enable'); 
        fclose(obj);
        return
    end 
    fclose(obj);



function et_maxW_Callback(hObject, eventdata, handles)
% hObject    handle to et_maxW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_maxW as text
%        str2double(get(hObject,'String')) returns contents of et_maxW as a double


% --- Executes during object creation, after setting all properties.
function et_maxW_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_maxW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_minW_Callback(hObject, eventdata, handles)
% hObject    handle to et_minW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_minW as text
%        str2double(get(hObject,'String')) returns contents of et_minW as a double


% --- Executes during object creation, after setting all properties.
function et_minW_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_minW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_maxE_Callback(hObject, eventdata, handles)
% hObject    handle to et_maxE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_maxE as text
%        str2double(get(hObject,'String')) returns contents of et_maxE as a double


% --- Executes during object creation, after setting all properties.
function et_maxE_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_maxE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_minE_Callback(hObject, eventdata, handles)
% hObject    handle to et_minE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_minE as text
%        str2double(get(hObject,'String')) returns contents of et_minE as a double


% --- Executes during object creation, after setting all properties.
function et_minE_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_minE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_pauseFlag_Callback(hObject, eventdata, handles)
% hObject    handle to et_pauseFlag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_pauseFlag as text
%        str2double(get(hObject,'String')) returns contents of et_pauseFlag as a double


% --- Executes during object creation, after setting all properties.
function et_pauseFlag_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_pauseFlag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pb_miaHand.
function pb_miaHand_Callback(hObject, eventdata, handles)
% hObject    handle to pb_miaHand (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
prompt = {'Grasp Mode: 1-Position, 2-Speed, 3-Unidirection speed', '[y]*Strength/[x] (Numerator)', 'Strength/[x] (50 = on/off, 1 = 100 buckets)', 'Grasp Enable On/Off', 'Speed/Force enable'};
def = {'1','3','10', '1', '1'};
% Ask for parameters
dlg_title = 'Mia-Hand Settings';
num_lines = 1;
answer = inputdlg(prompt,dlg_title,num_lines,def);
if size(answer,1) == 0
    return
end
MIAHand(1) = str2num(char(answer(1)));
MIAHand(2) = str2num(char(answer(2)));
MIAHand(3) = str2num(char(answer(3)));
MIAHand(4) = str2num(char(answer(4)));
MIAHand(5) = str2num(char(answer(5)));

%send MIAHand settings
if isfield(handles,'obj')
    obj = handles.obj;
else
    set(handles.t_msg,'String','No connection obj found');
    return;
end
% Open the connection
fopen(obj);
% Start send
fwrite(obj,'J','char');
replay = fread(obj,1,'char');
if replay == ('J')
    for i = 1:size(MIAHand,2)
        fwrite(obj,MIAHand(i),'char');
    end
end
replay = fread(obj,1,'char');
if strcmp(char(replay),'J')
    set(handles.t_msg,'String','Mia Hand settings sent succesfully');
else
    set(handles.t_msg,'String','Error, device is not responding or COM port is changed!');
end
fclose(obj);
