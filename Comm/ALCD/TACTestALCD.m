% ---------------------------- Copyright Notice ---------------------------
% This file is part of BioPatRec © which is open and free software under 
% the GNU Lesser General Public License (LGPL). See the file "LICENSE" for 
% the full license governing this code and copyrights.
%
% BioPatRec was initially developed by Max J. Ortiz C. at Integrum AB and 
% Chalmers University of Technology. All authors’ contributions must be kept
% acknowledged below in the section "Updates % Contributors". 
%
% Would you like to contribute to science and sum efforts to improve 
% amputees’ quality of life? Join this project! or, send your comments to:
% maxo@chalmers.se.
%
% The entire copyright notice must be kept in this or any source file 
% linked to BioPatRec. This will ensure communication with all authors and
% acknowledge contributions here and in the project web page (optional).
%
% ------------------- Function Description ------------------
% A TAC Test is performed using the VRE. It then uses the TacTestResult
% function to display the gathered data.
%
% The function is written in such a way that it requires the movement
% "rest" to run properly.
% --------------------------Updates--------------------------
% [Contributors are welcome to add their email]
% 2016-01-14 / Enzo Mastinu / Creation: this function executes TAC test 
%                           / with predictions read directly from the 
%                           / ALCD system. 
                            
% 20xx-xx-xx / Author     / Comment on update                          


function TACTestALCD(patRecX, handlesX)
    clear global;

    %global speed
    global time
    global patRec;    
    global handles;

    global wantedMovementId;
    global tacComplete;
    global firstTacTime;
    global startTimer;
    global completionTime;
    global selectionTime;
    global selectionTimeA;
    global nTW;
    global recordedMovements;
    global thresholdGUIData
    
    %DD 20190723
    global allowance;
    global realTimePosition;
    realTimePosition = 0;
    global pinchLatPosition;
    pinchLatPosition = 0;
    global realTimeMov;
    realTimeMov = 0;
    global realTimeTarget;
    realTimeTarget = 0;
    global realTimeDir;
    realTimeDir = 0;
    global tacTest;
    global openFlag;
    openFlag = -1;
    global speedSamplesBuff;
    global speedSamplesInd;
    global flagZero;
    
    patRec = patRecX;
    handles = handlesX;
    
    pDiv = 2; %Event is fired every TW/value milliseconds, ie 100ms if TW = 200ms & pDiv = 2.
    trials = str2double(get(handles.tb_trials,'String'));
    reps = str2double(get(handles.tb_repetitions,'String'));
    timeOut = str2double(get(handles.tb_executeTime,'String'));
    allowance = str2double(get(handles.tb_allowance,'String'));
    time = str2double(get(handles.tb_time,'String'));
    speedSamplesBuff = zeros(str2double(get(handles.tb_speedSamples,'String')),1);

    pause on; %Enable pausing

    tacComplete = 0;
    firstTacTime = [];

    % Get needed info from patRec structure
    tacTest.patRec      = patRec;
    tacTest.sF          = patRec.sF;
    % tacTest.tW          = patRec.tW;
    tacTest.trials      = trials;
    tacTest.nR          = reps;
    tacTest.timeOut     = timeOut;

    sF                  = tacTest.sF;
    nCh                 = length(patRec.nCh);       
    ComPortType         = patRec.comm;
    deviceName          = patRec.dev;

    % Get sampling time
    sT = tacTest.timeOut;
    tW = patRec.tW;                                                      
    timePrediction = patRec.wOverlap;
    
    % Is threshold (thOut) used?
    if(isfield(patRec.patRecTrained,'thOut'));
        %Threshold GUI init
        thresholdGUI = GUI_Threshold; 
        thresholdGUIData = guidata(thresholdGUI);
        set(GUI_Threshold,'CloseRequestFcn', 'set(GUI_Threshold, ''Visible'', ''off'')');
        xpatch = [1 1 0 0];
        ypatch = [0 0 0 0];
        for i=0:patRec.nOuts-1
            s = sprintf('movementSelector%d',i);
            s0 = sprintf('thPatch%d',i);
            s1 = sprintf('meter%d',i);
            axes(thresholdGUIData.(s1));
            handles.patRecHandles.(s0) = patch(xpatch,ypatch,'b','EdgeColor','b','EraseMode','normal','visible','on');
            ylim(thresholdGUIData.(s1), [0 1]);
            xlim('auto');
            set(thresholdGUIData.(s),'String',patRec.mov(patRec.indMovIdx));
            if (size(patRec.mov(patRec.indMovIdx),1) < i+1) 
                set(thresholdGUIData.(s),'Value',size(patRec.indMovIdx,2));
            else
                set(thresholdGUIData.(s),'Value',i+1);
            end
        end
    end

    %Initialise the control algorithm.
    %patRec = InitControl(patRec);  % No longer needed, initialization is performed inside the GUI

    % Start the test
    tempData = [];
    com = handles.vre_Com;
    
