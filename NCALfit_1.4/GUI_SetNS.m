function varargout = GUI_SetNS(varargin)
% GUI_SETNS MATLAB code for GUI_SetNS.fig
%      GUI_SETNS, by itself, creates a new GUI_SETNS or raises the existing
%      singleton*.
%
%      H = GUI_SETNS returns the handle to a new GUI_SETNS or the handle to
%      the existing singleton*.
%
%      GUI_SETNS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_SETNS.M with the given input arguments.
%
%      GUI_SETNS('Property','Value',...) creates a new GUI_SETNS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_SetNS_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_SetNS_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_SetNS

% Last Modified by GUIDE v2.5 23-Oct-2019 17:14:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_SetNS_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_SetNS_OutputFcn, ...
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


% --- Executes just before GUI_SetNS is made visible.
function GUI_SetNS_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_SetNS (see VARARGIN)

% Choose default command line output for GUI_SetNS
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

% UIWAIT makes GUI_SetNS wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_SetNS_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in cb_ch1.
function cb_ch1_Callback(hObject, eventdata, handles)
% hObject    handle to cb_ch1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_ch1


% --- Executes on button press in cb_ch2.
function cb_ch2_Callback(hObject, eventdata, handles)
% hObject    handle to cb_ch2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_ch2


% --- Executes on button press in cb_ch3.
function cb_ch3_Callback(hObject, eventdata, handles)
% hObject    handle to cb_ch3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_ch3



function et_amp_Callback(hObject, eventdata, handles)
% hObject    handle to et_amp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_amp as text
%        str2double(get(hObject,'String')) returns contents of et_amp as a double


% --- Executes during object creation, after setting all properties.
function et_amp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_amp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_pw_Callback(hObject, eventdata, handles)
% hObject    handle to et_pw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_pw as text
%        str2double(get(hObject,'String')) returns contents of et_pw as a double


% --- Executes during object creation, after setting all properties.
function et_pw_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_pw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_freq_Callback(hObject, eventdata, handles)
% hObject    handle to et_freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_freq as text
%        str2double(get(hObject,'String')) returns contents of et_freq as a double


