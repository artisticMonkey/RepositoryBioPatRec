classdef ALC < handle
    %ALC This class handles all communication between the ALC and Matlab
    
    
    % These properties are hard coded on the ALC and don't change unless a bigger firmware revision was made
	properties (Constant)
        % Property ranges for error checking
        allowedComPortTypes = 'COM';                                % Port type supported by ALC
        allowedChannels = 1:24;                                     % Number of total channels on ALC
        allowedSamplingRates = [100,150,250,500,1000,2000];         % Available sampling frequencies on ALC
        
        % Device properties
        numberOfMovements = 8;                                      % Number of movements available on ALC
        numberOfMiaMovements = 9;                                      % Number of movements available on ALC
        numberOfFeatures = 5;                                       % Number of features available on ALC
        numberOfChannels = 16;                                      % Number of physical channels on ALC
        numberOfClasses = 11;                                        % Number of classes on ALC
        numberOfExtraChannels = 8;                                    % Number of extra channels on ALC
        featuresSize = 5*16;                                        % Max size of a feature matrix on ALC
        featureNames = {'tmabs'; 'twl'; 'tzc'; 'tslpch2'; 'tstd'};  % Names of available features on ALC
        
        movementNames       = {'Open Hand', 'Close Hand', 'Pronation', 'Supination', 'Flex Elbow', 'Extend Elbow', ...
                               'Thumb Extend', 'Thumb Flex','Index Extend', 'Index Flex', 'Middle Extend', 'Middle Flex', ...
                               'Switch Grasp', ...
                               'Lock/Unlock Elbow', 'Lock/Unlock Cocontraction', 'Rest'};
                           
        movementNamesSwe    = {'Öpna handen', 'Stäng handen', 'Vrid handleden inåt', 'Vrid handleden utåt', 'Böj armbågen', 'Sträck armbågen', ...
                               'Sträck tummen', 'Böj tummen', 'Sträck pekfingret', 'Böj pekfingret', 'Sträck långfingret', 'Böj långfingret', ...
                               'Byt grepp', ...
                               'Lås armbågen', 'Lås cocontraction', 'Slappna av'}; 
                           
        movementIndex       = [1 2 4 8 16 32 65 66 68 72 80 96 128 129 130 0]; % Movement IDs
        
        graspNames          = {'Cylindric grasp', 'Bidigit grasp', 'Lateral grasp', 'Spherical grasp', 'Tridigit grasp', 'Rest'}
        
        graspIndex          = [132 133 134 135 135 0]; % Grasp IDss 
        
        movementNamesOB     = {'Open Hand', 'Close Hand', 'Pronation', 'Supination', 'Flex Elbow', 'Extend Elbow', ...
                               'Lock/Unlock Elbow', 'Lock/Unlock Cocontraction', 'Rest'}; % Movements specific to the Ottobock hand
                           
        movementNamesMia    = {'Open Hand', 'Close Hand', 'Pronation', 'Supination', 'Thumb Extend', 'Thumb Flex', ...
                               'Index Extend', 'Index Flex', 'Middle Extend', 'Middle Flex', 'Switch Grasp', 'Rest'}; % Movement specific to the Mia Hand
        
        handNames            = {'Generic PWM Hand', 'OB Sensor Hand', 'Mia Hand'};
        
        controlAlgorithmNames = {'None', 'Majority Vote', 'Ramp', 'Delicate Grasp', 'Inertial'};
        
        controlModeName       = {'Direct Control', 'Linear Discriminant Analysis', 'Support Vector Machine', 'Linear Regression', 'Transient SVM', 'Neural Network', 'Transient SVM Poly'};
        
        stimulationModeName   = {'None', 'Fixed stimulation', 'Amplitude modulation', 'Frequency modulation', 'Pulse-width modulation', 'Pulse-width and frequency modulation', 'Biomimetic Modulation'};

        stimResponses = containers.Map([ ...
                                hex2dec('AA'), hex2dec('81'), hex2dec('82'), hex2dec('83'), hex2dec('85'), ... %
                                hex2dec('86'), hex2dec('87'), hex2dec('88'), hex2dec('89'),hex2dec('90')], ...
                                {'ACK_OK' ,'WRONG_CMD_OPCODE' ,'WRONG_CHECKSUM' ,'WRONG_CMD_STRUCTURE' ,'STIM_ONGOING' ,'PARAM_OUT_OF_RANGE' ,'STIM_CHARGE_TOO_HIGH' ,'STIM_SATURATED' ,'STIM_TEST', 'STIM_TIMEOUT'});
     
     
	end
    
    properties 

        % State machine
        
        alcdMode = 0;                       % 0 = control mode, 1 = command mode, 4 = stream features, 6 = stream closed loop
        alcdState = 0;                      % 0 = idel, 1 = acquire EMG, 2 = acquire increment tW, 3 = extract features, 4 = identify movements, 5 = update hand sensors, 6 = output mov feedback
        
        % Active channels
        
        activeChannels = 1:16;
        chIdxExtra = 0;                     % ID of channels 17-24
        chIdxUpper = 255;                   % ID of channels 9-16
        chIdxLower = 255;                   % ID of channels 1-8
        activeChannelIndices = 65535;       % Decimal representation of active channels
        extraChannelsMatrix = zeros(8,16);  % Weights for combined channels 17-24
        numberOfActiveChannels = 16;        % Number of currently active channels
        
        % Sampling
        
        samplingFrequency = 1000;           % Current sampling frequency
        timeWindowSamples = 100;            % Current number of samples per window
        overlappingSamples = 0;             % Current number of samples overlapping per window
        samplesCounter = 0;                 % Current amount of acquired samples
        switchPauseCounter = 0;             % Current pause counter for execution time-outs
        
        % En-/Disable modules
        
        motorEnable = 1;                    % Motor enable ON/OFF
        filterEnable = 0;                   % Notch filter enable OF/OFF
        compressionEnable = 1;              % EMG compression ON/OFF
        combFilterEnable = 0;               % Comb filter ON/OFF
        differenceFilterEnable = 0;         % Difference filter ON/OFF
        featureCombinationEnable = 0;       % Feature combination ON/OFF
        iNEMO = 0;                          % IMU ON/OFF
        
        % Features
        
        featuresEnabled = [1,0,0,0,0];      % Currently enabled features [mav, wl, zc, slpch, std]
        numberOfActiveFeatures = 1;         % Number of channels active on ALC
        
        
        % Movements
        
        numberOfActiveMovements = 8;        % Currently active movements
        
        % Signal processing
        
        maskCoefficients = zeros(5,5);      % Coefficient matrix for masking
        maskEnable = 0;                     % Mask enabled/disabled
        
        
        
        % Control algorithms
        controlAlgorithm = 0;               % Selected control algorithm
        mvSteps = 3;                        % Number of votes for majorty vote
        rampLength = 10;                    % Length of ramp
        rampMode = 1;                       % Ramp mode ON/OFF
        delicateGrasp = 0;                  % Delicate grasp ON/OFF
        delicateGraspThreshold = 35;        % Threshold for delicate grasp
        inertialCoefficients = zeros(3,1)   % Coefficients for inertial mode
 
        % Control parameters
        handInUse = 0;                      % Currently used hand (0 = Speed hand, 1 = Sensor hand, 2 = MIA hand)
        sensitivity = 1;                    % Sensitivity of output speed mapping
        handSwitchMode = 0;                 % Currently used hand mode (0 = automatic switch mode, 1 = analog)
        handMinimumSpeed = 22;              % Minimum speed set for hand
        handMaximumSpeed = 60;              % Maximum speed set for hand
        wristMinimumSpeed = 30;             % Minimum wrist rotation speed 
        wristMaximumSpeed = 100;            % Maximum wrist rotation speed
        elbowMinimumSpeed = 20;             % Minimum elbow speed
        elbowMaximumSpeed = 50;             % Maximum elbow speed   
        miaMinActivationThreshold = 10;
        miaSensitivity = 1.0;
        miaMinimumSpeed = 1;
        miaMaximumSpeed = 100;
        miaMinModulationSpeedStep = 3;
        miaMaxModulationSpeedStep = 8;
        miaMinPwm = 30;
        miaMaxPWM = 80;
                
        miaParameters = struct('graspControlMode', 2, 'graspStepSize', 3, 'graspDiscretization', 10, ...
                               'graspModeEnabled', 1, 'forceControlEnabled', 0, ...
                               'holdOpenEnabled', 1, 'holdOpenTime', 20, 'holdOpenThreshold', 50);
        % Prediction
        NNCoefficients = struct('nActiveClasses', [], 'nFeatureSets', [], 'weights', [], 'bias', [], ...
                                'threshold', [], 'prostheticOutput', [], 'mean', [], 'std', [], 'propThreshol', [], 'floorNoise', [], 'switchThreshold', [], 'streamEnable', []);
        LDACoefficients = struct('weights',[],'bias',[]);                       % LDA coefficients (weights: nMovements x featuresSize, bias: nMovements)
        SVMCoefficients = struct('weights',[],'bias',[],'scale',[],'shift',[]); % SVM coefficients (weights: nMovements x featuresSize, bias: nMovements, scale: featuresSize, shift: featuresSize)
        regressionCoefficients = struct('b',[],'chIndices',[]); 

        % Control
        controlMode = 0;
                        % Regression coefficients (bias: nMovements x nChannels)
        normalizationParameters = struct('range',[],'midrange',[]);             % Normalize parameters (range: featureSize% midrange: featureSize)         
        propPRTable = struct('prostheticOutput',[],'channelsMVC',[]);           % Proportionality table (prostheticOuptut: nMovements, channelsMVC: nMovements x nChannels + nExtraChannels)
        
        proportionalParameters = struct('strengthFilterLength', []);
        thresholdRatioParameters = zeros(2,1);
        thresholdRatioEnable = 0;           % Threshold ratio enabled/disabled
        
        % Direct control movements
        openHand = struct('movementName',"open hand",'active',0, ...
                    'pwmOutput',0,'chAcqIndex',0,'motorThresh',0,...
                    'mvcLevel',0,'moveIndex',1);
        closeHand = struct('movementName',"close hand",'active',0, ...
                    'pwmOutput',0,'chAcqIndex',0,'motorThresh',0,...
                    'mvcLevel',0,'moveIndex',2);
        switch1 = struct('movementName',"switch 1",'active',0, ...
                    'pwmOutput',0,'chAcqIndex',0,'motorThresh',0,...
                    'mvcLevel',0,'moveIndex',129);
        pronation = struct('movementName',"pronation",'active',0, ...
                    'pwmOutput',0,'chAcqIndex',0,'motorThresh',0,...
                    'mvcLevel',0,'moveIndex',4);
        supination = struct('movementName',"supination",'active',0, ...
                    'pwmOutput',0,'chAcqIndex',0,'motorThresh',0,...
                    'mvcLevel',0,'moveIndex',8);
        flexElbow = struct('movementName',"flex elbow",'active',0, ...
                    'pwmOutput',0,'chAcqIndex',0,'motorThresh',0,...
                    'mvcLevel',0,'moveIndex',16);
        extendElbow = struct('movementName',"supination",'active',0, ...
                    'pwmOutput',0,'chAcqIndex',0,'motorThresh',0,...
                    'mvcLevel',0,'moveIndex',32);
        cocontraction = struct('movementName',"cocontraction",'active',0, ...
                    'pwmOutput',0,'thresh1',0,'thresh2',0,'moveIndex',130);
       
        % Filters
        combFilterOrder = 0; 
        combFilterCoefficients = [0,0,0];
        differenceFilterCoefficients = zeros(16,1);   
                
        % SD card
        sdCard = 0;
        sdBlockSize = 512;
        sdMemorySize = 16000000000;
        sdBlockID = 0;
        sdBlocks;
        
        % Stimulation:
        nsEnable = 0;
        nsArtifactRemovalMatrix = [];
        nsArtifactRemovalEnable = 0;
        nsArtifactRemovalStimChannel = 0;
        stimParameters = struct('mode',0,'channel',0,'amplitude',0,...
                            'pulseWidth',0,'frequency',0,'repetitions',0,...
                            'modAmpTop',0,'modAmpLow',0,'modPWTop',0,...
                            'modPWLow',0,'modFreqTop',0,'modFreqLow',0,...
                            'DESCenable',0,'DESCchannel',0,'DESCamplitude',0,...
                            'DESCpulseWidth',0,'DESCfrequency',0,...
                            'DESCrepetitions',0,'DESCatSlips',0);
                        
        % Stimulation information:                
        % max stimulation charge: 5000u [0.5 uC]
        % max stimulation amplitude: 100u [1000 uA]
        % max stimulation pw: 50u [500 us]
        % max stimulation frequency: 100u [100 Hz]
        
        % Various
        vBattery = 0;
        temperature = 0;
        
    end
    
    methods
        
        %% Class constructor
        %------------------------------------------------------------------
        function objALC = ALC()
            % set default values

        end
        
        %% Status commands
        %------------------------------------------------------------------
        
        function getStatus(self,obj)
        % Get current status of ALC     
            try
                identificationByte = 0x21;
                
                obj.flush();
                write(obj,identificationByte,'uint8');
                
                % First confirmation Byte
                rsp = read(obj,1,'uint8');
                self.firstResponseCheck(rsp, identificationByte, 'getStatus')
             
                % fill status struct
                status.vBattery = read(obj,1,'single');
                status.temperature = read(obj,1,'single');
                status.handInUse = read(obj,1,'uint8');
                status.nsEnable = read(obj,1,'uint8');
                status.sdCard = read(obj,1,'uint8');
                status.iNEMO = read(obj,1,'uint8');
                status.motorEnable = read(obj,1,'uint8'); 
                status.filterEnable = read(obj,1,'uint8');
                status.controlAlgorithm = read(obj,1,'uint8');
                status.controlMode = read(obj,1,'uint8');
                status.timeWindowSamples = read(obj,1,'uint32');
                status.overlappingSamples = read(obj,1,'uint32');
                status.samplingFrequency = read(obj,1,'uint32');
                status.numberOfActiveChannels = read(obj,1,'uint8');
                status.numberOfActiveFeatures = read(obj,1,'uint8');
                status.rampLength = read(obj,1,'uint8');
                status.rampMode = read(obj,1,'uint8');
                status.inertialCoefficients(1) = read(obj,1,'uint8');
                status.inertialCoefficients(2)  = read(obj,1,'uint8');
                status.inertialCoefficients(3)  = read(obj,1,'uint8');
                status.mvSteps = read(obj,1,'uint8');
                status.delicateGrasp = read(obj,1,'uint8');
                status.delicateGraspThreshold = read(obj,1,'uint8');
                status.sensitivity = read(obj,1,'single');
                status.handMinimumSpeed = read(obj,1,'uint8');
                status.handMaximumSpeed = read(obj,1,'uint8');
                status.handSwitchMode = read(obj,1,'uint8');
                status.wristMinimumSpeed = read(obj,1,'uint8');
                status.wristMaximumSpeed = read(obj,1,'uint8');
                status.elbowMinimumSpeed = read(obj,1,'uint8');
                status.elbowMaximumSpeed = read(obj,1,'uint8');
                status.switchPauseCounter = read(obj,1,'uint8');
                
                % Final confirmation Byte
                rsp = read(obj,1,'uint8');
                self.finalResponseCheck(rsp, identificationByte, 'getStatus')
                
                % store read variables
                self.vBattery = status.vBattery;
                self.temperature = status.temperature;
                self.handInUse = status.handInUse; 
                self.nsEnable = status.nsEnable;
                self.sdCard = status.sdCard;
                self.iNEMO = status.iNEMO;
                self.motorEnable = status.motorEnable;
                self.filterEnable = status.filterEnable;
                self.controlAlgorithm = status.controlAlgorithm;
                self.controlMode = status.controlMode;
                self.timeWindowSamples = status.timeWindowSamples;
                self.overlappingSamples = status.overlappingSamples;
                self.samplingFrequency = status.samplingFrequency;
                self.numberOfActiveChannels = status.numberOfActiveChannels;
                self.numberOfActiveFeatures = status.numberOfActiveFeatures;
                self.rampLength = status.rampLength;
                self.rampMode = status.rampMode;
                self.mvSteps = status.mvSteps;
                self.delicateGrasp = status.delicateGrasp;
                self.delicateGraspThreshold = status.delicateGraspThreshold;
                self.sensitivity = status.sensitivity;
                self.handMinimumSpeed = status.handMinimumSpeed;
                self.handMaximumSpeed = status.handMaximumSpeed;
                self.handSwitchMode = status.handSwitchMode;
                self.wristMinimumSpeed = status.wristMinimumSpeed;
                self.wristMaximumSpeed = status.wristMaximumSpeed;
                self.elbowMinimumSpeed = status.elbowMinimumSpeed;
                self.elbowMaximumSpeed = status.elbowMaximumSpeed; 
                self.switchPauseCounter = status.switchPauseCounter; 
                
            catch e
                if exist('obj','var')
                    delete(obj);
                end
                error(e.message)
                return
            end
        end
        
        function getRecSettings(self,obj)
        % Get ALC settings needed to update Matlab for recordings
            try
                identificationByte = 0x22;
                
                obj.flush();
                write(obj,identificationByte,'uint8');
                
                % First confirmation Byte
                rsp = read(obj,1,'uint8');
                self.firstResponseCheck(rsp, identificationByte, 'getRecSettings')
                                
                status.numberOfActiveChannels = read(obj,1,'uint8');
                status.chIdxExtra = read(obj,1,'uint8');
                status.chIdxUpper = read(obj,1,'uint8');
                status.chIdxLower = read(obj,1,'uint8');
                status.numberOfActiveFeatures = read(obj,1,'uint8');
                status.featuresEnabled = read(obj,self.numberOfFeatures,'uint8');
                status.timeWindowSamples = read(obj,1,'uint32');
                status.overlappingSamples = read(obj,1,'uint32');
                status.samplingFrequency = read(obj,1,'uint32');
                status.compressionEnable = read(obj,1,'uint8');
                status.featureCombinationEnable = read(obj,1,'uint8');
                status.handInUse = read(obj,1,'uint8');
                
                % Final confirmation Byte
                rsp = read(obj,1,'uint8');
                self.finalResponseCheck(rsp, identificationByte, 'getRecSettings')
                
                self.numberOfActiveChannels = status.numberOfActiveChannels;
                self.chIdxExtra = status.chIdxExtra;
                self.chIdxUpper = status.chIdxUpper;
                self.chIdxLower = status.chIdxLower;
                self.numberOfActiveFeatures = status.numberOfActiveFeatures;
                self.featuresEnabled = status.featuresEnabled;
                self.timeWindowSamples = status.timeWindowSamples;
                self.overlappingSamples = status.overlappingSamples; 
                self.samplingFrequency = status.samplingFrequency;
                self.compressionEnable = status.compressionEnable;
                self.featureCombinationEnable = status.featureCombinationEnable;
                self.handInUse = status.handInUse;
                    
                self.activeChannels = [];
                tempLower = flip(dec2bin(self.chIdxLower,8));
                tempUpper = flip(dec2bin(self.chIdxUpper,8));
                tempExtra = flip(dec2bin(self.chIdxExtra,8));

                for bit=1:8
                    if tempLower(bit) == '1'
                       self.activeChannels = [self.activeChannels bit];
                    end

                    if tempUpper(bit) == '1'
                       self.activeChannels = [self.activeChannels bit+8];
                    end

                    if tempExtra(bit) == '1'
                       self.activeChannels = [self.activeChannels bit+16];
                    end
                end
                    
                self.activeChannels = sort(self.activeChannels);
                self.numberOfActiveChannels = length(self.activeChannels);

                if self.featureCombinationEnable
                    self.activeChannels = self.activeChannels(find(self.activeChannels>16));
                    self.numberOfActiveChannels = length(self.activeChannels);
                end

                
            catch e
                if exist('obj','var')
                    delete(obj);
                end
                    error(e.message)
                return
            end        
        end
        
        %% Start/stop acquisition commands
        %------------------------------------------------------------------
       
        function startRawACQ(self,obj)
        % Start EMG continous acquistion
            try
                
                identificationByte = 0x47; % = 'G'
                
                obj.flush;
                write(obj,identificationByte,'uint8');
                write(obj,self.chIdxExtra,'uint8');
                write(obj,self.chIdxUpper,'uint8');
                write(obj,self.chIdxLower,'uint8');
                write(obj,self.numberOfActiveChannels,'uint8');
                rsp = read(obj,1,'uint8');
                self.firstResponseCheck(rsp, identificationByte, 'startRawACQ')
                
                % Set state and mode
                self.alcdState = 1;   % acquire EMG
                self.alcdMode = 1; % command mode
                
               
            catch e
                if exist('obj','var')
                    delete(obj);
                end
                    error(e.message)
                return
            end
        end
        
        function startFeaturesACQ(self,obj)
        % Start EMG acquistion and features
            try
                
                identificationByte = 0x58; % = 'X'
                % Send the START command
                write(obj,identificationByte,'uint8');
                write(obj,self.chIdxExtra,'uint8');
                write(obj,self.chIdxUpper,'uint8');
                write(obj,self.chIdxLower,'uint8');
                write(obj,self.numberOfActiveChannels,'uint8');
                
                rsp = read(obj,1,'uint8');
                self.firstResponseCheck(rsp, identificationByte, 'startFeaturesACQ')
                
                self.alcdState = 2;  % acquire increment tw
                self.alcdMode = 4;   % streaming features
                   
            catch e
                if exist('obj','var')
                    delete(obj);
                end
                    error(e.message)
                return
            end
        end
        
        function startClosedLoopACQ(self,obj)
        % Start closed-loop feature acquisition
            try
                
                identificationByte = 0x59; % = 'Y'
                % Send the START command
                write(obj,identificationByte,'uint8');
                rsp = read(obj,1,'uint8');
                self.firstResponseCheck(rsp, identificationByte, 'startClosedLoopACQ')
                
                self.alcdState = 2;  % acquire increment tw
                self.alcdMode = 6;   % streaming features in closed loop
                self.samplesCounter = 0;
                    
            catch e
                if exist('obj','var')
                    delete(obj);
                end
                    error(e.message)
                return
            end
        end
        
        function startSensoryACQ(self,obj)
            try
                
                identificationByte = 0x4E; % = 'N'
                write(obj,identificationByte,'uint8');
                rsp = read(obj,1,'uint8');
                self.firstResponseCheck(rsp, identificationByte, 'startSensoryACQ')
                
                self.alcdState = 2;  % acquire increment tw
                self.alcdMode = 7;   % streaming features in closed loop
                self.samplesCounter = 0;

            catch e
                if exist('obj','var')
                    delete(obj);
                end
                    error(e.message)
                return
            end
        end
        
        function stopACQ(self,obj)
        % Stop EMG continuous acquisition 
            try
                identificationByte = 0x54; % = 'T'
                write(obj,identificationByte,'uint8');
                               
                self.alcdState = 0;  % idle
                self.alcdMode = 1;   % command mode

                
                pause(0.5);
                % Flush serial in- and outputs
                obj.flush;
            catch e
                error(e.message)
                return
            end
        end
        
        %% Get block of EMG from ALC
        %------------------------------------------------------------------
        
        function data = acquireTWs(self,obj,timeWindowSamples)
        % Get one windows of raw EMG    
            try
                tWs = timeWindowSamples;
                nCh = self.numberOfActiveChannels;
                chIdxUpperTmp = self.chIdxUpper;
                chIdxLowerTmp = self.chIdxLower;
                chIdxDiffTmp = self.chIdxExtra;
                
                % allocate memory
                data = zeros(tWs,nCh);
                
                for sampleNr = 1:tWs
                    go = 0;
                    while go == 0
                       
                        if self.compressionEnable
                            % compressed int16 data mode (2bytes X nCh channels)
                            tmpData = read(obj,nCh,'int16');
                            byteData = self.decompressData(tmpData);
                        else
                            % float data mode (4bytes X nCh channels)
                            byteData = read(obj,nCh,'single');
                        end                            % float data mode (4bytes X nCh channels)
                        if byteData < 5
                            go = 1;
                        else
                            % Synchronize the device again
                            write(obj,'T','char');
                            % Read available data and discard it
                            if obj.NumBytesAvailable > 0
                                read(obj,obj.NumBytesAvailable,'uint8');
                            end
                            write(obj,chIdxDiffTmp,'uint8');
                            write(obj,chIdxUpperTmp,'uint8');
                            write(obj,chIdxLowerTmp,'uint8');
                            write(obj,nCh,'uint8');
                            read(obj,1,'char');
                            disp('Communication issue: automatic resynchronization')
                            go = 0;
                        end
                    end
                    data(sampleNr,:) = byteData;
                end               
            catch e
                if exist('obj','var')
                    delete(obj);
                end
                    error(e.message)
                return
            end
        end
        
        %% Set ALC modes
        %------------------------------------------------------------------
           
        function setCommandMode(self,obj)
        % Switch to command mode
            try
                identificationByte = 0xAA;

                obj.flush();
                write(obj,identificationByte,'uint8');

                rsp = char(read(obj,4,'uint8'));
                if strcmp(rsp,'COMM')
                    fprintf('Command mode set.\n');
                    self.alcdState = 0; % idle
                    self.alcdMode = 1;  % command mode
                else
                    self.firstResponseCheck(rsp, identificationByte, 'setCommandMode')
                end
                
            catch e
                if exist('obj','var')
                    delete(obj);
                end
                error(e.message)
                return
            end
        end 
        
        function setControlMode(self,obj)
        % Switch to control mode
            try
                identificationByte = 0xEE;

                obj.flush();
                write(obj,identificationByte,'uint8');
                
                rsp = char(read(obj,4,'char'));
                if strcmp(convertCharsToStrings(rsp),'CTRL')
                    fprintf('Control mode set.\n');
                    self.alcdState = 2; % acquire increment tw
                    self.alcdMode = 0;  % control mode
                    self.samplesCounter = 0;
                else
                    self.firstResponseCheck(rsp, identificationByte, 'getStimParameters')
                end
            catch e
                if exist('obj','var')
                    delete(obj);
                end
                error(e.message)
                return
            end
        end
       
        
        %% Set signal acquisition parameter commands
        %------------------------------------------------------------------
        function setActiveChannels(self, obj, channels)
            try
                
                identificationByte = 0x4B; % = 'K'
               
                obj.flush();
                write(obj,identificationByte,'uint8');
                
                % First confirmation Byte
                rsp = read(obj,1,'uint8');
                self.firstResponseCheck(rsp, identificationByte, 'setActiveChannels')
                
                numberOfActiveChannels = size(channels,2);
                [chIdxLower, chIdxUpper, chIdxExtra] = self.calculateChannelIndex(channels);
                
                write(obj,chIdxExtra,'uint8');
                write(obj,chIdxUpper,'uint8');
                write(obj,chIdxLower,'uint8');
                write(obj,numberOfActiveChannels,'uint8');
                
                 % Final confirmation Byte
                rsp = read(obj,1,'uint8');
                self.finalResponseCheck(rsp, identificationByte, 'setActiveChannels')
                
                
                self.numberOfActiveChannels = numberOfActiveChannels;
                self.chIdxLower = chIdxLower;
                self.chIdxUpper = chIdxUpper;
                self.chIdxExtra = chIdxExtra;
                self.activeChannels = channels;
                
            catch e
                if exist('obj','var')
                    delete(obj);
                end
                    error(e.message)
                return
            end
        end
        
        function setSamplingFrequency(self,obj,sF)
        % Set sampling Frequency
            try
                identificationByte = hex2dec(dec2hex('r'));

                obj.flush();
                write(obj,identificationByte,'uint8');
                
                % First confirmation Byte
                rsp = read(obj,1,'uint8');
                self.firstResponseCheck(rsp, identificationByte, 'setSamplingFrequency')
                
                % set sampling frequency
                write(obj,sF,'uint32');
                
                % Final confirmation Byte
                rsp = read(obj,1,'uint8');
                self.finalResponseCheck(rsp, identificationByte, 'setSamplingFrequency')
                
            catch e
                if exist('obj','var')
                    delete(obj);
                end
                rethrow(e);
            end
        end
        
        function setFeatureParameters(self,obj,tWs,oWs,nActiveFeatures,enabledFeatures)
        % Set time windows, overlapping windows and active features    
            try
                identificationByte = 0x66; % 0x66 = 'f'

                obj.flush();
                write(obj,identificationByte,'uint8');
                
                % First confirmation Byte
                rsp = read(obj,1,'uint8');
                self.firstResponseCheck(rsp, identificationByte, 'setFeatureParameters')
                
                % send parameters
                write(obj,tWs,'uint32');
                write(obj,oWs,'uint32');
                write(obj,nActiveFeatures,'uint8');
                
                numberOfFeaturesTmp = self.numberOfFeatures;
                
                for i = 1:numberOfFeaturesTmp
                    write(obj,enabledFeatures(i),'uint8');
                end
                
                 % Final confirmation Byte
                rsp = read(obj,1,'uint8');
                self.finalResponseCheck(rsp, identificationByte, 'setFeatureParameters')
                
            catch e
                if exist('obj','var')
                    delete(obj);
                end
                error(e.message)
                return
            end
        end
        
        function setCompressionEnable(self,obj,compressionEnable)
        % Enable/disable EMG compression for streaming
            try

                identificationByte = 0x62; % 0x62 = 'b'

                obj.flush();
                write(obj,identificationByte,'uint8');
                
                % First confirmation Byte
                rsp = read(obj,1,'uint8');
                self.firstResponseCheck(rsp, identificationByte, 'setCompressionEnable')
                
                % Send filter enable/disable byte
                write(obj,compressionEnable,'uint8');
                
                % Final confirmation Byte
                rsp = read(obj,1,'uint8');
                self.finalResponseCheck(rsp, identificationByte, 'setCompressionEnable')
                self.compressionEnable = compressionEnable;
            catch e
                if exist('obj','var')
                    delete(obj);
                end
                error(e.message)
                return
            end
        end
        
        function setExtraChannels(self,obj, extraChannelsMatrix)
            try
                identificationByte = 0x4F; %'O'
                
                obj.flush;
                write(obj,identificationByte,'uint8');
                rsp = read(obj,1,'uint8');
                self.firstResponseCheck(rsp, identificationByte, 'setExtraChannels')
                
                for i = 1:self.numberOfExtraChannels
                	write(obj,extraChannelsMatrix(i,:),'single')
                end
                
                
                % Final confirmation Byte
                rsp = read(obj,1,'uint8');
                self.finalResponseCheck(rsp, identificationByte, 'setExtraChannels')
                
                self.extraChannelsMatrix = extraChannelsMatrix;
                
            catch e
                if exist('obj','var')
                    delete(obj);
                end
                error(e.message)
                return
            end 
        end
        
        function getExtraChannels(self,obj)
            try
                identificationByte = 0x46; %'F'
                
                obj.flush;
                write(obj,identificationByte,'uint8');
                rsp = read(obj,1,'uint8');
                self.firstResponseCheck(rsp, identificationByte, 'getExtraChannels')
                
                extraChannelsMatrix = zeros(8,16); 
                
                for i = 1:self.numberOfExtraChannels
                	extraChannelsMatrix(i,:) = read(obj,self.numberOfChannels,'single');
                end
                
                
                % Final confirmation Byte
                rsp = read(obj,1,'uint8');
                self.finalResponseCheck(rsp, identificationByte, 'getExtraChannels')
                
                self.extraChannelsMatrix = extraChannelsMatrix;
                
            catch e
                if exist('obj','var')
                    delete(obj);
                end
                error(e.message)
                return
            end 
        end
        
        %% Set/get signal processing parameter commands
        %------------------------------------------------------------------
                
        function setFiltersEnabled(self,obj,filterEnable)
        % Enable/Disable notch and highpass filters
            try
                identificationByte = 0x48; % 0x48 = 'H'
                
                obj.flush();
                write(obj,identificationByte,'uint8');
                
                % First confirmation Byte
                rsp = read(obj,1,'uint8');
                self.firstResponseCheck(rsp, identificationByte, 'setFiltersEnabled')
        
                % Send filter enable/disable byte
                write(obj,filterEnable,'uint8');
                
                 % Final confirmation Byte
                rsp = read(obj,1,'uint8');
                self.finalResponseCheck(rsp, identificationByte, 'setFiltersEnabled')
                
                self.filterEnable = filterEnable;
            catch e
                if exist('obj','var')
                    delete(obj);
                end
                error(e.message)
                return
            end
        end
        
        function setCombParameter(self,obj,enable, combOrder,coefficients)
            try
                identificationByte = 0xC1;
                
                obj.flush();
                write(obj,identificationByte,'uint8');
                
                % First confirmation Byte
                rsp = read(obj,1,'uint8');
                self.firstResponseCheck(rsp, identificationByte, 'setCombParameter')
                
                % enable comb filter and set its parameters
                write(obj,enable,'uint8');
                write(obj,combOrder,'uint8');
                write(obj,coefficients,'single');

               
                % Final confirmation Byte
                rsp = read(obj,1,'uint8');
                self.finalResponseCheck(rsp, identificationByte, 'setCombParameter')
                    
                self.combFilterEnable = enable;
                self.combFilterOrder = combOrder; 
                self.combFilterCoefficients = coefficients;

            catch e
                if exist('obj','var')
                    delete(obj);
                end
                error(e.message)
                return
            end
        end
        
        function getCombParameter(self,obj)
            try
                identificationByte = 0xC2;
                
                obj.flush();
                write(obj,identificationByte,'uint8');
                
                % First confirmation Byte
                rsp = read(obj,1,'uint8');
                self.firstResponseCheck(rsp, identificationByte, 'getCombParameter')
                
                % enable comb filter and set its parameters
                enable = read(obj,1,'uint8');
                combOrder = read(obj,1,'uint8');
                coefficients = read(obj,3,'single');

                % Final confirmation Byte
                rsp = read(obj,1,'uint8');
                self.finalResponseCheck(rsp, identificationByte, 'getCombParameter')
                    
                self.combFilterEnable = enable;
                self.combFilterOrder = combOrder; 
                self.combFilterCoefficients = coefficients;

            catch e
                if exist('obj','var')
                    delete(obj);
                end
                error(e.message)
                return
            end
        end
        
        function setDifferenceFilterParameter(self,obj, enable, coefficients)
            try
                identificationByte = 0xC3;
                
                obj.flush;                
                write(obj,identificationByte,'uint8');
                rsp = read(obj,1,'uint8');
                self.firstResponseCheck(rsp, identificationByte, 'setDifferenceFilterParameter')
                
                % Send enable on/off
                write(obj, enable,'uint8'); 
                
                % Send difference filter coefficients
                write(obj, coefficients,'uint8'); 
                   
                % Final confirmation Byte
                rsp = read(obj,1,'uint8');
                self.finalResponseCheck(rsp, identificationByte, 'setDifferenceFilterParameter')
                
                 % Store parameters in class
                self.differenceFilterEnable = enable;
                self.differenceFilterCoefficients = coefficients;
                
            catch e
                if exist('obj','var')
                    delete(obj);
                end
                error(e.message)
                return
            end

            
        end        
        
        function getDifferenceFilterParameter(self,obj)
            try
                identificationByte = 0xC4;
                
                obj.flush;
                write(obj,identificationByte,'uint8');
                rsp = read(obj,1,'uint8');
                
                self.firstResponseCheck(rsp, identificationByte, 'getDifferenceFilterParameter')
                
                coefficients = zeros(16,1);
                
                % Get parameters from ALC
                
                enable = read(obj,1,'uint8');  

                for i = 1:16
                    coefficients(i,1) = read(obj,1,'uint8'); % 
                end   
                
                rsp = read(obj,1,'uint8');
                self.finalResponseCheck(rsp, identificationByte, 'getDifferenceFilterParameter')
                
                % Store parameters in class
                self.differenceFilterEnable = enable;
                self.differenceFilterCoefficients = coefficients;
                
            catch e
                if exist('obj','var')
                    delete(obj);
                end
                error(e.message)
                return
            end

            
        end
        
        
        %% Set/get feature processing parameter commands
        %------------------------------------------------------------------
        function setMaskingParameters(self,obj, coefficients)
            try
                identificationByte = 0xC6;
                
                obj.flush;
                write(obj,identificationByte,'uint8');
                rsp = read(obj,1,'uint8');
                self.firstResponseCheck(rsp, identificationByte, 'setMaskingParameters')
                        
                for i = 1:5
                    write(obj,coefficients(i,1),'single'); % Masking channel 
                    write(obj,coefficients(i,2),'single'); % TMABS threshold
                    write(obj,coefficients(i,3),'single'); % Masked channel
                    write(obj,coefficients(i,4),'single'); % Scale factor
                    write(obj,coefficients(i,5),'single'); % Trailing edge length
                end
                
               
                % Final confirmation Byte
                rsp = read(obj,1,'uint8');
                self.finalResponseCheck(rsp, identificationByte, 'setMaskingParameters')
                self.maskCoefficients = coefficients;
                if all(all(coefficients == 0))
                    self.maskEnable = 0;
                else
                    self.maskEnable = 1;
                end
                
                
            catch e
                if exist('obj','var')
                    delete(obj);
                end
                error(e.message)
                return
            end

            
        end  
        
        function getMaskingParameters(self,obj)
            try
                identificationByte = 0xC7;
                
                obj.flush;
                write(obj,identificationByte,'uint8');
                rsp = read(obj,1,'uint8');
                
                self.firstResponseCheck(rsp, identificationByte, 'getMaskingParameters')
                
                coefficients = zeros(5,5);
                        
                for i = 1:5
                    coefficients(i,1) = read(obj,1,'single'); % Masking channel 
                    coefficients(i,2) = read(obj,1,'single'); % TMABS threshold
                    coefficients(i,3) = read(obj,1,'single'); % Masked channel
                    coefficients(i,4) = read(obj,1,'single'); % Scale factor
                    coefficients(i,5) = read(obj,1,'single'); % Trailing edge length
                end
                
                rsp = read(obj,1,'uint8');
                self.finalResponseCheck(rsp, identificationByte, 'getMaskingParameters')
                self.maskCoefficients = coefficients;
                if all(all(coefficients == 0))
                    self.maskEnable = 0;
                else
                    self.maskEnable = 1;
                end
                
            catch e
                if exist('obj','var')
                    delete(obj);
                end
                error(e.message)
                return
            end

            
        end
        
        function setFeatureCombinationCoefficients(self,obj,enable,coefficients,activeChannels)
            try
                identificationByte = 0xC5;
                
                obj.flush;
                write(obj,identificationByte,'uint8');
                
                % First confirmation Byte
                rsp = read(obj,1,'uint8');
                self.firstResponseCheck(rsp, identificationByte, 'setFeatureCombinationCoefficients')
                
                
                nInputCh = size(coefficients,1);
                nOutputCh = size(coefficients,2);
                
                write(obj,enable,'uint8')
                
                write(obj,nOutputCh,'uint8');
                write(obj,nInputCh,'uint8');
                
                chIdxUpperTmp = bitshift(sum(bitset(0,activeChannels)),-8);
                chIdxUpperTmp = bitand(chIdxUpperTmp,255);
                chIdxLowerTmp = bitand(sum(bitset(0,activeChannels)),255);
                
                write(obj,chIdxUpperTmp,'uint8');
                write(obj,chIdxLowerTmp,'uint8');
                             
                for i = 1:nOutputCh
                    for k = 1:nInputCh
                        write(obj,coefficients(k,i),'single');
                    end
                end
                
                % final confirmation Byte
                rsp = read(obj,1,'uint8');
                self.finalResponseCheck(rsp, identificationByte, 'getDifferenceFilterParameter')
                
            catch e
                if exist('obj','var')
                    delete(obj);
                end
                error(e.message)
                return
            end
        end
        

        %% Set/get prediction parameters
        %------------------------------------------------------------------
        function setNNParameters(self,obj, nnParameters)
            try
                identificationByte = 0xD1;
                
                obj.flush;
                write(obj,identificationByte,'uint8');
                rsp = read(obj,1,'uint8');
                self.firstResponseCheck(rsp, identificationByte, 'setNNParameters')
                
                write(obj,nnParameters.nActiveClasses,'uint8')
                write(obj,nnParameters.nFeatureSets,'uint8')
                
                for class = 1:nnParameters.nActiveClasses
                	write(obj,nnParameters.weights(class,1:nnParameters.nFeatureSets),'single');
                end
                
                write(obj,nnParameters.bias(1:nnParameters.nActiveClasses),'single');

                write(obj,nnParameters.threshold(1:nnParameters.nActiveClasses-1),'single');

                write(obj,nnParameters.prostheticOutput(1:nnParameters.nActiveClasses),'uint8');

                write(obj,nnParameters.mean(1:nnParameters.nFeatureSets),'single');

                write(obj,nnParameters.std(1:nnParameters.nFeatureSets),'single');

                
                for class = 1:(nnParameters.nActiveClasses-1)
                     % Lower threshold
                     write(obj,nnParameters.propThreshold(class,1),'single');
                     % Upper threshold
                     write(obj,nnParameters.propThreshold(class,2),'single');
                end
                
                write(obj,nnParameters.floorNoise,'single')
                write(obj,nnParameters.switchThreshold,'single')
                write(obj,nnParameters.streamEnable,'uint8')
                
                % Final confirmation Byte
                rsp = read(obj,1,'uint8');
                self.finalResponseCheck(rsp, identificationByte, 'setNNParameters')
                self.NNCoefficients = nnParameters;
                
            catch e
                if exist('obj','var')
                    delete(obj);
                end
                error(e.message)
                return
            end  
        end  
        
        function getNNParameters(self,obj)
            try
                identificationByte = 0xD2;
                
                obj.flush;
                write(obj,identificationByte,'uint8');
                rsp = read(obj,1,'uint8');
                self.firstResponseCheck(rsp, identificationByte, 'getNNParameters')
                
                parameter.nActiveClasses = read(obj,1,'uint8');
                parameter.nFeatureSets = read(obj,1,'uint8');
                
                parameter.weights = zeros(self.numberOfClasses,self.featuresSize);
                for class = 1:self.numberOfClasses
                    %for feature=1:self.featuresSize
                        parameter.weights(class,:) = read(obj,self.featuresSize,'single');
                    %end
                end
                
                parameter.bias = read(obj,self.numberOfClasses,'single')';

                parameter.threshold = read(obj,self.numberOfClasses-1,'single')';
                
                parameter.prostheticOutput = read(obj,self.numberOfClasses,'uint8')';
                
                parameter.mean = read(obj,self.featuresSize,'single')';

                parameter.std = read(obj,self.featuresSize,'single')';

                 parameter.propThreshold = zeros(self.numberOfClasses-1,2);
                for class = 1:(self.numberOfClasses-1)
                    parameter.propThreshold(class,1) = read(obj,1,'single');
                    parameter.propThreshold(class,2) = read(obj,1,'single');
                end

                parameter.floorNoise = read(obj,1,'single');
                parameter.switchThreshold = read(obj,1,'single');
                parameter.streamEnable = read(obj,1,'uint8');

                % Final confirmation Byte
                rsp = read(obj,1,'uint8');
                self.finalResponseCheck(rsp, identificationByte, 'getNNParameters')
                
                self.NNCoefficients = parameter;
                
            catch e
                if exist('obj','var')
                    delete(obj);
                end
                error(e.message)
                return
            end  
        end  

        %% Set/get control parameters
        %------------------------------------------------------------------
        function setMotorEnable(self, obj, flag)
            try
            	identificationByte = 0x65; %0x65 = 'e'
                
                obj.flush;
                write(obj,identificationByte,'uint8');
                rsp = read(obj,1,'uint8');
                self.firstResponseCheck(rsp, identificationByte, 'setMotorEnable')
                
                write(obj,flag,'uint8')

                % Final confirmation Byte
                rsp = read(obj,1,'uint8');
                self.finalResponseCheck(rsp, identificationByte, 'setMotorEnable')
                self.motorEnable = flag;
                
            catch e
                if exist('obj','var')
                    delete(obj);
                end
                error(e.message)
                return
            end  
        end
        
        function setControlAlgorithm(self,obj,algorithm,arg1,arg2)
        % Set control algorithm and parameters
            try
                
                identificationByte = 0x61; % 0x62 = 'a'

                obj.flush();
                write(obj,identificationByte,'uint8');
                
                % First confirmation Byte
                rsp = read(obj,1,'uint8');
                self.firstResponseCheck(rsp, identificationByte, 'setControlAlgorithm')
                
                % send paramters: How are they encoded on the MCU?
                
                write(obj,algorithm,'uint8');
                switch algorithm
                    case 0 % NONE   
                    case 1 % MAJORITY_VOTE
                        mVSteps = arg1;
                        write(obj,mVSteps,'uint8');
                    case 2 % RAMP
                        rampLengthTmp = arg1;
                        rampModeTmp = arg2;
                        write(obj,rampLengthTmp,'uint8');
                        write(obj,rampModeTmp,'uint8');
                    case 3 % DELICATEGRASP
                        % case not fully supported on ALC
                        delicateGraspTmp = arg1;
                        delicateGraspThresholdTmp = arg2;
                        write(obj,delicateGraspTmp,'uint8');
                        write(obj,delicateGraspThresholdTmp,'char');            
                    otherwise
                        throw(MException('CallbackDemo:noResponse', ...
                        ['No valid control algorithm given. Chose 0 (NONE),'...
                         ' 1 (majority vote), 2 (ramp) or 3 (delicategrasp)']));
                end
                
                % Final confirmation Byte
                rsp = read(obj,1,'uint8');
                self.finalResponseCheck(rsp, identificationByte, 'setCompressionEnable')

                self.controlAlgorithm = algorithm;
                switch algorithm
                    case 0 % NONE
                    case 1 % MAJORITY_VO
                        self.mvSteps = mVSteps;
                    case 2 % RAMP
                        self.rampLength = rampLengthTmp;
                        self.rampMode = rampModeTmp;
                    case 3 % DELICATEGRASP
                        self.delicateGrasp = delicateGraspTmp;
                        self.delicateGraspThreshold = delicateGraspThresholdTmp;
                    otherwise     
                end

            catch e
                if exist('obj','var')
                    delete(obj);
                end
                error(e.message)
                return
            end
        end
        
                
        function setHandControlParameters(self,obj, handParameters)
        % Set sensitivity and ranges for 3 DOF
                    
            try
                identificationByte = 0x44; % 0x44 = 'D'
                
                obj.flush;
                write(obj,identificationByte,'uint8');
                rsp = read(obj,1,'uint8');
                self.firstResponseCheck(rsp, identificationByte, 'setHandControlParameters')
                
                % send parameters
                write(obj,handParameters.sensitivity,'single');
                write(obj,handParameters.handMinimumSpeed,'uint8');
                write(obj,handParameters.handMaximumSpeed,'uint8');
                write(obj,handParameters.wristMinimumSpeed,'uint8');
                write(obj,handParameters.wristMaximumSpeed,'uint8');
                write(obj,handParameters.elbowMinimumSpeed,'uint8');
                write(obj,handParameters.elbowMaximumSpeed,'uint8');
                write(obj,handParameters.switchPauseCounter,'uint8');
                
                % Final confirmation Byte
                rsp = read(obj,1,'uint8');
                self.finalResponseCheck(rsp, identificationByte, 'setHandControlParameters')
               
                
                self.sensitivity = handParameters.sensitivity;
                self.handMinimumSpeed = handParameters.handMinimumSpeed;
                self.handMaximumSpeed = handParameters.handMaximumSpeed;
                self.wristMinimumSpeed = handParameters.wristMinimumSpeed;
                self.wristMaximumSpeed = handParameters.wristMaximumSpeed;
                self.elbowMinimumSpeed = handParameters.elbowMinimumSpeed;
                self.elbowMaximumSpeed = handParameters.elbowMaximumSpeed;
                self.switchPauseCounter = handParameters.switchPauseCounter;

            catch e
                if exist('obj','var')
                    delete(obj);
                end
                error(e.message)
                return
            end
        end
        
       
        function setMiaHandControlParametersSSSA(self,obj,minActivationThreshold, sensitivity, minimumSpeed,maximumSpeed, ...
                                          minModulationSpeedStep, maxModulationSpeedStep, minPWM, maxPWM)
        % Set sensitivity and ranges for 3 DOF
                    
            try
                identificationByte = 0x70; % 0x70 = 'p'
                
                obj.flush;
                write(obj,identificationByte,'uint8');
                rsp = read(obj,1,'uint8');
                self.firstResponseCheck(rsp, identificationByte, 'setMiaHandControlParameters')
                
                % send parameters
                write(obj,minActivationThreshold,'uint8');
                write(obj,sensitivity,'single');
                write(obj,minimumSpeed,'uint8');
                write(obj,maximumSpeed,'uint8');
                write(obj,minModulationSpeedStep,'uint8');
                write(obj,maxModulationSpeedStep,'uint8');
                write(obj,minPWM,'uint8');
                write(obj,maxPWM,'uint8');
                
                % Final confirmation Byte
                rsp = read(obj,1,'uint8');
                self.finalResponseCheck(rsp, identificationByte, 'setMiaHandControlParameters')
               
                self.miaMinActivationThreshold = minActivationThreshold;
                self.miaSensitivity = sensitivity;
                self.miaMinimumSpeed = minimumSpeed;
                self.miaMaximumSpeed = maximumSpeed;
                self.miaMinModulationSpeedStep = minModulationSpeedStep;
                self.miaMaxModulationSpeedStep = maxModulationSpeedStep;
                self.miaMinPwm = minPWM;
                self.miaMaxPWM = maxPWM;


            catch e
                if exist('obj','var')
                    delete(obj);
                end
                error(e.message)
                return
            end
        end
        
        function setMiaHandControlParameters(self,obj,handParameters)
        % Set sensitivity and ranges for 3 DOF
                    
            try
                identificationByte = 0x4A; % 0x4A = 'J'
                
                obj.flush;
                write(obj,identificationByte,'uint8');
                rsp = read(obj,1,'uint8');
                self.firstResponseCheck(rsp, identificationByte, 'setMiaHandControlParameters')
                
                % send parameters
                write(obj,handParameters.graspControlMode,'uint8');
                write(obj,handParameters.graspStepSize,'uint8');
                write(obj,handParameters.graspDiscretization,'uint8');
                write(obj,handParameters.graspModeEnabled,'uint8');
                write(obj,handParameters.forceControlEnabled,'uint8');
                write(obj,handParameters.holdOpenEnabled,'uint8');
                write(obj,handParameters.holdOpenTime,'uint8');
                write(obj,handParameters.holdOpenThreshold,'uint8');
                
                % Final confirmation Byte
                rsp = read(obj,1,'uint8');
                self.finalResponseCheck(rsp, identificationByte, 'setMiaHandControlParameters')
               
                self.miaParameters.graspControlMode = handParameters.graspControlMode;
                self.miaParameters.graspStepSize = handParameters.graspStepSize;
                self.miaParameters.graspDiscretization = handParameters.graspDiscretization;
                self.miaParameters.graspModeEnabled = handParameters.graspModeEnabled;
                self.miaParameters.forceControlEnabled = handParameters.forceControlEnabled;
                self.miaParameters.holdOpenEnabled = handParameters.holdOpenEnabled;
                self.miaParameters.holdOpenTime = handParameters.holdOpenTime;
                self.miaParameters.holdOpenThreshold = handParameters.holdOpenThreshold;

            catch e
                if exist('obj','var')
                    delete(obj);
                end
                error(e.message)
                return
            end
        end
        
        function getMiaHandControlParameters(self,obj,handParameters)
        % Set sensitivity and ranges for 3 DOF
                    
            try
                identificationByte = 0x6A; % 0x6A = 'j'
                
                obj.flush;
                write(obj,identificationByte,'uint8');
                rsp = read(obj,1,'uint8');
                self.firstResponseCheck(rsp, identificationByte, 'setMiaHandControlParameters')
                
                % get parameters
                
                handParameters.graspControlMode = read(obj,1,'uint8');
                handParameters.graspStepSize = read(obj,1,'uint8');
                handParameters.graspDiscretization = read(obj,1,'uint8');
                handParameters.graspModeEnabled = read(obj,1,'uint8');
                handParameters.forceControlEnabled = read(obj,1,'uint8');
                handParameters.holdOpenEnabled = read(obj,1,'uint8');
                handParameters.holdOpenTime = read(obj,1,'uint8');
                handParameters.holdOpenThreshold = read(obj,1,'uint8');

                
                % Final confirmation Byte
                rsp = read(obj,1,'uint8');
                self.finalResponseCheck(rsp, identificationByte, 'setMiaHandControlParameters')
               
                self.miaParameters.graspControlMode = handParameters.graspControlMode;
                self.miaParameters.graspStepSize = handParameters.graspStepSize;
                self.miaParameters.graspDiscretization = handParameters.graspDiscretization;
                self.miaParameters.graspModeEnabled = handParameters.graspModeEnabled;
                self.miaParameters.forceControlEnabled = handParameters.forceControlEnabled;
                self.miaParameters.holdOpenEnabled = handParameters.holdOpenEnabled;
                self.miaParameters.holdOpenTime = handParameters.holdOpenTime;
                self.miaParameters.holdOpenThreshold = handParameters.holdOpenThreshold;

            catch e
                if exist('obj','var')
                    delete(obj);
                end
                error(e.message)
                return
            end
        end
        
        function setProportionalControlParameters(self, obj, parameterStruct)
             try
                identificationByte = 0xE1; 
                
                obj.flush;
                write(obj,identificationByte,'uint8');
                rsp = read(obj,1,'uint8');
                self.firstResponseCheck(rsp, identificationByte, 'setProportionalControlParameters')
                
                % send parameters
                write(obj,parameterStruct.strengthFilterLength,'uint8');
                               
                % Final confirmation Byte
                rsp = read(obj,1,'uint8');
                self.finalResponseCheck(rsp, identificationByte, 'setProportionalControlParameters')
               
                self.proportionalParameters.strengthFilterLength = parameterStruct.strengthFilterLength;

            catch e
                if exist('obj','var')
                    delete(obj);
                end
                error(e.message)
                return
            end
        end
        
        function getProportionalControlParameters(self,obj)
                    
            try
                identificationByte = 0xE2; 
                
                obj.flush;
                write(obj,identificationByte,'uint8');
                rsp = read(obj,1,'uint8');
                self.firstResponseCheck(rsp, identificationByte, 'getProportionalControlParameters')
                
                % get parameters
                parameterStruct.strengthFilterLength = read(obj,1,'uint8');

                % Final confirmation Byte
                rsp = read(obj,1,'uint8');
                self.finalResponseCheck(rsp, identificationByte, 'getProportionalControlParameters')
               
                self.proportionalParameters.strengthFilterLength = parameterStruct.strengthFilterLength;


            catch e
                if exist('obj','var')
                    delete(obj);
                end
                error(e.message)
                return
            end
        end
        
        function setThresholdRatioParameters(self, obj, thresholdRatioParameters)
             try
                identificationByte = 0xE3; 
                
                obj.flush;
                write(obj,identificationByte,'uint8');
                rsp = read(obj,1,'uint8');
                self.firstResponseCheck(rsp, identificationByte, 'setThresholdRatioParameters')
                
                % send parameters
                write(obj,thresholdRatioParameters,'single');
                
                               
                % Final confirmation Byte
                rsp = read(obj,1,'uint8');
                self.finalResponseCheck(rsp, identificationByte, 'setThresholdRatioParameters')
               
                self.thresholdRatioParameters = thresholdRatioParameters;
                if all(thresholdRatioParameters == 0)
                    self.thresholdRatioEnable = 0;
                else
                    self.thresholdRatioEnable = 1;
                end

            catch e
                if exist('obj','var')
                    delete(obj);
                end
                error(e.message)
                return
            end
        end
        
        function getThresholdRatioParameters(self,obj)
                    
            try
                identificationByte = 0xE4; 
                
                obj.flush;
                write(obj,identificationByte,'uint8');
                rsp = read(obj,1,'uint8');
                self.firstResponseCheck(rsp, identificationByte, 'getThresholdRatioParameters')
                
                % get parameters
                thresholdRatioParameters = read(obj,2,'single');
                

                % Final confirmation Byte
                rsp = read(obj,1,'uint8');
                self.finalResponseCheck(rsp, identificationByte, 'getThresholdRatioParameters')
               
                self.thresholdRatioParameters = thresholdRatioParameters;
                
                if all(thresholdRatioParameters == 0)
                    self.thresholdRatioEnable = 0;
                else
                    self.thresholdRatioEnable = 1;
                end



            catch e
                if exist('obj','var')
                    delete(obj);
                end
                error(e.message)
                return
            end
        end
        
        %% Set/get neurostimulation parameters
        %------------------------------------------------------------------
        function setStimParameters(self,obj,stimParametersTmp)
            try
                
                identificationByte = 0xB2;
                
                obj.flush;
                write(obj,identificationByte,'uint8');
                
                % First confirmation Byte
                rsp = read(obj,1,'uint8');
                self.firstResponseCheck(rsp, identificationByte, 'setStimParameters')
                
                % fill nsParameters struct
                write(obj,stimParametersTmp.mode,'uint8');
                write(obj,stimParametersTmp.channel,'uint8');
                write(obj,stimParametersTmp.amplitude,'uint8');
                write(obj,stimParametersTmp.pulseWidth,'uint8');
                write(obj,stimParametersTmp.frequency,'uint8');
                write(obj,stimParametersTmp.repetitions,'uint8');
                write(obj,stimParametersTmp.modAmpTop,'uint8');
                write(obj,stimParametersTmp.modAmpLow,'uint8');
                write(obj,stimParametersTmp.modPWTop,'uint8');
                write(obj,stimParametersTmp.modPWLow,'uint8');
                write(obj,stimParametersTmp.modFreqTop,'uint8');
                write(obj,stimParametersTmp.modFreqLow,'uint8');
                write(obj,stimParametersTmp.DESCenable,'uint8');
                write(obj,stimParametersTmp.DESCchannel,'uint8');
                write(obj,stimParametersTmp.DESCamplitude,'uint8');
                write(obj,stimParametersTmp.DESCpulseWidth,'uint8');
                write(obj,stimParametersTmp.DESCfrequency,'uint8');
                write(obj,stimParametersTmp.DESCrepetitions,'uint8');
                write(obj,stimParametersTmp.DESCatSlips,'uint8');
                
                
                
                % Final confirmation Byte
                rsp = read(obj,1,'uint8');
                if isequal(rsp, uint8(0x86))
                    fprintf('Some NS parameters were out of range and illegal.')
                    fprintf('They were not set. Retry with new parameters.\n')
                    self.stimParameters.mode = -1;
                    self.stimParameters.amplitude = -1;
                    self.stimParameters.DESCenable = -1;
                    
                else
                    self.finalResponseCheck(rsp, identificationByte, 'setStimParameters')
                    self.stimParameters.mode = stimParametersTmp.mode;
                    self.stimParameters.amplitude = stimParametersTmp.amplitude;
                    self.stimParameters.DESCenable = stimParametersTmp.DESCenable;
                    
                    self.stimParameters.channel = stimParametersTmp.channel;
                    self.stimParameters.amplitude = stimParametersTmp.amplitude;
                    self.stimParameters.pulseWidth = stimParametersTmp.pulseWidth;
                    self.stimParameters.frequency = stimParametersTmp.frequency;
                    self.stimParameters.repetitions = stimParametersTmp.repetitions;
                    self.stimParameters.modAmpTop = stimParametersTmp.modAmpTop;
                    self.stimParameters.modAmpLow = stimParametersTmp.modAmpLow;
                    self.stimParameters.modPWTop = stimParametersTmp.modPWTop;
                    self.stimParameters.modPWLow = stimParametersTmp.modPWLow;
                    self.stimParameters.modFreqTop = stimParametersTmp.modFreqTop;
                    self.stimParameters.modFreqLow = stimParametersTmp.modFreqLow;
                    self.stimParameters.DESCenable = stimParametersTmp.DESCenable;
                    self.stimParameters.DESCchannel = stimParametersTmp.DESCchannel;
                    self.stimParameters.DESCamplitude = stimParametersTmp.DESCamplitude;
                    self.stimParameters.DESCpulseWidth = stimParametersTmp.DESCpulseWidth;
                    self.stimParameters.DESCfrequency = stimParametersTmp.DESCfrequency;
                    self.stimParameters.DESCrepetitions = stimParametersTmp.DESCrepetitions;
                    self.stimParameters.DESCatSlips = stimParametersTmp.DESCatSlips;
                end
                
                

                
            catch e
                if exist('obj','var')
                    delete(obj);
                end
                error(e.message)
                return
            end
        end
        
        function getStimParameters(self,obj)
            try
                
                identificationByte = 0xB1;
                
                obj.flush;
                write(obj,identificationByte,'uint8');
                
                % First confirmation Byte
                rsp = read(obj,1,'uint8');
                self.firstResponseCheck(rsp, identificationByte, 'getStimParameters')
                
                % Fill neurostimulation parameters struct
                stimParametersTmp.mode = read(obj,1,'uint8');
                stimParametersTmp.channel = read(obj,1,'uint8');
                stimParametersTmp.amplitude = read(obj,1,'uint8');
                stimParametersTmp.pulseWidth = read(obj,1,'uint8');
                stimParametersTmp.frequency = read(obj,1,'uint8');
                stimParametersTmp.repetitions = read(obj,1,'uint8');
                stimParametersTmp.modAmpTop = read(obj,1,'uint8');
                stimParametersTmp.modAmpLow = read(obj,1,'uint8');
                stimParametersTmp.modPWTop = read(obj,1,'uint8');
                stimParametersTmp.modPWLow = read(obj,1,'uint8');
                stimParametersTmp.modFreqTop = read(obj,1,'uint8');
                stimParametersTmp.modFreqLow = read(obj,1,'uint8');
                stimParametersTmp.DESCenable = read(obj,1,'uint8');
                stimParametersTmp.DESCchannel = read(obj,1,'uint8');
                stimParametersTmp.DESCamplitude = read(obj,1,'uint8');
                stimParametersTmp.DESCpulseWidth = read(obj,1,'uint8');
                stimParametersTmp.DESCfrequency = read(obj,1,'uint8');
                stimParametersTmp.DESCrepetitions = read(obj,1,'uint8');
                stimParametersTmp.DESCatSlips = read(obj,1,'uint8');
                
                % Final confirmation Byte
                rsp = read(obj,1,'uint8');
                self.finalResponseCheck(rsp, identificationByte, 'getStimParameters')
                
                % Update class properties
                                
                self.stimParameters.mode = stimParametersTmp.mode;
                self.stimParameters.channel = stimParametersTmp.channel;
                self.stimParameters.amplitude = stimParametersTmp.amplitude;
                self.stimParameters.pulseWidth = stimParametersTmp.pulseWidth;
                self.stimParameters.frequency = stimParametersTmp.frequency;
                self.stimParameters.repetitions = stimParametersTmp.repetitions;
                self.stimParameters.modAmpTop = stimParametersTmp.modAmpTop;
                self.stimParameters.modAmpLow = stimParametersTmp.modAmpLow;
                self.stimParameters.modPWTop = stimParametersTmp.modPWTop;
                self.stimParameters.modPWLow = stimParametersTmp.modPWLow;
                self.stimParameters.modFreqTop = stimParametersTmp.modFreqTop;
                self.stimParameters.modFreqLow = stimParametersTmp.modFreqLow;
                self.stimParameters.DESCenable = stimParametersTmp.DESCenable;
                self.stimParameters.DESCchannel = stimParametersTmp.DESCchannel;
                self.stimParameters.DESCamplitude = stimParametersTmp.DESCamplitude;
                self.stimParameters.DESCpulseWidth = stimParametersTmp.DESCpulseWidth;
                self.stimParameters.DESCfrequency = stimParametersTmp.DESCfrequency;
                self.stimParameters.DESCrepetitions = stimParametersTmp.DESCrepetitions;
                self.stimParameters.DESCatSlips = stimParametersTmp.DESCatSlips;
                
                
            catch e
                if exist('obj','var')
                    delete(obj);
                end
                error(e.message)
                return
            end
        end
        
        %% Set/get SD card 
        %------------------------------------------------------------------
        function getSDBlockID(self,obj)
        % Read memory usage by reading the BlockIdx
            try
                % define output
                dataR = [];
                
                identificationByte = 0x6E; % 0x6E = 'n'
                
                obj.flush;
                write(obj,identificationByte,'uint8');
                
                % First confirmation Byte
                rsp = read(obj,1,'uint8');
                if isequal(rsp,0xEE)
                    fprintf('No SD card connected.\n');
                    self.sdCard = 0;
                    self.sdBlockID = -1;
                    return;
                else
                    self.firstResponseCheck(rsp, identificationByte, 'getSDBlockID')
                end
                
                  
                % get SD card data
                dataR(1) = read(obj,1,'uint8');
                dataR(2) = read(obj,1,'uint8');
                dataR(3) = read(obj,1,'uint8');
                dataR(4) = read(obj,1,'uint8');
                
                rsp = read(obj,1,'uint8');
                assert(rsp==32||rsp==16,"SDError:WrongSizeSD","Incorrect SD size")
                    
                % Final confirmation Byte
                rsp = read(obj,1,'uint8');
                self.finalResponseCheck(rsp, identificationByte, 'getSDBlockID')
                self.sdCard = 1;
                self.sdBlockID = dataR;
 
            catch e
                if exist('obj','var')
                    delete(obj);
                end
                error(e.message)
                return
            end
        end
        
        function getSDBlocks(self,obj,count,address)
            try
                             
                identificationByte = 0x6D; % 0x6E = 'm'
                
                obj.flush;
                write(obj,identificationByte,'uint8');
                
                % First confirmation Byte
                rsp = read(obj,1,'uint8');
                if isequal(rsp,0xEE)
                    fprintf('No SD card connected.\n');
                    self.sdCard = 0;
                    self.sdBlocks  = -1;
                    return;
                else
                    self.firstResponseCheck(rsp, identificationByte, 'getSDBlocks')
                end
                
                % Allocate temp variables
                sdBlockSizeTmp = self.sdBlockSize;
                dataR = zeros(count,sdBlockSizeTmp);

                % send data transfer details
                write(obj,count,'uint32');
                write(obj,address,'uint32');
                    
                for i = 1:count
                   for k = 1:sdBlockSizeTmp
                       dataR(i,k) = read(obj,1,'uint8');
                   end 
                end
                
                % Final confirmation Byte
                rsp = read(obj,1,'uint8');
                self.finalResponseCheck(rsp, identificationByte, 'getSDBlocks')
                self.sdCard = 1;
                self.sdBlocks = dataR;

            catch e
                if exist('obj','var')
                    delete(obj);
                end
                error(e.message)
                return
            end
        end
        
        function resetSDBlockID(self,obj)
        % Reset the pointer of the SD card. All log data will be overwritten
            try
                identificationByte = 0x6F; % 0x6F = 'o'
                
                obj.flush;
                write(obj,identificationByte,'uint8');
                
                % First confirmation Byte
                rsp = read(obj,1,'uint8');
                if isequal(rsp,0xEE)
                    fprintf('No SD card connected.\n');
                    self.sdCard = 0;
                    self.sdBlocks  = -1;
                    return;
                else
                    self.firstResponseCheck(rsp, identificationByte, 'resetSDBlockID')
                end

                blockIdx = read(obj,1,'uint32');
                
                hWait = waitbar(0,sprintf('Resetting %d blocks',blockIdx),'CreateCancelBtn','setappdata(gcbf,''canceling'',1)');
                
                while true
                    currentIdx = read(obj,1,'uint32');
                    if currentIdx == 0
                        break
                    else
                        waitbar(currentIdx/blockIdx,hWait);
                        if getappdata(hWait,'canceling')
                            write(obj,blockIdx,'uint32');
                        else
                            write(obj,currentIdx,'uint32');
                        end
                    end
                end
                 delete(hWait); 
                % Final confirmation Byte
                rsp = read(obj,1,'uint8');
                self.finalResponseCheck(rsp, identificationByte, 'resetSDBlockID')
                
                fprintf('BlockIDx was reset successfully.\n');
                self.sdCard = 1;

            catch e
                if exist('obj','var')
                    delete(obj);
                end
                error(e.message)
                return
            end
        end
        
        %% Execute specific instructions on the ALC
        %------------------------------------------------------------------
        
         function executeMovement(self,obj, movementStruct)
        % Send movement execution message to ALC
         	 try
                identificationByte = 0x6B; % 0x6B = 'k'
                
                obj.flush;
                write(obj,identificationByte,'uint8');
                rsp = read(obj,1,'uint8');
                
                self.firstResponseCheck(rsp, identificationByte, 'executeMovement')
                
                % If elbow lock/unlock, set strength of elbow to 100.
                % Otherwise the movement is not executed
                if movementStruct.movIndex == 129 || movementStruct.movIndex == 130
                    movementStruct.strength(1) = 100;
                end
                    
                write(obj,movementStruct.movIndex,'uint8');
                write(obj,movementStruct.strength,'uint8');
                
                % Final confirmation Byte
                rsp = read(obj,1,'uint8');
                self.finalResponseCheck(rsp, identificationByte, 'executeMovement')
 
            catch e
                if exist('obj','var')
                    delete(obj);
                end
                error(e.message)
                return
            end
        end
        
        %% Test specific functions on the ALC
        %------------------------------------------------------------------
        function outIdx = testClassifier(self,obj, testData)
        % Send movement execution message to ALC
         	 try
                identificationByte = 0x63; % 0x63 = 'c'
                
                obj.flush;
                write(obj,identificationByte,'uint8');
                rsp = read(obj,1,'uint8');
                
                self.firstResponseCheck(rsp, identificationByte, 'testClassifier')
                
                % Byte to define only outIdx streaming 
                write(obj,1,'uint8');
                % Necessary variables
                write(obj,testData.nChannels,'uint8');
                write(obj,testData.nFeatures,'uint8');
                
                
                write(obj,testData.featVect,'single');

                outIdx = read(obj,1,'uint8');
                
                % Final confirmation Byte
                rsp = read(obj,1,'uint8');
                self.finalResponseCheck(rsp, identificationByte, 'testClassifier')
 
            catch e
                if exist('obj','var')
                    delete(obj);
                end
                error(e.message)
                return
            end
        end
        
        function [outIdx, featVector] = testClassifierfeatVector(self,obj, testData)
            % Send movement execution message to ALC
         	 try
                identificationByte = 0x63; % 0x63 = 'c'
                
                obj.flush;
                write(obj,identificationByte,'uint8');
                rsp = read(obj,1,'uint8');
                
                self.firstResponseCheck(rsp, identificationByte, 'testClassifier')

                % Byte to define streaming of outIdx and featureVector
                write(obj,2,'uint8');
                % Necessary variables
                write(obj,testData.nChannels,'uint8');
                write(obj,testData.nFeatures,'uint8');
                               
                write(obj,testData.featVect,'single');
                
                featVector = read(obj,testData.nMovements,'single'); 
                outIdx = read(obj,1,'uint8');
                
                % Final confirmation Byte
                rsp = read(obj,1,'uint8');
                self.finalResponseCheck(rsp, identificationByte, 'testClassifier')
 
            catch e
                if exist('obj','var')
                    delete(obj);
                end
                error(e.message)
                return
            end
        end
        
        function outFeatureVector = testFeatureExtraction(self, obj, testData)
            try
                identificationByte = 0x78; % 0x78 = 'x'
                
                obj.flush;
                write(obj,identificationByte,'uint8');
                rsp = read(obj,1,'uint8');
                
                self.firstResponseCheck(rsp, identificationByte, 'testFeatureExtraction')

                nSamples = size(testData.data,1);
                write(obj,testData.nChannels,'uint8');
                write(obj,nSamples,'uint32');
                
                for sample=1:nSamples
                    write(obj,testData.data(sample,:),'single');
                end
                                              
                outFeatureVector = read(obj,testData.nChannels*testData.nFeatures,'single'); 

                % Final confirmation Byte
                rsp = read(obj,1,'uint8');
                self.finalResponseCheck(rsp, identificationByte, 'testFeatureExtraction')
 
            catch e
                if exist('obj','var')
                    delete(obj);
                end
                error(e.message)
                return
            end
        end
        
        %% -----------------------------------------------------------------
        % ALC helper functions 
        % There is no corresponding function to this on the ALC
        %------------------------------------------------------------------
        function getAllParameters(self,obj)
            % Get all the data saved on the ALC
            self.getStatus(obj);
            pause(0.1);
            self.getRecSettings(obj);
            pause(0.1);
            self.getCombParameter(obj);
            pause(0.1);
            self.getDifferenceFilterParameter(obj);
            pause(0.1);
            self.getMaskingParameters(obj);
            pause(0.1);
            self.getMiaHandControlParameters(obj);
            pause(0.1);
            self.getThresholdRatioParameters(obj);
            pause(0.1);
            self.getProportionalControlParameters(obj);
            pause(0.1);
