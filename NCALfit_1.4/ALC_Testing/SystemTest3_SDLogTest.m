classdef SystemTest3_SDLogTest < matlab.unittest.TestCase
    %IntegrationTest3_StimulationTest tests for stimulation on ALC
    %
    
    properties
        serialObj
        hand
        testname
        testName
        maxTime
        threshold
        loops
        stimParams
        comPort
    end
    
    methods
        function testCase = SystemTest3_SDLogTest()
            % connect to ALC
            delete(instrfindall);
            ports = serialportlist;
            
            [index,inputMade] = listdlg('ListString',ports, 'SelectionMode','single');
            
            if ~inputMade
                error('IntegrationTest4:ListDialogError','No Port Selected')
            end
            testCase.comPort = ports(index);
            
            testCase.serialObj = ALC.createSerialObject(testCase.comPort);
            
        end
    end
    
    methods(Test)
        
        function SDMemoryBlocks(testCase)
            % Tests normal datalog is working as expected
            alc = ALC();
            pause(0.2)
            alc.setCommandMode(testCase.serialObj)
            %% Reset SD Card
            try
                write(testCase.serialObj,hex2dec('F1'),'char');
                reply = read(testCase.serialObj,1,'char');
                assert(reply == hex2dec('F1'),'SDDataLogTest:noreply','Error receiving reply from ALC');
                reply = char(read(testCase.serialObj,1,'char'));
                assert(reply == hex2dec('F1'),'SDDataLogTest:badreply','Error resetting SD card');
                
            catch exception
                rethrow(exception)
            end
            %% Reset BlockIdx
            try
                % reset blockIdx (LogFile block pointer on hardware)
                write(testCase.serialObj,'o','char');
                reply = char(read(testCase.serialObj,1,'char')');
                assert(strcmp(reply,'o'),'SDDataLogTest:noResponse','No response from ALC');
                
                blockIdx = read(testCase.serialObj,1,'uint32');
                
                
                while true
                    currentIdx = read(testCase.serialObj,1,'uint32');
                    if currentIdx == 0
                        break
                    else
                        write(testCase.serialObj,currentIdx,'uint32');
                    end
                end
                
                disp('BlockIdx Reset');
                
            catch exception
                %disp(exception.message);
                rethrow(exception)
            end
            %% Power ALC on and off
            fig = uifigure;
            selection = '';
            while  ~strcmp(selection, 'Continue')
                selection = uiconfirm(fig,'Restart the ALC. Click "Continue" when the bluetooth connection is paired again','Restart ALC','Icon','info', 'Options',{'Continue'});
            end
            close(fig)
            
            testCase.serialObj = ALC.createSerialObject(testCase.comPort);
            flush(testCase.serialObj)
            alc = ALC();
            pause(0.1)
            alc.setCommandMode(testCase.serialObj)
            pause(0.2)
            %% Ensure Normal mode for datalog
            debugDatalog = 0;
            EMGDatalog = 0;
            SDBlockCount = 2;
            
            write(testCase.serialObj,hex2dec('F0'),'char');
            reply = read(testCase.serialObj,1,'char');
            
            assert(reply == hex2dec('F0'),'IntegrationTest3:setDatalog_Callback:noreply','Error receiving reply from ALC');
            write(testCase.serialObj,debugDatalog,'uint8');
            write(testCase.serialObj,EMGDatalog,'uint8');
            write(testCase.serialObj,SDBlockCount,'uint8');
            
            clockPeriod = read(testCase.serialObj,1,'uint32')/80000000;
            
            reply = char(read(testCase.serialObj,1,'char'));
            
            %% Get data location
            write(testCase.serialObj,'n','char');
            reply=char(read(testCase.serialObj,1,'char'));
            if reply == 'n'
                lastLocation= read(testCase.serialObj,1,'uint32');
                SDmemsize= read(testCase.serialObj,1,'uint8');
            else
                error('IntegrationTest4:SDCommError','Issue asking for SD info')
            end
            % get the second n
            reply=char(read(testCase.serialObj,1,'char'));
            %% Get initial Data
            numBlocks = lastLocation+3;
            address = 0;
            tic
            % Set warnings to temporarily issue error (exceptions)
            s = warning('error', 'instrument:fread:unsuccessfulRead');
            write(testCase.serialObj,'m','char');
            reply = char(read(testCase.serialObj,1,'char'));
            if strcmp(reply,'m')
                write(testCase.serialObj,numBlocks,'uint32');
                write(testCase.serialObj,address,'uint32');
                for i = 1:numBlocks
                    try
                        %SDcardValuesChar(i,:) = read(testCase.serialObj,512,'char');
                        SDcardValues(i,:) = read(testCase.serialObj,512,'uint8');
                        disp(['Downloading can take some minutes...', num2str(i), ' of ', num2str(numBlocks)]);
                        
                    catch exception
                        save('SDcard.mat','SDcardValues');
                        return
                    end
                    %Set warning back to normal state
                    warning(s)
                end
                reply = char(read(testCase.serialObj,1,'char'));
                if strcmp(reply,'m')
                    %disp(obj)
                    save('SDcard.mat','SDcardValues');
                    disp('SDcard read successful: value saved into SDcard.mat file');
                else
                    error('IntegrationTest4:SDError','Error Reading SDcard');
                end
            else
                error('IntegrationTest4:SDError','Error Reading SDcard');
            end
            %% Do hand movements ---------------------------------------------------------
            %% Run test for long time
            movementStruct.movIndex = 2; % Hand closed
            movementStruct.strength(1:3) = 30; % Set All strengths to 30
            pause(0.1)
            alc.executeMovement(testCase.serialObj, movementStruct);
            pause(0.2)
            %% Write Settings
            selMov(1).CHinput = 2-1;
            selMov(1).MOVindex = 1; % open hand
            selMov(1).MVClevel = 0.00089484;%0.00084722;
            selMov(1).motorThresh = 0.00012103;%9.7222e-05;
            selMov(1).active = 1;
            % Close Hand
            selMov(2).CHinput = 4-1;
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
                end
            else
                disp('Error2 sending Control settings');
            end
            pause(1)
            
            alc.getStatus(testCase.serialObj);
            pause(0.1)
            alc.getRecSettings(testCase.serialObj);
            recordingTime=60*10;
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
            uiwait(msgbox('Run_SDIntegrationSignals.m in 2019a Matlab'));
            %alc.startClosedLoopACQ(testCase.serialObj);
            pause(recordingTime)

            pause(0.5)
            alc.setCommandMode(testCase.serialObj)
            pause(0.2)
            %% Get data locations
            write(testCase.serialObj,'n','char');
            reply=char(read(testCase.serialObj,1,'char'));
            if reply == 'n'
                lastLocation= read(testCase.serialObj,1,'uint32');
                SDmemsize= read(testCase.serialObj,1,'uint8');
            else
                error('IntegrationTest4:SDCommError','Issue asking for SD info')
            end
            reply=char(read(testCase.serialObj,1,'char'));
            %% Get Data after movements
            
            numBlocks = lastLocation+3;
            address = 0;
            data_bin=[];
            tic
            % Set warnings to temporarily issue error (exceptions)
            s = warning('error', 'instrument:fread:unsuccessfulRead');
            write(testCase.serialObj,'m','char');
            reply = char(read(testCase.serialObj,1,'char'));
            if strcmp(reply,'m')
                write(testCase.serialObj,numBlocks,'uint32');
                write(testCase.serialObj,address,'uint32');
                for i = 1:numBlocks
                    try
                        %SDcardValuesChar(i,:) = read(testCase.serialObj,512,'char');
                        data_now = read(testCase.serialObj,512,'uint8');
                        SDcardValues(i,:) = data_now;
                        data_bin = [data_bin,data_now];
                        disp(['Downloading can take some minutes...', num2str(i), ' of ', num2str(numBlocks)]);
                        
                    catch exception
                        save('SDcardAfter.mat','SDcardValues');
                        fileid=fopen('DataAfterTest.bin','w');
                        fwrite(fileid,data_bin);
                        fclose(fileid);
                        return
                    end
                    %Set warning back to normal state
                    warning(s)
                end
                reply = char(read(testCase.serialObj,1,'char'));
                if strcmp(reply,'m')
                    %disp(obj)
                    save('SDcardAfter.mat','SDcardValues');
                    cd('C:\Users\Workbench\Documents\SVN\biopatrec\branches\ALCLog_1.4_DataLogging')
                    fileid=fopen('DataAfterTest.bin','w');
                    fwrite(fileid,data_bin);
                    fclose(fileid);
                    disp('SDcard read successful: value saved into SDcardAfter.mat file');
                else
                    error('IntegrationTest4:SDError','Error Reading SDcard');
                end
            else
                error('IntegrationTest4:SDError','Error Reading SDcard');
            end
            %% Open Data Log and See if it is working
            cur_dir=pwd;
            ALCLog=ALCLogClass('DataAfterTest.bin');
            % Rest the Hand so the motors arent on all the time
            alc.setCommandMode(testCase.serialObj);
            movementStruct.movIndex = 0; % Rest
            movementStruct.strength(1:3) = 30; % Set All strengths to 30
            pause(0.1)
            alc.executeMovement(testCase.serialObj, movementStruct);
            
            
            % Load Data
            try
                savecounter = ALCLog.getDataFromBinFile('DataAfterTest.bin');
                logDuration = double(ALCLog.nBlocks)/60;
                points = double(ALCLog.nDataPoints);
                
                tVector = linspace(0, logDuration,points-1);
                maxval = max(max(ALCLog.variablesSupplementary.tmabsRaw));
                
                HandOpens=ALCLog.variablesSupplementary.tmabsRaw(:,1);
                HandCloses=ALCLog.variablesSupplementary.tmabsRaw(:,2);
            catch
                logDuration = double(ALCLog.nBlocks)/60;
                points = double(ALCLog.nDataPoints);
                
                tVector = linspace(0, logDuration,points-1);
                maxval = max(max(ALCLog.variablesSupplementary.tmabsRaw));
                
                HandOpens=ALCLog.variablesSupplementary.tmabsRaw(:,1);
                HandCloses=ALCLog.variablesSupplementary.tmabsRaw(:,2);
            end
            HandOpenCount=0;
            HandOpensToParse = find(ALCLog.variablesControlOB.outIdxRaw==1);
            for i=1:length(HandOpensToParse)-1
                if HandOpensToParse(i)+1==HandOpensToParse(i+1)
                    %not a new command continue on
                else
                    HandOpenCount= HandOpenCount+1;
                end
            end
            HandCloseCount=0;
            HandClosesToParse = find(ALCLog.variablesControlOB.outIdxRaw==2);
            for i=1:length(HandClosesToParse)-1
                if HandClosesToParse(i)+1==HandClosesToParse(i+1)
                    %not a new command continue on
                else
                    HandCloseCount= HandCloseCount+1;
                end
            end
            %% the test verifications
            testCase.verifyEqual(HandCloseCount,HandOpenCount,'RelTol',0.02);
            testCase.verifyEqual(HandCloseCount,69,'RelTol',0.03);
            %testCase.verifyGreaterThanOrEqual(HandCloseCount,60);
        end
        
        %  ---------------------------------------------------------------------------------------
        %% Debug Test ----------------------------------------------------------------------------
        %  ---------------------------------------------------------------------------------------
        function SDMemoryBlocksDebug(testCase)
            alc = ALC();
            pause(0.1)
            alc.setCommandMode(testCase.serialObj)
            %% Reset SD Card
            try
                write(testCase.serialObj,hex2dec('F1'),'char');
                reply = read(testCase.serialObj,1,'char');
                assert(reply == hex2dec('F1'),'SDDataLogTest:noreply','Error receiving reply from ALC');
                reply = char(read(testCase.serialObj,1,'char'));
                assert(reply == hex2dec('F1'),'SDDataLogTest:badreply','Error resetting SD card');
                
            catch exception
                rethrow(exception)
            end
            %% Reset BlockIdx
            try
                % reset blockIdx (LogFile block pointer on hardware)
                write(testCase.serialObj,'o','char');
                reply = char(read(testCase.serialObj,1,'char')');
                assert(strcmp(reply,'o'),'SDDataLogTest:noResponse','No response from ALC');
                
                blockIdx = read(testCase.serialObj,1,'uint32');
                
                
                while true
                    currentIdx = read(testCase.serialObj,1,'uint32');
                    if currentIdx == 0
                        break
                    else
                        write(testCase.serialObj,currentIdx,'uint32');
                    end
                end
                
                disp('BlockIdx Reset');
                
            catch exception
                %disp(exception.message);
                rethrow(exception)
            end
            %% Power ALC on and off
            fig = uifigure;
            selection = '';
            while  ~strcmp(selection, 'Continue')
                selection = uiconfirm(fig,'Restart the ALC. Click "Continue" when the bluetooth connection is paired again','Restart ALC','Icon','info', 'Options',{'Continue'});
            end
            close(fig)
            
            testCase.serialObj = ALC.createSerialObject(testCase.comPort);
            flush(testCase.serialObj)
            alc = ALC();
            pause(0.1)
            alc.setCommandMode(testCase.serialObj)
            pause(0.2)
            %% Ensure Debug mode for datalog
            debugDatalog = 1;
            EMGDatalog = 0;
            SDBlockCount = 4;
            
            write(testCase.serialObj,hex2dec('F0'),'char');
            reply = read(testCase.serialObj,1,'char');
            
            assert(reply == hex2dec('F0'),'IntegrationTest3:setDatalog_Callback:noreply','Error receiving reply from ALC');
            write(testCase.serialObj,debugDatalog,'uint8');
            write(testCase.serialObj,EMGDatalog,'uint8');
            write(testCase.serialObj,SDBlockCount,'uint8');
            
            clockPeriod = read(testCase.serialObj,1,'uint32')/80000000;
            
            reply = char(read(testCase.serialObj,1,'char'));
            %% Get data location
            write(testCase.serialObj,'n','char');
            reply=char(read(testCase.serialObj,1,'char'));
            if reply == 'n'
                lastLocation= read(testCase.serialObj,1,'uint32');
                SDmemsize= read(testCase.serialObj,1,'uint8');
            else
                error('IntegrationTest4:SDCommError','Issue asking for SD info')
            end
            % get the second n
            reply=char(read(testCase.serialObj,1,'char'));
            %% Get initial Data
            
            %
            numBlocks = lastLocation+3;
            address = 0;
            tic
            % Set warnings to temporarily issue error (exceptions)
            s = warning('error', 'instrument:fread:unsuccessfulRead');
            write(testCase.serialObj,'m','char');
            reply = char(read(testCase.serialObj,1,'char'));
            if strcmp(reply,'m')
                write(testCase.serialObj,numBlocks,'uint32');
                write(testCase.serialObj,address,'uint32');
                for i = 1:numBlocks
                    try
                        %SDcardValuesChar(i,:) = read(testCase.serialObj,512,'char');
                        SDcardValues(i,:) = read(testCase.serialObj,512,'uint8');
                        disp(['Downloading can take some minutes...', num2str(i), ' of ', num2str(numBlocks)]);
                        
                    catch exception
                        save('SDcard.mat','SDcardValues');
                        return
                    end
                    %Set warning back to normal state
                    warning(s)
                end
                reply = char(read(testCase.serialObj,1,'char'));
                if strcmp(reply,'m')
                    %disp(obj)
                    save('SDcard.mat','SDcardValues');
                    disp('SDcard read successful: value saved into SDcard.mat file');
                else
                    error('IntegrationTest4:SDError','Error Reading SDcard');
                end
            else
                error('IntegrationTest4:SDError','Error Reading SDcard');
            end
            %% Do hand movements ---------------------------------------------------------
            %% Run test for long time
            movementStruct.movIndex = 2; % Hand closed
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
            selMov(2).CHinput = 4-1;
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
                end
            else
                disp('Error2 sending Control settings');
            end
            pause(1)
            
            alc.getStatus(testCase.serialObj);
            pause(0.1)
            alc.getRecSettings(testCase.serialObj);
            recordingTime=60*10;
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
            uiwait(msgbox('Run_SDIntegrationSignals.m in 2019a Matlab'));
            %alc.startClosedLoopACQ(testCase.serialObj);
            pause(recordingTime)
            
            pause(0.5)
            alc.setCommandMode(testCase.serialObj)
            pause(0.2)
            %% Get data locations
            write(testCase.serialObj,'n','char');
            reply=char(read(testCase.serialObj,1,'char'));
            if reply == 'n'
                lastLocation= read(testCase.serialObj,1,'uint32');
                SDmemsize= read(testCase.serialObj,1,'uint8');
            else
                error('IntegrationTest4:SDCommError','Issue asking for SD info')
            end
            reply=char(read(testCase.serialObj,1,'char'));
            %% Get Data after movements
                       
            numBlocks = lastLocation+3;
            address = 0;
            data_bin=[];
            tic
            % Set warnings to temporarily issue error (exceptions)
            s = warning('error', 'instrument:fread:unsuccessfulRead');
            write(testCase.serialObj,'m','char');
            reply = char(read(testCase.serialObj,1,'char'));
            if strcmp(reply,'m')
                write(testCase.serialObj,numBlocks,'uint32');
                write(testCase.serialObj,address,'uint32');
                for i = 1:numBlocks
                    try
                        %SDcardValuesChar(i,:) = read(testCase.serialObj,512,'char');
                        data_now = read(testCase.serialObj,512,'uint8');
                        SDcardValues(i,:) = data_now;
                        data_bin = [data_bin,data_now];
                        disp(['Downloading can take some minutes...', num2str(i), ' of ', num2str(numBlocks)]);
                        
                    catch exception
                        save('SDcardAfter.mat','SDcardValues');
                        fileid=fopen('DataAfterTest.bin','w');
                        fwrite(fileid,data_bin);
                        fclose(fileid);
                        return
                        
                        %             SDcardValues(i,:) = fread(obj,512,'char');
                        %             message = sprintf('Downloading can take some minutes... %d on %d', i, numBlocks);
                        %             set(handles.t_msg,'String', message);
                        %             drawnow;
                    end
                    %Set warning back to normal state
                    warning(s)
                end
                reply = char(read(testCase.serialObj,1,'char'));
                if strcmp(reply,'m')
                    %disp(obj)
                    save('SDcardAfter.mat','SDcardValues');
                    cd('C:\Users\Workbench\Documents\SVN\biopatrec\branches\ALCLog_1.4_DataLogging')
                    fileid=fopen('DataAfterTest.bin','w');
                    fwrite(fileid,data_bin);
                    fclose(fileid);
                    disp('SDcard read successful: value saved into SDcardAfter.mat file');
                else
                    error('IntegrationTest4:SDError','Error Reading SDcard');
                end
            else
                error('IntegrationTest4:SDError','Error Reading SDcard');
            end
            %% Open Data Log and See if it is working
            cur_dir=pwd;
            ALCLog=ALCLogClass('DataAfterTest.bin');
            % Rest the Hand so the motors arent on all the time
            alc.setCommandMode(testCase.serialObj);
            movementStruct.movIndex = 0; % Rest
            movementStruct.strength(1:3) = 30; % Set All strengths to 30
            pause(0.1)
            alc.executeMovement(testCase.serialObj, movementStruct);
            
            % Load Data
            try
                savecounter = ALCLog.getDataFromBinFile('DataAfterTest.bin');
                logDuration = double(ALCLog.nBlocks)/60;
                points = double(ALCLog.nDataPoints);
                
                tVector = linspace(0, logDuration,points-1);
                maxval = max(max(ALCLog.variablesSupplementary.tmabsRaw));
                
                HandOpens=ALCLog.variablesSupplementary.tmabsRaw(:,1);
                HandCloses=ALCLog.variablesSupplementary.tmabsRaw(:,2);
            catch
                logDuration = double(ALCLog.nBlocks)/60;
                points = double(ALCLog.nDataPoints);
                
                tVector = linspace(0, logDuration,points-1);
                maxval = max(max(ALCLog.variablesSupplementary.tmabsRaw));
                
                HandOpens=ALCLog.variablesSupplementary.tmabsRaw(:,1);
                HandCloses=ALCLog.variablesSupplementary.tmabsRaw(:,2);
            end
            HandOpenCount=0;
            HandOpensToParse = find(ALCLog.variablesControlOB.outIdxRaw==1);
            for i=1:length(HandOpensToParse)-1
                if HandOpensToParse(i)+1==HandOpensToParse(i+1)
                    %not a new command continue on
                else
                    HandOpenCount= HandOpenCount+1;
                end
            end
            HandCloseCount=0;
            HandClosesToParse = find(ALCLog.variablesControlOB.outIdxRaw==2);
            for i=1:length(HandClosesToParse)-1
                if HandClosesToParse(i)+1==HandClosesToParse(i+1)
                    %not a new command continue on
                else
                    HandCloseCount= HandCloseCount+1;
                end
            end
            %% the test verifications
             testCase.verifyEqual(HandCloseCount,HandOpenCount,'RelTol',0.02);
             testCase.log("Hand Opens equal Hand Closes verification passed");
            testCase.verifyEqual(HandCloseCount,69,'RelTol',0.03);
            testCase.log("number of hand close test verification passed");
        end
        
        %  -------------------------------------------------------------------------------------
        %% EMG Test ----------------------------------------------------------------------------
        %  -------------------------------------------------------------------------------------
        function SDMemoryBlocksEMG(testCase)
            alc = ALC();
            pause(0.1)
            alc.setCommandMode(testCase.serialObj)
            %% Reset SD Card
            try
                write(testCase.serialObj,hex2dec('F1'),'char');
                reply = read(testCase.serialObj,1,'char');
                assert(reply == hex2dec('F1'),'SDDataLogTest:noreply','Error receiving reply from ALC');
                reply = char(read(testCase.serialObj,1,'char'));
                assert(reply == hex2dec('F1'),'SDDataLogTest:badreply','Error resetting SD card');
                
            catch exception
                rethrow(exception)
            end
            %% Reset BlockIdx
            try
                % reset blockIdx (LogFile block pointer on hardware)
                write(testCase.serialObj,'o','char');
                reply = char(read(testCase.serialObj,1,'char')');
                assert(strcmp(reply,'o'),'SDDataLogTest:noResponse','No response from ALC');
                
                blockIdx = read(testCase.serialObj,1,'uint32');
                
                
                while true
                    currentIdx = read(testCase.serialObj,1,'uint32');
                    if currentIdx == 0
                        break
                    else
                        write(testCase.serialObj,currentIdx,'uint32');
                    end
                end
                
                disp('BlockIdx Reset');
                
            catch exception
                %disp(exception.message);
                rethrow(exception)
            end
            %% Power ALC on and off
            fig = uifigure;
            selection = '';
            while  ~strcmp(selection, 'Continue')
                selection = uiconfirm(fig,'Restart the ALC. Click "Continue" when the bluetooth connection is paired again','Restart ALC','Icon','info', 'Options',{'Continue'});
            end
            close(fig)
            
            testCase.serialObj = ALC.createSerialObject(testCase.comPort);
            flush(testCase.serialObj)
            alc = ALC();
            pause(0.1)
            alc.setCommandMode(testCase.serialObj)
            pause(0.2)
            %% Ensure Debug mode for datalog
            debugDatalog = 0;
            EMGDatalog = 1;
            SDBlockCount = 10
            EMGChannels=[1 2]-1;
            
            write(testCase.serialObj,hex2dec('F0'),'char');
            reply = read(testCase.serialObj,1,'char');
            
            assert(reply == hex2dec('F0'),'IntegrationTest3:setDatalog_Callback:noreply','Error receiving reply from ALC');
            write(testCase.serialObj,debugDatalog,'uint8');
            write(testCase.serialObj,EMGDatalog,'uint8');
            write(testCase.serialObj,SDBlockCount,'uint8');
            write(testCase.serialObj,EMGChannels(1),'uint8');
            write(testCase.serialObj,EMGChannels(2),'uint8')
            clockPeriod = read(testCase.serialObj,1,'uint32')/80000000;
            
            reply = char(read(testCase.serialObj,1,'char'));
            %% Get data location
            write(testCase.serialObj,'n','char');
            reply=char(read(testCase.serialObj,1,'char'));
            if reply == 'n'
                lastLocation= read(testCase.serialObj,1,'uint32');
                SDmemsize= read(testCase.serialObj,1,'uint8');
            else
                error('IntegrationTest4:SDCommError','Issue asking for SD info')
            end
            % get the second n
            reply=char(read(testCase.serialObj,1,'char'));
            %% Get initial Data
            
            numBlocks = lastLocation+3;
            address = 0;
            tic
            % Set warnings to temporarily issue error (exceptions)
            s = warning('error', 'instrument:fread:unsuccessfulRead');
            write(testCase.serialObj,'m','char');
            reply = char(read(testCase.serialObj,1,'char'));
            if strcmp(reply,'m')
                write(testCase.serialObj,numBlocks,'uint32');
                write(testCase.serialObj,address,'uint32');
                for i = 1:numBlocks
                    try
                        %SDcardValuesChar(i,:) = read(testCase.serialObj,512,'char');
                        SDcardValues(i,:) = read(testCase.serialObj,512,'uint8');
                        disp(['Downloading can take some minutes...', num2str(i), ' of ', num2str(numBlocks)]);
                        
                    catch exception
                        save('SDcard.mat','SDcardValues');
                        return
                        
                        %             SDcardValues(i,:) = fread(obj,512,'char');
                        %             message = sprintf('Downloading can take some minutes... %d on %d', i, numBlocks);
                        %             set(handles.t_msg,'String', message);
                        %             drawnow;
                    end
                    %Set warning back to normal state
                    warning(s)
                end
                reply = char(read(testCase.serialObj,1,'char'));
                if strcmp(reply,'m')
                    %disp(obj)
                    save('SDcard.mat','SDcardValues');
                    disp('SDcard read successful: value saved into SDcard.mat file');
                else
                    error('IntegrationTest4:SDError','Error Reading SDcard');
                end
            else
                error('IntegrationTest4:SDError','Error Reading SDcard');
            end
            %% Do hand movements ---------------------------------------------------------
            %% Run test for long time
            movementStruct.movIndex = 2; % Hand closed
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
            selMov(2).CHinput = 4-1;
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
                end
            else
                disp('Error2 sending Control settings');
            end
            pause(1)
            
            alc.getStatus(testCase.serialObj);
            pause(0.1)
            alc.getRecSettings(testCase.serialObj);
            recordingTime=60*10;
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
            uiwait(msgbox('Run_SDIntegrationSignals.m in 2019a Matlab'));
            %alc.startClosedLoopACQ(testCase.serialObj);
            pause(recordingTime)
            
            pause(0.5)
            alc.setCommandMode(testCase.serialObj)
            pause(0.2)
            %% Get data locations
            write(testCase.serialObj,'n','char');
            reply=char(read(testCase.serialObj,1,'char'));
            if reply == 'n'
                lastLocation= read(testCase.serialObj,1,'uint32');
                SDmemsize= read(testCase.serialObj,1,'uint8');
            else
                error('IntegrationTest4:SDCommError','Issue asking for SD info')
            end
            reply=char(read(testCase.serialObj,1,'char'));
            %% Get Data after movements
                        
            numBlocks = lastLocation+3;
            address = 0;
            data_bin=[];
            tic
            % Set warnings to temporarily issue error (exceptions)
            s = warning('error', 'instrument:fread:unsuccessfulRead');
            write(testCase.serialObj,'m','char');
            reply = char(read(testCase.serialObj,1,'char'));
            if strcmp(reply,'m')
                write(testCase.serialObj,numBlocks,'uint32');
                write(testCase.serialObj,address,'uint32');
                for i = 1:numBlocks
                    try
                        %SDcardValuesChar(i,:) = read(testCase.serialObj,512,'char');
                        data_now = read(testCase.serialObj,512,'uint8');
                        SDcardValues(i,:) = data_now;
                        data_bin = [data_bin,data_now];
                        disp(['Downloading can take some minutes...', num2str(i), ' of ', num2str(numBlocks)]);
                        
                    catch exception
                        save('SDcardAfter.mat','SDcardValues');
                        fileid=fopen('DataAfterTest.bin','w');
                        fwrite(fileid,data_bin);
                        fclose(fileid);
                        return
                                               
                    end
                    %Set warning back to normal state
                    warning(s)
                end
                reply = char(read(testCase.serialObj,1,'char'));
                if strcmp(reply,'m')
                    %disp(obj)
                    save('SDcardAfter.mat','SDcardValues');
                    cd('C:\Users\Workbench\Documents\SVN\biopatrec\branches\ALCLog_1.4_DataLogging')
                    fileid=fopen('DataAfterTest.bin','w');
                    fwrite(fileid,data_bin);
                    fclose(fileid);
                    disp('SDcard read successful: value saved into SDcardAfter.mat file');
                else
                    error('IntegrationTest4:SDError','Error Reading SDcard');
                end
            else
                error('IntegrationTest4:SDError','Error Reading SDcard');
            end
            %% Open Data Log and See if it is working
            cur_dir=pwd;
            ALCLog=ALCLogClass('DataAfterTest.bin');
            % Rest the Hand so the motors arent on all the time
            alc.setCommandMode(testCase.serialObj);
            movementStruct.movIndex = 0; % Rest
            movementStruct.strength(1:3) = 30; % Set All strengths to 30
            pause(0.1)
            alc.executeMovement(testCase.serialObj, movementStruct);
            
            
            % Load Data
            try
                savecounter = ALCLog.getDataFromBinFile('DataAfterTest.bin');
                logDuration = double(ALCLog.nBlocks)/60;
                points = double(ALCLog.nDataPoints);
                
                tVector = linspace(0, logDuration,points-1);
                maxval = max(max(ALCLog.variablesSupplementary.tmabsRaw));
                
            catch
                logDuration = double(ALCLog.nBlocks)/60;
                points = double(ALCLog.nDataPoints);
                
                tVector = linspace(0, logDuration,points-1);
                maxval = max(max(ALCLog.variablesSupplementary.tmabsRaw));
                

            end
            
            %Reshape Channel 2
            data = reshape(ALCLog.variablesEMG.EMGRaw(:,:,2)',...
                numel(ALCLog.variablesEMG.EMGRaw(:,:,2)),1)';
            

            % Analyze Data
            index=1;
            pulse_count = 0;
            while (~isempty(index))
                EMGSigUp=find(data(index:end)>0.0003,1)+index;
                EMGSigDown = find(data(EMGSigUp:end)< 8e-5,1)+EMGSigUp;
                if ~isempty(EMGSigUp)
                    pulse_count= pulse_count+1;
                end
                index=EMGSigDown;
            end
            [pks,locs]=findpeaks(data,'MinPeakProminence',0.5e-3,'MinPeakDistance',0.01e5);
            [pks2,locs2]=findpeaks(-data,'MinPeakProminence',0.5e-3,'MinPeakDistance',0.01e5);
            %% Test verification
            % There should be 69 hand opens
            testCase.verifyEqual(length(pks),69)
            % There should be 69 hand closes
            testCase.verifyEqual(length(pks2),69)
            % Validating that the opening hand controls are as expected
            % A low,medium,high sequence repeated 23 times 
            amp_flag=[];
            for i=1:3:69
                if data(locs(i))<data(locs(i+1))&&  data(locs(i+1))<data(locs(i+2))
                    amp_flag=[amp_flag,1];
                else
                    amp_flag=[amp_flag,0];
                end
            end
            testCase.verifyEqual(amp_flag,ones(1,length(pks)/3),'RelTol',0.01)
        end
    end
    
end