%     com.Timeout = 1;
%     try
%         while(fread(com,1))
%         end
%     catch
%     end
%     com.Timeout = 10;

    %Sends a value to set the TAC hand to ON.
    fwrite(com,sprintf('%c%c%c%c','c',char(2),char(1),char(0)));
    fread(com,1);

    fwrite(com,sprintf('%c%c%c%c','c',char(3),char(allowance),char(0),char(0)));   % OLD VRE   
%     fwrite(com,sprintf('%c%c%c%c%c','c',char(3),char(allowance),char(0),char(0)));   % NEW VRE
%     fwrite(com,sprintf('%c%c%c%c%c','c',char(7),char(0),char(0),char(0)));
%     fwrite(com,sprintf('%c%c%c%c','c',char(7),char(0),char(0)));
    fread(com,1);
    
    CurrentPosition('init',patRec,allowance, handles.movList);
    TrackStateSpace('initialize',patRec,allowance);

    numeroProva = 0;
    %Run through all the trials
    for t = 1 : trials
        %Create a random order for the wanted movements.
        indexOrder = GetMovementCombination(handles.dofs,patRec.nOuts-1);
        tacTest.combinations = size(indexOrder,1);
        for r = 1 : reps
            set(handles.txt_status,'String',sprintf('Trial: %d , Rep: %d.',t,r));
            set(handles.TACTestPlot.et_targetTAC,'String',sprintf('Trial: %d , Rep: %d.',t,r));

            %Loop through all of the movements
            for i = 1 : size(indexOrder,1)
                completionTime = NaN;
                selectionTime = NaN;
                selectionTimeA = NaN;
                startTimer = [];
                recordedMovements = [];
                tacComplete = 0;
                nTW = 1;
                wantedMovementId = [];
                printName = '';

                %Reset the TAC hand. Own function?
                
                fwrite(com,sprintf('%c%c%c%c','r','t',char(0),char(0),char(0)));
                fread(com,1);

                fwrite(com,sprintf('%c%c%c%c','r','1',char(0),char(0),char(0)));
                fread(com,1);
                
                fwrite(com,sprintf('%c%c%c%c','c',char(3),char(allowance),char(0),char(0))); % NEW VRE
                fread(com,1);
                
                numeroProva = numeroProva+1
                %Get all random movements for this set of movements.
                index = indexOrder(i,:);
                realTimeTarget = zeros(size(index));
                realTimeDir = zeros(size(index));

                set(handles.txt_status,'String','Wait!');
                set(handles.TACTestPlot.et_targetTAC,'String','Wait!');
                drawnow;
                pause(2);
                name = 'Wanted: ';
                %distance = randi(5,1) * 15 + 50;
                distance = 40;
                for j = 1:length(index)
                    movementIndex = patRec.movOutIdx{index(j)};
                    listOfMovements = handles.movList;
                    movement = listOfMovements(movementIndex);
                    name = strcat(name,movement.name,',');
                    printName = strcat(printName,upper(movement.name{1}(regexp(movement.name{1}, '\<.'))),',');
                    realTimeTarget(j) = movement.idVRE;
                    realTimeDir(j) = movement.vreDir;
                    
