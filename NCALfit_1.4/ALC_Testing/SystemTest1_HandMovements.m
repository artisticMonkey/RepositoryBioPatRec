classdef SystemTest1_HandMovements < matlab.unittest.TestCase
    %IntegrationTest1_HandMovements tests for hand movements
    %   Tests All Movements Depending on Hand
    
    properties
        serialObj
        hand
        arm
    end
    
    methods
        function testCase = SystemTest1_HandMovements()
            delete(instrfindall);
            ports = serialportlist;
            [index,inputMade] = listdlg('ListString',ports, 'SelectionMode','single');
            
            if ~any(inputMade)
                error('SystemTests:ListDialogError','No Port Selected')
            end
            comPort = ports(index);
            
            testCase.serialObj = ALC.createSerialObject(comPort);
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
        function handOpenClose(testCase)
            %% Test Desc
            % uses channels 2 and 3 from the SpeedGoat
            % to close and open the hand. The Test runs to close the
            % hand first.
            alc = ALC();
            
            %% Test Connection
            connectionFlag = ALC.testConnection(testCase.serialObj);
            assertTrue(testCase,connectionFlag)
            alc.setCommandMode(testCase.serialObj);
            pause(0.2)
            %% Close Hand if Open
            movementStruct.movIndex = 2; % Hand Close
            movementStruct.strength(1:3) = 30; % Set All strengths to 30
            pause(0.1)
            alc.executeMovement(testCase.serialObj, movementStruct);
            pause(0.2)
            %% Reset Motor movements
            for i=1:6
                selMov(i).active=0;
                selMov(i).MOVindex=0;
                selMov(i).CHinput=0;
                selMov(i).motorThresh=0.000;
                selMov(i).MVClevel=0.000;
            end

            nMovements=6;
            write(testCase.serialObj,'w','char');
            replay = char(read(testCase.serialObj,1,'char'));
            if strcmp(replay,'w')
                write(testCase.serialObj,nMovements,'char');
                for i = 1:nMovements
                    write(testCase.serialObj,selMov(i).active,'char');
                    write(testCase.serialObj,selMov(i).MOVindex,'char');
                    write(testCase.serialObj,selMov(i).CHinput,'char');
                    write(testCase.serialObj,selMov(i).motorThresh,'single');
                    write(testCase.serialObj,selMov(i).MVClevel,'single');
                end
                replay = char(read(testCase.serialObj,1,'char'));
                if strcmp(replay,'w')
                    disp('Control settings correctly sent to ALC-D');
                else
                    error('ALCError:write','Error sending Control settings');
                end
            else
                error('ALCError:write','Error sending Control settings');
            end
            
            %% Write Settings
            selMov(1).CHinput = 2-1;
            selMov(1).MOVindex = 1; % open hand
            selMov(1).MVClevel =0.00089087;% 0.00081944;%0.00089484;
            selMov(1).motorThresh = 7.7381e-05;%4.1667e-05;%0.00012103;%9.7222e-05;
            selMov(1).active = 1;
            % Close Hand
            selMov(2).CHinput = 4-1;
            selMov(2).MOVindex = 2; % close hand
            selMov(2).MVClevel =0.00089881;% 0.00093431;% 0.000875;%0.00085476;
            selMov(2).motorThresh =6.1508e-05;% 4.9603e-05;%0.00010516;%0.0001119;
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
            prompt = {'Start Speedgoat and choose seconds for recording:'};
            dlgtitle = 'Input Time';
            dims = [1 35];
            definput = {'25'};
            answer = inputdlg(prompt,dlgtitle,dims,definput);
            if isempty(answer)
                error('SystemTests:InputDialogError','No Time Selected')
            end
            recordingTime=str2double(answer);
            %recordingTime =input("Seconds for Recording");
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
                ErrMsg=exception.message;
                X = [' Test Failed because ',ErrMsg];
                disp(X)
                testCase.verifyFail(ErrMsg);
            end
            alc.stopACQ(testCase.serialObj);
            pause(0.5)
            alc.getStatus(testCase.serialObj);
            pause(0.5)
            save('alc_data.mat','alc')
            %% Analyze Test
            average_pwm = [];
            max_pwm = [];
            movement_summary ={};
            base_index =1;
            try
                for i=1:6
                    if i==1
                        rising_edge = find(movement.activLevel1(base_index:end)~=0,1);
                    else
                        rising_edge = base_index - 1 + find(movement.activLevel1(base_index:end)~=0,1);
                    end
                    falling_edge = rising_edge - 1 + find(movement.activLevel1(rising_edge:end)==0,1);
                    movement_summary{1,i} = string_PredictedMovement{1,rising_edge};
                    average_pwm(i) = mean(movement.activLevel1(rising_edge:falling_edge-1));
                    max_pwm(i)=max(movement.activLevel1(rising_edge:falling_edge-1));
                    base_index=falling_edge;
                    
                end
            catch
                disp("Seems like there are not enough pulses - activLevel1 saved in pulses.mat")
                save('pulses.mat','movement');
            end
            cHand = ['Close Hand'];
            oHand = ['Open Hand'];
            % Verify hand open 1 - minimum hand open is the in low range of motor setting
            ind = 1;
            testCase.verifyLessThan(max_pwm(ind),27)
            testCase.verifyGreaterThan(max_pwm(ind),20)
            testCase.verifyEqual(movement_summary{1,ind},oHand)
            
            % Verify hand close 1  - minimum hand close is the in low range of motor setting
            ind = 2;
            testCase.verifyLessThan(max_pwm(ind),26)
            testCase.verifyGreaterThan(max_pwm(ind),20)
            testCase.verifyEqual(movement_summary{1,ind},'Close Hand')
            
            % Verify hand open 2- medium hand open is the in middle of motor
            % setting
            ind =3;
            testCase.verifyLessThan(max_pwm(ind),59)
            testCase.verifyGreaterThan(max_pwm(ind),43)
            testCase.verifyEqual(movement_summary{1,ind},oHand)
            
            % Verify hand close 2 - medium hand close is the in middle of motor
            % setting
            ind = 4;
            testCase.verifyLessThan(max_pwm(ind),57)
            testCase.verifyGreaterThan(max_pwm(ind),43)
            testCase.verifyEqual(movement_summary{1,ind},'Close Hand')
            
            % Verify hand open 3 - maximal hand open is the max motor
            % setting
            ind = 5;
            testCase.verifyLessThan(max_pwm(ind),61)
            testCase.verifyGreaterThan(max_pwm(ind),58)
            testCase.verifyEqual(movement_summary{1,ind},oHand)
            
            % Verify hand close 3 - maximal hand close is the max motor
            % setting
            ind = 6;
            testCase.verifyLessThan(max_pwm(ind),61)
            testCase.verifyGreaterThan(max_pwm(ind),58)
            testCase.verifyEqual(movement_summary{1,ind},'Close Hand')
            
        end
    end
end