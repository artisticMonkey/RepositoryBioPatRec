classdef app_ProportionalThresholdsMixed < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                        matlab.ui.Figure
        GridLayout                      matlab.ui.container.GridLayout
        LeftPanel                       matlab.ui.container.Panel
        ActiveMovementsListBoxLabel     matlab.ui.control.Label
        ActiveMovementsListBox          matlab.ui.control.ListBox
        RecordingTimeFieldLabel         matlab.ui.control.Label
        RecordingTimeField              matlab.ui.control.NumericEditField
        MovingAverageFieldLabel         matlab.ui.control.Label
        MovingAverageField              matlab.ui.control.NumericEditField
        StartRecordingButton            matlab.ui.control.Button
        CenterPanel                     matlab.ui.container.Panel
        OutputLabel                     matlab.ui.control.Label
        ProportionalRecordingPanel      matlab.ui.container.Panel
        PredictedOutputPanel            matlab.ui.container.Panel
        RightPanel                      matlab.ui.container.Panel
        UpperThresholdSpinnerLabel      matlab.ui.control.Label
        UpperThresholdSpinner           matlab.ui.control.Spinner
        LowerThresholdSpinnerLabel      matlab.ui.control.Label
        LowerThresholdSpinner           matlab.ui.control.Spinner
        MappingListBoxLabel             matlab.ui.control.Label
        MappingListBox                  matlab.ui.control.ListBox
        SaveSettingsButton              matlab.ui.control.Button
        UploadCoeffsButton              matlab.ui.control.Button
        
        % User defined properties
        alc
        serialObj
        recordingData
        network
        axesList 
        linesList
        thresholdList
    end

    % Properties that correspond to apps with auto-reflow
    properties (Access = private)
        onePanelWidth = 576;
        twoPanelWidth = 768;
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: StartRecordingButton
        function startRecording(app, ~)
            
            %--------------------------------------------------------------
            % Get current parameters from ALC to double check 
            %--------------------------------------------------------------
            app.alc.getRecSettings(app.serialObj);
            sF = app.alc.samplingFrequency;
            tWs = app.alc.timeWindowSamples;

            %--------------------------------------------------------------
            % Set up plot parameters
            %--------------------------------------------------------------
            
            selectedMovement = app.ActiveMovementsListBox.Value;
            selectedOutClass = strcmp(app.recordingData.movements, selectedMovement);
            
            recordingTime = app.RecordingTimeField.Value;
            nWindows = sF/tWs*recordingTime;
            timeVector = linspace(0,recordingTime,nWindows);   
            movementData = zeros(nWindows,1);
            recordedData = zeros(nWindows,1);
            predictedOutputData = zeros(nWindows,1);
            nMovements = numel(app.recordingData.movements);
            selectedMovements = [];
            
            for field = 1:nMovements
                fieldName = app.recordingData.movementFields{field};
                if ~isempty(app.recordingData.movementRecordings.(fieldName).data)
                    selectedMovements = [selectedMovements; field];
                end
            end
            
                        
            %--------------------------------------------------------------
            % Clean plots
            %--------------------------------------------------------------
            
            clearpoints(app.linesList{1});
            clearpoints(app.linesList{2});
            xlim(app.axesList{1},[0 recordingTime])
            xlim(app.axesList{2},[0 recordingTime])
            app.thresholdList{1}.Visible = 1;
            app.thresholdList{2}.Visible = 1;
            
            app.StartRecordingButton.Enable = 0;
            app.UploadCoeffsButton.Enable = 0;
            app.SaveSettingsButton.Enable = 0;
            %--------------------------------------------------------------
            % Start acquisition and update plots
            %--------------------------------------------------------------
            % Activate streaming
            
            app.alc.getNNParameters(app.serialObj);
            app.alc.NNCoefficients.streamEnable = 1;
            app.alc.setNNParameters(app.serialObj,app.alc.NNCoefficients)
            app.alc.setCommandMode(app.serialObj)
            flush(app.serialObj)
            app.alc.setControlMode(app.serialObj)
            
            tic;
            for win = 1:nWindows
                % Receive ALC Data
                outVector = zeros(nMovements,1);
                outVector(selectedMovements) = read(app.serialObj,app.alc.NNCoefficients.nActiveClasses,'single'); 

                outputIndex = read(app.serialObj,1,'uint8'); 
                
                outputStrength(win,:) = read(app.serialObj,3,'uint8'); 
                
                outputMAV = read(app.serialObj,1,'single'); 
                                
                string_PredictedMovement = app.alc.decodeOutIndex(outputIndex);
                                
                app.OutputLabel.Text = string_PredictedMovement;
                
                 
                 % If predicted class is equal the selected class
                 if strcmp(selectedMovement,string_PredictedMovement)
                     app.linesList{1}.Color = [0 0.4470 0.7410];
                     movementData(win) = outputMAV;
                 else 
                    app.linesList{1}.Color = [0.3010 0.7450 0.9330];
                    movementData(win) = NaN;
                 end

                
                % Update proportional plot
                addpoints(app.linesList{1},timeVector(win),outputMAV);

                % Update predicted output plot                      
                if strcmp(selectedMovement,string_PredictedMovement)
                	addpoints(app.linesList{2},timeVector(win),1);
                    predictedOutputData(win) = 1;
                else
                    addpoints(app.linesList{2},timeVector(win),0);
                    predictedOutputData(win) = 0;
                end
                        
                %drawnow limitrate
                
                % Save data
                recordedData(win) = outputMAV;
                
                
            end
            toc
            
            app.linesList{1}.Color = [0 0.4470 0.7410];
            
            %--------------------------------------------------------------
            % Stop acquisistion
            %--------------------------------------------------------------            
            flush(app.serialObj)
            app.alc.setCommandMode(app.serialObj)
            % Deactivate streaming
            app.alc.NNCoefficients.streamEnable = 0;
            app.alc.setNNParameters(app.serialObj,app.alc.NNCoefficients)

            
            % Calculate thresholds
            upperThreshold = max(movementData);
            lowerThreshold = min(movementData);
            
            % Avoid errors due to NaN values
            if isnan(upperThreshold) || isnan(upperThreshold)
                upperThreshold = 0;
                lowerThreshold = 0;
                app.thresholdList{1}.Visible = 0;
                app.thresholdList{2}.Visible = 0;
            else
                % Add upper threshold line