% --- Executes during object creation, after setting all properties.
function et_freq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_freq (see GCBO)
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
    
    
% --- Executes on button press in pb_send.
function pb_send_Callback(hObject, eventdata, handles)
% hObject    handle to pb_send (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    amplitude = str2double(get(handles.et_amp,'String'))/10;
    pulseWidth = str2double(get(handles.et_pw,'String'))/10;
    frequency = str2double(get(handles.et_freq,'String'));
    pulses = str2double(get(handles.et_pulses,'String'));
    
    % selected channel
    chs = [];
    for i = 1 : 16
        chs(i) = get(eval(strcat('handles.cb_',num2str(i))),'Value');
    end
    nCh = size(find(chs==1),2);
    if(nCh == 0)
        set(handles.t_msg,'String','Select a channel!');
        return
    end
    if(nCh > 1)
        set(handles.t_msg,'String','Select ONLY one channel!');
        return
    end
    channel = find(chs==1) - 1;
    
    % Get connection object
    if isfield(handles,'obj')
        obj = handles.obj;
    else
        set(handles.t_msg,'String','No connection obj found');   
        return;
    end
    % Open the connection
    fopen(obj); 
    fwrite(obj,hex2dec('B0'),'char');
    fwrite(obj,channel,'char');
    fwrite(obj,amplitude,'char');
    fwrite(obj,pulseWidth,'char');
    fwrite(obj,frequency,'char');
    fwrite(obj,pulses,'char');   
    answer = fread(obj,1,'char');
    replay = fread(obj,1,'char');
    set(handles.t_msg,'String',' '); 
    pause(0.3);
    if replay == 176 %0xB0
        switch answer
            case hex2dec('AA')
                set(handles.t_msg,'String','ACK_OK'); 
            case hex2dec('81')
                set(handles.t_msg,'String','WRONG_CMD_OPCODE');
            case hex2dec('82')
                set(handles.t_msg,'String','WRONG_CHECKSUM');
            case hex2dec('83')
                set(handles.t_msg,'String','WRONG_CMD_STRUCTURE');
            case hex2dec('85')
                set(handles.t_msg,'String','STIM_ONGOING');
            case hex2dec('86')
                set(handles.t_msg,'String','PARAM_OUT_OF_RANGE'); 
            case hex2dec('87')
                set(handles.t_msg,'String','STIM_CHARGE_TOO_HIGH');  
            case hex2dec('88')
                set(handles.t_msg,'String','STIM_SATURATED');
            case hex2dec('89')
                set(handles.t_msg,'String','STIM_TEST');
            case hex2dec('90')
                set(handles.t_msg,'String','STIM_TIMEOUT');
            otherwise
               set(handles.t_msg,'String','Not known answer! probably error');
        end
    else
        set(handles.t_msg,'String','Communication Error'); 
        fclose(obj);
        return
    end
    fclose(obj);


function et_pulses_Callback(hObject, eventdata, handles)
% hObject    handle to et_pulses (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_pulses as text
%        str2double(get(hObject,'String')) returns contents of et_pulses as a double


% --- Executes during object creation, after setting all properties.
function et_pulses_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_pulses (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function menuALCD_Callback(hObject, eventdata, handles)
% hObject    handle to menuALCD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in cb_enableNS.
function cb_enableNS_Callback(hObject, eventdata, handles)
% hObject    handle to cb_enableNS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    enableNS = get(handles.cb_enableNS,'Value');
    % Get connection object
    if isfield(handles,'obj')
        obj = handles.obj;
    else
        set(handles.t_msg,'String','No connection obj found'); 
        if enableNS
            set(handles.cb_enableNS,'Value',0);
        else
            set(handles.cb_enableNS,'Value',1);
        end
        return;
    end
    % Open the connection
    fopen(obj);
    % Set up the filters enable
    fwrite(obj,hex2dec('B3'),'char');
    replay = fread(obj,1,'char');
    if replay == hex2dec('B3')
        fwrite(obj,enableNS,'char');
        replay = fread(obj,1,'char');
        if replay == hex2dec('B3')
            if(enableNS)
                set(handles.t_msg,'String','Neurostimulator enabled');
            else
                set(handles.t_msg,'String','Neurostimulator disabled');
            end
        else
            set(handles.t_msg,'String','Error Setting Neurostimulator enable'); 
            fclose(obj);
            return
        end
    else
        set(handles.t_msg,'String','Error Setting Neurostimulator enable'); 
        fclose(obj);
        return
    end   
    fclose(obj);


% --- Executes on button press in cb_1.
function cb_1_Callback(hObject, eventdata, handles)
% hObject    handle to cb_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_1


% --- Executes on button press in cb_9.
function cb_9_Callback(hObject, eventdata, handles)
% hObject    handle to cb_9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_9


% --- Executes on button press in cb_2.
function cb_2_Callback(hObject, eventdata, handles)
% hObject    handle to cb_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_2


% --- Executes on button press in cb_10.
function cb_10_Callback(hObject, eventdata, handles)
% hObject    handle to cb_10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_10


% --- Executes on button press in cb_3.
function cb_3_Callback(hObject, eventdata, handles)
% hObject    handle to cb_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_3


% --- Executes on button press in cb_11.
function cb_11_Callback(hObject, eventdata, handles)
% hObject    handle to cb_11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_11


% --- Executes on button press in cb_4.
function cb_4_Callback(hObject, eventdata, handles)
% hObject    handle to cb_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_4


% --- Executes on button press in cb_12.
function cb_12_Callback(hObject, eventdata, handles)
% hObject    handle to cb_12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_12


% --- Executes on button press in cb_5.
function cb_5_Callback(hObject, eventdata, handles)
% hObject    handle to cb_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_5


% --- Executes on button press in cb_13.
function cb_13_Callback(hObject, eventdata, handles)
% hObject    handle to cb_13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_13


% --- Executes on button press in cb_6.
function cb_6_Callback(hObject, eventdata, handles)
% hObject    handle to cb_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_6


% --- Executes on button press in cb_14.
function cb_14_Callback(hObject, eventdata, handles)
% hObject    handle to cb_14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_14


% --- Executes on button press in cb_7.
function cb_7_Callback(hObject, eventdata, handles)
% hObject    handle to cb_7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_7


% --- Executes on button press in cb_15.
function cb_15_Callback(hObject, eventdata, handles)
% hObject    handle to cb_15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_15


% --- Executes on button press in cb_8.
function cb_8_Callback(hObject, eventdata, handles)
% hObject    handle to cb_8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_8


% --- Executes on button press in cb_16.
function cb_16_Callback(hObject, eventdata, handles)
% hObject    handle to cb_16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_16


% --- Executes on button press in pb_write.
function pb_write_Callback(hObject, eventdata, handles)
% hObject    handle to pb_write (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    % Get connection object
    if isfield(handles,'obj')
        obj = handles.obj;
    else
        set(handles.t_msg,'String','');
        pause(0.5)
        set(handles.t_msg,'String','No connection obj found');   
        return;
    end
    
    % Read stimulation settings from GUI
    mode = get(handles.pm_stimMode,'Value')-1;
    channel = get(handles.pm_stimCh,'Value')-1;  
    amplitude = str2double(get(handles.et_stimAmp,'String'))/10;
    pulseWidth = str2double(get(handles.et_stimPW,'String'))/10;
    frequency = str2double(get(handles.et_stimFreq,'String'));
    pulses = str2double(get(handles.et_stimPulses,'String')); 
    % Read modulation ranges from GUI
    modAmpTop = str2double(get(handles.et_modAmpTop,'String'))/10;
    modAmpLow = str2double(get(handles.et_modAmpLow,'String'))/10;
    modPWTop = str2double(get(handles.et_modPWTop,'String'))/10;
    modPWLow = str2double(get(handles.et_modPWLow,'String'))/10;
    modFreqTop = str2double(get(handles.et_modFreqTop,'String'));
    modFreqLow = str2double(get(handles.et_modFreqLow,'String'));    
    % Read DESC settings from GUI
    DESCenable = get(handles.cb_DESCenable,'Value');
    DESCchannel = get(handles.pm_DESCch,'Value')-1;  
    DESCamplitude = str2double(get(handles.et_DESCamp,'String'))/10;
    DESCpulseWidth = str2double(get(handles.et_DESCpw,'String'))/10;
    DESCfrequency = str2double(get(handles.et_DESCfreq,'String'));
    DESCpulses = str2double(get(handles.et_DESCpulses,'String'));
    DESCatSlips = get(handles.cb_DESCatSlips,'Value');
    
    % Send the settings to the ALC
    fopen(obj); 
    fwrite(obj,hex2dec('B2'),'char');
    reply = fread(obj,1,'char'); % first echo
    % send stim settings
    fwrite(obj,mode,'char');
    fwrite(obj,channel,'char');
    fwrite(obj,amplitude,'char');
    fwrite(obj,pulseWidth,'char');
    fwrite(obj,frequency,'char');
    fwrite(obj,pulses,'char');
    % send mod ranges
    fwrite(obj,modAmpTop,'char');
    fwrite(obj,modAmpLow,'char');
    fwrite(obj,modPWTop,'char');
    fwrite(obj,modPWLow,'char');
    fwrite(obj,modFreqTop,'char');
    fwrite(obj,modFreqLow,'char');
    % send DESC settings
    fwrite(obj,DESCenable,'char');
    fwrite(obj,DESCchannel,'char');
    fwrite(obj,DESCamplitude,'char');
    fwrite(obj,DESCpulseWidth,'char');
    fwrite(obj,DESCfrequency,'char');
    fwrite(obj,DESCpulses,'char'); 
    fwrite(obj,DESCatSlips,'char');
    reply = fread(obj,1,'char'); % confirmation echo
    if reply == 178 %0xB2
        set(handles.t_msg,'String','');
        pause(0.5)
        set(handles.t_msg,'String','Stimulation Parameters written correctly!');
    elseif reply == 134 %0x86
        set(handles.t_msg,'String','');
        pause(0.5)
        set(handles.t_msg,'String','PARAM_OUT_OF_RANGE, settings not saved');
        fclose(obj);
        return
    else
        set(handles.t_msg,'String','');
        pause(0.5)
        set(handles.t_msg,'String','Communication Error'); 
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
        set(handles.t_msg,'String','');
        pause(0.5)
        set(handles.t_msg,'String','No connection obj found');   
        return;
    end
    
    % Read the settings from the ALC
    fopen(obj);
    fwrite(obj,hex2dec('B1'),'char');
    reply = fread(obj,1,'char');
    stimParams.mode = fread(obj,1,'char');
    stimParams.channel = fread(obj,1,'char');
    stimParams.amplitude = fread(obj,1,'char');
    stimParams.pulseWidth = fread(obj,1,'char');
    stimParams.frequency = fread(obj,1,'char');
    stimParams.pulses = fread(obj,1,'char');
    stimParams.modAmpTop = fread(obj,1,'char');
    stimParams.modAmpLow = fread(obj,1,'char');
    stimParams.modPWTop = fread(obj,1,'char');
    stimParams.modPWLow = fread(obj,1,'char');
    stimParams.modFreqTop = fread(obj,1,'char');
    stimParams.modFreqLow = fread(obj,1,'char');
    stimParams.DESCenable = fread(obj,1,'char');
    stimParams.DESCchannel = fread(obj,1,'char');
    stimParams.DESCamplitude = fread(obj,1,'char');
    stimParams.DESCpulseWidth = fread(obj,1,'char');
    stimParams.DESCfrequency = fread(obj,1,'char');
    stimParams.DESCpulses = fread(obj,1,'char');
    stimParams.DESCatSlips = fread(obj,1,'char');
    reply = fread(obj,1,'char');
    if reply == 177 %0xB1
        save('STIM_SETTINGS.mat','stimParams');
        set(handles.t_msg,'String','');
        pause(0.5)
        set(handles.t_msg,'String','Parameters saved on STIM_SETTINGS.mat file'); 
    else
        set(handles.t_msg,'String','');
        pause(0.5)
        set(handles.t_msg,'String','Communication Error'); 
        fclose(obj);
        return
    end
    fclose(obj);
    
    % Update the GUI
    set(handles.pm_stimMode,'Value',stimParams.mode+1);
    set(handles.pm_stimCh,'Value', stimParams.channel+1);  
    set(handles.et_stimAmp,'String', num2str(stimParams.amplitude*10));
    set(handles.et_stimPW,'String', num2str(stimParams.pulseWidth*10));
    set(handles.et_stimFreq,'String', num2str(stimParams.frequency));
    set(handles.et_stimPulses,'String', num2str(stimParams.pulses)); 
    set(handles.et_modAmpTop,'String', num2str(stimParams.modAmpTop*10));
    set(handles.et_modAmpLow,'String', num2str(stimParams.modAmpLow*10));
    set(handles.et_modPWTop,'String', num2str(stimParams.modPWTop*10));
    set(handles.et_modPWLow,'String', num2str(stimParams.modPWLow*10));
    set(handles.et_modFreqTop,'String', num2str(stimParams.modFreqTop));
    set(handles.et_modFreqLow,'String', num2str(stimParams.modFreqLow));
    set(handles.cb_DESCenable,'Value',stimParams.DESCenable);
    set(handles.pm_DESCch,'Value',stimParams.DESCchannel+1);  
    set(handles.et_DESCamp,'String',num2str(stimParams.DESCamplitude*10));
    set(handles.et_DESCpw,'String',num2str(stimParams.DESCpulseWidth*10));
    set(handles.et_DESCfreq,'String', num2str(stimParams.DESCfrequency));
    set(handles.et_DESCpulses,'String', num2str(stimParams.DESCpulses)); 
    set(handles.cb_DESCatSlips,'Value',stimParams.DESCatSlips);
    

% --- Executes on selection change in pm_stimMode.
function pm_stimMode_Callback(hObject, eventdata, handles)
% hObject    handle to pm_stimMode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pm_stimMode contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pm_stimMode


% --- Executes during object creation, after setting all properties.
function pm_stimMode_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pm_stimMode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pm_DESCch.
function pm_DESCch_Callback(hObject, eventdata, handles)
% hObject    handle to pm_DESCch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pm_DESCch contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pm_DESCch


% --- Executes during object creation, after setting all properties.
function pm_DESCch_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pm_DESCch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in cb_DESCenable.
function cb_DESCenable_Callback(hObject, eventdata, handles)
% hObject    handle to cb_DESCenable (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_DESCenable



function et_DESCamp_Callback(hObject, eventdata, handles)
% hObject    handle to et_DESCamp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_DESCamp as text
%        str2double(get(hObject,'String')) returns contents of et_DESCamp as a double


% --- Executes during object creation, after setting all properties.
function et_DESCamp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_DESCamp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_DESCpw_Callback(hObject, eventdata, handles)
% hObject    handle to et_DESCpw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_DESCpw as text
%        str2double(get(hObject,'String')) returns contents of et_DESCpw as a double


% --- Executes during object creation, after setting all properties.
function et_DESCpw_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_DESCpw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_DESCfreq_Callback(hObject, eventdata, handles)
% hObject    handle to et_DESCfreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_DESCfreq as text
%        str2double(get(hObject,'String')) returns contents of et_DESCfreq as a double


% --- Executes during object creation, after setting all properties.
function et_DESCfreq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_DESCfreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_DESCpulses_Callback(hObject, eventdata, handles)
% hObject    handle to et_DESCpulses (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_DESCpulses as text
%        str2double(get(hObject,'String')) returns contents of et_DESCpulses as a double


% --- Executes during object creation, after setting all properties.
function et_DESCpulses_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_DESCpulses (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pm_stimCh.
function pm_stimCh_Callback(hObject, eventdata, handles)
% hObject    handle to pm_stimCh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pm_stimCh contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pm_stimCh


% --- Executes during object creation, after setting all properties.
function pm_stimCh_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pm_stimCh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_stimAmp_Callback(hObject, eventdata, handles)
% hObject    handle to et_stimAmp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_stimAmp as text
%        str2double(get(hObject,'String')) returns contents of et_stimAmp as a double


% --- Executes during object creation, after setting all properties.
function et_stimAmp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_stimAmp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_stimPW_Callback(hObject, eventdata, handles)
% hObject    handle to et_stimPW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_stimPW as text
%        str2double(get(hObject,'String')) returns contents of et_stimPW as a double


% --- Executes during object creation, after setting all properties.
function et_stimPW_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_stimPW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_stimFreq_Callback(hObject, eventdata, handles)
% hObject    handle to et_stimFreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_stimFreq as text
%        str2double(get(hObject,'String')) returns contents of et_stimFreq as a double


% --- Executes during object creation, after setting all properties.
function et_stimFreq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_stimFreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_stimPulses_Callback(hObject, eventdata, handles)
% hObject    handle to et_stimPulses (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_stimPulses as text
%        str2double(get(hObject,'String')) returns contents of et_stimPulses as a double


% --- Executes during object creation, after setting all properties.
function et_stimPulses_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_stimPulses (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_modAmpLow_Callback(hObject, eventdata, handles)
% hObject    handle to et_modAmpLow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_modAmpLow as text
%        str2double(get(hObject,'String')) returns contents of et_modAmpLow as a double


% --- Executes during object creation, after setting all properties.
function et_modAmpLow_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_modAmpLow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_modAmpTop_Callback(hObject, eventdata, handles)
% hObject    handle to et_modAmpTop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_modAmpTop as text
%        str2double(get(hObject,'String')) returns contents of et_modAmpTop as a double


% --- Executes during object creation, after setting all properties.
function et_modAmpTop_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_modAmpTop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_modPWLow_Callback(hObject, eventdata, handles)
% hObject    handle to et_modPWLow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_modPWLow as text
%        str2double(get(hObject,'String')) returns contents of et_modPWLow as a double


% --- Executes during object creation, after setting all properties.
function et_modPWLow_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_modPWLow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_modPWTop_Callback(hObject, eventdata, handles)
% hObject    handle to et_modPWTop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_modPWTop as text
%        str2double(get(hObject,'String')) returns contents of et_modPWTop as a double


% --- Executes during object creation, after setting all properties.
function et_modPWTop_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_modPWTop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_modFreqLow_Callback(hObject, eventdata, handles)
% hObject    handle to et_modFreqLow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_modFreqLow as text
%        str2double(get(hObject,'String')) returns contents of et_modFreqLow as a double


% --- Executes during object creation, after setting all properties.
function et_modFreqLow_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_modFreqLow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_modFreqTop_Callback(hObject, eventdata, handles)
% hObject    handle to et_modFreqTop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_modFreqTop as text
%        str2double(get(hObject,'String')) returns contents of et_modFreqTop as a double


% --- Executes during object creation, after setting all properties.
function et_modFreqTop_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_modFreqTop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in cb_DESCatSlips.
function cb_DESCatSlips_Callback(hObject, eventdata, handles)
% hObject    handle to cb_DESCatSlips (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_DESCatSlips
