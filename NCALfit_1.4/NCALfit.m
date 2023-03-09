function varargout = NCALfit(varargin)
% NCALFIT MATLAB code for NCALfit.fig
%      NCALFIT, by itself, creates a new NCALFIT or raises the existing
%      singleton*.
%
%      H = NCALFIT returns the handle to a new NCALFIT or the handle to
%      the existing singleton*.
%
%      NCALFIT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NCALFIT.M with the given input arguments.
%
%      NCALFIT('Property','Value',...) creates a new NCALFIT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before NCALfit_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to NCALfit_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help NCALfit


% Last Modified by GUIDE v2.5 17-Feb-2023 11:26:28

 %#ok<*INUSL,*DEFNU,*INUSD,*NASGU,*FREAD> 

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @NCALfit_OpeningFcn, ...
                   'gui_OutputFcn',  @NCALfit_OutputFcn, ...
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


%% --- Executes just before NCALfit is made visible.
function NCALfit_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to NCALfit (see VARARGIN)

% Choose default command line output for NCALfit
handles.output = hObject;

% refresh_image = imread('refresh.jpg');
% set(handles.pb_refresh,'CData',refresh_image);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes NCALfit wait for user response (see UIRESUME)
% uiwait(handles.figure1);


%% --- Outputs from this function are returned to the command line.
function varargout = NCALfit_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


%% --- Executes on button press in pb_start.
function pb_start_Callback(hObject, eventdata, handles)
    global go;
    go = 1;
    
    % Get connection object
    if isfield(handles,'obj')
        obj = handles.obj;
    else
        set(handles.t_msg,'String','No connection obj found');   
        return;
    end
    set(handles.pb_stop,'Enable','on');
    
        
    % ----------------------------------
%     W = evalin('base','whos');
%     tgExist = ismember('tg',[W(:).name]);
%     if(tgExist)
%         tg = evalin('base', 'tg');
%         tg.start
%     end
%     
    % ----------------------------------
    
    % Open the connection
    fopen(obj);
    % Read available data and discard it
    if obj.BytesAvailable > 0
        fread(obj,obj.BytesAvailable,'uint8');    % Read the samples        
    end
    
    %find the sampling frequency in use
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
            %status = sprintf('Sampling Frequency is use = %d Hz', sF);
            %msgbox(status,'System Status');
        else
            set(handles.t_msg,'String','Error, device is not responding or COM port is changed!'); 
            fclose(obj);
            return
        end
    else
        set(handles.t_msg,'String','Error, device is not responding or COM port is changed!');   
        fclose(obj);
        return
    end
    handles.sF = sF;
    tW = 0.2;
    sT = max( tW,str2double(get(handles.et_sT,'String')) ); %ensure minimum of 1 time window is recorded
    
    % read recording settings
    try
        fwrite(obj,hex2dec('22'),'char');
        replay = fread(obj,1,'char');
        assert(replay == hex2dec('22'),'STATUS_REC_SETTINGS not working');
        
        fread(obj,1,'uint8'); %nChannels
        fread(obj,1,'uint8'); %chIdxExtra
        fread(obj,1,'uint8'); %chIdxUpper
        fread(obj,1,'uint8'); %chIdxLower
        nFeatures = fread(obj,1,'uint8'); %ActiveFeatures
        fread(obj,5,'uint8'); %featuresEnabled
        fread(obj,1,'uint32'); %timeWindowSamples
        fread(obj,1,'uint32'); %overlappingSamples
        fread(obj,1,'uint32'); %samplingFrequency
        compressionEnabled = fread(obj,1,'uint8'); %compressionEnable
        fread(obj,1,'uint8'); %featureCombinationEnable
        fread(obj,1,'uint8'); %handInUse
       
        % Final confirmation Byte
        rsp = fread(obj,1,'uint8');
        assert(rsp == hex2dec('22'),'STATUS_REC_SETTINGS not working');
    catch exception
        set(handles.t_msg,'String','Error, device is not responding or COM port is changed!');
        fclose(obj);
        return
    end

    %Selected channels
    allCh = str2double(get(handles.lb_ch,'String'))-1;
    vCh = allCh(get(handles.lb_ch,'Value'))+1; % Vector of channels
    nCh = size(vCh,1);
    chIdxDiff = bitshift(sum(bitset(0,vCh)),-16); %extra channels 17-24
    chIdxUpper = bitshift(sum(bitset(0,vCh)),-8);
    chIdxUpper = bitand(chIdxUpper,255); %upper channels 9-16
    chIdxLower = bitand(sum(bitset(0,vCh)),255); %lower channels 1-8
       
    % Setting for data peeking
    tv = 0:1/sF:tW-1/sF;                                                   % Create vector of time
    tWs = tW*sF;                                                           % Time window samples
    sData = zeros(tWs,nCh);                                                % tWs sized matrix useful for real time plot
    allData = zeros(sT*sF, nCh);                                           % sT*sF sized matrix used for keep all datas
    
    plotGain = 10000000;
    
    % Offset the plot of the different channels to fit into the main figure
    ampPP     = 5;
    offVector = 0:nCh-1;
    offVector = offVector .* ampPP;
    for i = 1 : nCh
        sData(:,i) = sData(:,i) + offVector(i);
    end    
    
    % Draw figure
    p_t0 = plot(handles.a_t0, tv, sData);
    xlim([0,tW]);  
    set(handles.a_t0,'YTick',offVector);
    set(handles.a_t0,'YTickLabel',vCh);
    set(handles.a_t0,'YLim',[-0.75,nCh-0.25]*ampPP);

    sData = zeros(tWs, nCh);                                               % tWs sized vector used for offset and plot datas
    printFlag = 1; 

    % Start the acquisition
    fwrite(obj,'G','char');
    fwrite(obj,chIdxDiff,'uint8');
    fwrite(obj,chIdxUpper,'uint8');
    fwrite(obj,chIdxLower,'uint8');
    fwrite(obj,nCh,'uint8');
    reply = char(fread(obj,1,'char'));
    switch reply
        case 'G'
            set(handles.t_msg,'String','EMG Start');
    end
    
    tic;
    for i = 1:sT*sF  
        % Set warnings to temporarily issue error (exceptions)
        s = warning('error', 'instrument:fread:unsuccessfulRead');
        try
            if compressionEnabled
                % compressed int16 data mode (2bytes X nCh channels)
                tmpData = fread(obj,nCh,'int16');
                byteData = DecompressData(tmpData);
            else
                % float data mode (4bytes X nCh channels)
                byteData = fread(obj,nCh,'float32');    
            end
            allData(i,:) = byteData(1:nCh,:)';
            sData(printFlag,:) = byteData(1:nCh,:)';
        catch exception
           set(handles.t_msg,'String','Error in communication'); 
           fclose(obj);
           return
        end
        %Set warning back to normal state
        warning(s);
        
        printFlag = printFlag + 1; 
        if printFlag >= tWs+1 
            
            % calculate single channel's plot gain for time window
            % the idea is that the gain is automatically scaled depending on the absolute maximum
            % value found in this new recording. In this way the gain will be changed
            % dynamically to be able to discern a "rest" from a "contraction" plot
            K = ampPP/(2*(max(max(abs(sData)))));
            if K < plotGain
                % if the signals in the different windows is getting bigger the gain
                % must be reduced consequently, the channels plots must always fit
                % the main plot
                plotGain = K;
            end
            mu = mean(sData);
            % plot a new tWs sized window
            for j = 1 : nCh
                set(p_t0(j),'YData',(sData(:,j)-mu(j))*plotGain + offVector(j));       % add offsets to plot channels in same graph
            end 
            printFlag = 1;
            drawnow 
        end 
        
        if go == 0
            break;
        end
        
    end
    
    toc;
    
    % Stop the aquisition
    fwrite(obj,'T','char');
    
    % Close connection
    fclose(obj);
    set(handles.pb_stop,'Enable','off');
    go = 0;
    disp(obj);
    
    % Print the data    
    tv = 0:1/sF:sT-1/sF;                                                   % Create vector of time
    mu = mean(allData);
    for i = 1:sT*sF 
        for k = 1:nCh        
            sData(i,k) = (allData(i,k)-mu(k))*plotGain + offVector(k);
        end 
    end
    plot(tv, sData);
    set(handles.a_t0,'YTick',offVector);
    set(handles.a_t0,'YTickLabel',vCh); 
    set(handles.a_t0,'YLim',[-0.75,nCh-0.25]*ampPP);

%     if get(handles.cb_FFT,'Value');
%         % Plot FFT of acquired signals
%         nS = length(sData(:,1));     
%         nS = 2^nextpow2(nS);               % Find next power of 2
%         X = fft(sData,nS);
%         spectra2side = abs(X/nS);          % 2-side Magnitude Spectrum
%         %phi = angle(X);                   % Phase (radians)
%         %S = (X .^ 2);                     % Power Density Spectrum
%         % 1-side Magnitude Spectrum
%         spectra1side = spectra2side(1:nS/2+1,:);
%         spectra1side(2:end-1) = 2*spectra1side(2:end-1);                                     
%         % Offset and scale the data
%         offVector = 0:nCh-1;
%         for j = 1 : nCh
%             fData(:,j) = spectra1side(:,j) + offVector(j);
%         end
%         % plot
%         figure(1)
%         f = sF*(0:(nS/2))/nS;
%         a_f0 = plot(f,fData);
%         title('Single-Sided Amplitude Spectrum')
%         xlabel('f (Hz)')
%         ylabel('|A(f)|')
%         %set(a_f0,'YTick',offVector);
%         %set(a_f0,'YTickLabel',0:nCh-1);
%         %xlim(a_f0, [0,sF/2]);
%     end
    
    set(handles.t_msg,'String','');
    save('EMG.mat','allData','sF','vCh'); 
       
%% ----------    
function float_vec = DecompressData(data)

    % Bias and scale values
    MULAW_BIAS = int32(hex2dec('2100'));
    BLK_BITS = int32(hex2dec('201'));
    INT32_SCALE = 16777216.0;

    % Bit field definitions
    POS_MASK = int16(hex2dec('7F00'));
    LSB_MASK = int16(hex2dec('00FF'));

    % Inputs are ones-complement uint16
    int16_vec = int16(data);
    int16_vec = bitcmp(int16_vec);

    % Extract bit fields
    sgn = data > 0;
    pos = int32(bitshift(bitand(POS_MASK, int16_vec), -8) + 9);
    lsb = int32(bitand(LSB_MASK, int16_vec));

    % Reconstruct number from parts
    int32_vec = bitshift(lsb, pos-8) + bitshift(BLK_BITS, pos-9) - MULAW_BIAS;
    int32_vec(sgn) = -int32_vec(sgn);

    % Convert to floating point
    float_vec = double(int32_vec) / INT32_SCALE;