%                     if movement.idVRE == 3
%                         movement.idVRE = 12;
%                     elseif movement.idVRE == 5
%                         movement.idVRE = 13;
%                     end
                    
                    % Reset NearToggles
                    set(handles.TacTestToggles.txt_CH,'BackgroundColor',[1 1 1]);
                    set(handles.TacTestToggles.txt_FH,'BackgroundColor',[1 1 1]);
                    set(handles.TacTestToggles.txt_EH,'BackgroundColor',[1 1 1]);
                    set(handles.TacTestToggles.txt_P,'BackgroundColor',[1 1 1]);
                    set(handles.TacTestToggles.txt_S,'BackgroundColor',[1 1 1]);
                    set(handles.TacTestToggles.txt_SG,'BackgroundColor',[1 1 1]);
                    set(handles.TacTestToggles.txt_FG,'BackgroundColor',[1 1 1]);
                    set(handles.TacTestToggles.txt_OH,'BackgroundColor',[1 1 1]);

                    if movement.idVRE == 12 % if fine grip grasp
                        VREActivation(com,40,[],9,1,0);  % cylindrical open
                        VREActivation(com,10,[],5,1,0);   % thumb open
                        VREActivation(com,5,[],4,0,0);   % index close
                        VREActivation(com,5,[],3,0,0);   % middle close
                        VREActivation(com,30,[],6,0,0);  %opposition
                        VREActivation(com,40,[],9,1,1);  % cylindrical open
                        VREActivation(com,10,[],5,1,1);   % thumb open
                        VREActivation(com,5,[],4,0,1);   % index close
                        VREActivation(com,5,[],3,0,1);   % middle close
                        VREActivation(com,30,[],6,0,1);  %opposition
                        pause(1.5);
                    elseif movement.idVRE == 13 % if side grasp
%                         VREActivation(com,15,[],13,0,0); %standard side -
%                         forced because of mantaining of ovrall RoM.
                        VREActivation(com,15,[],6,0,0);  %opposition
%                         VREActivation(com,35,[],5,1,0);  %thumb open
                        VREActivation(com,50,[],5,1,0);  %thumb open
%                         VREActivation(com,15,[],13,0,1); %standard side
                        VREActivation(com,15,[],6,0,1);  %opposition
%                         VREActivation(com,35,[],5,1,1);  %thumb open
                        VREActivation(com,50,[],5,1,1);  %thumb open
                        pause(1.5)
                    end
                    
                    for temp_index = 1:distance
                        if movement.idVRE ~= 12 && movement.idVRE ~= 13 % if no fine && no lateral
                            VREActivation(com, 1, [], movement.idVRE, movement.vreDir, 1);
                            %                         VREActivation(com, 0.5, [], 3, 0, 0)
                            %                         VREActivation(com, 1, [], 12, 1, 0);
                        else
                            if movement.idVRE == 12 % if fine grip grasp
                                VREActivation(com,1,[],5,0,1);   % thumb close
                                VREActivation(com,1,[],4,0,1);   % index close
                                VREActivation(com,1,[],3,0,1);   % middle close
                            elseif movement.idVRE == 13 % if side grasp
                                VREActivation(com,1,[],5,0,1);  %thumb close
                            end
                            
                        end
                    end
                    wantedMovementId = [wantedMovementId; movementIndex];
                end
                %Remove the last comma. Other way of solving it?
                name{1}(end) = [];
                
%                 com.Timeout = 1;
%                 try
%                     while(fread(com,1))
%                     end
%                 catch
%                 end
%                 com.Timeout = 10;
                
                set(handles.txt_status,'String',name);
                set(handles.txt_status2,'String','');
                set(handles.TACTestPlot.et_timerTAC,'String','');
                set(handles.TACTestPlot.et_timerTAC,'BackgroundColor',[1 1 1]);
                set(handles.TACTestPlot.et_targetTAC,'String',name);
