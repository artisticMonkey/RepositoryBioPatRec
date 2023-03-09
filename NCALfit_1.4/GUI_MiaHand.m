function varargout = GUI_Prosthetics_MIA(varargin)
% GUI_PROSTHETICS MATLAB code for GUI_Prosthetics_MIA.fig
%      GUI_PROSTHETICS_MIA, by itself, creates a new GUI_PROSTHETICS_MIA or raises the existing
%      singleton*.
%
%      H = GUI_PROSTHETICS_MIA returns the handle to a new GUI_PROSTHETICS_MIA or the handle to
%      the existing singleton*.
%
%      GUI_PROSTHETICS_MIA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_PROSTHETICS_MIA.M with the given input arguments.
%
%      GUI_PROSTHETICS_MIA('Property','Value',...) creates a new GUI_PROSTHETICS_MIA or raises the
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

% Last Modified by GUIDE v2.5 03-Apr-2019 14:19:49

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


function et_max_Callback(hObject, eventdata, handles)
% hObject    handle to et_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_max as text
%        str2double(get(hObject,'String')) returns contents of et_max as a double


% --- Executes during object creation, after setting all properties.
function et_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_max (see GCBO)
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


function et_min_Callback(hObject, eventdata, handles)
% hObject    handle to et_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function et_min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_min (see GCBO)
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
        return;
    end   
    % Open connection
    if ~strcmp(obj.status,'open')
        fopen(obj);
    end   
    switch mov
        case 1
            SendMotorCommand(obj, 0, 'A', 1, speed);
            pause(time);
            SendMotorCommand(obj, 0, 'R', 1, 0);
        case 2   
            SendMotorCommand(obj, 0, 'A', 0, speed);
            pause(time);  
            SendMotorCommand(obj, 0, 'R', 1, 0);
        case 3 % SHP_CYLINDRICAL_GRASP
            SendMotorCommand(obj, 0, 'D', 0, 0);  
            pause(time); 
        case 4 % SHP_BIDIGIT_GRASP
            SendMotorCommand(obj, 0, 'E', 0, 0);  
            pause(time);
        case 5 % SHP_LATERAL_GRASP
            SendMotorCommand(obj, 0, 'F', 0, 0);  
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
    chActivationIndexes = fread(obj,1,'uint32');
    chActivationIndexes = dec2bin(chActivationIndexes,32);
    fwrite(obj,1,'char'); % dummy writes (compatibility with ALC-D1)
    replay = char(fread(obj,1,'char'));
    if strcmp(replay,'L')
        set(handles.t_msg,'String','Control-Test Start');
    else
        set(handles.t_msg,'String','Error Start'); 
        fclose(obj);
        return
    end