%                 app.thresholdList{1} = yline('Parent', app.axesList{1}, upperThreshold, '-','Upper threshold');
%                 app.thresholdList{2} = yline('Parent', app.axesList{1}, lowerThreshold, '-','Lower threshold');
%                 app.thresholdList{1}.Value = upperThreshold;
%                 app.thresholdList{2}.Value = lowerThreshold;
%                 app.thresholdList{1}.Visible = 1;
%                 app.thresholdList{2}.Visible = 1;
                % Update threshold GUI values
%                 app.UpperThresholdSpinner.Value = upperThreshold;
%                 app.LowerThresholdSpinner.Value = lowerThreshold;
                % Set step size to 5%
                stepSize = (upperThreshold-lowerThreshold)/20;
                
                if stepSize ~= 0
                    app.UpperThresholdSpinner.Step = stepSize;
                    app.LowerThresholdSpinner.Step = stepSize;
                end
                
            end

            % Update alcRec 
            fieldName = app.recordingData.movementFields(selectedOutClass);
            app.network.proportionalThresholds.(fieldName{:}).upperThreshold = upperThreshold;
            app.network.proportionalThresholds.(fieldName{:}).lowerThreshold = lowerThreshold;
            app.network.proportionalThresholds.(fieldName{:}).movementData = movementData;
            app.network.proportionalThresholds.(fieldName{:}).recordedData = recordedData;
            app.network.proportionalThresholds.(fieldName{:}).timeVector = timeVector;
            app.network.proportionalThresholds.(fieldName{:}).predictedOutputData = predictedOutputData;

            app.StartRecordingButton.Enable = 1; 
            app.UploadCoeffsButton.Enable = 1;
            app.SaveSettingsButton.Enable = 1;
        end
        
        
        % Value changed function: UpperThresholdSpinner
        function updateUpperThreshold(app, ~)
            value = app.UpperThresholdSpinner.Value;
            % Update GUI
            app.thresholdList{1}.Value = value;
            % Save value to network
            selectedMovement = app.ActiveMovementsListBox.Value;
            selectedOutClass = strcmp(app.recordingData.movements, selectedMovement);
            fieldName = app.recordingData.movementFields(selectedOutClass);
            app.network.proportionalThresholds.(fieldName{:}).upperThreshold = value; 
        end
        
        % Value changed function: LowerThresholdSpinner
        function updateLowerThreshold(app, ~)
            value = app.LowerThresholdSpinner.Value;
            % Update GUI
            app.thresholdList{2}.Value = value;
            % Save value to netwrok
            selectedMovement = app.ActiveMovementsListBox.Value;
            selectedOutClass = strcmp(app.recordingData.movements, selectedMovement);
            fieldName = app.recordingData.movementFields(selectedOutClass);
            app.network.proportionalThresholds.(fieldName{:}).lowerThreshold = value;
        end
        
        % Update the GUI when the selected movement changes
        function updateActiveMovement(app, ~)
            
            %--------------------------------------------------------------
            % Clean plots
            %--------------------------------------------------------------
            recordingTime = app.RecordingTimeField.Value;
            clearpoints(app.linesList{1});
            clearpoints(app.linesList{2});
            xlim(app.axesList{1},[0 recordingTime])
            xlim(app.axesList{2},[0 recordingTime])
            app.thresholdList{1}.Visible = 0;
            app.thresholdList{2}.Visible = 0;
            
            %--------------------------------------------------------------
            % Load previous recording if it exists
            %--------------------------------------------------------------

            selectedMovement = app.ActiveMovementsListBox.Value;
            selectedOutClass = strcmp(app.recordingData.movements, selectedMovement);
            fieldName = app.recordingData.movementFields(selectedOutClass);
            if ~isempty(app.network.proportionalThresholds.(fieldName{:}))
                
                recordedData = app.network.proportionalThresholds.(fieldName{:}).recordedData;
                upperThreshold = app.network.proportionalThresholds.(fieldName{:}).upperThreshold;
                lowerThreshold = app.network.proportionalThresholds.(fieldName{:}).lowerThreshold;
                timeVector = app.network.proportionalThresholds.(fieldName{:}).timeVector;
                predictedOutputData = app.network.proportionalThresholds.(fieldName{:}).predictedOutputData;
                % Update threshold GUI values
                app.UpperThresholdSpinner.Value = upperThreshold;
                app.LowerThresholdSpinner.Value = lowerThreshold;
                % Set step size to 5%
                stepSize = (upperThreshold-lowerThreshold)/20;
                if stepSize ~= 0
                    app.UpperThresholdSpinner.Step = stepSize;
                    app.LowerThresholdSpinner.Step = stepSize;
                end
                % Plot animated line
                addpoints(app.linesList{1},timeVector,recordedData)
                addpoints(app.linesList{2},timeVector,predictedOutputData)
                
                % Update thresholds
                app.thresholdList{1}.Visible = 1;
                app.thresholdList{2}.Visible = 1;
                app.updateLowerThreshold();
                app.updateUpperThreshold();
                
                if all(~isnan(timeVector))
                    xlim(app.axesList{1},[0 timeVector(end)])
                    xlim(app.axesList{2},[0 timeVector(end)])
                end
                
            end
        end
        
        function uploadNNCoefficients(app, ~)
           
            app.alc.getNNParameters(app.serialObj);
            
            fieldName = app.recordingData.movementFields;
            for field = 1:length(fieldName)
                app.alc.NNCoefficients.propThreshold(field,1) = app.network.proportionalThresholds.(fieldName{field}).lowerThreshold;
                app.alc.NNCoefficients.propThreshold(field,2) = app.network.proportionalThresholds.(fieldName{field}).upperThreshold;
            end

            app.alc.setNNParameters(app.serialObj,app.alc.NNCoefficients)
        end
        
        function saveSettings(app, ~)
            
            alcRec.alc = struct(app.alc);
            alcRec.network = app.network;
            alcRec.recordingData = app.recordingData;
            alcRec.mov = app.recordingData.movements;
            alcRec.movFields = app.recordingData.movementFields;
            fileName = sprintf('alcRec_%s.mat', datestr(now,'yyyy-mm-dd HH-MM'));
            save(fileName , 'alcRec');
        end

        % Changes arrangement of the app based on UIFigure width
        function updateAppLayout(app, ~)
            currentFigureWidth = app.UIFigure.Position(3);
            if(currentFigureWidth <= app.onePanelWidth)
                % Change to a 3x1 grid
                app.GridLayout.RowHeight = {480, 480, 480};
                app.GridLayout.ColumnWidth = {'1x'};
                app.CenterPanel.Layout.Row = 1;
                app.CenterPanel.Layout.Column = 1;
                app.LeftPanel.Layout.Row = 2;
                app.LeftPanel.Layout.Column = 1;
                app.RightPanel.Layout.Row = 3;
                app.RightPanel.Layout.Column = 1;
            elseif (currentFigureWidth > app.onePanelWidth && currentFigureWidth <= app.twoPanelWidth)
                % Change to a 2x2 grid
                app.GridLayout.RowHeight = {480, 480};
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
                app.GridLayout.ColumnWidth = {166, '1x', 170};
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
            app.UIFigure.Position = [100 100 1000 480];
            app.UIFigure.Name = 'MATLAB App';
            app.UIFigure.SizeChangedFcn = createCallbackFcn(app, @updateAppLayout, true);

            % Create GridLayout
            app.GridLayout = uigridlayout(app.UIFigure);
            app.GridLayout.ColumnWidth = {166, '1x', 184};
            app.GridLayout.RowHeight = {'1x'};
            app.GridLayout.ColumnSpacing = 0;
            app.GridLayout.RowSpacing = 0;
            app.GridLayout.Padding = [0 0 0 0];
            app.GridLayout.Scrollable = 'on';

            % Create LeftPanel
            app.LeftPanel = uipanel(app.GridLayout);
            app.LeftPanel.Layout.Row = 1;
            app.LeftPanel.Layout.Column = 1;

            % Create ActiveMovementsListBoxLabel
            app.ActiveMovementsListBoxLabel = uilabel(app.LeftPanel);
            app.ActiveMovementsListBoxLabel.HorizontalAlignment = 'right';
            app.ActiveMovementsListBoxLabel.Position = [25 438 105 22];
            app.ActiveMovementsListBoxLabel.Text = 'Active Movements';

            % Create ActiveMovementsListBox
            app.ActiveMovementsListBox = uilistbox(app.LeftPanel);
            app.ActiveMovementsListBox.ValueChangedFcn = createCallbackFcn(app, @updateActiveMovement);
            app.ActiveMovementsListBox.Position = [25 258 126 166];

            % Create RecordingTimeFieldLabel
            app.RecordingTimeFieldLabel = uilabel(app.LeftPanel);
            app.RecordingTimeFieldLabel.HorizontalAlignment = 'right';
            app.RecordingTimeFieldLabel.Position = [25 119 103 22];
            app.RecordingTimeFieldLabel.Text = 'Recording time [s]';

            % Create RecordingTimeField
            app.RecordingTimeField = uieditfield(app.LeftPanel, 'numeric');
            app.RecordingTimeField.Position = [25 88 126 22];
            app.RecordingTimeField.Value = 30;
            