%                 set(handles.TACTestPlot.et_targetTAC,'String','');
                set(handles.TACTestPlot.et_currentTAC,'String','');
                set(handles.TACTestPlot.et_targetTAC,'FontSize',14);
                set(handles.TACTestPlot.et_currentTAC,'ForegroundColor',[0 0.9 0]);
                set(handles.TACTestPlot.et_currentTAC,'FontSize',14);
                drawnow;
                CurrentPosition('target',index, distance);
                TrackStateSpace('target',index, distance); % ONLY WORKS IF DISTANCE IS THE SAME IN ALL DOFS

                % Reset the controller between trials
                patRec = ReInitControl(patRec);

                % Prepare handles for next function calls
                handles.deviceName  = deviceName;
                handles.ComPortType = ComPortType;
                if strcmp (ComPortType, 'COM')
                    handles.ComPortName = patRec.comn;
                end
                handles.sF          = sF;
                handles.sT          = sT;
                handles.nCh         = nCh;
                handles.sTall       = sT;

                % Delete connection object
                if isfield(handles,'obj')
                    delete(handles.obj);
                end

                % Connect the chosen device, it returns the connection object
                obj = ConnectDevice(handles);

                handles.obj = obj;
                handles.success = 0;
                
                % Start to acquire the control output from ALCD
                fwrite(obj,'L','char');
                %     fwrite(obj,nCh,'char'); %ALC_D compatible - DD 20190712
                
                chActivationIndexes = fread(obj,1,'uint32');   % Active channels ALC 24ch - DD 20190712
                %     bitget(chActivationIndexes,32:-1:1,'uint32');
                %     chActivationIndexes = dec2bin(chActivationIndexes,32);
                %     activeChannels = str2num(chActivationIndexes);
                fwrite(obj,1,'char'); % dummy writes (compatibility with ALC-D1)
                replay = char(fread(obj,1,'char'));
                if strcmp(replay,'L')
                    set(handles.patRecHandles.t_msg,'String','ALC-D Control-Test Start');
                else
                    set(handles.patRecHandles.t_msg,'String','Error Start'); 
                    fclose(obj);
                    return
                end
                
%                 fread(com,1);
                
                realTimePosition = 0;
                realTimeMov = 0;
                openFlag = 1;
                speedSamplesBuff = zeros(length(speedSamplesBuff),1);
                speedSamplesInd = 1;

                for timeWindowNr = 1:round(sT/timePrediction)
                    tic
                    TACTestALCD_OneShot();   
                    if handles.success
                        % if the previous movement was "success" we can
                        % stop this acquisition and pass to the next
                        break
                    end 
                    toc
                end

                % Stop acquisition
                StopAcquisition(deviceName, obj);

                test.recordedMovements = recordedMovements;
                test.completionTime = completionTime;
                test.selectionTime = selectionTime;
                test.selectionTimeA = selectionTimeA;

                %Record data, present it.
                test.fail = isnan(completionTime);

                test.allowance = allowance;
                test.distance = distance;

                if(test.fail)
                    test.pathEfficiency = NaN;
                else
                    %This is not used for path efficiency any longer
                    %test.pathEfficiency = TrackStateSpace('single');
                    test.pathEfficiency = CurrentPosition('get');
                end

                test.movement = listOfMovements(wantedMovementId);
                test.name = printName(1:end-1); %Use something else?

                %Save the data to the trialResult in each trial, repetitition
                %and movement.
                tacTest.trialResult(t,r,i) = test;

                tempData = [];
            end
        end
    end

    tacTest.ssTracker = TrackStateSpace('read');
    tacTest.maxDegPerMovement = patRec.control.maxDegPerMov;
    tacTest.mov = patRec.mov;
    tacTest.testID = handles.testID;
    
    fwrite(com,sprintf('%c%c%c%c','r','t',char(0),char(0),char(0)));
    fread(com,1);
    
    fwrite(com,sprintf('%c%c%c%c','r','1',char(0),char(0),char(0)));
    fread(com,1);

    % Save test
    [filename, pathname] = uiputfile({'*.mat','MAT-files (*.mat)'},'Save as', 'Untitled.mat');
    if isequal(filename,0) || isequal(pathname,0)
       disp('User pressed cancel')
    else
        save([pathname,filename],'tacTest');    
    end

    %Display results
    tacTest = TacTestResults(tacTest);
end