%     s0 = plot(handles.a_strengthValues, 0, 0,'.','MarkerSize',20,'color','g');
%     s1 = plot(handles.a_dStep_MAV, 0, 0,'.','MarkerSize',20,'color','g');
%     s2 = plot(handles.a_PWM_MAV, 0, 0,'.','MarkerSize',20,'color','g');
%     s3 = plot(handles.a_Time_dStep, 0, 0,'.','MarkerSize',20,'color','g');
%     s4 = plot(handles.a_Speed_MAV, 0, 0,'.','MarkerSize',20,'color','g');
    s0 = [];
    s1 = [];
    s2 = [];
    s3 = [];
    s4 = [];
    greenSize = 40;
    
    
    
    
    
    tic;
    for i = 1:samples
        % Read the predicted movement from ALC-D
        % Movements are hardcoded accordingly to this definition:
        % #define REST 			  		0
        % #define OPENHAND 			  	1
        % #define CLOSEHAND			  	2
        % #define PRONATION            	3
        % #define SUPINATION            4
        % #define SWITCH1               5
        % Conversion of the ALC-D output is needed because:
        %  - zero index
        %  - REST is usually the last one in BioPatRec
        while(fread(obj,1,'char') ~= '+')
        end
        movIdx = fread(obj,1,'char');   
        activLevel = fread(obj,1,'char'); % MAV
        rtStrength = fread(obj,1,'char'); % Strength
        rtdStep = fread(obj,1,'char');
        rtPWM = fread(obj,1,'char');
        set(handles.txt_predict,'String',num2str(movIdx));
        set(handles.txt_activLevel,'String',num2str(activLevel));
        delete(s0);
        delete(s1);
        delete(s2);
        delete(s3);
        delete(s4);
        closingPeriod = 100*0.05./rtdStep;
        if movIdx ~= 0
            set(handles.txt_dStep,'String',num2str(rtdStep));
            set(handles.txt_PWM,'String',num2str(rtPWM));            
            s0 = plot(handles.a_strengthValues, activLevel, rtStrength,'.','MarkerSize',greenSize,'color','g');
            s1 = plot(handles.a_dStep_MAV, activLevel, rtdStep,'.','MarkerSize',greenSize,'color','g');
            s2 = plot(handles.a_PWM_MAV, activLevel, rtPWM,'.','MarkerSize',greenSize,'color','g');
            s3 = plot(handles.a_Time_dStep, rtdStep, closingPeriod,'.','MarkerSize',greenSize,'color','g');
            s4 = plot(handles.a_Speed_MAV, activLevel, 1/closingPeriod,'.','MarkerSize',greenSize,'color','g');
        else
            set(handles.txt_dStep,'String',num2str(0));
            set(handles.txt_PWM,'String',num2str(0));
            s0 = plot(handles.a_strengthValues, 0, 0,'.','MarkerSize',greenSize,'color','g');
            s1 = plot(handles.a_dStep_MAV, 0, 0,'.','MarkerSize',greenSize,'color','g');
            s2 = plot(handles.a_PWM_MAV, 0, 0,'.','MarkerSize',greenSize,'color','g');
            s3 = plot(handles.a_Time_dStep, 0, 0,'.','MarkerSize',greenSize,'color','g');
            s4 = plot(handles.a_Speed_MAV, 0, 0,'.','MarkerSize',greenSize,'color','g');
        end

        switch movIdx
            case 199
                set(handles.t_msg,'String','majority vote step');
            case 0
                set(handles.t_msg,'String','Rest');
            case 5
                set(handles.t_msg,'String','Open');
            case 3
                set(handles.t_msg,'String','Close');
            case 4
                set(handles.t_msg,'String','Pinch');
            case 2
                set(handles.t_msg,'String','Pronation');
            case 1
                set(handles.t_msg,'String','Supination');
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
        if go == 0
            break;
        end
    end
    toc   
    delete(s0);
    delete(s1);
    delete(s2);
    delete(s3);
    delete(s4);
    % Stop the aquisition
    fwrite(obj,'T','char');
    % Close connection
    fclose(obj);
    set(handles.pb_stop,'Enable','off');
    go = 0;
    set(handles.t_msg,'String','Control-Test session completed');
    set(handles.txt_predict,'String','');
    set(handles.txt_activLevel,'String','');
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
    max = str2double(get(handles.et_max,'String'));
    min = str2double(get(handles.et_min,'String'));
    if max>100
        errordlg('Wrong maximum value! Please insert a value below 100')
        return
    end
    if min<0
        errordlg('Wrong minimum value! Please insert a positive value')
        return
    end
    if max<min
        errordlg('Wrong selection of maximum and minimum! Please insert correct values')
        return
    end   
    sensitivity = str2double(get(handles.et_sens,'String'));
    minModSpeedStep = str2double(get(handles.et_minStep,'String'));
    maxModSpeedStep = str2double(get(handles.et_maxStep,'String'));
    shpPosMinPwm = str2double(get(handles.et_minPWM,'String'));
    shpPosMaxPwm = str2double(get(handles.et_maxPWM,'String'));
    minThresh = str2double(get(handles.et_minThresh,'String'));
    % Open the connection
    fopen(obj);
    % Write new settings 
    fwrite(obj,'D','char');
    replay = char(fread(obj,1,'char'));
    if strcmp(replay,'D')
        fwrite(obj,sensitivity,'float32');
        fwrite(obj,min,'char');
        fwrite(obj,max,'char');
        fwrite(obj,minModSpeedStep,'char');
        fwrite(obj,maxModSpeedStep,'char');
        fwrite(obj,shpPosMinPwm,'char');
        fwrite(obj,shpPosMaxPwm,'char');
        fwrite(obj,minThresh,'char');
        replay = char(fread(obj,1,'char'));
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
    
    %Plot strength trend
    MAV = 1:1:100;
    MAV2=MAV;
    MAV2(MAV<min)=min;
    MAV2(MAV2>max)=max;
    normStrength = (MAV2 - min)./(max - min);
    strength = min + (max - min).*normStrength.^sensitivity;
    cla(handles.a_strengthValues)
    stairs(handles.a_strengthValues, MAV, floor(strength), 'color', [0.6 0.6 0.6],'linewidth',2)
    set(handles.a_strengthValues, 'NextPlot', 'add')
    hold on
    stairs(handles.a_strengthValues, [MAV(1:minThresh) MAV(minThresh:end)], [ones(1,minThresh)*0 floor(strength(minThresh:max)) ones(1,100-max)*floor(strength(max))] ,'color','b','linewidth',2)
    hold on
    stairs(handles.a_strengthValues, MAV(minThresh), floor(strength(minThresh)),'.','MarkerSize',20,'color','r')
    set(handles.a_strengthValues, 'YGrid', 'on')
    set(handles.a_strengthValues, 'XGrid', 'on')
    set(handles.a_strengthValues, 'YMinorGrid', 'on')
    set(handles.a_strengthValues, 'YMinorTick', 'on')
    set(handles.a_strengthValues, 'XMinorGrid', 'on')
    set(handles.a_strengthValues, 'XMinorTick', 'on')
    set(handles.a_strengthValues, 'YLIM',[0 100])
    
    %Plot dStep-MAV
    cla(handles.a_dStep_MAV)
    minStep = str2double(get(handles.et_minStep,'String'));
    maxStep = str2double(get(handles.et_maxStep,'String'));
    dStepMav = (maxStep-minStep).*(floor(strength)-min)./(max - min)+ minStep;
    stairs(handles.a_dStep_MAV, MAV, floor(dStepMav), 'color', [0.6 0.6 0.6],'linewidth',2)
    set(handles.a_dStep_MAV, 'NextPlot', 'add')
    hold on
    stairs(handles.a_dStep_MAV, [MAV(1:minThresh) MAV(minThresh:end)], floor([ones(1,minThresh)*0 dStepMav(minThresh:max) ones(1,100-max)*dStepMav(max)]) ,'color','b','linewidth',2)
    hold on
    plot(handles.a_dStep_MAV, MAV(minThresh), floor(dStepMav(minThresh)),'.','MarkerSize',20,'color','r')
    set(handles.a_dStep_MAV, 'YGrid', 'on')
    set(handles.a_dStep_MAV, 'XGrid', 'on')
    set(handles.a_dStep_MAV, 'YMinorGrid', 'on')
    set(handles.a_dStep_MAV, 'YMinorTick', 'on')
    set(handles.a_dStep_MAV, 'XMinorGrid', 'on')
    set(handles.a_dStep_MAV, 'XMinorTick', 'on')
    set(handles.a_dStep_MAV, 'YLIM',[0 maxStep+2])
  
    %Plot PWM-MAV
    cla(handles.a_PWM_MAV)
    minPWM = str2double(get(handles.et_minPWM,'String'));
    maxPWM = str2double(get(handles.et_maxPWM,'String'));
    dPWM = (maxPWM-minPWM).*(floor(strength)-min)./(max - min)+ minPWM;
    stairs(handles.a_PWM_MAV, MAV, floor(dPWM), 'color', [0.6 0.6 0.6],'linewidth',2)
    set(handles.a_PWM_MAV, 'NextPlot', 'add')
    set(handles.a_PWM_MAV,'XTick',0:20:100)
    hold on
    stairs(handles.a_PWM_MAV, [MAV(1:minThresh) MAV(minThresh:end)], floor([ones(1,minThresh)*0 dPWM(minThresh:max) ones(1,100-max)*dPWM(max)]) ,'color','b','linewidth',2)
    hold on
    plot(handles.a_PWM_MAV, MAV(minThresh), floor(dPWM(minThresh)),'.','MarkerSize',20,'color','r')
    set(handles.a_PWM_MAV, 'YGrid', 'on')
    set(handles.a_PWM_MAV, 'XGrid', 'on')
    set(handles.a_PWM_MAV, 'YMinorGrid', 'on')
    set(handles.a_PWM_MAV, 'YMinorTick', 'on')
    set(handles.a_PWM_MAV, 'XMinorGrid', 'on')
    set(handles.a_PWM_MAV, 'XMinorTick', 'on')
    set(handles.a_PWM_MAV, 'YLIM',[0 100])

    %Plot Time-dStep
    cla(handles.a_Time_dStep)
    closingTime = 100*0.05./floor(dStepMav);
    stairs(handles.a_Time_dStep, floor(dStepMav(minThresh:end)), closingTime(minThresh:end), 'color', [0.6 0.6 0.6],'linewidth',2)
    set(handles.a_Time_dStep, 'NextPlot', 'add')
    hold on
    stairs(handles.a_Time_dStep, floor(dStepMav(minThresh:end)), [closingTime(minThresh:max) ones(1,100-max)*closingTime(max)] ,'color','b','linewidth',2)
    hold on
    plot(handles.a_Time_dStep, floor(dStepMav(minThresh)), (closingTime(minThresh)),'.','MarkerSize',20,'color','r')
    set(handles.a_Time_dStep, 'YGrid', 'on')
    set(handles.a_Time_dStep, 'XGrid', 'on')
    set(handles.a_Time_dStep, 'YMinorGrid', 'on')
    set(handles.a_Time_dStep, 'YMinorTick', 'on')
    set(handles.a_Time_dStep, 'XMinorGrid', 'on')
    set(handles.a_Time_dStep, 'XMinorTick', 'on')
    set(handles.a_Time_dStep, 'YLIM',[0.3 closingTime(minThresh)+0.1])

    %Plot Speed-Mav
    cla(handles.a_Speed_MAV)
    closingSpeed = 1./closingTime;
    stairs(handles.a_Speed_MAV, MAV, closingSpeed, 'color', [0.6 0.6 0.6],'linewidth',2)
    set(handles.a_Speed_MAV, 'NextPlot', 'add')
    set(handles.a_Speed_MAV,'XTick',0:20:100)
    hold on
    stairs(handles.a_Speed_MAV, MAV(minThresh:end), [closingSpeed(minThresh:max) ones(1,100-max)*closingSpeed(max)] ,'color','b','linewidth',2)
    hold on
    plot(handles.a_Speed_MAV, floor(MAV(minThresh)), (closingSpeed(minThresh)),'.','MarkerSize',20,'color','r')
    set(handles.a_Speed_MAV, 'YGrid', 'on')
    set(handles.a_Speed_MAV, 'XGrid', 'on')
    set(handles.a_Speed_MAV, 'YMinorGrid', 'on')
    set(handles.a_Speed_MAV, 'YMinorTick', 'on')
    set(handles.a_Speed_MAV, 'XMinorGrid', 'on')
    set(handles.a_Speed_MAV, 'XMinorTick', 'on')
    set(handles.a_Speed_MAV, 'YLIM',[0 2.5])


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
        minModSpeedStep = fread(obj,1,'char');
        maxModSpeedStep = fread(obj,1,'char');
        shpPosMinPwm = fread(obj,1,'char');
        shpPosMaxPwm = fread(obj,1,'char');
        minThresh = fread(obj,1,'char');
        stepWidth = fread(obj,1,'char');
        replay = char(fread(obj,1,'char'));
        if replay == hex2dec('21')
            status = sprintf('MIAhand = %s\nMotors = %s\nPost-Control-Algorithm = %s\nramp length = %d\nramp mode = %d\nmajority vote steps = %d\ndelicate grasp = %d\ndelicate grasp threshold = %d', SH, enableM, PC, rampLength, rampMode, mvSteps, delicateGrasp, delicateGraspThreshold);
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
    
    % update GUI with the settings just read
    set(handles.et_max,'String',num2str(max));
    set(handles.et_min,'String',num2str(min));   
    set(handles.et_sens,'String',num2str(sensitivity));
    set(handles.et_minStep,'String',minModSpeedStep);
    set(handles.et_maxStep,'String',maxModSpeedStep);
    set(handles.et_minPWM,'String',shpPosMinPwm);
    set(handles.et_maxPWM,'String',shpPosMaxPwm);
    set(handles.et_minThresh,'String',minThresh);
    
    %Plot strength trend
    MAV = 1:1:100;
    MAV2 = MAV;
    MAV2(MAV<min) = min;
    MAV2(MAV2>max) = max;
    normStrength = (MAV2 - min)./(max - min);
    strength = min + (max - min).*normStrength.^sensitivity;
    cla(handles.a_strengthValues)
    stairs(handles.a_strengthValues, MAV, floor(strength), 'color', [0.6 0.6 0.6],'linewidth',2)
    set(handles.a_strengthValues, 'NextPlot', 'add')
    hold on
    stairs(handles.a_strengthValues, [MAV(1:minThresh) MAV(minThresh:end)], [ones(1,minThresh)*0 floor(strength(minThresh:max)) ones(1,100-max)*floor(strength(max))] ,'color','b','linewidth',2)
    hold on
    stairs(handles.a_strengthValues, MAV(minThresh), floor(strength(minThresh)),'.','MarkerSize',20,'color','r')
    set(handles.a_strengthValues, 'YGrid', 'on')
    set(handles.a_strengthValues, 'XGrid', 'on')
    set(handles.a_strengthValues, 'YMinorGrid', 'on')
    set(handles.a_strengthValues, 'YMinorTick', 'on')
    set(handles.a_strengthValues, 'XMinorGrid', 'on')
    set(handles.a_strengthValues, 'XMinorTick', 'on')
    set(handles.a_strengthValues, 'YLIM',[0 100])
    
    %Plot dStep-MAV
    cla(handles.a_dStep_MAV)
    minStep = str2double(get(handles.et_minStep,'String'));
    maxStep = str2double(get(handles.et_maxStep,'String'));
    dStepMav = (maxStep-minStep).*(floor(strength)-min)./(max - min)+ minStep;
    stairs(handles.a_dStep_MAV, MAV, floor(dStepMav), 'color', [0.6 0.6 0.6],'linewidth',2)
    set(handles.a_dStep_MAV, 'NextPlot', 'add')
    hold on
    stairs(handles.a_dStep_MAV, [MAV(1:minThresh) MAV(minThresh:end)], floor([ones(1,minThresh)*0 dStepMav(minThresh:max) ones(1,100-max)*dStepMav(max)]) ,'color','b','linewidth',2)
    hold on
    plot(handles.a_dStep_MAV, MAV(minThresh), floor(dStepMav(minThresh)),'.','MarkerSize',20,'color','r')
    set(handles.a_dStep_MAV, 'YGrid', 'on')
    set(handles.a_dStep_MAV, 'XGrid', 'on')
    set(handles.a_dStep_MAV, 'YMinorGrid', 'on')
    set(handles.a_dStep_MAV, 'YMinorTick', 'on')
    set(handles.a_dStep_MAV, 'XMinorGrid', 'on')
    set(handles.a_dStep_MAV, 'XMinorTick', 'on')
    set(handles.a_dStep_MAV, 'YLIM',[0 maxStep+2])
      
    %Plot PWM-MAV
    cla(handles.a_PWM_MAV)
    minPWM = str2double(get(handles.et_minPWM,'String'));
    maxPWM = str2double(get(handles.et_maxPWM,'String'));
    dPWM = (maxPWM-minPWM).*(floor(strength)-min)./(max - min)+ minPWM;
    stairs(handles.a_PWM_MAV, MAV, floor(dPWM), 'color', [0.6 0.6 0.6],'linewidth',2)
    set(handles.a_PWM_MAV, 'NextPlot', 'add')
    set(handles.a_PWM_MAV,'XTick',0:20:100)
    hold on
    stairs(handles.a_PWM_MAV, [MAV(1:minThresh) MAV(minThresh:end)], floor([ones(1,minThresh)*0 dPWM(minThresh:max) ones(1,100-max)*dPWM(max)]) ,'color','b','linewidth',2)
    hold on
    plot(handles.a_PWM_MAV, MAV(minThresh), floor(dPWM(minThresh)),'.','MarkerSize',20,'color','r')
    set(handles.a_PWM_MAV, 'YGrid', 'on')
    set(handles.a_PWM_MAV, 'XGrid', 'on')
    set(handles.a_PWM_MAV, 'YMinorGrid', 'on')
    set(handles.a_PWM_MAV, 'YMinorTick', 'on')
    set(handles.a_PWM_MAV, 'XMinorGrid', 'on')
    set(handles.a_PWM_MAV, 'XMinorTick', 'on')
    set(handles.a_PWM_MAV, 'YLIM',[0 100])

    %Plot Time-dStep
    cla(handles.a_Time_dStep)
    closingTime = 100*0.05./floor(dStepMav);
    stairs(handles.a_Time_dStep, floor(dStepMav(minThresh:end)), closingTime(minThresh:end), 'color', [0.6 0.6 0.6],'linewidth',2)
    set(handles.a_Time_dStep, 'NextPlot', 'add')
    hold on
    stairs(handles.a_Time_dStep, floor(dStepMav(minThresh:end)), [closingTime(minThresh:max) ones(1,100-max)*closingTime(max)] ,'color','b','linewidth',2)
    hold on
    plot(handles.a_Time_dStep, floor(dStepMav(minThresh)), (closingTime(minThresh)),'.','MarkerSize',20,'color','r')
    set(handles.a_Time_dStep, 'YGrid', 'on')
    set(handles.a_Time_dStep, 'XGrid', 'on')
    set(handles.a_Time_dStep, 'YMinorGrid', 'on')
    set(handles.a_Time_dStep, 'YMinorTick', 'on')
    set(handles.a_Time_dStep, 'XMinorGrid', 'on')
    set(handles.a_Time_dStep, 'XMinorTick', 'on')
    set(handles.a_Time_dStep, 'YLIM',[0.3 closingTime(minThresh)+0.1])
    
    %Plot Speed-Mav
    cla(handles.a_Speed_MAV)
    closingSpeed = 1./closingTime;
    stairs(handles.a_Speed_MAV, MAV, closingSpeed, 'color', [0.6 0.6 0.6],'linewidth',2)
    set(handles.a_Speed_MAV, 'NextPlot', 'add')
    set(handles.a_Speed_MAV,'XTick',0:20:100)
    hold on
    stairs(handles.a_Speed_MAV, MAV(minThresh:end), [closingSpeed(minThresh:max) ones(1,100-max)*closingSpeed(max)] ,'color','b','linewidth',2)
    hold on
    plot(handles.a_Speed_MAV, floor(MAV(minThresh)), (closingSpeed(minThresh)),'.','MarkerSize',20,'color','r')
    set(handles.a_Speed_MAV, 'YGrid', 'on')
    set(handles.a_Speed_MAV, 'XGrid', 'on')
    set(handles.a_Speed_MAV, 'YMinorGrid', 'on')
    set(handles.a_Speed_MAV, 'YMinorTick', 'on')
    set(handles.a_Speed_MAV, 'XMinorGrid', 'on')
    set(handles.a_Speed_MAV, 'XMinorTick', 'on')
    set(handles.a_Speed_MAV, 'YLIM',[0 2.5])
   

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



