classdef app_RecordMovements < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                       matlab.ui.Figure
        GridLayout                     matlab.ui.container.GridLayout
        LeftPanel                      matlab.ui.container.Panel
        MovementListBoxLabel           matlab.ui.control.Label
        MovementListBox                matlab.ui.control.ListBox
        SelectMovementsButton          matlab.ui.control.Button
        LoadButton                     matlab.ui.control.Button
        TimeLabel                      matlab.ui.control.Label
        TimeField                      matlab.ui.control.NumericEditField
        ShapeDropDownLabel             matlab.ui.control.Label
        ShapeDropDown                  matlab.ui.control.DropDown
        StartButton                    matlab.ui.control.Button
        CenterPanel                    matlab.ui.container.Panel
        Panel                          matlab.ui.container.Panel
        Panel_2                        matlab.ui.container.Panel
        MainLabel                      matlab.ui.control.Label
        RightPanel                     matlab.ui.container.Panel
        ReconnectButton                matlab.ui.control.Button
        AnalyseButton                  matlab.ui.control.Button
        NetworkStructureDropDownLabel  matlab.ui.control.Label
        NetworkStructureDropDown       matlab.ui.control.DropDown
        TrainNetworkButton             matlab.ui.control.Button
        SetNNThresholdsButton          matlab.ui.control.Button
        SetPropThresholdsButton        matlab.ui.control.Button
        SaveNetworkButton              matlab.ui.control.Button
        UploadNetworkButton            matlab.ui.control.Button
        SaveDataButton                 matlab.ui.control.Button
        ChangelangguageSwitch          matlab.ui.control.Switch
        FloorNoiseSpinner              matlab.ui.control.Spinner
        FloorNoiseSpinnerLabel         matlab.ui.control.Label
        SwitchThresholdSpinner         matlab.ui.control.Spinner
        SwitchThresholdSpinnerLabel    matlab.ui.control.Label
        
        % User defined properties
        alc
        serialObj
        recordingData 
        recordingWindow
        rampLine
        rampMAVLine
        network
        displayedNames  
    end

    % Properties that correspond to apps with auto-reflow
    properties (Access = private)
        %movementSelectionApp
        onePanelWidth = 576;
        twoPanelWidth = 768;
    end
    
    % Methods handling app interaction
    methods (Access = public)
        function updateMovement(app, selectedMovements, selectedMovementsSwe)
            app.recordingData.movements = selectedMovements;
            app.recordingData.movementsSwe = selectedMovementsSwe;
            

            movements = strrep(app.recordingData.movements,' ','');
            movements = strrep(movements,'+','');
            app.recordingData.movementFields = strrep(movements,'/','');
            emptyCell = cell(length(movements),1);
            app.recordingData.movementRecordings = cell2struct(emptyCell,app.recordingData.movementFields);
              
            for index = 1:numel(app.recordingData.movementFields)
                name = cell2mat(app.recordingData.movementFields(index));
                app.recordingData.movementRecordings.(name).data = [];
                app.recordingData.movementRecordings.(name).nRecordings= -1;
                app.recordingData.movementRecordings.(name).samples = [];
                app.recordingData.movementRecordings.(name).MVC = 1;
            end
            app.recordingData.movementRecordings.('Rest').MVC = 0;

            app.MovementListBox.Items = strcat(app.recordingData.movements, ' [-]');
            app.displayedNames = app.recordingData.movements;
            app.StartButton.Enable = 1;
        end
        
        function updateMovementListValues(app)
             fieldNames = app.recordingData.movementFields;
             for mov=1:numel(fieldNames)
                 fieldName = fieldNames{mov};
                 if app.recordingData.movementRecordings.(fieldName).nRecordings >= 0             
                     app.MovementListBox.Items(mov) = {[cell2mat(app.recordingData.movements(mov)) sprintf(' [%i]', app.recordingData.movementRecordings.(fieldName).nRecordings)]}; 
                 else
                     app.MovementListBox.Items(mov) = {[cell2mat(app.recordingData.movements(mov)) sprintf(' [-]')]}; 
                 end
             end
        end
        
    end
    
    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: SelectMovementsButton
        function selectMovement(app, ~)
            
           %app.movementSelectionApp = app_MovementSelection(app);
           app_MovementSelection(app);
        end
               
        function loadRecording(app, ~)
            app.UIFigure.Visible = 'off';
            file = uigetfile('*.mat');
            app.UIFigure.Visible = 'on';
            if file == 0
                return
            end
            load(file, 'alcRec')
            
            app.alc.getRecSettings(app.serialObj);
            
            if ~isequal(app.alc.activeChannels,alcRec.alc.activeChannels)
                
                uialert(app.UIFigure,'Selected data was recorded with different channels than currentl active','Error')
                return;
            elseif ~(app.alc.featuresEnabled == alcRec.alc.featuresEnabled)
                uialert(app.UIFigure,'Selected data was recorded with different features than currently active','Error')
                return;
            elseif ~(app.alc.samplingFrequency == alcRec.alc.samplingFrequency)
                uialert(app.UIFigure,'Selected data was recorded with different sampling frequency than currently active','Error')
                return;
            elseif ~(app.alc.timeWindowSamples == alcRec.alc.timeWindowSamples)
                uialert(app.UIFigure,'Selected data was recorded with different window length than currently active','Error')
                return;
            else
                app.recordingData = alcRec.recordingData;
                displayedMovements = app.recordingData.movements;
                for mov=1:numel(displayedMovements)
                    fieldName = app.recordingData.movementFields{mov};
                    if app.recordingData.movementRecordings.(fieldName).nRecordings > 0
                        displayedMovements(mov) = {[cell2mat(displayedMovements(mov)) sprintf(' [%i]', app.recordingData.movementRecordings.(fieldName).nRecordings)]};
                    else
                        displayedMovements(mov) = {[cell2mat(displayedMovements(mov)) ' [-]']};
                    end
                end
                if isfield(alcRec, 'network')
                    app.network = alcRec.network;
                end

                app.FloorNoiseSpinner.Value = app.recordingData.floorNoise;
                app.SwitchThresholdSpinner.Value = app.recordingData.switchThreshold;
                app.displayedNames = app.recordingData.movements;
                app.MovementListBox.Items = displayedMovements;
                app.StartButton.Enable = 1;
                app.MainLabel.Text = 'Data loaded from file';
            end
            
        end

        % Button pushed function: StartButton
        function startRecording(app, ~)
            app.StartButton.Enable = 0;
            %--------------------------------------------------------------
            % Get current parameters
            %--------------------------------------------------------------
              
            sF = app.alc.samplingFrequency;
            tWs = app.alc.timeWindowSamples;
            nCh = app.alc.numberOfActiveChannels;
            nFeatures = app.alc.numberOfActiveFeatures*nCh;
            
            %--------------------------------------------------------------
            % Get values needed for plotting
            %--------------------------------------------------------------
            recordingTime = app.TimeField.Value; 
            nWindows = sF/tWs*recordingTime;
            timeVector = linspace(0,recordingTime,nWindows);       
            featureData = zeros(nWindows,nFeatures);
            labels = zeros(nWindows,1);
            
            selectedMovement = app.MovementListBox.Value;
            cutoff = find(ismember(selectedMovement, '['));
            selectedMovement = selectedMovement(1:cutoff-2);
            selectedMovementIndex = find(strcmp(app.recordingData.movements, selectedMovement));
            fieldName = cell2mat(app.recordingData.movementFields(selectedMovementIndex));
            MVC = app.recordingData.movementRecordings.(fieldName).MVC;
            restMAV = app.recordingData.movementRecordings.('Rest').MVC;
            
            if app.recordingData.movementRecordings.(fieldName).nRecordings == -1 || strcmp(selectedMovement, 'Rest')
                app.rampLine.Visible = 'Off';
                ylim(app.recordingWindow,[0 inf]);
            else
                app.rampLine.Visible = 'On';
                ylim(app.recordingWindow,[0 105]);
            end
            
            % Reset plot
            clearpoints(app.rampMAVLine)
            
            % Display message
            app.MainLabel.Text = '3';
            pause(1)
            app.MainLabel.Text = '2';
            pause(1)
            app.MainLabel.Text = '1';
            pause(1)
            app.MainLabel.Text = app.displayedNames(selectedMovementIndex);
            
            % Get ALC ready
            app.alc.setMotorEnable(app.serialObj, 0);
            tic;
            flush(app.serialObj)
            app.alc.startClosedLoopACQ(app.serialObj)
            
            for win = 1:nWindows
                % Receive ALC Data

                featureData(win,:) = read(app.serialObj,nFeatures,'single'); 

                movement.moveIndex = read(app.serialObj,1,'uint8');   
                movement.activLevel1 = read(app.serialObj,1,'uint8');
                movement.activLevel2 = read(app.serialObj,1,'uint8');
                movement.activLevel3 = read(app.serialObj,1,'uint8');
                
                meanMAV = mean(featureData(win,1:nCh));
                
                

                % Update plot
               if app.recordingData.movementRecordings.(fieldName).nRecordings == -1 || strcmp(selectedMovement, 'Rest')
                   addpoints(app.rampMAVLine,timeVector(win),meanMAV);
               else
                   scaledMAV = 100*(meanMAV-restMAV)/(MVC-restMAV);
                   if scaledMAV > 100
                       scaledMAV = 100;
                   elseif scaledMAV<0
                       scaledMAV=0;
                   end
                   addpoints(app.rampMAVLine,timeVector(win),scaledMAV);
               end
               
               % Get label
               labels(win) = selectedMovementIndex;
               

            end
            
            %--------------------------------------------------------------
            % Stop acquisistion
            %--------------------------------------------------------------            
            toc
            app.alc.stopACQ(app.serialObj)   
            app.alc.setMotorEnable(app.serialObj, 1);
            
            app.MainLabel.Text = 'Recording finished';
            
            %--------------------------------------------------------------
            % Save Data
            %-------------------------------------------------------------- 
            %fig = uifigure;
            msg = 'Do you want to save this recording?';
            title = 'Confirm Save';
            selection = uiconfirm(app.UIFigure,msg,title,...
                'Options',{'Yes', 'No'},...
                'DefaultOption',1);
            if strcmp(selection, 'Yes')
                truncationPercentage = 0.1;
                index = floor(nWindows*truncationPercentage);

                if app.recordingData.movementRecordings.(fieldName).nRecordings == -1

                    app.recordingData.movementRecordings.(fieldName).MVC = mean(mean(featureData(index:end-index,1:nCh)));
                    if strcmp(selectedMovement, 'Rest')
                        app.FloorNoiseSpinner.Value = 1.2*app.recordingData.movementRecordings.(fieldName).MVC;
                        app.recordingData.floorNoise = 1.2*app.recordingData.movementRecordings.(fieldName).MVC;
                        app.FloorNoiseSpinner.Step = 0.1*app.recordingData.floorNoise;
                    end
                    
                    if strcmp(selectedMovement, 'Lock/Unlock Elbow')
                        app.SwitchThresholdSpinner.Value = app.recordingData.movementRecordings.(fieldName).MVC;
                        app.recordingData.switchThreshold = app.recordingData.movementRecordings.(fieldName).MVC;
                        app.SwitchThresholdSpinner.Step = 0.1*app.recordingData.switchThreshold;
                    end
                else

                    app.recordingData.data = [app.recordingData.data; featureData(index:end-index,:)];
                    app.recordingData.labels = [app.recordingData.labels; labels(index:end-index)];
                    app.recordingData.movementRecordings.(fieldName).data = [app.recordingData.movementRecordings.(fieldName).data; featureData(index:end-index,:)];
                    app.recordingData.movementRecordings.(fieldName).samples = [app.recordingData.movementRecordings.(fieldName).samples; size(featureData(index:end-index,:),1)];
                end
               
                app.recordingData.movementRecordings.(fieldName).nRecordings = app.recordingData.movementRecordings.(fieldName).nRecordings + 1;
                
                app.MovementListBox.Items(selectedMovementIndex) = {[cell2mat(app.recordingData.movements(selectedMovementIndex)) sprintf(' [%i]', app.recordingData.movementRecordings.(fieldName).nRecordings)]};
                app.MovementListBox.Value = app.MovementListBox.Items(selectedMovementIndex);
            end
            
            app.StartButton.Enable = 1;
        end
        
        function reconnectSerialPort(app, ~)
            
            if  ~isvalid(app.serialObj)

                instrreset
                ports = serialportlist;
                [index,inputMade] = listdlg('PromptString',{'Select ALC port'},'ListString',ports, 'SelectionMode','single');

                if ~inputMade
                    return;
                end
                app.UIFigure.Visible = 'on'; 
                comPort = ports(index);

                app.serialObj = ALC.createSerialObject(comPort);
                ALC.testConnection(app.serialObj);
                app.MainLabel.Text = 'ALC reconnected';
                app.StartButton.Enable = 1;
            else
                app.MainLabel.Text = 'ALC already connected';
                app.StartButton.Enable = 1;
            end
            
        end

        % Button pushed function: AnalyseButton
        function analyseData(app, ~)
            if isempty(app.recordingData.data)
                uialert(app.UIFigure,'No data to be analysed','Error')
            else
                app_AnalyseRecording(app)
            end
        end

        % Button pushed function: TrainNetworkButton
        function trainNetwork(app, ~)
            app.MainLabel.Text = 'Network training';
            if strcmp(app.NetworkStructureDropDown.Value ,'1 Layer FFNN ReLU')
                app.network = NeuralNetworks(app.recordingData.data, app.recordingData.labels, '1LayerFFNNReLU');                
            
            elseif strcmp(app.NetworkStructureDropDown.Value ,'1 Layer FFNN SigmoidMixed')
                labels = app.alc.encodeLabelsOneHot(app.recordingData.labels, app.recordingData.movements);
                app.network = NeuralNetworks(app.recordingData.data, labels, '1LayerFFNNSigmoidMixed');                
            
                
            end
            app.MainLabel.Text = 'Network trained';
        end

        % Button pushed function: SaveNetworkButton
        function saveNetwork(app, ~)
            
            trainedNetwork = struct(app.network);
            fileName = sprintf('trainedNetwork_%s.mat', datestr(now,'yyyy-mm-dd HH-MM'));
            save(fileName , 'trainedNetwork');
            app.MainLabel.Text = 'Network saved';
        end

        % Button pushed function: UploadNetworkButton
        function uploadNetwork(app, ~)
            
            selectedMovements = [];

            for field = 1: numel(app.recordingData.movementFields)
                
                fieldName = app.recordingData.movementFields{field};
                if ~isempty(app.recordingData.movementRecordings.(fieldName).data)
                    selectedMovements = [selectedMovements; field];
                end
            end
            
            app.alc.getNNParameters(app.serialObj);
            
            % DOUBLE CHECK THIS FUNCTION!
            prostheticOutput = app.alc.convertMovementNamesToProstheticOutput(app.recordingData.movements(selectedMovements));
            


            app.alc.NNCoefficients.nActiveClasses = app.network.nOutputs;
            app.alc.NNCoefficients.nFeatureSets = size(app.network.net.Layers(3).Weights,2);
            app.alc.NNCoefficients.weights = app.network.net.Layers(3).Weights; 
            app.alc.NNCoefficients.bias = app.network.net.Layers(3).Bias;
            app.alc.NNCoefficients.prostheticOutput = prostheticOutput;
            app.alc.NNCoefficients.mean = app.network.meanVector; 
            app.alc.NNCoefficients.std = app.network.stdVector; 
            app.alc.NNCoefficients.floorNoise = app.recordingData.floorNoise;
            app.alc.NNCoefficients.switchThreshold = app.recordingData.switchThreshold;
            app.alc.NNCoefficients.streamEnable = 0;

            app.alc.setNNParameters(app.serialObj,app.alc.NNCoefficients)
            app.MainLabel.Text = 'Network coefficients uploaded';
        end
        
        function setNNThresholds(app, ~)
            app_NetworkThresholdsMixed(app.alc, app.serialObj, app.recordingData, app.network);
        end
        
        function setPropThresholds(app, ~)
            app_ProportionalThresholdsMixed(app.alc, app.serialObj, app.recordingData, app.network);
        end

        % Button pushed function: SaveDataButton
        function saveData(app, ~)
            alcRec.alc = app.alc; % if this causes problems, use struct(app.alc)
            alcRec.network = app.network;
            alcRec.recordingData = app.recordingData;
            alcRec.mov = app.recordingData.movements;
            alcRec.movFields = app.recordingData.movementFields;
            fileName = sprintf('alcRec_%s.mat', datestr(now,'yyyy-mm-dd HH-MM'));
            save(fileName , 'alcRec');
            app.MainLabel.Text = 'Recording session saved';
        end

        % Value changed function: ChangelangguageSwitch
        function changeLanguage(app, ~)
            value = app.ChangelangguageSwitch.Value;
            
            if strcmp(value, 'English')
                app.displayedNames = app.recordingData.movements;
                app.MainLabel.Text = 'Language changed to english';
            else
                app.displayedNames = app.recordingData.movementsSwe;
                app.MainLabel.Text = 'Språk ändrat till svenska';
            end
    
        end
        
        function updateFloorNoise(app, ~)
            app.recordingData.floorNoise = app.FloorNoiseSpinner.Value;
        end
        
        function updateSwitchThreshold(app, ~)
            app.recordingData.switchThreshold = app.SwitchThresholdSpinner.Value;
        end
        
        function updateAxes(app, ~)
            
            recordingTime = app.TimeField.Value; 
            sF = app.alc.samplingFrequency;
            tWs = app.alc.timeWindowSamples;
            nWindows = sF/tWs*recordingTime;
            
            timeVector = linspace(0,recordingTime,nWindows); 
            indexSlope = floor(nWindows/3);
            indexFlat = nWindows - 2*indexSlope;
            rampVector = [linspace(0,60,indexSlope) linspace(60,60,indexFlat) linspace(60,0,indexSlope)];
            
            xlim(app.recordingWindow,[0 recordingTime]);
            ylim(app.recordingWindow,[0 100]);
            xlabel(app.recordingWindow,'Time [s]');
            ylabel(app.recordingWindow,'Mean absolute value');
            clearpoints(app.rampLine)
            clearpoints(app.rampMAVLine)
            addpoints(app.rampLine,timeVector,rampVector);
            
            
        end

        % Changes arrangement of the app based on UIFigure width
        function updateAppLayout(app, ~)
            currentFigureWidth = app.UIFigure.Position(3);
            if(currentFigureWidth <= app.onePanelWidth)
                % Change to a 3x1 grid
                app.GridLayout.RowHeight = {644, 644, 644};
                app.GridLayout.ColumnWidth = {'1x'};
                app.CenterPanel.Layout.Row = 1;
                app.CenterPanel.Layout.Column = 1;
                app.LeftPanel.Layout.Row = 2;
                app.LeftPanel.Layout.Column = 1;
                app.RightPanel.Layout.Row = 3;
                app.RightPanel.Layout.Column = 1;
            elseif (currentFigureWidth > app.onePanelWidth && currentFigureWidth <= app.twoPanelWidth)
                % Change to a 2x2 grid
                app.GridLayout.RowHeight = {644, 644};
                app.GridLayout.ColumnWidth = {'1x', '1x'};
                app.CenterPanel.Layout.Row = 1;
                app.CenterPanel.Layout.Column = [1,2];
                app.LeftPanel.Layout.Row = 2;
                app.LeftPanel.Layout.Column = 1;
                app.RightPanel.Layout.Row = 2;
                app.RightPanel.Layout.Column = 2;
            else
                % Change to a 1x3 grid
                app.GridLayout.RowHeight = {'1x'};
                app.GridLayout.ColumnWidth = {235, '1x', 249};
                app.LeftPanel.Layout.Row = 1;
                app.LeftPanel.Layout.Column = 1;
                app.CenterPanel.Layout.Row = 1;
                app.CenterPanel.Layout.Column = 2;
                app.RightPanel.Layout.Row = 1;
                app.RightPanel.Layout.Column = 3;
            end
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.AutoResizeChildren = 'off';
            app.UIFigure.Position = [100 100 1260 644];
            app.UIFigure.Name = 'Recording Session';
            app.UIFigure.SizeChangedFcn = createCallbackFcn(app, @updateAppLayout, true);

            % Create GridLayout
            app.GridLayout = uigridlayout(app.UIFigure);
            app.GridLayout.ColumnWidth = {235, '1x', 249};
            app.GridLayout.RowHeight = {'1x'};
            app.GridLayout.ColumnSpacing = 0;
            app.GridLayout.RowSpacing = 0;
            app.GridLayout.Padding = [0 0 0 0];
            app.GridLayout.Scrollable = 'on';

            % Create LeftPanel
            app.LeftPanel = uipanel(app.GridLayout);
            app.LeftPanel.Layout.Row = 1;
            app.LeftPanel.Layout.Column = 1;

            % Create MovementListBoxLabel
            app.MovementListBoxLabel = uilabel(app.LeftPanel);
            app.MovementListBoxLabel.Position = [22 549 201 22];
            app.MovementListBoxLabel.Text = 'Movement';

            % Create MovementListBox
            app.MovementListBox = uilistbox(app.LeftPanel);
            app.MovementListBox.Position = [23 219 200 322];
            app.MovementListBox.Items = {''};

            % Create SelectMovementsButton
            app.SelectMovementsButton = uibutton(app.LeftPanel, 'push');
            app.SelectMovementsButton.ButtonPushedFcn = createCallbackFcn(app, @selectMovement, true);
            app.SelectMovementsButton.Position = [22 600 201 22];
            app.SelectMovementsButton.Text = 'Select movements';
            
            % Create LoadButton
            app.LoadButton = uibutton(app.LeftPanel, 'push');
            app.LoadButton.ButtonPushedFcn = createCallbackFcn(app, @loadRecording, true);
            app.LoadButton.Position = [22 570 201 22];
            app.LoadButton.Text = 'Load recordings';

            % Create TimeLabel
            app.TimeLabel = uilabel(app.LeftPanel);
            app.TimeLabel.Position = [23 112 200 22];
            app.TimeLabel.Text = 'Time';

            % Create TimeEditField
            app.TimeField = uieditfield(app.LeftPanel, 'numeric');
            app.TimeField.Limits = [0 Inf];
            app.TimeField.ValueChangedFcn = createCallbackFcn(app, @updateAxes, true);
            app.TimeField.Position = [23 91 200 22];
            app.TimeField.Value = 10;

            % Create ShapeDropDownLabel
            app.ShapeDropDownLabel = uilabel(app.LeftPanel);
            app.ShapeDropDownLabel.Position = [23 183 200 22];
            app.ShapeDropDownLabel.Text = 'Shape';

            % Create ShapeDropDown
            app.ShapeDropDown = uidropdown(app.LeftPanel);
            app.ShapeDropDown.Items = {'Trapezoidal'};
            app.ShapeDropDown.Position = [23 162 200 22];
            app.ShapeDropDown.Value = 'Trapezoidal';

            % Create StartButton
            app.StartButton = uibutton(app.LeftPanel, 'push');
            app.StartButton.ButtonPushedFcn = createCallbackFcn(app, @startRecording, true);
            app.StartButton.Position = [22 37 201 22];
            app.StartButton.Text = 'Start';

            % Create CenterPanel
            app.CenterPanel = uipanel(app.GridLayout);
            app.CenterPanel.Layout.Row = 1;
            app.CenterPanel.Layout.Column = 2;

            % Create Panel
            app.Panel = uipanel(app.CenterPanel);
            app.Panel.Position = [6 12 764 538];

            % Create Panel_2
            app.Panel_2 = uipanel(app.CenterPanel);
            app.Panel_2.Position = [6 559 764 73];

            % Create MainLabel
            app.MainLabel = uilabel(app.Panel_2);
            app.MainLabel.HorizontalAlignment = 'center';
            app.MainLabel.FontSize = 20;
            app.MainLabel.Position = [1 12 764 48];
            app.MainLabel.Text = 'Select or load movements to begin';

            % Create RightPanel
            app.RightPanel = uipanel(app.GridLayout);
            app.RightPanel.Layout.Row = 1;
            app.RightPanel.Layout.Column = 3;
            
            % Create ReconnectButton
            app.ReconnectButton = uibutton(app.RightPanel, 'push');
            app.ReconnectButton.ButtonPushedFcn = createCallbackFcn(app, @reconnectSerialPort, true);
            app.ReconnectButton.Position = [15 550 211 22];
            app.ReconnectButton.Text = 'Reconnect ALC';
            
            % Create AnalyseButton
            app.AnalyseButton = uibutton(app.RightPanel, 'push');
            app.AnalyseButton.ButtonPushedFcn = createCallbackFcn(app, @analyseData, true);
            app.AnalyseButton.Position = [15 491 211 22];
            app.AnalyseButton.Text = 'Analyse';

            % Create NetworkStructureDropDownLabel
            app.NetworkStructureDropDownLabel = uilabel(app.RightPanel);
            app.NetworkStructureDropDownLabel.HorizontalAlignment = 'left';
            app.NetworkStructureDropDownLabel.Position = [15 444 211 22];
            app.NetworkStructureDropDownLabel.Text = 'NetworkStructure';

            % Create NetworkStructureDropDown
            app.NetworkStructureDropDown = uidropdown(app.RightPanel);
            app.NetworkStructureDropDown.Position = [15 423 211 22];
            app.NetworkStructureDropDown.Items = {'1 Layer FFNN ReLU', '1 Layer FFNN SigmoidMixed'};

            % Create TrainNetworkButton
            app.TrainNetworkButton = uibutton(app.RightPanel, 'push');
            app.TrainNetworkButton.ButtonPushedFcn = createCallbackFcn(app, @trainNetwork, true);
            app.TrainNetworkButton.Position = [15 379 211 22];
            app.TrainNetworkButton.Text = 'TrainNetwork';
            
            % Create SetNNThresholdsButton 
            app.SetNNThresholdsButton  = uibutton(app.RightPanel, 'push');
            app.SetNNThresholdsButton.ButtonPushedFcn = createCallbackFcn(app, @setNNThresholds, true);
            app.SetNNThresholdsButton.Position = [15 150 211 22];
            app.SetNNThresholdsButton.Text = 'Set NN thresholds';
            
            % Create SetPropThresholdsButton
            app.SetPropThresholdsButton = uibutton(app.RightPanel, 'push');
            app.SetPropThresholdsButton.ButtonPushedFcn = createCallbackFcn(app, @setPropThresholds, true);
            app.SetPropThresholdsButton.Position = [15 120 211 22];
            app.SetPropThresholdsButton.Text = 'Set proportional thresholds';
            
            % Create FloorNoise
            app.FloorNoiseSpinnerLabel = uilabel(app.RightPanel);
            app.FloorNoiseSpinnerLabel.HorizontalAlignment = 'left';
            app.FloorNoiseSpinnerLabel.Position = [15 340 63 22];
            app.FloorNoiseSpinnerLabel.Text = 'Floor noise';

            % Create FloorNoiseSpinner
            app.FloorNoiseSpinner = uispinner(app.RightPanel);
            app.FloorNoiseSpinner.ValueChangedFcn = createCallbackFcn(app, @updateFloorNoise, true);
            app.FloorNoiseSpinner.Step = 0.05;
            app.FloorNoiseSpinner.Limits = [0 1];
            app.FloorNoiseSpinner.Position = [15 320 211 22];
            
            % Create SwitchThreshold
            app.SwitchThresholdSpinnerLabel = uilabel(app.RightPanel);
            app.SwitchThresholdSpinnerLabel.HorizontalAlignment = 'left';
            app.SwitchThresholdSpinnerLabel.Position = [15 290 100 22];
            app.SwitchThresholdSpinnerLabel.Text = 'Switch Threshold';

            % Create SwitchThresholdSpinner
            app.SwitchThresholdSpinner = uispinner(app.RightPanel);
            app.SwitchThresholdSpinner.ValueChangedFcn = createCallbackFcn(app, @updateSwitchThreshold, true);
            app.SwitchThresholdSpinner.Step = 0.05;
            app.SwitchThresholdSpinner.Limits = [0 1];
            app.SwitchThresholdSpinner.Position = [15 270 211 22];

            % Create SaveNetworkButton
            app.SaveNetworkButton = uibutton(app.RightPanel, 'push');
            app.SaveNetworkButton.ButtonPushedFcn = createCallbackFcn(app, @saveNetwork, true);
            app.SaveNetworkButton.Position = [15 30 211 22];
            app.SaveNetworkButton.Text = 'SaveNetwork';

            % Create UploadNetworkButton
            app.UploadNetworkButton = uibutton(app.RightPanel, 'push');
            app.UploadNetworkButton.ButtonPushedFcn = createCallbackFcn(app, @uploadNetwork, true);
            app.UploadNetworkButton.Position = [15 200 211 22];
            app.UploadNetworkButton.Text = 'UploadNetwork';

            % Create SaveDataButton
            app.SaveDataButton = uibutton(app.RightPanel, 'push');
            app.SaveDataButton.ButtonPushedFcn = createCallbackFcn(app, @saveData, true);
            app.SaveDataButton.Position = [15 60 211 22];
            app.SaveDataButton.Text = 'SaveData';

            % Create ChangelangguageSwitch
            app.ChangelangguageSwitch = uiswitch(app.RightPanel, 'slider');
            app.ChangelangguageSwitch.Items = {'English', 'Svenska'};
            app.ChangelangguageSwitch.ValueChangedFcn = createCallbackFcn(app, @changeLanguage, true);
            app.ChangelangguageSwitch.Position = [143 612 45 20];
            app.ChangelangguageSwitch.Value = 'English';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = app_RecordMovements(handles)
            
            %--------------------------------------------------------------
            % Compability for old NCALFit
            %--------------------------------------------------------------
            if isfield(handles,'obj')
                obj = handles.obj;
                comPort = obj.Port;
                baudRate = obj.BaudRate;
                
                delete(instrfindall);                
                app.serialObj = serialport(comPort, baudRate, 'Databits', 8, ...
                'Byteorder', 'big-endian');
                
                ALC.testConnection(app.serialObj);
                
            else
            set(handles.t_msg,'String','No connection obj found');   
                return;
            end
            %--------------------------------------------------------------
            % Create UIFigure and components
            %--------------------------------------------------------------
            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)
            
            %--------------------------------------------------------------
            % Create ALC object
            %--------------------------------------------------------------   
            app.alc = ALC();
            % Get current parameters from ALC
            app.alc.getRecSettings(app.serialObj);
                     
            %--------------------------------------------------------------
            % Prepare recording window
            %--------------------------------------------------------------
            app.recordingWindow = axes(app.Panel);
            app.rampLine = animatedline('Parent', app.recordingWindow, 'LineWidth', 2);
            app.rampMAVLine = animatedline('Parent', app.recordingWindow, 'Color', [0.8500 0.3250 0.0980], 'Marker', 'o');
            
            app.updateAxes(NaN)
            
            app.recordingData.data = [];
            app.recordingData.labels = [];
            app.recordingData.movements = [];
            app.recordingData.movementsSwe = [];
            app.recordingData.floorNoise = 0;
            app.recordingData.switchThreshold = 0;
            
            
            app.StartButton.Enable = 0;
            
            

            %--------------------------------------------------------------
            % Clean up
            %--------------------------------------------------------------
            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end