function TACTestALCD_OneShot()
    pTime = tic;
    global patRec;
    global handles;
    global nTW;     % Number of time windows evaluated
    global fpTW;    % First time window with any movement.
    %global speed;
    global time;

    global wantedMovement;
    global wantedMovementId;

    global completionTime;
    global selectionTime;
    global selectionTimeA;
    global tacComplete;
    global processingTime;
    global firstTacTime;
    global startTimer;
    global recordedMovements;
    global thresholdGUIData
    
    global distance %FIX
    
    % DD - 20190723
    global allowance;
    global realTimePosition;
    global pinchLatPosition;
    global realTimeMov;
    global realTimeTarget;
    global realTimeDir;
    global tacTest;
    global openFlag;
    global speedSamplesBuff;
    global speedSamplesInd;
    global flagZero;
    global pathDir;


    % Output vector reset
    outVectorMotor = zeros(patRec.nOuts,1);
    outVector      = zeros(patRec.nOuts,1);
    
    %Start counting processing time
    processingTimeTic = tic;

    % General routine for RealtimePatRec

    %% REAL TIME CONTROL ALCD
    % Read the predicted movement from ALC-D
    % Movements are hardcoded accordingly to this definition:
    % #define REST 			  		0
    % #define OPENHAND 			  	1
    % #define CLOSEHAND			  	2
    % #define PRONATION            	3
    % #define SUPINATION            4
    % Conversion of the ALC-D output is needed because:
    %  - zero index
    %  - REST is usually the last one in BioPatRec
    
    %fread(handles.obj,1,'char'); % '+'  DD 20190712
    while(fread(handles.obj,1,'char') ~= '+')
    end
    
    outMov = fread(handles.obj,1,'char');
    % in case of controldecisionstep of the majority vote algorithm
    if(outMov == 199)
        return;
    end
    activLevel = fread(handles.obj,1,'char');
    % Re-scale strength value respect to the rest threshold
    
    
    restFlag = 0;
    if outMov == 0    
        outMov = patRec.nM;
        restFlag = 1; % ALC compatibility - DD 20190715
    end
    
    outVectorMotor(outMov) = 1;
    outVector(outMov) = 1;
    
    fread(handles.obj,1,'char'); % 'Strength'  DD 20190712
    fread(handles.obj,1,'char'); % 'dStep'  DD 20190712
    fread(handles.obj,1,'char'); % 'PWMg'  DD 20190712
    
    
    % Buffer to smooth velocity peaks
    speedSamplesBuff(speedSamplesInd) = activLevel;
    activLevel = round(mean(speedSamplesBuff));
    speedSamplesInd = speedSamplesInd +1;
    if speedSamplesInd > length(speedSamplesBuff)
        speedSamplesInd = 1;
    end
    
    %Rescaling respect to the rest threshold - DD 20191129
    pTable = patRec.pTable;
    minMovValues = tacTest.patRec.normSets.minMovValues;
    rampMax = tacTest.patRec.control.rampTrainingData.ramp.rampMax;
    if restFlag ~= 1
%         offset = (minMovValues(find(outMov == pTable))/rampMax(find(outMov == pTable)))*100;
        offset = 0; % this rescaling it is done on the embedded platform - DD 20220727
        if activLevel < offset
            activLevel = 0;
        else
            activLevel = round((activLevel - offset)*100/(100 - offset));
        end
    end
    
    %% Convert the predicted strength into VRE speed (from 1 to maxDegPerMov)
    patRec.control.currentDegPerMov = patRec.control.maxDegPerMov*activLevel/100;
   
    
    %% Control algorithm
    [patRec, outMov] = ApplyControl(patRec, outMov, outVector);
    
    % DD 20190715
%     pTable = patRec.pTable;
    outMov = find(outMov == pTable);
    if (restFlag == 1)
        outMov = length(pTable);
    end
%     fwrite(handles.vre_Com,sprintf('%c%c%c%c','c',char(3),char(allowance),char(0)));   

%     TrackStateSpace('move',outMov, patRec.control.currentDegPerMov);
%     CurrentPosition('move',outMov, patRec.control.currentDegPerMov);

    processingTime(nTW) = toc(processingTimeTic);

    %Check whether to start timer for completionTime and selectionTime.
    if isempty(startTimer) && isempty(find(outMov == patRec.nM))
        startTimer = tic;
        fpTW = nTW;
    end
    %Ensure that on movement or recording of time is done after the TAC has
    %completed.

    if ~tacComplete
        %Get movement from the list of movements.
        movement = handles.movList(outMov);
        speed = patRec.control.currentDegPerMov(outMov);
        
        