%             self.getNNParameters(obj)
%             pause(0.1);
            self.getThresholdRatioParameters(obj)
            pause(0.1);
%             self.getStimParameters(obj);  
%             pause(0.1)
            self.getExtraChannels(obj);
        end
        
                
        function featureVector = getActiveFeaturesVector(self,featureNamesVector)
            % Allocate vector
            featureVector = zeros(self.numberOfFeatures,1);
            
            % Check if the features listed in featureNamesVector are
            % actually a feature supported by the ALC and if yes, set the
            % corresponding byte to turn them on
            for feature=1:self.numberOfFeatures
                if any(contains(featureNamesVector, self.featureNames(feature)))
                    featureVector(feature) = 1;
                end
            end
        end
       
        % Update the ALC with the settings of a PatRec file
        function setPatRecSettings(self, obj, patRec)
            try
                %Set sF 
                sF = patRec.sF;
                self.setSamplingFrequency(obj,sF)
                              
                % Set feature parameter
                tWs = sF * patRec.tW;
                oWs = sF * patRec.wOverlap;
                enabledFeatures = self.getActiveFeaturesVector(patRec.selFeatures);
                nActiveFeatures = sum(enabledFeatures);
                self.setFeatureParameters(obj,tWs,oWs,nActiveFeatures,enabledFeatures);
                
                % Set active channels
                vCh = patRec.vCh;
                self.setActiveChannels(obj,vCh)
                
                % Set control algorithmus
                nM = patRec.nM;
                % TODO update control algorithms
                
                % Save all new parameters to class
                self.samplingFrequency = sF;
                self.timeWindowSamples = tWs;
                self.overlappingSamples = oWs;
                self.featuresEnabled = enabledFeatures;
                self.numberOfActiveFeatures = nActiveFeatures;
                self.activeChannels = vCh;
                self.numberOfActiveMovements =nM;
                
            catch e
                if exist('obj','var')
                    delete(obj);
                end
                error(e.message)
            end
        end
        
        function prostheticOutput = convertMovementArrayToProstheticOutput(self, movementArray, movOutIdx)
            
            nMovements = length(movementArray);
            prostheticOutput = zeros(nMovements,1);
            
            for mov = 1:nMovements
                if length(movOutIdx{mov}) == 1
                    prostheticOutput(mov) = self.movementIndex(contains(self.movementNames,movementArray(mov)));
                
                
                elseif length(movOutIdx{mov}) == 2
                    index = de2bi(prostheticOutput(movOutIdx{mov}),8);
                    prostheticOutput(mov) = bi2de(bitor(index(1,:), index(2,:)));
                
                elseif length(movOutIdx{mov}) == 3
                    index = de2bi(prostheticOutput(movOutIdx{mov}),8);
                    temp = (bitor(index(1,:), index(2,:)));
                    prostheticOutput(mov) = bi2de(bitor(temp, index(3,:)));
                end
                
            end

            
        end
        
        function prostheticOutput = convertMovementNamesToProstheticOutput(self, movementNames)
            
            nMovements = numel(movementNames);
            prostheticOutput = zeros(nMovements,1);
            
            for mov = 1:numel(self.movementNames)
                
                index = strcmp(movementNames,self.movementNames(mov))';
                prostheticOutput = prostheticOutput + index*self.movementIndex(mov);
            
            end
            
            indexSimult = prostheticOutput== 0;
            
            for mov = 1:numel(self.movementNames)
                index = contains(movementNames,self.movementNames(mov))';
                prostheticOutput = prostheticOutput + indexSimult.*index*self.movementIndex(mov);
            end

        end
        
        function encodedLabels = encodeLabelsOneHot(self, labels, movementNames)
            nIndividualClasses = numel(movementNames);
            nClasses = 0;
            for mov = 1:numel(self.movementNames)
                if any(strcmp(movementNames,self.movementNames(mov)))
                    nClasses = nClasses + 1;
                end
            end
            
            mixedLabels = zeros(nIndividualClasses,nClasses);
            index = 0;
            for mov = 1:numel(self.movementNames)    
                if any(contains(movementNames,self.movementNames(mov)))
                    index = index +1;
                    temp = find(contains(movementNames,self.movementNames(mov)));
                    mixedLabels(temp,index) = 1;
                end
            end

            
            nSamples  = size(labels,1);
            encodedLabels = zeros(nSamples, nClasses);
            for sample = 1:nSamples 
                encodedLabels(sample,:) = mixedLabels(labels(sample),:);
            end

        end
        
        function string_PredictedMovement = decodeOutIndex(self,movIdx)
            if any(ismember(self.movementIndex,movIdx))
                string_PredictedMovement = self.movementNames(ismember(self.movementIndex,movIdx));
                
            else
                string_PredictedMovement = '';
                movIdxBin = de2bi(movIdx,8);
                flag = 0;
                for i = 1:length(self.movementIndex)
                    movementIndexBin = de2bi(self.movementIndex(i),8);
                    % if a number is the same after BitAND with mix, it's
                    % part of the movement combination
                    if ~any(bitxor(bitand(movIdxBin,movementIndexBin),movementIndexBin))
                        if movIdxBin(7) && movementIndexBin(7) % Finger movement
                            if flag
                                string_PredictedMovement = strcat(string_PredictedMovement,' + ',{' '}, self.movementNames(i));
                            else
                                string_PredictedMovement = self.movementNames(i);
                                flag = 1;
                            end
                        end
                        if ~movIdxBin(7) && ~movementIndexBin(7)
                            if flag
                                if ~strcmp(self.movementNames(i),'Rest')
                                string_PredictedMovement = strcat(string_PredictedMovement,' +',{' '}, self.movementNames(i));
                                end
                            else
                                if ~strcmp(self.movementNames(i),'Rest')
                                string_PredictedMovement = self.movementNames(i);
                                flag = 1;
                                end
                            end
                        end
                    end
                end
                
            end
                

        end
        function answer = sendStimCommand(self, obj, channel, amplitude, pulseWidth, frequency, pulses)

            try
                identificationByte = 0xB0; % NS_STIMULATION
               
                obj.flush;
                write(obj,identificationByte,'uint8');

                % This command does not have a first response from the ALC, probably due to compatability with NCALfit functions.
                % Therefore, the two lines below have been left commented out!
                % rsp = read(obj,1,'uint8');
                % self.firstResponseCheck(rsp, identificationByte, 'sendStimCommand')
               
                % send parameters
                write(obj, channel, 'uint8');
                write(obj, fix(amplitude/10), 'uint8');
                write(obj, fix(pulseWidth/10), 'uint8');
                write(obj, frequency, 'uint8');
                write(obj, pulses, 'uint8');
               
                % read the answer from the MSP
                answer = read(obj,1,'uint8');
                               
                % Final confirmation Byte
                rsp = read(obj,1,'uint8');
                self.finalResponseCheck(rsp, identificationByte, 'sendStimCommand')
               
                % everything okay, translate return value to something useful
                if isKey(self.stimResponses, answer)
                    answer = self.stimResponses(answer);
                else
                    answer = 'UNKNOWN_RESPONSE';
                end
 
            catch e
                if exist('obj','var')
                    delete(obj);
                end
                error(e.message)
                return
            end   
        end

    end
    
    methods(Static)
        %% -----------------------------------------------------------------
        % ALC helper functions 
        % There is no corresponding function to this on the ALC
        %------------------------------------------------------------------

        % Create Serial object
        function obj = createSerialObject(comPort)
       
            try
                obj = serialport(comPort, 460800, 'Databits', 8, ...
                    'Byteorder', 'big-endian');
                
                disp("Created serial object for ALC");
                
            catch e
                if exist('obj','var')
                    delete(obj);
                end
                obj = -1;
                disp(e)
                return      
            end
        end
        
        % Test connection to ALC
        function flag = testConnection(obj)
            flag = false;
            try
                obj.flush;
                write(obj,'A','char'); 
                write(obj,'C','char'); 
                rsp = char(read(obj,1,'char'));
                if rsp == 'C'
                    fprintf('Connection working\n');
                    flag = true;
                elseif isempty(rsp)
                    throw(MException('CallbackDemo:noResponse', ...
                        'No connection response'));
                elseif ~strcmp(char(rsp),'C')
                    throw(MException('CallbackDemo:invalidResponse', ...
                        'Invalid connection response'));
                end
            catch e
                if exist('obj','var')
                    delete(obj);
                end
                    error(e.message)
                return
            end
        end
        
        % Decompress EMG data
        function float_vec = decompressData(data)
            
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
        end
        
        % Convert movement index to readable string
        function string_PredictedMovement = decodeOutIndexOld(movIdx)
            string_PredictedMovement = '';
            if bitand(movIdx,1)
                string_PredictedMovement = 'Open hand';
            elseif bitand(movIdx,2)
                string_PredictedMovement = 'Close hand';
            end
            if bitand(movIdx,4)
                if isempty(string_PredictedMovement)
                    string_PredictedMovement = 'Pronation';
                else
                    string_PredictedMovement = strcat(string_PredictedMovement,' & ',' pronation');
                end
            elseif bitand(movIdx,8)
                if isempty(string_PredictedMovement)
                    string_PredictedMovement = 'Supination';
                else
                    string_PredictedMovement = strcat(string_PredictedMovement,' & ',' supination');
                end
            end
            if bitand(movIdx,16)
                if isempty(string_PredictedMovement)
                    string_PredictedMovement = 'Flex elbow';
                else
                    string_PredictedMovement = strcat(string_PredictedMovement,' & ',' flex elbow');
                end
            elseif bitand(movIdx,32)
                if isempty(string_PredictedMovement)
                    string_PredictedMovement = 'Extend elbow';
                else
                    string_PredictedMovement = strcat(string_PredictedMovement,' & ',' extend elbow');
                end
            end
            
            
            
            
        end
        
        % Check for first confirmation byte
        function firstResponseCheck(rspByte, desiredByte, functionName)
            if isempty(rspByte)
                message = [functionName ': No first byte response'];
                throw(MException('CallbackDemo:noResponse', ...
                   message));
            elseif ~isequal(rspByte, uint8(desiredByte))
                message = [functionName ': Invalid first byte response'];
                throw(MException('CallbackDemo:invalidResponse', ...
                    message));
            end
        end
        
        % Check for final confirmation byte
        function finalResponseCheck(rspByte, desiredByte, functionName)
           
            if isequal(rspByte, uint8(desiredByte))
                message = [functionName ': Succesful \n'];
                fprintf(message);

            elseif isempty(rspByte)
                message = [functionName ': No final byte response'];
                throw(MException('CallbackDemo:noResponse', ...
                    message));
            elseif ~isequal(rspByte, uint8(desiredByte))
                message = [functionName ': Invalid final byte response'];
                throw(MException('CallbackDemo:invalidResponse', ...
                    message));
            end
        end
        
        % Convert channel numbers to channel indexes for the ALC
        function [chIdxLowerTmp, chIdxUpperTmp, chIdxExtraTmp] = calculateChannelIndex(activeChannelsVector)

            chIdxExtraTmp = bitshift(sum(bitset(0,activeChannelsVector)),-16);  %channels 17-24
            chIdxUpperTmp = bitshift(sum(bitset(0,activeChannelsVector)),-8);
            chIdxUpperTmp = bitand(chIdxUpperTmp,255); % channels 9-16
            chIdxLowerTmp = bitand(sum(bitset(0,activeChannelsVector)),255); % channels 1-8

        end

        
    end
    
    

end

