
classdef SystemTest2_StimulationTest < matlab.unittest.TestCase
    %IntegrationTest1_HandMovements tests for hand movements
    %   Tests All Movements Depending on Hand
    
    properties
        serialObj
        hand
        arm
    end
    
    methods
        function testCase = SystemTest2_StimulationTest()
            delete(instrfindall);
            ports = serialportlist;
            [index,inputMade] = listdlg('ListString',ports, 'SelectionMode','single');
            
            if ~any(inputMade)
                error('SystemTests:ListDialogError','No Port Selected')
            end
            comPort = ports(index);
            
            testCase.serialObj = ALC.createSerialObject(comPort);
            
            uiwait(msgbox('Set oscilliscope vertical parameter to 50 mV on Ch1'))
            %% Select a Hand Setup
            handSetups = ["OBSensor", "OBSpeed", "MiaHand", "BeBionic", "OBSensorWBridge", "OBSpeedWBridge"];
            
            % to be added - the different arms
            [index,inputMade] = listdlg('ListString',handSetups, 'SelectionMode','single');
            if ~any(inputMade)
                error('SystemTests:ListDialogError','No Hand Selected')
            end
            testCase.hand = handSetups(index);
            %% Hand Setup
            armSetups = ["Ottobock Arm","Wrist only"];
            [index,inputMade] = listdlg('ListString',armSetups, 'SelectionMode','single');
            
            if ~any(inputMade)
                error('SystemTests:ListDialogError','No Arm Selected')
            end
            testCase.arm = armSetups(index);
            clc;
            
        end
        
    end
    
    
    
    
    
    
    
    
    
    methods (Test)
        function handOpenCloseDirectStimulation(testCase)
            %% set control mode
            alc = ALC();
            alc.setCommandMode(testCase.serialObj)
            uiwait(msgbox('Run _SystemStimTest.m - needs to connect over TCP'))
            %% Setup TCP/IP Client - to connect to MATLAB 2019a
            client=tcpclient("localhost",30000,"Timeout",60*5);
            
                
            % The Default values loaded into the GUI from NCALfit 1.4
            modAmpTop = 40;
            modAmpLow = 15;
            modPWTop = 15;
            modPWLow = 10;
            modFreqTop = 30;
            modFreqLow = 5;
            % Read DESC settings from GUI
            DESCenable = 0;
            DESCchannel = 0;
            DESCamplitude = 15;
            DESCpulseWidth = 10;
            DESCfrequency = 100;
            DESCpulses = 5;
            DESCatSlips = 1;
            
            
            
            stimMode=1;
            channel = 14-1;
            amplitude = 150;
            frequency = 50;
            pulseWidth = 250;
            pulses = 10;
            
            % Send the settings to the ALC
            write(testCase.serialObj,hex2dec('B2'),'char');
            reply = read(testCase.serialObj,1,'char'); % first echo
            % send stim settings
            write(testCase.serialObj,stimMode,'char');
            write(testCase.serialObj,channel,'char');
            write(testCase.serialObj,amplitude/10,'char');
            write(testCase.serialObj,pulseWidth/10,'char');
            write(testCase.serialObj,frequency,'char');
            write(testCase.serialObj,pulses,'char');
            % send mod ranges
            write(testCase.serialObj,modAmpTop,'char');
            write(testCase.serialObj,modAmpLow,'char');
            write(testCase.serialObj,modPWTop,'char');
            write(testCase.serialObj,modPWLow,'char');
            write(testCase.serialObj,modFreqTop,'char');
            write(testCase.serialObj,modFreqLow,'char');
            % send DESC settings
            write(testCase.serialObj,DESCenable,'char');
            write(testCase.serialObj,DESCchannel,'char');
            write(testCase.serialObj,DESCamplitude,'char');
            write(testCase.serialObj,DESCpulseWidth,'char');
            write(testCase.serialObj,DESCfrequency,'char');
            write(testCase.serialObj,DESCpulses,'char');
            write(testCase.serialObj,DESCatSlips,'char');
            reply =[];
            reply = read(testCase.serialObj,1,'uint8'); % confirmation echo
            if reply == 178 %0xB2
                disp('Stimulation Parameters written correctly!');
            elseif reply == 134 %0x86
                pause(0.5)
                error('StimulationTest:NSPARAM_OUT_OF_RANGE','PARAM_OUT_OF_RANGE');
            else
                set(handles.t_msg,'String','');
                pause(0.5)
                error('StimulationTest:NSCommunicationError','Communication Error');
            end
            pause(0.2)
            
            % Enable Stimulation
            enableNS=1;
            write(testCase.serialObj,hex2dec('B3'),'char'); %%
            reply = read(testCase.serialObj,1,'char');
            if reply == hex2dec('B3')
                write(testCase.serialObj,enableNS,'char');
                reply = read(testCase.serialObj,1,'char');
                if reply == hex2dec('B3')
                    disp('Enabled')
                else
                    error('StimulationTest:NSInvalidSecondResponse','Error Setting Neurostimulator enable');
                end
            else
                error('StimulationTest:NSInvalidFirstResponse','Error Setting Neurostimulator enable');
            end
            
            %% Set the Hand Movement Thresholds
            %% Close Hand if Open
            movementStruct.movIndex = 1; % Hand Open
            movementStruct.strength(1:3) = 30; % Set All strengths to 30
            pause(0.1)
            alc.executeMovement(testCase.serialObj, movementStruct);
            pause(0.2)
            %% Write Settings
            selMov(1).CHinput = 1;
            selMov(1).MOVindex = 1; % open hand
            selMov(1).MVClevel = 0.00089484;%0.00084722;
            selMov(1).motorThresh = 0.00012103;%9.7222e-05;
            selMov(1).active = 1;
            % Close Hand
            selMov(2).CHinput = 3;
            selMov(2).MOVindex = 2; % close hand
            selMov(2).MVClevel = 0.00093431;%0.000875;%0.00085476;
            selMov(2).motorThresh = 4.9603e-05;%0.00010516;%0.0001119;
            selMov(2).active = 1;
            write(testCase.serialObj,'w','char');
            replay = read(testCase.serialObj,1,'char');
            if strcmp(replay,'w')
                write(testCase.serialObj,2,'char')%two channels one after the other i think
                for i = 1:2
                    write(testCase.serialObj,selMov(i).active,'char');
                    %alc.setActiveChannels([2,3]);
                    write(testCase.serialObj,selMov(i).MOVindex,'char');
                    write(testCase.serialObj,selMov(i).CHinput,'char');
                    write(testCase.serialObj,selMov(i).motorThresh,'single');
                    write(testCase.serialObj,selMov(i).MVClevel,'single');
                end
                replay = read(testCase.serialObj,1,'char');
                if strcmp(replay,'w')
                    disp('Control settings correctly sent to ALC-D');
                else
                    disp('Error1 sending Control settings');
                    close(testCase.serialObj);
                    return
                end
            else
                disp('Error2 sending Control settings');
                close(testCase.serialObj);
                return
            end
            pause(1)
            
            alc.getStatus(testCase.serialObj);
            pause(0.1)
            alc.getRecSettings(testCase.serialObj);
            %             prompt = {'Seconds for Recording:'};

            recordingTime=6;
            sF = alc.samplingFrequency;
            tWs = alc.timeWindowSamples;
            nCh = alc.numberOfActiveChannels;
            nFeatures = alc.numberOfActiveFeatures;
            nWindows = sF/tWs*recordingTime;
            %timeVector = linspace(0,recordingTime,nWindows);
            featureData = zeros(nWindows,nCh, nFeatures);
            %% Write Control Mode
            expectedMode = 0;
            pause(0.1);
            alc.setControlMode(testCase.serialObj)
            testCase.verifyEqual(alc.alcdMode,expectedMode);
            %% Wait for Simulink Model to Start

            while 1
                data=read(client,1, "char");
                if data(1)=="H"
                    break;
                else
                    disp('waiting for Matlab 2019a to say Hello')
                end
            end
                       
            
            %% Oscilloscope for stimulation reading
            % Initialize the scope object
            myScope = oscilloscope();
            
            % The address of the oscilloscope
            myScope.Resource = 'USB::0x0699::0x0408::C031188::INSTR';
            
            % Connect the scope
            connect(myScope);
            
            % Enable channel 1 (GPIO1) and channel 2 (GPIO2)
            enableChannel(myScope, 'CH1');
            % Set the acquisition time and number of samples
            Acquisition_Time = 4; %in seconds
            NumSamples = 5e6;
            set(myScope,'AcquisitionTime',Acquisition_Time);
            set(myScope, 'WaveformLength',NumSamples);
            
            %% Execute Motion
            string_PredictedMovement=[];
            movement.activLevel1= [];
            movement.activLevel2 =[];
            movement.activLevel3 =[];
            % Start Reading from ALC
            alc.startClosedLoopACQ(testCase.serialObj);
            try
                for win = 1:nWindows
                    for feature=1:nFeatures
                        featureData(win,:,feature) = read(testCase.serialObj,nCh,'single');
                    end
                    movement.moveIndex = read(testCase.serialObj,1,'uint8');
                    movement.activLevel1 = [movement.activLevel1,read(testCase.serialObj,1,'uint8')];
                    movement.activLevel2 = [movement.activLevel2,read(testCase.serialObj,1,'uint8')];
                    movement.activLevel3 = [movement.activLevel2,read(testCase.serialObj,1,'uint8')];
                    string_PredictedMovement = [string_PredictedMovement,alc.decodeOutIndex(movement.moveIndex)];
                    
                end
            catch exception
                alc.stopACQ(testCase.serialObj);
                disconnect(myScope);
                ErrMsg=exception.message;
                X = [' Test Failed because ',ErrMsg];
                disp(X)
                testCase.verifyFail(ErrMsg);
            end
            alc.stopACQ(testCase.serialObj);
            [ch1] = getWaveform(myScope);
            disconnect(myScope);
            pause(0.5)
            alc.getStatus(testCase.serialObj);
            pause(0.5)
            save('alc_data.mat','alc')
            
            %% Verify the test results
            index=1;
            pulse_count = 0;
            pulse_ind=[];
            while (~isempty(index))
                stimDown_beg = find(ch1(index:end) <  (-0.66*amplitude/1000),1)+index;
                stimDown_end = find(ch1(stimDown_beg:end) > (-0.66*amplitude/1000),1)+stimDown_beg;
                figure(1)
                plot(ch1(stimDown_beg-1:stimDown_end))
                title('The last stimulation')
                ylabel('volts')
                xlabel('samples')
                pulseWidthMeas = (stimDown_end - stimDown_beg)*Acquisition_Time/NumSamples;
                upperLim = (pulseWidth+pulseWidth/10)*1e-6;
                lowerLim = (pulseWidth-pulseWidth/5)*1e-6;
                if (~isempty(stimDown_beg))
                    if  (pulseWidthMeas < upperLim) && (pulseWidthMeas > lowerLim)
                        pulse_count= pulse_count+1;
                        pulse_ind = [pulse_ind,stimDown_beg];
                    end
                end
                index = stimDown_end;
            end
            
            % making sure that there are at least num pulses occuring for a
            % touch
            testCase.verifyGreaterThanOrEqual(pulse_count,pulses)
            
            % make sure frequency of stimulation is correct
            freqMeas=1./(diff(pulse_ind)*Acquisition_Time/NumSamples);
            mostCommFreq = mode(freqMeas);
            testCase.verifyLessThanOrEqual(mostCommFreq,frequency+frequency/10)
            testCase.verifyGreaterThanOrEqual(mostCommFreq,frequency-frequency/10)
        end
    end
end