%         % DD 09/09/2019 - if rest position and open cyl is not the target,
%         % the hand cannot open
%         if movement(1).idVRE == 9 && movement(1).vreDir == 1
%             if ~(~isempty(realTimeTarget(find(realTimeTarget==9))) && ~isempty(realTimeDir(find(realTimeTarget==9)) == 1)) && realTimePosition <= 0
%                 outMov = 9;
%             end
%         end
        
       
        %Temporary time 
        if ~isempty(startTimer)
            tempTime = toc(startTimer);
            if isnan(selectionTime) && sum(ismember(outMov,wantedMovementId))
                selectionTime = tempTime+patRec.tW+processingTime(fpTW);
            end

            if isnan(selectionTimeA) && sum(ismember(wantedMovementId, outMov))
                selectionTimeA = tempTime+patRec.tW+processingTime(fpTW);
            end

        end
        %Only add the recorded movement if we are not yet done.

        if(length(movement)>1)
            name = movement(1).name;
            for i = 2:length(movement)
                name = strcat(name,',',movement(i).name);
            end
        else
            name = movement.name;
        end
        set(handles.txt_status2,'String',name);
        set(handles.TACTestPlot.et_currentTAC,'String',name);
%         drawnow;
        
        performedMovements = [];
        
        for i = 1:length(outMov)
            performedMovements = [performedMovements, {movement(i), speed(i)}];
            dof = movement(i).idVRE;
            dir = movement(i).vreDir;               
            
            if (handles.SMCtestEnabled) % if SMC test
                handles.SMCposition = SMCtestMapPosToVib(handles, wantedMovementId(1), dof, dir, speed(i), []);
            end
            
            % DD 20190723 - grasp type can be change only if the virtual
            % hand is in rest position
            
            if (handles.activeTarget)
                if (dof == 9 && dir == 1) || ~isempty(dof == realTimeTarget(find(realTimeTarget==dof)))
                    
                else
                    dof = 0;
                    outMov = 9;
                end
                handles.testID = 0;
            end
                        
            if dof == 9 ||  dof == 12 ||  dof == 13 ||  dof == 5 ||  dof == 3   % 9 = cylindrical, 12 = pinch, 13 = lateral, 5 = thumb, 3 = middle
                if realTimePosition <= 0.1 && realTimePosition >= -5    % if rest, movement can change. If pos <-5 then the target is open
                    realTimeMov = dof;
                end
                if dof == 9 && dir == 1
                    realTimePosition = realTimePosition - speed(i);
                    openFlag = 1;
                    if ~(~isempty(realTimeTarget(find(realTimeTarget==9))) && ~isempty(realTimeDir(find(realTimeTarget==9)) == 1)) && realTimePosition <= 0.01
%                         fwrite(handles.vre_Com,sprintf('%c%c%c%c','r','1',char(0),char(0)));
%                         fread(handles.vre_Com,1);
%                         realTimePosition = 0;
                        speed(i) = realTimePosition + speed(i);
                        patRec.control.currentDegPerMov(:) = speed(i);
%                         if speed(i) ~= 0
%                             patRec.control.currentDegPerMov = patRec.control.currentDegPerMov
%                         end
                        dof = realTimeMov;
                        realTimePosition = 0;
                        if flagZero == 0
                            outMov = 9;
                            dof = 0;
                        end
                        flagZero = 0;
                    else
                        flagZero = 1;
                    end
                    if realTimePosition <= -50
                        realTimePosition = realTimePosition + speed(i);                        
                        dof = 0;
                        outMov = 9;
                        speed(i) = 0;
%                         realTimePosition = -50;
                    end
%                     if realTimeMov == 12 || realTimeMov == 13
%                         pinchLatPosition = pinchLatPosition + speed(i);
%                         if pinchLatPosition > 15
%                             fwrite(com,sprintf('%c%c%c%c','r','1',char(0),char(0)));
%                             fread(com,1);
%                             pinchLatPosition = 0; 
%                         end
%                     end
                else
                    if dof == realTimeMov
                        realTimePosition = realTimePosition + speed(i);
                        openFlag = -1;
                        if realTimePosition >= 50
                            realTimePosition = realTimePosition - speed(i);                            
                            dof = 0;
                            outMov = 9;
                            speed(i) = 0;
%                             realTimePosition = 50;
                        end
                    end
                    pinchLatPosition = 0;
                end
                if dof == realTimeMov || (dof == 9 && dir == 1)
                    dof = realTimeMov;
                else
                    dof = 0;
                    outMov = 9;
                    speed(i) = 0;
                end
            end 
            
            if outMov == 9
                speed(i) = 0;
                speedSamplesBuff(:) = 0;
            end
            