%             % Create RecordingTimeFieldLabel
%             app.MovingAverageFieldLabel = uilabel(app.LeftPanel);
%             app.MovingAverageFieldLabel.HorizontalAlignment = 'right';
%             app.MovingAverageFieldLabel.Position = [25 189 103 22];
%             app.MovingAverageFieldLabel.Text = 'MA Order';
% 
%             % Create RecordingTimeField
%             app.MovingAverageField = uieditfield(app.LeftPanel, 'numeric');
%             app.MovingAverageField.Position = [25 158 126 22];
%             app.MovingAverageField.Value = 0;

            % Create StartRecordingButton
            app.StartRecordingButton = uibutton(app.LeftPanel, 'push');
            app.StartRecordingButton.ButtonPushedFcn = createCallbackFcn(app, @startRecording, true);
            app.StartRecordingButton.Position = [25 34 126 22];
            app.StartRecordingButton.Text = 'Start Recording';

            % Create CenterPanel
            app.CenterPanel = uipanel(app.GridLayout);
            app.CenterPanel.Layout.Row = 1;
            app.CenterPanel.Layout.Column = 2;

            % Create ProportionalRecordingPanel
            app.ProportionalRecordingPanel = uipanel(app.CenterPanel);
            app.ProportionalRecordingPanel.Title = 'Proportional Recording';
            app.ProportionalRecordingPanel.BackgroundColor = [1 1 1];
            app.ProportionalRecordingPanel.Position = [23 248 620 221];

            % Create PredictedOutputPanel
            app.PredictedOutputPanel = uipanel(app.CenterPanel);
            app.PredictedOutputPanel.Title = 'Predicted Output';
            app.PredictedOutputPanel.BackgroundColor = [1 1 1];
            app.PredictedOutputPanel.Position = [23 19 620 221];
            
            % Create OutputLabel
            app.OutputLabel = uilabel(app.CenterPanel);
            app.OutputLabel.HorizontalAlignment = 'left';
            app.OutputLabel.Position = [500 219 130 22];
            app.OutputLabel.Text = '';

            % Create RightPanel
            app.RightPanel = uipanel(app.GridLayout);
            app.RightPanel.Layout.Row = 1;
            app.RightPanel.Layout.Column = 3;

            % Create UpperThresholdSpinnerLabel
            app.UpperThresholdSpinnerLabel = uilabel(app.RightPanel);
            app.UpperThresholdSpinnerLabel.HorizontalAlignment = 'right';
            app.UpperThresholdSpinnerLabel.Position = [26 402 95 22];
            app.UpperThresholdSpinnerLabel.Text = 'Upper Threshold';

            % Create UpperThresholdSpinner
            app.UpperThresholdSpinner = uispinner(app.RightPanel);
            app.UpperThresholdSpinner.RoundFractionalValues = 'off';
            app.UpperThresholdSpinner.ValueChangedFcn = createCallbackFcn(app, @updateUpperThreshold, true);
            app.UpperThresholdSpinner.Position = [26 381 123 22];

            % Create LowerThresholdSpinnerLabel
            app.LowerThresholdSpinnerLabel = uilabel(app.RightPanel);
            app.LowerThresholdSpinnerLabel.HorizontalAlignment = 'right';
            app.LowerThresholdSpinnerLabel.Position = [26 341 95 22];
            app.LowerThresholdSpinnerLabel.Text = 'Lower Threshold';

            % Create LowerThresholdSpinner
            app.LowerThresholdSpinner = uispinner(app.RightPanel);
            app.LowerThresholdSpinner.RoundFractionalValues = 'off';
            app.LowerThresholdSpinner.ValueChangedFcn = createCallbackFcn(app, @updateLowerThreshold, true);
            app.LowerThresholdSpinner.Position = [27 320 123 22];

            % Create MappingListBoxLabel
            app.MappingListBoxLabel = uilabel(app.RightPanel);
            app.MappingListBoxLabel.HorizontalAlignment = 'right';
            app.MappingListBoxLabel.Position = [23 207 123 22];
            app.MappingListBoxLabel.Text = 'Interpolation mapping';

            % Create MappingListBox
            app.MappingListBox = uilistbox(app.RightPanel);
            app.MappingListBox.Items = {'Linear', 'Quadratic', 'Sigmoid'};
            app.MappingListBox.Position = [23 109 124 83];
            app.MappingListBox.Value = 'Linear';

            % Create SaveSettingsButton
            app.SaveSettingsButton = uibutton(app.RightPanel, 'push');
            app.SaveSettingsButton.ButtonPushedFcn = createCallbackFcn(app, @saveSettings, true);
            app.SaveSettingsButton.Position = [23 50 126 22];
            app.SaveSettingsButton.Text = 'Save Settings';
            
            
            % Create UploadCoeffsButton 
            app.UploadCoeffsButton  = uibutton(app.RightPanel, 'push');
            app.UploadCoeffsButton.ButtonPushedFcn = createCallbackFcn(app, @uploadNNCoefficients, true);
            app.UploadCoeffsButton.Position = [23 20 126 22];
            app.UploadCoeffsButton.Text = 'Upload Thresholds';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = app_ProportionalThresholdsMixed(alc, serialObj, recordingData, network)
            
            app.alc = alc;
            app.serialObj = serialObj;
            app.recordingData = recordingData;
            app.network = network;
            %--------------------------------------------------------------
            % Create UIFigure and components
            %--------------------------------------------------------------
            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)
            
            
            % If proportionalThresholds doesn't exist, create it
            if isempty(app.network.proportionalThresholds)
            
                emptyCell = cell(numel(app.recordingData.movementFields),1);
                app.network.proportionalThresholds = cell2struct(emptyCell,app.recordingData.movementFields);
            
                % Initialize 
                fieldName = app.recordingData.movementFields;
                for field = 1:length(fieldName)
                    app.network.proportionalThresholds.(fieldName{field}).upperThreshold = 0;
                    app.network.proportionalThresholds.(fieldName{field}).lowerThreshold = 0;
                    app.network.proportionalThresholds.(fieldName{field}).movementData = NaN;
                    app.network.proportionalThresholds.(fieldName{field}).recordedData = NaN;
                    app.network.proportionalThresholds.(fieldName{field}).timeVector = NaN;
                    app.network.proportionalThresholds.(fieldName{field}).predictedOutputData = NaN;
                end
                
            end
            

            %--------------------------------------------------------------
            % Prepare recording window
            %--------------------------------------------------------------
            
            app.ActiveMovementsListBox.Items = app.recordingData.movements(1:end-1);
            
            recordingTime = app.RecordingTimeField.Value;
            
            % Allocate axes, line and threshold lists
            app.axesList = cell(2,1);
            app.linesList = cell(2,1);
            app.thresholdList = cell(2,1);
            
            % Add axes for proportional plot
            app.axesList{1} = axes('Parent', app.ProportionalRecordingPanel);
            xlim(app.axesList{1},[0 recordingTime])
            ylabel(app.axesList{1},'MAV [V]');
            % Add animated line proportional plot
            app.linesList{1} = animatedline('Parent', app.axesList{1}, 'Color',[0 0.4470 0.7410]);
            
            
            
            % Add axes for predcited output plot
            app.axesList{2} = axes('Parent', app.PredictedOutputPanel);
            xlim(app.axesList{2},[0 recordingTime])
            ylim(app.axesList{2},[-0.1 1.1])
            yticks(app.axesList{2},[0 1])
            ylabel(app.axesList{2},'Predicted Output [-]');
            % Add animated line for predcited output plot
            app.linesList{2} = animatedline('Parent', app.axesList{2});
            
            app.thresholdList{1} = yline('Parent', app.axesList{1}, 0, '-','Upper threshold');
            app.thresholdList{2} = yline('Parent', app.axesList{1}, 0, '-','Lower threshold');
            app.thresholdList{1}.Visible = 0;
            app.thresholdList{2}.Visible = 0;
            
            % Set text
            app.OutputLabel.Text = app.ActiveMovementsListBox.Value;
            
            
            app.updateActiveMovement
            
            
            
       

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