%% --- Executes on button press in pb_connect.
function pb_connect_Callback(hObject, eventdata, handles)
    try
        compath_idx = get(handles.pm_ComPort,'Value');
        ComPortName     = get(handles.pm_ComPort,'string');
        if iscell(ComPortName)
            ComPortName     = ComPortName(compath_idx);
        end
        
        BaudRate    = 460800;
        
        
        set(handles.t_msg,'String','Testing connection...');
        drawnow();
        delete(instrfindall);
        obj = serial (ComPortName, 'baudrate', BaudRate, 'databits', 8, 'byteorder', 'bigEndian');
        %     obj = serialport(ComPortName{1}, BaudRate, 'Databits', 8,'Byteorder', 'big-endian');
        % Open connection
        fclose(obj);
        fopen(obj);
        fwrite(obj,'A','char');
        fwrite(obj,'C','char');
        reply = char(fread(obj,1,'char'));
        assert(strcmp(reply,'C'),'NCALfit:pb_connect_readbackerror','Error, device is not responding or COM port is changed!');
        
        set(handles.t_msg,'String',' ');
        pause(0.5)
        set(handles.t_msg,'String','Connection established');
        pause(0.5)
        % Set the system into COMMAND MODE
        fwrite(obj,hex2dec('AA'),'char');
        reply = char(fread(obj,4,'char')');
        assert(strcmp(reply,'COMM'),'NCALfit:pb_connect_COMMerror','Error Setting COMMAND MODE');
        
        set(handles.t_msg,'String','COMMAND MODE enabled');
        
        % Ask for serial number and firmware version of the device
        fwrite(obj,hex2dec('a0'),'uint8');
        reply = fread(obj,1,'uint8');
        assert(reply == hex2dec('a0'),'NCALfit:pb_connect:badserialstart','Error initiating ALC serial');
        
        serialN = [];
        stop = 0;
        while stop == 0
            serialN = [serialN char(fread(obj,1,'uint8'))];
            stop = strcmp(serialN(end),'~');
        end
        serialN = serialN(1:end-1);
        firmwareV = [];
        stop = 0;
        while stop == 0
            firmwareV = [firmwareV char(fread(obj,1,'uint8'))];
            stop = strcmp(firmwareV(end),'~');
        end
        firmwareV = firmwareV(1:end-1);
        
        reply = fread(obj,1,'uint8');
        assert(reply == hex2dec('a0'),'NCALfit:pb_connect:badserialsend','Error sending ALC serial');
        
        set(handles.txt_devID,'String',serialN);
        set(handles.txt_vers,'String',firmwareV);

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
    
%% possible outdated function
function pb_PatRecStart_Callback(hObject, eventdata, handles)

    %Selected channels
    allCh = str2double(get(handles.lb_ch,'String'))-1;
    vCh = allCh(get(handles.lb_ch,'Value')); % Vector of channels
    nCh = size(vCh,1);   
    chIdxUpper = bitshift(sum(bitset(0,vCh+1)),-8);
    chIdxLower = bitand(sum(bitset(0,vCh+1)),255);
     
    tPrediction = str2double(get(handles.et_tPredict,'String'));
    samples = str2double(get(handles.eT_samples,'String'));
     
    % Get connection object
    if isfield(handles,'obj')
        obj = handles.obj;
    else
        set(handles.t_msg,'String','No connection obj found');   
        return;
    end
    
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
    fwrite(obj,chIdxUpper,'uint8');
    fwrite(obj,chIdxLower,'uint8');
    fwrite(obj,nCh,'char');
    reply = char(fread(obj,1,'char'));
    if strcmp(reply,'L')
        set(handles.t_msg,'String','Control-Test Start');
    else
        set(handles.t_msg,'String','Error Start'); 
        fclose(obj);
        return
    end

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
        movIdx = fread(obj,1,'char');   
        activLevel = fread(obj,1,'char');
        set(handles.txt_predict,'String',num2str(movIdx));
        set(handles.txt_activLevel,'String',num2str(activLevel));
        switch movIdx
            case 199
                set(handles.t_msg,'String','majority vote step');
            case 0
                set(handles.t_msg,'String','rest');
            case 1
                set(handles.t_msg,'String','open');
            case 2
                set(handles.t_msg,'String','close');
            case 3
                set(handles.t_msg,'String','switch1');
            case 4
                set(handles.t_msg,'String','pronation');
            case 5
                set(handles.t_msg,'String','supination');
            case 6
                set(handles.t_msg,'String','co-contraction');
%             case 4
%                 set(handles.t_msg,'String','flex');
%             case 5
%                 set(handles.t_msg,'String','extend');
            otherwise
                set(handles.t_msg,'String','possible error!');
        end
        drawnow;
        outMov(i,:) = [movIdx activLevel];
    end
    disp('Estimated time:');
    samples*tPrediction
    toc
    
    % Stop the aquisition
    fwrite(obj,'T','char');
    % Close connection
    fclose(obj);
    set(handles.t_msg,'String','Control-Test session completed');
    set(handles.txt_predict,'String','');
    set(handles.txt_activLevel,'String','');
    save('Control-Output.mat','outMov');                                                                               
    

%% possible outdated function
function pb_PatRecStop_Callback(hObject, eventdata, handles)

    % Get connection object
    if isfield(handles,'obj')
        obj = handles.obj;
    else
        set(handles.t_msg,'String','No connection obj found');   
        return;
    end
    % Open the connection
    fopen(obj);
    % Stop ADS1299 continous acquisition
    fwrite(obj,'T','char');
    reply = char(fread(obj,1,'char'));
    if strcmp(reply,'T')
        set(handles.t_msg,'String','');
    else
        set(handles.t_msg,'String','Error with Stop command'); 
        fclose(obj);
        return
    end
    fclose(obj);                                                                             

%% --- Executes on button press in cb_filters.
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
    reply = char(fread(obj,1,'char'));
    if strcmp(reply,'H')
        fwrite(obj,FiltersEnable,'char');
        reply = char(fread(obj,1,'char'));
        if strcmp(reply,'H');
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


%% --- Executes on button press in pb_readRegisters.
function pb_readRegisters_Callback(hObject, eventdata, handles)

    % Get connection object
    if isfield(handles,'obj')
        obj = handles.obj;
    else
        set(handles.t_msg,'String','No connection obj found');   
        return;
    end
    % Open the connection
    fopen(obj);

    % Ask for 24 bytes containing the config registers of ADS1299
    fwrite(obj,'q','char');
    reply = char(fread(obj,1,'char'));
    if strcmp(reply,'q')
        for i = 1:24
            reg(i,:) = dec2hex(fread(obj,1,'char'));
        end
        %msgbox({'CONFIG REGISTERs:'},{'00 = %x'});
        reply = char(fread(obj,1,'char'));
        if strcmp(reply,'q')
            disp(obj)
            save('CONFIG.mat','reg');  
            set(handles.t_msg,'String','Config registers value saved into CONFIG.mat file');
        else
            set(handles.t_msg,'String','Error Reading Registers'); 
            fclose(obj);
            return
        end
    else
        set(handles.t_msg,'String','Error Reading Registers'); 
        fclose(obj);
        return
    end

    fclose(obj);

%% ----------
function menu_fwVersion_Callback(hObject, eventdata, handles)

    % Get connection object
    if isfield(handles,'obj')
        obj = handles.obj;
    else
        set(handles.t_msg,'String','No connection obj found');   
        return;
    end
    % Open the connection
    fopen(obj);

    % Ask for serial number and firmware version of the device
    fwrite(obj,hex2dec('a0'),'uint8');
    reply = fread(obj,1,'uint8');
    if reply == hex2dec('a0')
        serialN = [];
        stop = 0;
        while stop == 0
            serialN = [serialN char(fread(obj,1,'char'))];
            stop = strcmp(serialN(end),'~');
        end
        serialN = serialN(1:end-1);
        firmwareV = [];
        stop = 0;
        while stop == 0
            firmwareV = [firmwareV char(fread(obj,1,'char'))];
            stop = strcmp(firmwareV(end),'~');
        end
        firmwareV = firmwareV(1:end-1);
        reply = fread(obj,1,'uint8');
        if reply == hex2dec('a0')
            msgbox(sprintf('Device: %s\nFirmware version: %s',serialN,firmwareV));
        else
            set(handles.t_msg,'String','Error Reading Firmware version'); 
            fclose(obj);
            return
        end
    else
        set(handles.t_msg,'String','Error Reading Firmware version'); 
        fclose(obj);
        return
    end

    fclose(obj);

%% --------------------------------------------------------------------
function menu_SetChsMovs_Callback(hObject, eventdata, handles)

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
            status = sprintf('Please, be aware of the current settings:\nSampling Frequency = %d\nTime Windows Samples = %d\nOverlap Windows Samples = %d\nNumber of Features Enabled = %d\n', sF, tWs, oWs, nFeatures);
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

    % Open Fig and load information
    handles.tWs = tWs;
    handles.oWs = oWs;
    handles.sF = sF;
    guidata(hObject,handles);
    GUI_SetDC(handles);

%% ----------
function menu_UploadCoefficients_Callback(hObject, eventdata, handles)

    % Dialog box to open a patRec file
    [file, path] = uigetfile({'*.mat'});
    if ~isequal(file, 0)
        [pathstr,name,ext] = fileparts(file);
        if(strcmp(ext,'.mat'))
            load([path,file]);
            if ~exist('patRec','var') 
                disp('Not a valid pattern recognition training file');
                errordlg('Not a valid patRec file','Error');
                return;   
            end
        else
            disp('Not a valid pattern recognition training file');
            errordlg('Not a valid patRec file','Error');
            return; 
        end
    end

    if ~isfield('patRec','comm')
        patRec.comm = 'COM';
        patRec.comn = handles.obj.port;
    end
    
    handles.patRec = patRec;
    
    if strcmp(handles.patRec.patRecTrained.algorithm, 'DA') || ...
       strcmp(handles.patRec.patRecTrained.algorithm, 'SVM') || ...
       strcmp(handles.patRec.patRecTrained.algorithm, 'REG')    
        UpdateCoefficientsALCD(handles);
    else
        set(handles.t_msg,'String','No DA or SVM found. No data uploaded');
    end


%% --------------------------------------------------------------------
function menu_SetPRControl_Callback(hObject, eventdata, handles)

    % Get connection object
    if isfield(handles,'obj')
        obj = handles.obj;
    else
        set(handles.t_msg,'String','No connection obj found');   
        return;
    end
    % Open the connection
    fopen(obj);
    
    % Ask which algorithm
    prompt = {'Which algorithm? (1 = LDA, 2 = SVM, 3 = LREG)'};
    dlg_title = 'PR algorithm selection';
    num_lines = 1;
    def = {'1'};
    answer = inputdlg(prompt,dlg_title,num_lines,def);
    controlMode = str2num(answer{:});

    % Set up PatRec-Control enable
    fwrite(obj,'l','char');
    reply = char(fread(obj,1,'char'));
    if strcmp(reply,'l')
        fwrite(obj,controlMode,'char');
        reply = char(fread(obj,1,'char'));
        if strcmp(reply,'l');
            switch controlMode
                case 1
                    set(handles.t_msg,'String','PatRec-Control enabled: LDA');
                case 2
                    set(handles.t_msg,'String','PatRec-Control enabled: SVM');
                case 3
                    set(handles.t_msg,'String','PatRec-Control enabled: LREG');
            end
        else
            set(handles.t_msg,'String','Error Setting PatRec-Control'); 
            fclose(obj);
            return
        end
    else
        set(handles.t_msg,'String','Error Setting PatRec-Control'); 
        fclose(obj);
        return
    end
    
    fclose(obj);
    

%% --------------------------------------------------------------------
function menu_SetDirectControl_Callback(hObject, eventdata, handles)

    % Get connection object
    if isfield(handles,'obj')
        obj = handles.obj;
    else
        set(handles.t_msg,'String','No connection obj found');   
        return;
    end
    % Open the connection
    fopen(obj);
    
    controlMode = 0;

    % Set up Direct-Control enable
    fwrite(obj,'l','char');
    reply = char(fread(obj,1,'char'));
    if strcmp(reply,'l')
        fwrite(obj,controlMode,'char');
        reply = char(fread(obj,1,'char'));
        if strcmp(reply,'l');
            set(handles.t_msg,'String','Direct-Control enabled');
        else
            set(handles.t_msg,'String','Error Setting Direct-Control'); 
            fclose(obj);
            return
        end
    else
        set(handles.t_msg,'String','Error Setting Direct-Control'); 
        fclose(obj);
        return
    end
    
    fclose(obj);


%% --------------------------------------------------------------------
function menu_CheckBattery_Callback(hObject, eventdata, handles)

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
    fwrite(obj,'B','char');
    reply = char(fread(obj,1,'char'));
    if strcmp(reply,'B')
        battery = fread(obj,1,'float32');
        reply = char(fread(obj,1,'char'));
        if strcmp(reply,'B');
            msgbox(sprintf('Battery Voltage = %2.3g V',battery),'battery')
        else
            set(handles.t_msg,'String','Error, device is not responding or COM port is changed!'); 
            fclose(obj);
            return
        end
    else
        set(handles.t_msg,'String','Error, device is not responding or COM port is changed!');        
    end
    
    fclose(obj);

%% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% % Get connection object
% if isfield(handles,'obj')
%     obj = handles.obj;
%     % Close and delete connection
%     if strcmp(obj.status,'open')
%         fclose(obj);
%     end
%     delete(obj);
% end

% Hint: delete(hObject) closes the figure
delete(hObject);


%% --------------------------------------------------------------------
function menu_CONTROL_Callback(hObject, eventdata, handles)

% Get connection object
if isfield(handles,'obj')
    obj = handles.obj;
else
    set(handles.t_msg,'String','No connection obj found');   
    return;
end
% Open the connection
fopen(obj);

% Set up the CONTROL MODE enable
fwrite(obj,hex2dec('EE'),'char');
reply = char(fread(obj,4,'char')');
if strcmp(reply,'CTRL')
    set(handles.t_msg,'String','CONTROL MODE enabled'); 
else
    set(handles.t_msg,'String','Error Setting CONTROL MODE'); 
    fclose(obj);
    return
end

fclose(obj);


%% --------------------------------------------------------------------
function menu_COMMAND_Callback(hObject, eventdata, handles)

% Get connection object
if isfield(handles,'obj')
    obj = handles.obj;
else
    set(handles.t_msg,'String','No connection obj found');   
    return;
end
% Open the connection
fopen(obj);

% Set up the COMMAND MODE enable
fwrite(obj,hex2dec('AA'),'char');
reply = char(fread(obj,4,'char')');
if strcmp(reply,'COMM')
    set(handles.t_msg,'String','COMMAND MODE enabled'); 
else
    set(handles.t_msg,'String','Error Setting COMMAND MODE'); 
    fclose(obj);
    return
end

fclose(obj);

%% --------------------------------------------------------------------
function menu_Read_Callback(hObject, eventdata, handles)

% Get connection object
if isfield(handles,'obj')
    obj = handles.obj;
else
    set(handles.t_msg,'String','No connection obj found');   
    return;
end
% Open the connection


% Ask for SD memory blocks
prompt = {'Enter number of Blocks to Read:','Enter starting Address:'};
dlg_title = 'SDcard download';
num_lines = 1;
def = {'10','0'};
answer = inputdlg(prompt,dlg_title,num_lines,def);
if isempty(answer) %if canceled
    return;
else
    fopen(obj);
end    
numBlocks = str2double(char(answer(1)));
address = str2double(char(answer(2)));

tic
% Set warnings to temporarily issue error (exceptions)
s = warning('error', 'instrument:fread:unsuccessfulRead');
fwrite(obj,'m','char');
reply = char(fread(obj,1,'char'));
if strcmp(reply,'m')
    fwrite(obj,numBlocks,'uint32');
    fwrite(obj,address,'uint32');
    for i = 1:numBlocks 
        try
            SDcardValues(i,:) = fread(obj,512,'char');
            message = sprintf('Downloading can take some minutes... %d on %d', i, numBlocks);
            set(handles.t_msg,'String', message);
            drawnow;
        catch exception
           save('SDcard.mat','SDcardValues'); 
           set(handles.t_msg,'String','Error in communication: not all blocks were downloaded'); 
           delete(obj);
           return

%             SDcardValues(i,:) = fread(obj,512,'char');
%             message = sprintf('Downloading can take some minutes... %d on %d', i, numBlocks);
%             set(handles.t_msg,'String', message);
%             drawnow;
        end
        %Set warning back to normal state
        warning(s)
    end
    reply = char(fread(obj,1,'char'));
    if strcmp(reply,'m')
        disp(obj)
        save('SDcard.mat','SDcardValues');  
        set(handles.t_msg,'String','SDcard read successful: value saved into SDcard.mat file');
    else
        set(handles.t_msg,'String','Error Reading SDcard'); 
        fclose(obj);
        return
    end
else
    set(handles.t_msg,'String','Error Reading SDcard'); 
    fclose(obj);
    return
end
toc

fclose(obj);
    
   
%% --------------------------------------------------------------------
function menu_memorySpace_Callback(hObject, eventdata, handles)

% Get connection object
if isfield(handles,'obj')
    obj = handles.obj;
else
    set(handles.t_msg,'String','No connection obj found');
    return;
end
% Open the connection
fopen(obj);

tic

fwrite(obj,'n','char');
reply = char(fread(obj,1,'char'));
if strcmp(reply,'n')
    LastLocationUsed = fread(obj,1,'uint32');
    SDMemorySize = fread(obj,1,'uint8');
    reply = char(fread(obj,1,'char'));
    if strcmp(reply,'n')
        disp(obj)
        message = sprintf('Memory state: %dB of %dGB (%0.2f%%), block Idx = %d', LastLocationUsed*512, SDMemorySize, (LastLocationUsed*512*100/(SDMemorySize*1E9)), LastLocationUsed);
        set(handles.t_msg,'String', message);
        drawnow;
    else
        set(handles.t_msg,'String','Error with SDcard');
        fclose(obj);
        return
    end
else
    set(handles.t_msg,'String','Error with SDcard');
    fclose(obj);
    return
end

toc

fclose(obj);


%% --------------------------------------------------------------------
function menu_resetBlockIdx_Callback(hObject, eventdata, handles)

% Ask for SD memory blocks
answer = questdlg('Would you like to reset the Block Index?','Reset BlockIdx','Yes','No','Yes');
if strcmp(answer,'Yes')
    % Get connection object
    if isfield(handles,'obj')
        obj = handles.obj;
    else
        set(handles.t_msg,'String','No connection obj found');
        return;
    end
    % Open the connection
    fopen(obj);

    try
        % reset blockIdx (LogFile block pointer on hardware)
        fwrite(obj,'o','char');
        reply = char(fread(obj,1,'char')');
        assert(strcmp(reply,'o'),'resetBlockIdx:noResponse','No response from ALC');

        blockIdx = fread(obj,1,'uint32');

        hWait = waitbar(0,sprintf('Resetting %d blocks',blockIdx),'CreateCancelBtn','setappdata(gcbf,''canceling'',1)');

        while true
            currentIdx = fread(obj,1,'uint32');
            if currentIdx == 0
                break
            else
                waitbar(currentIdx/blockIdx,hWait);
                if getappdata(hWait,'canceling')
                    fwrite(obj,blockIdx,'uint32');
                else
                    fwrite(obj,currentIdx,'uint32');
                end
            end
        end

       delete(hWait);            
        set(handles.t_msg,'String','BlockIdx Reset');

        fclose(obj);
    catch exception
        set(handles.t_msg,'String',exception.message);
        fclose(obj);
    end
end


%% read from the entire datalog
function menu_readLog_Callback(hObject, eventdata, handles)

% Get connection object
if isfield(handles,'obj')
    obj = handles.obj;
else
    set(handles.t_msg,'String','No connection obj found');   
    return;
end
% Open the connection
fopen(obj);

tic
% Read blockIdx
fwrite(obj,'n','char');
reply = char(fread(obj,1,'char'));
if strcmp(reply,'n')
    LastLocationUsed = fread(obj,1,'uint32');
    SDMemorySize = fread(obj,1,'uint8');
    reply = char(fread(obj,1,'char'));
    if strcmp(reply,'n')
        disp(obj) 
        message = sprintf('Memory state: %dB of %dGB, block Idx = %d ', LastLocationUsed*512, SDMemorySize, LastLocationUsed);
        set(handles.t_msg,'String', message);
        drawnow;
    else
        set(handles.t_msg,'String','Error with SDcard'); 
        fclose(obj);
        return
    end
else
    set(handles.t_msg,'String','Error with SDcard'); 
    fclose(obj);
    return
end
numBlocks = LastLocationUsed;
address = 19;

fclose(obj);
% Set up receiving buffer
obj.InputBufferSize = 512*numBlocks;
% Open the connection again
fopen(obj);

% Set warnings to temporarily issue error (exceptions)
s = warning('error', 'instrument:fread:unsuccessfulRead');
SDcardValues = zeros(numBlocks,512);   
for i = 1:numBlocks
    go = 0;
    attempt = 0;
    while go == 0
        fwrite(obj,'m','char');
        reply = char(fread(obj,1,'char'));
        if strcmp(reply,'m')
            fwrite(obj,1,'uint32');
            fwrite(obj,address+i,'uint32');
            try
                SDcardValues(i,:) = fread(obj,512,'char');
            catch exception
               save('LogFile_ALC-D.mat','SDcardValues'); 
               set(handles.t_msg,'String','Error1 in communication: not all blocks were donwloaded'); 
               delete(obj);
               return
            end 
            warning(s);
            if SDcardValues(i,1) ~= 255 && SDcardValues(i,1) ~= 127 && SDcardValues(i,1) ~= 0 && attempt < 3
                go = 0;
                attempt = attempt + 1;
            else
                go = 1;     
            end
            char(fread(obj,1,'char'));
        else
            save('LogFile_ALC-D.mat','SDcardValues'); 
            set(handles.t_msg,'String','Error2 in communication: not all blocks were donwloaded'); 
            fclose(obj);
            return 
        end
    end
    message = sprintf('Downloading can take some minutes... %d of %d', i, numBlocks);
    set(handles.t_msg,'String', message);
    drawnow;
end
save('LogFile_ALC-D.mat','SDcardValues');
set(handles.t_msg,'String','SDcard read successful: value saved into LogFile_ALC-D.mat file');
toc

% % Set warnings to temporarily issue error (exceptions)
% s = warning('error', 'instrument:fread:unsuccessfulRead');
% SDcardValues = zeros(numBlocks,512);
% fwrite(obj,'m','char');
% reply = char(fread(obj,1,'char'));
% if strcmp(reply,'m')
%     fwrite(obj,numBlocks,'uint32');
%     fwrite(obj,address,'uint32');
%     for i = 1:numBlocks
%         try
%             SDcardValues(i,:) = fread(obj,512,'char');
%             message = sprintf('Downloading can take some minutes... %d on %d', i, numBlocks);
%             set(handles.t_msg,'String', message);
%             drawnow;
%         catch exception
%            save('LogFile_ALC-D.mat','SDcardValues'); 
%            set(handles.t_msg,'String','Error in communication: not all blocks were donwloaded'); 
%            delete(obj);
%            return
%         end
%         %Set warning back to normal state
%         warning(s); 
%     end
%     reply = char(fread(obj,1,'char'));
%     if strcmp(reply,'m')
%         disp(obj)
%         save('LogFile_ALC-D.mat','SDcardValues');  % BUG!!!!
%         set(handles.t_msg,'String','SDcard read successful: value saved into LogFile_ALC-D.mat file');
%     else
%         set(handles.t_msg,'String','Error Reading SDcard'); 
%         fclose(obj);
%         return
%     end 
% else
%     set(handles.t_msg,'String','Error Reading SDcard'); 
%     fclose(obj);
%     return
% end
% toc

fclose(obj);
    
%% select the desired datalog setting to change saved variables
function menu_setDatalog_Callback(hObject, eventdata, handles)
    
% Get connection object
if isfield(handles,'obj')
    obj = handles.obj;
else
    set(handles.t_msg,'String','No connection obj found');
    return;
end

datalogMode = questdlg('Select the datalog mode', ...
    'Datalog Mode', ...
    'Normal','Debug','EMG','Normal');

switch datalogMode
    case 'Normal'
        debugDatalog = 0;
        EMGDatalog = 0;
        SDBlockCount = 2;
    case 'Debug'
        debugDatalog = 1;
        EMGDatalog = 0;
        SDBlockCount = 4;
    case 'EMG'
        debugDatalog = 0;
        EMGDatalog = 1;
        SDBlockCount = 10;

        while true
            EMGChannels = listdlg('PromptString',{'Select EMG channels to save','Select exactly 2 channels'},'SelectionMode','Multiple',...
                'ListString',get(handles.lb_ch,'String'),'InitialValue',[1,9])-1;
            if isempty(EMGChannels)
                datalogMode = 'Normal';
                debugDatalog = 0;
                EMGDatalog = 0;
                SDBlockCount = 4;
            elseif length(EMGChannels) ~= 2
                disp('Please select exactly 2 channels');
            else
                break;
            end
        end
end

% Open the connection
try
    fopen(obj);
    tic

    fwrite(obj,hex2dec('F0'),'char');
    reply = fread(obj,1,'char');

    assert(reply == hex2dec('F0'),'menu_setDatalog_Callback:noreply','Error receiving reply from ALC');

    fwrite(obj,debugDatalog,'uint8');
    fwrite(obj,EMGDatalog,'uint8');
    fwrite(obj,SDBlockCount,'uint8');

    if EMGDatalog
        fwrite(obj,EMGChannels(1),'uint8');
        fwrite(obj,EMGChannels(2),'uint8');
    end
    
    clockPeriod = fread(obj,1,'uint32')/80000000;

    reply = char(fread(obj,1,'char'));

    assert(reply == hex2dec('F0'),'menu_setDatalog_Callback:badreply','Error setting datalog mode');

    set(handles.t_msg,'String',sprintf('%s datalog, SD period: %0.1fs',datalogMode,clockPeriod));

    fclose(obj);

catch exception
    set(handles.t_msg,'String',exception.message);
    fclose(obj);
    return
end

toc

fclose(obj);

%% --- Executes on button press in cb_motorEnable.
function cb_motorEnable_Callback(hObject, eventdata, handles)

    motorsEnable = get(handles.cb_motorEnable,'Value');
    
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
    fwrite(obj,'e','char');
    reply = char(fread(obj,1,'char'));
    if strcmp(reply,'e')
        fwrite(obj,motorsEnable,'char');
        reply = char(fread(obj,1,'char'));
        if strcmp(reply,'e');
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

%% --- Executes on button press in pb_executeMov.
function pb_executeMov_Callback(hObject, eventdata, handles)

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
            SendMotorCommand(obj, 0, 'A', 1, speed);
            pause(time);
            SendMotorCommand(obj, 0, 'R', 1, 0);
        case 2   
            SendMotorCommand(obj, 0, 'A', 0, speed);
            pause(time);  
            SendMotorCommand(obj, 0, 'R', 1, 0);
        case 3 % SWITCH
            SendMotorCommand(obj, 0, 'S', 0, 0);  
            pause(time);  
    end
    % Close connection
    fclose(obj);
    
    %ActivateSP_FixedTime(obj,'B',speed,time);
    set(handles.pb_executeMov,'Enable','on');

%% --- Executes on selection change in pm_control.
function pm_control_Callback(hObject, eventdata, handles)

    menu = get(handles.pm_control,'string');
    menu = menu{get(handles.pm_control,'Value')};
    
    switch menu
        case 'select control algorithm'
            algorithm.mode = 0; % None
            set(handles.et_tPredict,'String',0.05);
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
            set(handles.et_tPredict,'String',0.05*algorithm.param(1));
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
            set(handles.et_tPredict,'String',0.05);
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
            set(handles.et_tPredict,'String',0.05);
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

    % Set up the ADS1299 datarate output (and bandwidth)
    fwrite(obj,'a','char');
    reply = char(fread(obj,1,'char'));
    if strcmp(reply,'a')
        fwrite(obj,algorithm.mode,'char');
        if algorithm.mode ~= 0
            for i = 1:size(algorithm.param,2)
                fwrite(obj,algorithm.param(i),'char');
            end
        end
        reply = char(fread(obj,1,'char'));
        if strcmp(reply,'a');
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

%% --------------------------------------------------------------------
function menu_checkStatus_Callback(hObject, eventdata, handles)

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
            status = sprintf('Battery Voltage = %2.3g V\nCPU Temperature = %2.3g C\nSensor-Hand = %s\nNeurostimulator = %s\nSD-card = %s\niNEMO = %s\nMotors = %s\nFilters = %s\nPost-Control-Algorithm = %s\nControl Algorithm = %s\ntime window samples = %d\noverlapp window samples = %d\nsampling frequency = %d Hz\nnumber of channels = %d\nnumber of features = %d\nramp length = %d\nramp mode = %d\nmajority vote steps = %d\ndelicate grasp = %d\ndelicate grasp threshold = %d\nsensitivity = %d\nhand minimum speed = %d\nhand maximum speed = %d\nHand control mode = %s\nwrist minimum speed = %d\nwrist maximum speed = %d\nelbow minimum speed = %d\nelbow maximum speed = %d\nLock/unlock pause counter = %d', battery, temperature, SH, enableSH, SD, IMU, enableM, enableF, PC, CM, tWs, oWs, sF, nChannels, nFeatures, rampLength, rampMode, mvSteps, delicateGrasp, delicateGraspThreshold, sensitivity, minH, maxH, handCtrlMd, minW, maxW, minE, maxE, pauseCounter);
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

%% --------------------------------------------------------------------
function menu_NSsetup_Callback(hObject, eventdata, handles)

%     try
%         [id code] = id_file;
%     catch
%         errordlg('id_file not found!','Error');
%         return
%     end
%     X = inputdlg('Please, enter your identification code to proceed');
%     x = str2double(X{1,1});
%     if x == code
%         ans = sprintf('Welcome %s\n\n\nThe inserted code is correct!\n',id);
%         uiwait(msgbox(ans,'Login'));
%     else 
%         ans = sprintf('Welcome %s\n\n\nThe inserted code is incorrect!\n',id);
%         uiwait(msgbox(ans,'Error!'));
%         return
%     end
    % Open Fig and load information   
    guidata(hObject,handles);
    GUI_SetNS(handles);


%% --------------------------------------------------------------------
function menu_setDC_Callback(hObject, eventdata, handles)

    % Open Fig and load information   
    guidata(hObject,handles);
    GUI_ControlSettings_List(handles);

%% --------------------------------------------------------------------
function menu_updatePRtable_Callback(hObject, eventdata, handles)

    % Ask for windowing parameters
    dlg_title = 'Windows size';
    prompt = {'window size [s]','increment [s]'};
    def = {'0.2','0.05'};
    num_lines = 1;
    answer = inputdlg(prompt,dlg_title,num_lines,def);
    if size(answer,1) == 0
        return
    end
    tW = str2num(char(answer(1)));  
    iW = str2num(char(answer(2)));

    % Load recSession and calculate table
    [file, path] = uigetfile({'*.mat';'*.csv'});
    % Check that the loaded file is a "ss" struct
    if ~isequal(file, 0)
        [pathstr,name,ext] = fileparts(file);
        if(strcmp(ext,'.mat'))
            load([path,file]);
%             if (exist('recSession','var') && isfield(recSession,'ramp'))
            if exist('recSession','var')
            else
                disp('That was not a valid recording session');
                errordlg('That was not a valid recording session','Error');
                return;
            end
        end
    end
    % create table
    set(handles.t_msg,'String','Calculating the proportional table...');
    propTable = CreatePRtable_ALCD(tW, iW, recSession);
    nCh = recSession.nCh;
    nM = recSession.nM+1;
    if isfield(recSession,'vCh')
        vCh = recSession.vCh;
    else
        error('recSession is missing information about the recorded channels (vCh)')
        return;
    end
    nameMovs = recSession.mov;
    nameMovs{nM} = 'rest';
    barh(propTable);
    legend(nameMovs);
    axis([0 max(max(propTable)) 0 nCh+1]);
    % Create GUI-window
    set(handles.t_msg,'String','Setup movements and prosthetic outputs...');
    figureH = figure;
    % Set up Vars used by GUI-code
    movValBoxes = zeros(1,nM);
    % Set up position and sizes for the different GUI-fields
    xPosNameBox = 20;
    yPosNameBox = 70;
    xSizeNameBox = 150;
    ySizeNameBox = 20;
    xPosValBox = xPosNameBox + xSizeNameBox + 10;
    yPosValBox = yPosNameBox;
    xSizeValBox = 150;
    ySizeValBox = ySizeNameBox;
    % Create UI objects for the prosthetic outputs
    for i = 1:nM
        % Create UI-name boxes from the parameters
        uicontrol('Style', 'text', 'String', nameMovs{nM-i+1},...
            'Position', [xPosNameBox yPosNameBox+(i-1)*ySizeNameBox, ...
            xSizeNameBox ySizeNameBox]);
        % Save value of the parameters
        if i == 1
            parameterValue = 0;
        else
            parameterValue = 2^(nM-i);
        end
        % Create UI-value boxes from the parameters
        movValBoxes(i) = uicontrol('Style', 'edit', 'String', parameterValue,...
            'Position', [xPosValBox yPosValBox+(i-1)*ySizeValBox, ...
            xSizeValBox ySizeValBox],...
            'Tag',nameMovs{nM-i+1});    
    end
    % Create a UI-title
    title = uicontrol('Style', 'text', 'String', ['Associate PR classes to prosthetic outputs'],...
        'Position', [(xPosNameBox+xPosValBox)/2 yPosNameBox+(i+1)*ySizeNameBox, ...
        250 65], ...
        'Tag', 'Title');
    % Set title fontsize
    set(title,'FontSize',15);
    % Create OK-button
    uicontrol('Style', 'pushbutton', 'String', 'Confirm',...
        'Position', [xPosValBox+xSizeValBox+20 yPosValBox 50 40], ...
        'Callback', {@UpdatePRtable,hObject,movValBoxes,propTable, nM, nCh, vCh});
    % Resize the GUI-window
    figurePos = get(figureH,'Position');
    figurePos(3:4) = [xSizeNameBox+xSizeValBox+50+2*xPosNameBox+20,...
        yPosNameBox+50+yPosNameBox+(i+1)*ySizeNameBox];
    set(figureH,'Position',figurePos,'MenuBar','none');
    
%% ----------
function UpdatePRtable(hObj, event, inObj, movValBoxes, propTable, nM, nCh, vCh)

    for i = 1:size(movValBoxes,2)
        prostheticOutputs(i) = str2double(get(movValBoxes(i),'String'));
    end
    prostheticOutputs = fliplr(prostheticOutputs);
    
    chIdxDiff = bitshift(sum(bitset(0,vCh)),-16);
    chIdxUpper = bitshift(sum(bitset(0,vCh)),-8);
    chIdxUpper = bitand(chIdxUpper,255);
    chIdxLower = bitand(sum(bitset(0,vCh)),255);

    handles = guidata(inObj);
    % Get connection object
    if isfield(handles,'obj')
        obj = handles.obj;
    else
        set(handles.t_msg,'String','No connection obj found');   
        close(clf);
        return;
    end
 
    % Open the connection
    fopen(obj);
    % Start to send coeff values
    fwrite(obj,'v','char');
    fwrite(obj,nM,'char');
    fwrite(obj,nCh,'char');
    fwrite(obj,chIdxDiff,'uint8');
    fwrite(obj,chIdxUpper,'uint8');
    fwrite(obj,chIdxLower,'uint8');
    reply = char(fread(obj,1,'char'));
    if strcmp(reply,'v')
        set(handles.t_msg,'String','Upload Start');
    else
        set(handles.t_msg,'String','Error Start');
        fclose(obj);
        return
    end
    % send table to the ALC-D
    tic;
    for i = 1:nM
        fwrite(obj,prostheticOutputs(i),'char');
    end
    for i = 1:nM
        for k = 1:nCh
            fwrite(obj,propTable(k,i),'float');
        end
    end
    toc;
    reply = char(fread(obj,1,'char'));
    if strcmp(reply,'v');
        set(handles.t_msg,'String','Upload completed');
    else
        set(handles.t_msg,'String','Error uploading');
        fclose(obj);
        return
    end
    fclose(obj);
    guidata(inObj, handles);
    close(clf);


%% --------------------------------------------------------------------
function menu_downloadPRtable_Callback(hObject, eventdata, handles)

    % Get connection object
    if isfield(handles,'obj')
        obj = handles.obj;
    else
        set(handles.t_msg,'String','No connection obj found');   
        return;
    end
    % Open the connection
    fopen(obj);

    % Ask for the PR table
    fwrite(obj,'V','char');
    reply = char(fread(obj,1,'char'));
    if strcmp(reply,'V')       
        nM = fread(obj,1,'uint8');
        nCh = fread(obj,1,'uint8'); 
        chIdxDiff = fread(obj,1,'uint8');
        chIdxUpper = fread(obj,1,'uint8');
        chIdxLower = fread(obj,1,'uint8');     
        for i = 1:nM
            PRtable.prostheticOut(i) = fread(obj,1,'uint8');
        end
        for i = 1:nM
            for k = 1:nCh
                PRtable.channelsMVC(k,i) = fread(obj,1,'float32');
            end
        end
        reply = char(fread(obj,1,'char'));
        if strcmp(reply,'V')
            disp(obj)            
            % TO BE FIXED!!!!!!!!!
            %tmp = hexToBinaryVector([chIdxDiff chIdxUpper chIdxLower], 24);  
            save('PRTABLE.mat','PRtable', 'nM', 'nCh', 'chIdxDiff', 'chIdxUpper', 'chIdxLower');  
            set(handles.t_msg,'String','PR-Table saved in PRTABLE.mat file');
        else
            set(handles.t_msg,'String','Error Reading PR-Table'); 
            fclose(obj);
            return
        end
    else
        set(handles.t_msg,'String','Error Reading PR-Table'); 
        fclose(obj);
        return
    end

    fclose(obj);


%% --------------------------------------------------------------------
function loadFile_pb_ClickedCallback(hObject, eventdata, handles)

    [file, path] = uigetfile({'*.mat';'*.csv'});
    if ~isequal(file, 0)
        [pathstr,name,ext] = fileparts(file);
        if(strcmp(ext,'.mat'))
            load([path,file]);
            if(exist('recSession','var')) 
                set(handles.t_msg,'String','Selected file is a recSession! Please use BioPatRec instead to load it.');
                return
            elseif(exist('allData','var'))
                nCh = size(allData,2);
            else
                set(handles.t_msg,'String','File not valid!');
            end
        end
    end

    %sF = get(handles.pm_sF,'string');
    %sF = str2num(sF{get(handles.pm_sF,'Value')});
    sF = 1000;
    sT = length(allData)/sF;
    tv = 0:1/sF:sT-1/sF;
    
    % Offset the plot of the different channels to fit into the main figure
    ampPP     = 5;
    plotGain = ampPP/(2*(max(max(abs(allData)))));
    offVector = 0:nCh-1;
    offVector = offVector .* ampPP;
    
    % Print the data    
    for i = 1:sT*sF 
        for k = 1:nCh        
            sData(i,k) = allData(i,k)*plotGain + offVector(k);
        end 
    end
    plot(tv, sData);
    set(handles.a_t0,'YTick',offVector);
    set(handles.a_t0,'YTickLabel',1:nCh); 
    
    if get(handles.cb_FFT,'Value');
        % Plot FFT of acquired signals
        nS = length(sData(:,1));     
        nS = 2^nextpow2(nS);               % Find next power of 2
        X = fft(sData,nS);
        spectra2side = abs(X/nS);          % 2-side Magnitude Spectrum
        %phi = angle(X);                   % Phase (radians)
        %S = (X .^ 2);                     % Power Density Spectrum
        % 1-side Magnitude Spectrum
        spectra1side = spectra2side(1:nS/2+1,:);
        spectra1side(2:end-1) = 2*spectra1side(2:end-1);                                     
        % Offset and scale the data
        offVector = 0:nCh-1;
        for j = 1 : nCh
            fData(:,j) = spectra1side(:,j) + offVector(j);
        end
        % plot
        figure(1)
        f = sF*(0:(nS/2))/nS;
        a_f0 = plot(f,fData);
        title('Single-Sided Amplitude Spectrum')
        xlabel('f (Hz)')
        ylabel('|A(f)|')
        %set(a_f0,'YTick',offVector);
        %set(a_f0,'YTickLabel',0:nCh-1);
        %xlim(a_f0, [0,sF/2]);
    end
    
    set(handles.t_msg,'String','Recording Loaded');

%% --------------------------------------------------------------------
function menu_control_Callback(hObject, eventdata, handles)

    % download status bytes from the controller to check latest settings
    

    % Open Fig and load information   
    guidata(hObject,handles);
    GUI_Prosthetics(handles);
    
%% --------------------------------------------------------------------
function menu_closedLoopStream_Callback(hObject, eventdata, handles)

    % Open Fig and load information   
    guidata(hObject,handles);
    app_ClosedLoopStream(handles)

%% stream sensor data from hand
function menu_sensorStream_Callback(hObject, eventdata, handles)
    set(handles.t_msg,'String','');
    % Open Fig and load information   
    guidata(hObject,handles);
    app_SensorStream(handles)    
    

%% --- Executes on button press in pb_stop.
function pb_stop_Callback(hObject, eventdata, handles)

    global go;
    go = 0;
    

%% --- Executes on button press in pb_refresh.
function pb_refresh_Callback(hObject, eventdata, handles)

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

%% run automatic impedance test from MSP
function menu_impedance_Callback(hObject, eventdata, handles)
  
    %Selected channels
    allCh = str2double(get(handles.lb_ch,'String'))-1;
    vCh = allCh(get(handles.lb_ch,'Value')); % Vector of channels
    nCh = size(vCh,1);

    % Get connection object
    if isfield(handles,'obj')
        obj = handles.obj;
    else
        set(handles.t_msg,'String','No connection obj found');   
        return;
    end
    set(handles.pb_stop,'Enable','on');
    
    answer = questdlg({'Impedance will be measured on the selected channels.','This process might take some time (approx. 30 seconds per channel).','Do you want to proceed?'},'Impedance test','Yes','No','No');
    if ~strcmp(answer,'Yes')
        return;
    end

    set(obj, 'timeout',60);
    
    % Open the connection
    fopen(obj);
    % Read available data and discard it
    if obj.BytesAvailable > 1
        fread(obj,obj.BytesAvailable,'uint8');    % Read the samples        
    end    
    set(handles.t_msg,'String','Impedance measurement started...');
    drawnow;
    
    tic
    for ii = 1:nCh      
        fprintf('Testing channel %d\n',vCh(ii)+1);
        % Initiate the command
        fwrite(obj,'I','char');   
        reply = char(fread(obj,1,'char'));
        if strcmp(reply,'I')
            fwrite(obj,vCh(ii),'char'); % Send channel
            result = fread(obj,1,'char');
            if result == hex2dec('AA')
                % good!
                impedance(ii).channel = vCh(ii);
                impedance(ii).real = fread(obj,1,'int32');
                impedance(ii).imag = fread(obj,1,'int32');
                impedance(ii).angle = fread(obj,1,'float32');
                set(handles.t_msg,'String','Success! Check the results file.');
                fprintf('Measured impedance: %d + j%d Ω\n',impedance(ii).real,impedance(ii).imag);
            end
            reply = char(fread(obj,1,'char'));
            if ~strcmp(reply,'I')
                set(handles.t_msg,'String','Error');
                fclose(obj);
                return
            end    
        else
            set(handles.t_msg,'String','Error'); 
            fclose(obj);
            return
        end       
    end
    toc
    fclose(obj);
    set(obj, 'timeout',10);
    
    % store data
    testTypeStr = 'ALCD-Impedance-Measurement';
    timeTest = clock;
    year = timeTest(1);
    month = timeTest(2);
    day = timeTest(3);
    hour = timeTest(4);
    min = timeTest(5);
    strSaveName = [testTypeStr '_' num2str(day) '_' num2str(month) '_' num2str(year) '-' num2str(hour) '_' num2str(min) '.mat'];
    save(strSaveName,'impedance');
  


%% --------------------------------------------------------------------
function menu_advsettings_Callback(hObject, eventdata, handles)
   
    % Open Fig and load information   
    guidata(hObject,handles);
    GUI_Settings(handles);

    
%% --------------------------------------------------------------------
function menu_extrachannels_Callback(hObject, eventdata, handles)

    % Open Fig and load information   
    %guidata(hObject,handles);
    %GUI_SetExtraChs(handles);
    app_ExtraChannels(handles)


%% --------------------------------------------------------------------
function menu_SetDC_Callback(hObject, eventdata, handles)

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
            status = sprintf('Please, be aware of the current settings:\nSampling Frequency = %d\nTime Windows Samples = %d\nOverlap Windows Samples = %d\nNumber of Features Enabled = %d\n', sF, tWs, oWs, nFeatures);
            %msgbox(status,'System Status')
        else
            set(handles.t_msg,'String','Error, device is not responding or COM port is changed!'); 
            fclose(obj);
            return
        end
    else
        set(handles.t_msg,'String','Error, device is not responding or COM port is changed!');        
    end
    fclose(obj);

    % Open Fig and load information
    handles.tWs = tWs;
    handles.oWs = oWs;
    handles.sF = sF;
    guidata(hObject,handles);
    GUI_SetDC_24chs(handles);


%% --------------------------------------------------------------------
function menu_regression_Callback(hObject, eventdata, handles)

    % Dialog box to open a patRec file
    [file, path] = uigetfile({'*.mat'});
    if ~isequal(file, 0)
        [pathstr,name,ext] = fileparts(file);
        if(strcmp(ext,'.mat'))
            load([path,file]);
            if ~exist('recSession','var')  
                disp('Not a valid recording session file');
                errordlg('Not a valid recording session file','Error');
                return;   
            end
        else
            disp('Not a valid recording session file');
            errordlg('Not a valid recording session file','Error');
            return; 
        end
    end
    
    % ask to input which movements to consider for the training
    movs4training = listdlg('PromptString', 'Select movements for training:', 'SelectionMode', 'multiple', 'ListString', recSession.mov);
    % Ask for time window size
    prompt = {'Enter the time window size:'};
    dlg_title = 'tW for training';
    num_lines = 1;
    def = {'0.1'};
    answer = inputdlg(prompt,dlg_title,num_lines,def);
    tW = str2num(char(answer(1)));
    [patRec.patRecTrained.coeffs, patRec.patRecTrained.RMSerrors] = trainingREG(movs4training, recSession, recSession.nCh, tW, 1);
    patRec.selectedMovs = movs4training;
    patRec.selectedMovsLabels = recSession.mov(movs4training,1:end);
    patRec.recSession = recSession;
    patRec.sF = recSession.sF;
    patRec.nCh = recSession.nCh;
    if isfield(recSession,'vCh')
        % they have already been defined
        patRec.vCh = recSession.vCh;
    else
        % They have not been defined
        % Ask to input the recording channels
        vCh = [];
        while size(vCh,2) ~= recSession.nCh
            str = {'1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16'};
            vCh = listdlg('PromptString', 'Define which channels were used in this recording:', 'SelectionMode', 'multiple', 'ListString', str);
            if size(vCh,2) ~= recSession.nCh
                 waitfor(errordlg(['This recording was done with ', num2str(recSession.nCh), ' channels!']));
            end
        end
        patRec.vCh = vCh;
    end
    patRec.patRecTrained.algorithm = 'REG';
    patRec.patRecTrained.tW = tW;
    [filename, pathname] = uiputfile({'*.mat','MAT-files (*.mat)'},'Save as', 'patRec.mat');
    if isequal(filename,0) || isequal(pathname,0)
    else
        disp(['User selected ', fullfile(pathname, filename)])
        save([pathname,filename],'patRec');
        disp(patRec);
    end 



    
 %% --------------------------------------------------------------------
 function menu_SetArtifactRemoval_Callback(hObject, eventdata, handles)

    % Get connection object
    if isfield(handles,'obj')
        obj = handles.obj;
    else
        set(handles.t_msg,'String','No connection obj found');   
        return;
    end
    
    % Ask for enable
    answer = questdlg('Do you want to enable the stimulation artifact removal routine?');
    if strcmp(answer,'Yes')
        artifactRemovalEnable = 1;
    else
        artifactRemovalEnable = 0;
    end
    
    if artifactRemovalEnable
        % Dialog box to browse a coefficients file
        [file, path] = uigetfile({'*.mat'});
        if ~isequal(file, 0)
            [pathstr,name,ext] = fileparts(file);
            if(strcmp(ext,'.mat'))
                load([path,file]);
                if ~exist('artifactRemovalCoefficients','var')
                    disp('Not a valid file');
                    errordlg('Not a valid file','Error');
                    return;
                end
            else
                disp('Not a valid file');
                errordlg('Not a valid file','Error');
                return;
            end
        else
            return;
        end
        if sum(size(artifactRemovalCoefficients) ~= [24,3]) >0
            disp('Not a valid matrix');
            errordlg('Not a valid matrix','Error');
            return;
        end
    else
        artifactRemovalCoefficients = zeros(24,4);
    end

    % Open the connection
    fopen(obj);
    fwrite(obj,hex2dec('B5'),'char');
    reply = fread(obj,1,'char');
    if reply == 181 %0xB5
        fwrite(obj,artifactRemovalEnable,'char');  
        
        % HARD CODED!
        artifactRemovalStimChannel = 2; %zeroindexed
        fwrite(obj,artifactRemovalStimChannel,'char'); %AS_note: observe how this is handled by the ALC
        for i = 1:24
            fwrite(obj,artifactRemovalCoefficients(i,1),'float32'); % m
            fwrite(obj,artifactRemovalCoefficients(i,2),'float32');
            fwrite(obj,artifactRemovalCoefficients(i,3),'float32'); % m
        end      
        reply = fread(obj,1,'char');
        set(handles.t_msg,'String','');
        pause(0.5)
        if reply == 181 %0xB5
            set(handles.t_msg,'String','Artifact Removal parameters set');
        else
            set(handles.t_msg,'String','Error Setting Artifact Removal parameters'); 
            fclose(obj);
            return
        end
    else
        set(handles.t_msg,'String','Error Setting Artifact Removal parameters'); 
        fclose(obj);
        return
    end
    fclose(obj);
    

%% --------------------------------------------------------------------
function menu_GetArtifactRemoval_Callback(hObject, eventdata, handles)

    % Get connection object
    if isfield(handles,'obj')
        obj = handles.obj;
    else
        set(handles.t_msg,'String','No connection obj found');   
        return;
    end
    
    artifactRemovalEnable = 0;
     artifactRemovalStimChannel = 0;
    artifactRemovalCoefficients = zeros(24,3);

    % Open the connection
    fopen(obj);
    fwrite(obj,hex2dec('B6'),'char');
    reply = fread(obj,1,'char');
    if reply == 182 %0xB6
        artifactRemovalEnable = fread(obj,1,'char');  
        artifactRemovalStimChannel = fread(obj,1,'char');
        for i = 1:24
            artifactRemovalCoefficients(i,1) = fread(obj,1,'float32'); % m
            artifactRemovalCoefficients(i,2) = fread(obj,1,'float32'); % b
            artifactRemovalCoefficients(i,3) = fread(obj,1,'float32'); % b
        end      
        reply = fread(obj,1,'char');
        set(handles.t_msg,'String','');
        pause(0.5)
        if reply == 182 %0xB6
            save('artifactRemoval.mat','artifactRemovalCoefficients','artifactRemovalEnable','artifactRemovalStimChannel');  
            set(handles.t_msg,'String','Artifact Removal parameters saved into artifactRemoval.mat file');
        else
            set(handles.t_msg,'String','Error reading Artifact Removal parameters'); 
            fclose(obj);
            return
        end
    else
        set(handles.t_msg,'String','Error reading Artifact Removal parameters'); 
        fclose(obj);
        return
    end
    fclose(obj);
    


%% --------------------------------------------------------------------
function menu_setMask_Callback(hObject, eventdata, handles)
    
% Get connection object
    if isfield(handles,'obj')
        obj = handles.obj;
    else
        set(handles.t_msg,'String','No connection obj found');   
        return;
    end
   
    [file, path] = uigetfile({'*.mat'});
    if ~isequal(file, 0)
        [pathstr,name,ext] = fileparts(file);
        if(strcmp(ext,'.mat'))
            load([path,file]);
            if ~exist('maskCoefficients','var')
                disp('Not a valid file');
                errordlg('Not a valid file','Error');
                return;
            end
        else
            disp('Not a valid file');
            errordlg('Not a valid file','Error');
            return;
        end
    else
        return;
    end
    
    if any(size(maskCoefficients) ~= [5,5]) || ... %size is incorrect
            any(any(logical(maskCoefficients(:,[1,3])-round(maskCoefficients(:,[1,3]))))) ||... %channels are not integer
            any(any(maskCoefficients(:,[1,3]) > max(str2double(get(handles.lb_ch,'String'))))) % channels are not valid
        disp('Not a valid matrix');
        errordlg('Not a valid matrix','Error');
        return;
    end

    % Open the connection
    fopen(obj);
    fwrite(obj,hex2dec('C6'),'char');
    reply = fread(obj,1,'char');
    if reply == 198 %0xC6

        for i = 1:5
            fwrite(obj,maskCoefficients(i,1),'float32'); % masking channel 
            fwrite(obj,maskCoefficients(i,2),'float32'); % TMABS threshold
            fwrite(obj,maskCoefficients(i,3),'float32'); % masked channel
            fwrite(obj,maskCoefficients(i,4),'float32'); % scale factor
            fwrite(obj,maskCoefficients(i,5),'float32'); % trailing edge length
        end      
        reply = fread(obj,1,'char');
        set(handles.t_msg,'String','');
        pause(0.5)
        if reply == 198 %0xC6
            set(handles.t_msg,'String','Mask parameters set');
        else
            set(handles.t_msg,'String','Error Setting mask parameters'); 
            fclose(obj);
            return
        end
    else
        set(handles.t_msg,'String','Error Setting mask parameters'); 
        fclose(obj);
        return
    end
    fclose(obj);

%% --------------------------------------------------------------------
function menu_readMask_Callback(hObject, eventdata, handles)

    if isfield(handles,'obj')
        obj = handles.obj;
    else
        set(handles.t_msg,'String','No connection obj found');   
        return;
    end
    
    maskCoefficients = zeros(5,5);

    % Open the connection
    fopen(obj);
    fwrite(obj,hex2dec('C7'),'char');
    reply = fread(obj,1,'char');
    if reply == 199 %0xC7
        
        for i = 1:5
            maskCoefficients(i,1) = fread(obj,1,'float32'); % masking channel 
            maskCoefficients(i,2) = fread(obj,1,'float32'); % TMABS threshold
            maskCoefficients(i,3) = fread(obj,1,'float32'); % masked channel
            maskCoefficients(i,4) = fread(obj,1,'float32'); % scale factor
            maskCoefficients(i,5) = fread(obj,1,'float32'); % trailing edge length
        end      
        reply = fread(obj,1,'char');
        set(handles.t_msg,'String','');
        pause(0.5)
        if reply == 199 %0xC7
            save('maskCoefficientsRead.mat','maskCoefficients');  
            set(handles.t_msg,'String','Mask parameters saved into maskCoefficientsRead.mat file');
        else
            set(handles.t_msg,'String','Error reading mask parameters'); 
            fclose(obj);
            return
        end
    else
        set(handles.t_msg,'String','Error reading mask parameters'); 
        fclose(obj);
        return
    end
    fclose(obj);
    


%% --------------------------------------------------------------------
function menu_setDiffFilter_Callback(hObject, eventdata, handles)

   if isfield(handles,'obj')
        obj = handles.obj;
    else
        set(handles.t_msg,'String','No connection obj found');   
        return;
   end
    
   answer = questdlg('Do you want to enable the difference filter?');
    if strcmp(answer,'Yes')
        diffFilterEnable = 1;
    elseif strcmp(answer,'No')
        diffFilterEnable = 0;
    else
        return;
    end
   
    if diffFilterEnable
    [file, path] = uigetfile({'*.mat'});
        if ~isequal(file, 0)
            [pathstr,name,ext] = fileparts(file);
            if(strcmp(ext,'.mat'))
                load([path,file]);
                if ~exist('differenceFilter','var')
                    disp('Not a valid file');
                    errordlg('Not a valid file','Error');
                    return;
                end
            else
                disp('Not a valid file');
                errordlg('Not a valid file','Error');
                return;
            end
        else
            return;
        end
        if any(size(differenceFilter) ~= [16,1]) %#ok<NODEF>
            disp('Not a valid matrix');
            errordlg('Not a valid matrix','Error');
            return;
        end
    else
        differenceFilter = zeros(16,1);
    end


    % Open the connection
    fopen(obj);
    fwrite(obj,hex2dec('C3'),'char');
    reply = fread(obj,1,'char');
    if reply == 195 %0xC3
        
        fwrite(obj,diffFilterEnable,'char');
        
        for i = 1:16
            fwrite(obj,differenceFilter(i,1),'char'); % m
        end   

        reply = fread(obj,1,'char');
        set(handles.t_msg,'String','');
        pause(0.5)
        if reply == 195 %0xC3
            set(handles.t_msg,'String','Difference filter parameters set');
        else
            set(handles.t_msg,'String','Error setting difference filter parameters'); 
            fclose(obj);
            return
        end
    else
        set(handles.t_msg,'String','Error setting difference filter parameters'); 
        fclose(obj);
        return
    end
    fclose(obj);

%% --------------------------------------------------------------------
function menu_readDiffFilter_Callback(hObject, eventdata, handles)

    if isfield(handles,'obj')
        obj = handles.obj;
    else
        set(handles.t_msg,'String','No connection obj found');   
        return;
    end
    
    differenceFilter = zeros(16,1);

    % Open the connection
    fopen(obj);
    fwrite(obj,hex2dec('C4'),'char');
    reply = fread(obj,1,'char');
    if reply == 196 %0xC4
        
        diffFilterEnable = fread(obj,1,'char');  
        
        for i = 1:16
            differenceFilter(i,1) = fread(obj,1,'char'); % 
        end    

        
        reply = fread(obj,1,'char');
        set(handles.t_msg,'String','');
        pause(0.5)
        if reply == 196 %0xC4
            save('diffFilterRead.mat','diffFilterEnable', 'differenceFilter');  
            set(handles.t_msg,'String','Difference filter parameters saved into diffFilterRead.mat file');
        else
            set(handles.t_msg,'String','Error reading difference filter parameters'); 
            fclose(obj);
            return
        end
    else
        set(handles.t_msg,'String','Error reading difference filter parameters'); 
        fclose(obj);
        return
    end
    fclose(obj);


%% --------------------------------------------------------------------
function menu_FeatureCombination_Callback(hObject, eventdata, handles)

    %--------------------------------------------------------------
    % Compability for old NCALFit
    %--------------------------------------------------------------
    if isfield(handles,'obj')
        obj = handles.obj;
        comPort = obj.Port;
        baudRate = obj.BaudRate;

        delete(instrfindall);                
        serialObj = serialport(comPort, baudRate, 'Databits', 8, ...
        'Byteorder', 'big-endian');

        ALC.testConnection(serialObj);

    else
    set(handles.t_msg,'String','No connection obj found');   
        return;
    end
    
    %--------------------------------------------------------------
    % Update Coefficients
    %--------------------------------------------------------------

    alc = ALC();
    % Get current parameters from ALC
    alc.getRecSettings(serialObj);

    answer = questdlg('Do you want to enable the linear combination of features?');
    if strcmp(answer,'Yes')
        combineFeaturesEnable = 1;
    else
        combineFeaturesEnable = 0;
        activeChannels = 1:16;
        coefficients = zeros(16,16);
        combineFeatures = [activeChannels;coefficients];
        
    end

    if combineFeaturesEnable
    [file, path] = uigetfile({'*.mat'});
        if ~isequal(file, 0)
            [pathstr,name,ext] = fileparts(file);
            if(strcmp(ext,'.mat'))
                load([path,file]);
                if ~exist('combineFeatures','var')
                    disp('Not a valid file');
                    errordlg('Not a valid file','Error');
                    return;
                end
            else
                disp('Not a valid file');
                errordlg('Not a valid file','Error');
                return;
            end
        end
    end
    
    activeChannels = combineFeatures(1,:);
    coefficients = combineFeatures(2:end,:)';

    alc.setFeatureCombinationCoefficients(serialObj,combineFeaturesEnable,coefficients,activeChannels)
    set(handles.t_msg,'String','Combine Features coefficients set'); 
    %--------------------------------------------------------------
    % Compability for old NCALFit
    %--------------------------------------------------------------
    delete(instrfindall);
    handles.obj = serial (comPort, 'baudrate', baudRate, 'databits', 8, 'byteorder', 'bigEndian');
    guidata(hObject,handles);


%% --------------------------------------------------------------------
function menu_control_mia_Callback(hObject, eventdata, handles)

% Open Fig and load information   
    guidata(hObject,handles);
    GUI_MiaHand(handles);


%% check and report prosthesis status
function menu_checkStatus_New_Callback(hObject, eventdata, handles)
    app_Status(handles);
    pause(0.5);
    pb_connect_Callback(handles.pb_connect, eventdata, handles)
    


%% --------------------------------------------------------------------
function menu_controlMia_Callback(hObject, eventdata, handles)

    guidata(hObject,handles);
    GUI_Prosthetics_MIA(handles);


%% configure hands and execute motor commands
function menu_configureHands_Callback(hObject, eventdata, handles)
    set(handles.t_msg,'String','');
    app_Prosthetics(handles);


%% --------------------------------------------------------------------
function menu_writeNN_Callback(hObject, eventdata, handles)

    %--------------------------------------------------------------
    % Compability for old NCALFit
    %--------------------------------------------------------------
    if isfield(handles,'obj')
        obj = handles.obj;
        comPort = obj.Port;
        baudRate = obj.BaudRate;

        delete(instrfindall);                
        serialObj = serialport(comPort, baudRate, 'Databits', 8, ...
        'Byteorder', 'big-endian');

        ALC.testConnection(serialObj);

    else
    set(handles.t_msg,'String','No connection obj found');   
        return;
    end
    
    %--------------------------------------------------------------
    % Get NN coefficients and write them to ALC
    %--------------------------------------------------------------
    
    [file, path] = uigetfile({'*.mat'});
    if ~isequal(file, 0)
        [pathstr,name,ext] = fileparts(file);
        if(strcmp(ext,'.mat'))
            load([path,file]);
            if ~exist('patRec','var')
                disp('Not a valid file');
                errordlg('Not a valid file','Error');
                return;
            end
        else
            disp('Not a valid file');
            errordlg('Not a valid file','Error');
            return;
        end
    end
    
    alc = ALC();
    prostheticOutput = alc.convertMovementArrayToProstheticOutput(patRec.mov, patRec.movOutIdx);
    weights = patRec.patRecTrained.net.Layers(3).Weights;
    bias = patRec.patRecTrained.net.Layers(3).Bias;
    
    
    NNCoefficients.nActiveClasses = patRec.nOuts;
    NNCoefficients.nFeatureSets = size(weights,2);
    NNCoefficients.weights = weights;
    NNCoefficients.bias = bias;
    NNCoefficients.threshold = patRec.networkThresholds; %[0.1 0.5 0.5 0.5 0.5 0.5];
    NNCoefficients.prostheticOutput = prostheticOutput;
    NNCoefficients.mean = patRec.normSets.nMean; %zeros(1,48);
    NNCoefficients.std = patRec.normSets.nStd; %ones(1,48);
    NNCoefficients.propThreshold = zeros(patRec.nOuts-1,2);
    NNCoefficients.streamEnable = 0;
    %NNCoefficients.propThreshold(:,2) = ones(6,1);
    for mov=1:patRec.nOuts-1
        fieldName = patRec.movNames(mov);
        NNCoefficients.propThreshold(mov,1) = patRec.proportionalThresholds.(fieldName{:}).lowerThreshold;
        NNCoefficients.propThreshold(mov,2) = patRec.proportionalThresholds.(fieldName{:}).upperThreshold;
    end
    
    alc.setNNParameters(serialObj,NNCoefficients)
    alc.setPatRecSettings(serialObj,patRec)
    
    
    set(handles.t_msg,'String','NN Coefficients set');  
    
    %--------------------------------------------------------------
    % Compability for old NCALFit
    %--------------------------------------------------------------
    delete(instrfindall); 
    handles.obj = serial (comPort, 'baudrate', baudRate, 'databits', 8, 'byteorder', 'bigEndian');
    guidata(hObject,handles);
    
    


%% --------------------------------------------------------------------
function menu_readNN_Callback(hObject, eventdata, handles)

    %--------------------------------------------------------------
    % Compability for old NCALFit
    %--------------------------------------------------------------
    if isfield(handles,'obj')
        obj = handles.obj;
        comPort = obj.Port;
        baudRate = obj.BaudRate;

        delete(instrfindall);                
        serialObj = serialport(comPort, baudRate, 'Databits', 8, ...
        'Byteorder', 'big-endian');

        ALC.testConnection(serialObj);

    else
    set(handles.t_msg,'String','No connection obj found');   
        return;
    end
    
    %--------------------------------------------------------------
    % Read NN parameters
    %--------------------------------------------------------------

    alc = ALC();
    alc.getNNParameters(serialObj)
    set(handles.t_msg,'String','NN Coefficients read');  
    NNCoefficientsRead = alc.NNCoefficients;
    save('ReadNNCoefficients.mat', 'NNCoefficientsRead')
    
    %--------------------------------------------------------------
    % Compability for old NCALFit
    %--------------------------------------------------------------
    delete(instrfindall); 
    handles.obj = serial (comPort, 'baudrate', baudRate, 'databits', 8, 'byteorder', 'bigEndian');
    guidata(hObject,handles);


%% --------------------------------------------------------------------
function menu_streamNN_Callback(hObject, eventdata, handles)

    app_FeatureVectorStream(handles)

    
%% --------------------------------------------------------------------
function menu_NNThresholds_Callback(hObject, eventdata, handles)

    app_NetworkThresholds(handles)


%% --------------------------------------------------------------------
function menu_PropThresholds_Callback(hObject, eventdata, handles)

    app_ProportionalThresholds(handles)


%% --------------------------------------------------------------------
function menu_recording_Callback(hObject, eventdata, handles)

    app_RecordMovements(handles)


%% --------------------------------------------------------------------
function menu_ThresholdRatio_Callback(hObject, eventdata, handles)

    app_ThresholdRatio(handles);


%% --------------------------------------------------------------------
function reset_SDCard_Callback(hObject, eventdata, handles)
if isfield(handles,'obj')
    obj = handles.obj;
else
    set(handles.t_msg,'String','No connection obj found');
    return;
end

f = questdlg({'Are you sure you want to reset the SD card to default values?','This will not affect the dataLog or blockIdx'},'Reset SD Card?','Yes','No','No');

if strcmp(f,'No')
    return;
end

% Open the connection
try
    fopen(obj);

    fwrite(obj,hex2dec('F1'),'char');
    reply = fread(obj,1,'char');

    assert(reply == hex2dec('F1'),'menu_setDatalog_Callback:noreply','Error receiving reply from ALC');

    reply = char(fread(obj,1,'char'));

    assert(reply == hex2dec('F1'),'menu_setDatalog_Callback:badreply','Error resetting SD card');

    fclose(obj);

catch exception
    set(handles.t_msg,'String',exception.message);
    fclose(obj);
    return
end

%% create functions

function pm_ComPort_CreateFcn(hObject, eventdata, handles)
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

%% empty/superfluous callback functions
function menu_Control_Callback(hObject, eventdata, handles)
function et_sT_Callback(hObject, eventdata, handles)
function et_Mode_Callback(hObject, eventdata, handles)
function lb_ch_Callback(hObject, eventdata, handles)
function et_Ampp_Callback(hObject, eventdata, handles)
function FiltCheckBox_Callback(hObject, eventdata, handles)
function txt_COM_Callback(hObject, eventdata, handles)
function eT_samples_Callback(hObject, eventdata, handles)
function cb_WiFi_Callback(hObject, eventdata, handles)
function cb_wl_Callback(hObject, eventdata, handles)
function cb_zc_Callback(hObject, eventdata, handles)
function cb_slpch_Callback(hObject, eventdata, handles)
function cb_mabs_Callback(hObject, eventdata, handles)
function menu_test_Callback(hObject, eventdata, handles)
function cb_std_Callback(hObject, eventdata, handles)
function menu_Hardware_Callback(hObject, eventdata, handles)
function menu_PR_Callback(hObject, eventdata, handles)
function menu_SD_Callback(hObject, eventdata, handles)
function cb_FFT_Callback(hObject, eventdata, handles)
function pm_movement_Callback(hObject, eventdata, handles)
function et_speedMov_Callback(hObject, eventdata, handles)
function et_timeMov_Callback(hObject, eventdata, handles)
function et_tPredict_Callback(hObject, eventdata, handles)
function et_tW_Callback(hObject, eventdata, handles)
function et_oW_Callback(hObject, eventdata, handles)
function menu_NS_Callback(hObject, eventdata, handles)
function menu_prosthesis_Callback(hObject, eventdata, handles)
function menu_EF_Callback(hObject, eventdata, handles)
function menu_Neural_Network_Callback(hObject, eventdata, handles)

%% useless create functions

function et_oW_CreateFcn(hObject, eventdata, handles) 
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function et_sT_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function et_Mode_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function lb_ch_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function et_Ampp_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function txt_COM_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function eT_samples_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function pm_movement_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function et_speedMov_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function et_timeMov_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function pm_control_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function et_tW_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% outdated functions
% depreciated function
function menu_streamAndNS_Callback(hObject, eventdata, handles)
% hObject    handle to menu_streamAndNS (see GCBO)
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
    set(handles.pb_stop,'Enable','on');
       
    % Open the connection
    fopen(obj);
    % Read available data and discard it
    if obj.BytesAvailable > 0
        fread(obj,obj.BytesAvailable,'uint8');    % Read the samples        
    end
    
    %find the sampling frequency in use
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
            %status = sprintf('Sampling  is use = %d Hz', sF);
            %msgbox(status,'System Status');
        else
            set(handles.t_msg,'String','Error, device is not responding or COM port is changed!'); 
            fclose(obj);
            return
        end
    else
        set(handles.t_msg,'String','Error, device is not responding or COM port is changed!');   
        fclose(obj);
        return
    end
    handles.sF = sF;
    sT = str2double(get(handles.et_sT,'String'));
    tW = 0.2;
    
    % compression algorithm
    compressionEnabled = 1;

    %Selected channels
    allCh = str2double(get(handles.lb_ch,'String'))-1;
    vCh = allCh(get(handles.lb_ch,'Value'))+1; % Vector of channels
    nCh = size(vCh,1);
    chIdxDiff = bitshift(sum(bitset(0,vCh)),-16);
    chIdxUpper = bitshift(sum(bitset(0,vCh)),-8);
    chIdxUpper = bitand(chIdxUpper,255);
    chIdxLower = bitand(sum(bitset(0,vCh)),255);
       
    % Setting for data peeking
    tv = 0:1/sF:tW-1/sF;                                                   % Create vector of time
    tWs = tW*sF;                                                           % Time window samples
    sData = zeros(tWs,nCh);                                                % tWs sized matrix useful for real time plot
    allData = zeros(sT*sF, nCh);                                           % sT*sF sized matrix used for keep all datas
    
    plotGain = 10000000;
    
    % Offset the plot of the different channels to fit into the main figure
    ampPP     = 5;
    offVector = 0:nCh-1;
    offVector = offVector .* ampPP;
    for i = 1 : nCh
        sData(:,i) = sData(:,i) + offVector(i);
    end    
    
    % Draw figure
    p_t0 = plot(handles.a_t0, tv, sData);
    xlim([0,tW]);  
    set(handles.a_t0,'YTick',offVector);
    set(handles.a_t0,'YTickLabel',vCh);   

    sData = zeros(tWs, nCh);                                               % tWs sized vector used for offset and plot datas
    printFlag = 1; 

    % stimulation parameters
    stimChannel = 1; % NOTE: zero-indexed
    stimAmplitude = 50; % NOTE: amplitude in tents of uA 
    stimPulseWidth = 20; % NOTE: amplitude in tents of us 
    stimFrequency = 30;
    stimPulses = 1;
    stimCountdown = floor((1/stimFrequency)/(1/sF));
    stimCounter = 0;
    
    % Start the acquisition
    fwrite(obj,'G','char');
    fwrite(obj,chIdxDiff,'uint8');
    fwrite(obj,chIdxUpper,'uint8');
    fwrite(obj,chIdxLower,'uint8');
    fwrite(obj,nCh,'uint8');
    reply = char(fread(obj,1,'char'));
    switch reply
        case 'G'
            set(handles.t_msg,'String','EMG Start');
    end
    
    tic;
    for i = 1:sT*sF  

        % check when to stimulate
        if stimCounter>stimCountdown
            % stimulation!
            fwrite(obj,hex2dec('B4'),'char');
            fwrite(obj,stimChannel,'char');
            fwrite(obj,stimAmplitude,'char');
            fwrite(obj,stimPulseWidth,'char');
            fwrite(obj,stimFrequency,'char');
            fwrite(obj,stimPulses,'char');
            stimCounter = 0;
        else
            stimCounter = stimCounter + 1;
        end
        
        % Set warnings to temporarily issue error (exceptions)
        s = warning('error', 'instrument:fread:unsuccessfulRead');
        try
            if compressionEnabled
                % compressed int16 data mode (2bytes X nCh channels)
                tmpData = fread(obj,nCh,'int16');
                byteData = DecompressData(tmpData);
            else
                % float data mode (4bytes X nCh channels)
                byteData = fread(obj,nCh,'float32');    
            end
            allData(i,:) = byteData(1:nCh,:)';
            sData(printFlag,:) = byteData(1:nCh,:)';
        catch exception
           set(handles.t_msg,'String','Error in communication'); 
           delete(obj);
           return
        end
        %Set warning back to normal state
        warning(s);
        
        printFlag = printFlag + 1; 
        if printFlag >= tWs+1 
            
            % calculate single channel's plot gain for time window
            % the idea is that the gain is automatically scaled depending on the absolute maximum
            % value found in this new recording. In this way the gain will be changed
            % dynamically to be able to discern a "rest" from a "contraction" plot
            K = ampPP/(2*(max(max(abs(sData)))));
            if K < plotGain
                % if the signals in the different windows is getting bigger the gain
                % must be reduced consequently, the channels plots must always fit
                % the main plot
                plotGain = K;
            end
            % plot a new tWs sized window
            for j = 1 : nCh
                set(p_t0(j),'YData',sData(:,j)*plotGain + offVector(j));       % add offsets to plot channels in same graph
            end 
            printFlag = 1;
            drawnow 
        end 
        
        if go == 0
            break;
        end
        
    end
    
    toc;
    
    % Stop the aquisition
    fwrite(obj,'T','char');
    
    % Close connection
    fclose(obj);
    set(handles.pb_stop,'Enable','off');
    go = 0;
    disp(obj);
    
    % Print the data    
    tv = 0:1/sF:sT-1/sF;                                                   % Create vector of time
    for i = 1:sT*sF 
        for k = 1:nCh        
            sData(i,k) = allData(i,k)*plotGain + offVector(k);
        end 
    end
    plot(tv, sData);
    set(handles.a_t0,'YTick',offVector);
    set(handles.a_t0,'YTickLabel',vCh); 
    
    set(handles.t_msg,'String','');
    save('EMG.mat','allData','sF','vCh'); 


% --------------------------------------------------------------------
function menu_SetDC_MIA_Callback(hObject, eventdata, handles)
% hObject    handle to menu_SetDC_MIA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    guidata(hObject,handles);
    GUI_SetDC_MIA(handles);


% --------------------------------------------------------------------
function menu_MIA_DC_Callback(hObject, eventdata, handles)
% hObject    handle to menu_MIA_DC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Fucntion toggles the MIA DC flag
    if isfield(handles,'obj')
        obj = handles.obj;
    else
        set(handles.t_msg,'String','No connection obj found');   
        return;
    end
    fopen(obj);

    fwrite(obj,'S',char);
    replay = fread(obj,1,'char');
    if (char(replay)~='S')
        set(handles.t_msg,'String','Error setting MIA DC');
        return;
    end
    flag = fread(obj,1,"uint8");
    replay = fread(obj,1,"char");
    if strcmp(char(replay),'S')
        if (flag)
            set(handles.t_msg,'String','MIA DC enabled');
        else
            set(handles.t_msg,'String','MIA DC disabled');
        end
    else
        set(handles.t_msg,'String','Error setting MIA DC');
        return;
    end