%             fwrite(handles.vre_Com,sprintf('%c%c%c%c','c',char(3),char(allowance*2),char(0)));   % allowance*2 because of new VRE setting
%             VREActivation(handles.vre_Com,5,[],12,0,0)  side
%             VREActivation(handles.vre_Com,5,[],6,0,0)   min = -30 opp
%             VREActivation(handles.vre_Com,1,[],5,0,0)   thumb 
%             VREActivation(handles.vre_Com,40,[],9,1,0)   cyl        
%             VREActivation(handles.vre_Com,5,[],4,0,0)   index
%             VREActivation(handles.vre_Com,40,[],7,0,0)   pron/sup

            % acting for pinch/lateral movement
            if dof == 12
                if openFlag == 1
                    dir = 1;
                else
                    dir = 0;
                end
                VREActivation(handles.vre_Com,speed(i),[],4,dir,0);
                VREActivation(handles.vre_Com,speed(i),[],3,dir,0);
                ack = VREActivation(handles.vre_Com,speed(i),[],5,dir,0);
                outMov = 8;
            elseif dof == 13
                if openFlag == 1
                    dir = 1;
                else
                    dir = 0;
                end
                ack = VREActivation(handles.vre_Com,speed(i),[],5,dir,0);
                outMov = 7;
            else
                ack = VREActivation(handles.vre_Com,speed(i),[],dof,dir,0);
            end
            
            pathDir = dir;
            if (outMov > length(patRec.mov)) % KD 02092022: Added because the code above considers that always 8 classes are used, ...
                % this part corrects the output class in case there are less than 8 classes
                switch outMov
                    case 9
                        movStr = "Rest";
                    case 5
                        movStr = "Pronation";
                    case 6
                        movStr = "Supination";
                    case 7
                        movStr = "Side Grip";
                    case 8
                        movStr = "Fine Grip";
                end
                outMov = find(patRec.mov == movStr);
            end
            TrackStateSpace('move',outMov, patRec.control.currentDegPerMov,openFlag,handles.TACTestPlot.a_spiderPlotTAC,handles.TacTestToggles);
            CurrentPosition('move',outMov, patRec.control.currentDegPerMov);
            
            if (ack)
%                 VREActivation(handles.vre_Com,1,[],5,0,0)
%                 realTimePosition = realTimePosition - 1
                if (isempty(firstTacTime))
                   firstTacTime = tic; 
                else
                    heldTime = toc(firstTacTime);
                    if(heldTime > time)
                        set(handles.txt_status2,'String','Movement Completed!');
                        set(handles.TACTestPlot.et_timerTAC,'String','Movement Completed!');
                        completionTime = toc(startTimer);
                        completionTime = completionTime - time;
                        tacComplete = 1;
                        %Stop the acquisition and move on to the next movement.
                        handles.success = 1;
                        %Pause 1 second once the movement is completed.
                        pause(1);
                        %This means that the TAC-test is completed. This value
                        %is set so no more motion is completed. 
                        realTimePosition = 0;
                    else
                        set(handles.txt_status2,'String',sprintf('Movement reached. Hold for %0.02f more seconds.',time-heldTime));
                        set(handles.TACTestPlot.et_timerTAC,'String',sprintf('Movement reached. Hold for %0.02f more seconds.',time-heldTime));
                        set(handles.TACTestPlot.et_timerTAC,'FontSize',14);
                        set(handles.TACTestPlot.et_timerTAC,'BackgroundColor',[0 1 0]);
                        drawnow;
                    end
                end
            else
                firstTacTime = [];
                set(handles.TACTestPlot.et_timerTAC,'BackgroundColor',[1 1 1]);
%                 reset(handles.TACTestPlot.a_spiderPlotTAC);
%                 radarplot(handles.TACTestPlot.a_spiderPlotTAC,[1 2 3 4 5 6;7 8 9 10 11 12.5],{'','a','b','c','','e'},{'r','g'},{'b','r'},{'no','.'},5);
                
            end
            drawnow;
        end
        recordedMovements = [recordedMovements; {performedMovements}];
    end
    nTW = nTW + 1;
end