function et_minThresh_Callback(hObject, eventdata, handles)
% hObject    handle to et_minThresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_minThresh as text
%        str2double(get(hObject,'String')) returns contents of et_minThresh as a double


% --- Executes during object creation, after setting all properties.
function et_minThresh_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_minThresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_minStep_Callback(hObject, eventdata, handles)
% hObject    handle to et_minStep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_minStep as text
%        str2double(get(hObject,'String')) returns contents of et_minStep as a double


% --- Executes during object creation, after setting all properties.
function et_minStep_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_minStep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_maxStep_Callback(hObject, eventdata, handles)
% hObject    handle to et_maxStep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_maxStep as text
%        str2double(get(hObject,'String')) returns contents of et_maxStep as a double


% --- Executes during object creation, after setting all properties.
function et_maxStep_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_maxStep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_minPWM_Callback(hObject, eventdata, handles)
% hObject    handle to et_minPWM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_minPWM as text
%        str2double(get(hObject,'String')) returns contents of et_minPWM as a double


% --- Executes during object creation, after setting all properties.
function et_minPWM_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_minPWM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_maxPWM_Callback(hObject, eventdata, handles)
% hObject    handle to et_maxPWM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_maxPWM as text
%        str2double(get(hObject,'String')) returns contents of et_maxPWM as a double


% --- Executes during object creation, after setting all properties.
function et_maxPWM_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_maxPWM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit19_Callback(hObject, eventdata, handles)
% hObject    handle to et_minThresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_minThresh as text
%        str2double(get(hObject,'String')) returns contents of et_minThresh as a double


% --- Executes during object creation, after setting all properties.
function edit19_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_minThresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
