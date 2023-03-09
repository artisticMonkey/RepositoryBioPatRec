classdef app_NetworkThresholdsMixed < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure               matlab.ui.Figure
        GridLayout             matlab.ui.container.GridLayout
        LeftPanel              matlab.ui.container.Panel
        MovementListBoxLabel   matlab.ui.control.Label
        MovementListBox        matlab.ui.control.ListBox
        ThresholdSpinnerLabel  matlab.ui.control.Label
        ThresholdSpinner       matlab.ui.control.Spinner
        StartButton            matlab.ui.control.Button
        TimeLabel              matlab.ui.control.Label
        Time                   matlab.ui.control.NumericEditField
        MovingAverageLabel     matlab.ui.control.Label
        MovingAverage          matlab.ui.control.NumericEditField
        SaveVariablesButton    matlab.ui.control.Button
        UploadCoeffButton      matlab.ui.control.Button
        RightPanel             matlab.ui.container.Panel
        Panel                  matlab.ui.container.Panel
        PredictedmovementLabel matlab.ui.control.Label
        
        % User defined properties
        %alcRec
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
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Changes arrangement of the app based on UIFigure width
        function updateAppLayout(app, ~)
            currentFigureWidth = app.UIFigure.Position(3);
            if(currentFigureWidth <= app.onePanelWidth)
                % Change to a 2x1 grid
                app.GridLayout.RowHeight = {855, 855};
                app.GridLayout.ColumnWidth = {'1x'};
                app.RightPanel.Layout.Row = 2;
                app.RightPanel.Layout.Column = 1;
            else
                % Change to a 1x2 grid
                app.GridLayout.RowHeight = {'1x'};
                app.GridLayout.ColumnWidth = {288, '1x'};
                app.RightPanel.Layout.Row = 1;
                app.RightPanel.Layout.Column = 2;
            end
        end
    end

    % Component initialization
    methods (Access = private)
        
        % Button pushed function: StartButton
        function startRecording(app, ~)
            %--------------------------------------------------------------
            % Get current parameters from ALC to double check 
            %--------------------------------------------------------------

            app.alc.getRecSettings(app.serialObj);
            sF = app.alc.samplingFrequency;
            tWs = app.alc.timeWindowSamples;
            
                        
            %--------------------------------------------------------------
            % Get values needed for plotting
            %--------------------------------------------------------------
            
            nMovements = numel(app.recordingData.movements);
            recordingTime = app.Time.Value; 
            nWindows = sF/tWs*recordingTime;
            timeVector = linspace(0,recordingTime,nWindows);       
            selectedMovements = [];
            
            for field = 1:nMovements
                fieldName = app.recordingData.movementFields{field};
                if ~isempty(app.recordingData.movementRecordings.(fieldName).data)
                    selectedMovements = [selectedMovements; field];
                end
            end

            prostheticOutput = app.alc.convertMovementNamesToProstheticOutput(app.recordingData.movements);

            %--------------------------------------------------------------
            % Start acquisition and update plots
            %--------------------------------------------------------------
            for mov=1:(nMovements)
                    clearpoints(app.linesList{mov,1});
                    clearpoints(app.linesList{mov,2});
                    xlim(app.axesList{mov,1},[0 recordingTime])
                    xlim(app.axesList{mov,2},[0 recordingTime])
            end
            
            app.StartButton.Enable = 0;
            app.UploadCoeffButton.Enable = 0;
            app.SaveVariablesButton.Enable = 0;

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
                
                outputStrength = read(app.serialObj,3,'uint8'); 
                
                outputMAV = read(app.serialObj,1,'single');                
                              
                % Prosthetic outputIndex to matlab numbering
                outClass = find(prostheticOutput==outputIndex);
                
                epsilon = 0.01;
                
                for mov=1:nMovements
                        
                        addpoints(app.linesList{mov,1},timeVector(win),outVector(mov)+epsilon);
                        if mov == outClass
                            addpoints(app.linesList{mov,2},timeVector(win),1);
                        else
                            addpoints(app.linesList{mov,2},timeVector(win),epsilon);
                        end
                             
                end
              
                
                drawnow limitrate
                
                app.PredictedmovementLabel.Text = sprintf('Predicted Movement: %s',app.recordingData.movements{outClass});
                
                
            end
            toc
            
            %--------------------------------------------------------------
            % Stop acquisistion
            %--------------------------------------------------------------            
            app.alc.setCommandMode(app.serialObj)
            % Deactivate streaming
            app.alc.NNCoefficients.streamEnable = 0;
            app.alc.setNNParameters(app.serialObj,app.alc.NNCoefficients)
            
            app.StartButton.Enable = 1;
            app.UploadCoeffButton.Enable = 1;
            app.SaveVariablesButton.Enable = 1;

        end
        
        % Value changed function: ThresholdSpinner
        function updateThreshold(app, ~)
            value = app.ThresholdSpinner.Value;

            selectedMovement = app.MovementListBox.Value;
            
            if isempty(selectedMovement)
                uialert(app.UIFigure,'Select movement first','Error')
                return
            end
            
            movementIndex = find(strcmp(app.recordingData.movements, selectedMovement));
            
            % Update GUI
            app.thresholdList{movementIndex,1}.Value = value;

          
            % Save value to alcRec           
            app.network.networkThresholds(movementIndex) = value;

        end
        
        function saveSettings(app, ~)
            alcRec.alc = app.alc;
            alcRec.network = app.network;
            alcRec.recordingData = app.recordingData;
            alcRec.mov = app.recordingData.movements;
            alcRec.movFields = app.recordingData.movementFields;
            fileName = sprintf('alcRec_%s.mat', datestr(now,'yyyy-mm-dd HH-MM'));
            save(fileName , 'alcRec');
        end
        
        % Update the GUI when the selected movement changes
        function updateSpinnerValue(app, ~)
            selectedMovement = app.MovementListBox.Value;
            movementIndex = strcmp(app.recordingData.movements, selectedMovement);
            app.ThresholdSpinner.Value = app.network.networkThresholds(movementIndex);
        end
        
        function uploadNNCoefficients(app, ~)

            app.alc.getNNParameters(app.serialObj);
            app.alc.NNCoefficients.threshold = app.network.networkThresholds; 
            app.alc.setNNParameters(app.serialObj,app.alc.NNCoefficients)
            app.PredictedmovementLabel.Text = 'NN coefficients uploaded';
        end

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.AutoResizeChildren = 'off';
            app.UIFigure.Position = [100 100 1529 855];
            app.UIFigure.Name = 'app_NetworkThresholds';
            app.UIFigure.SizeChangedFcn = createCallbackFcn(app, @updateAppLayout, true);

            % Create GridLayout
            app.GridLayout = uigridlayout(app.UIFigure);
            app.GridLayout.ColumnWidth = {288, '1x'};
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
            app.MovementListBoxLabel.HorizontalAlignment = 'right';
            app.MovementListBoxLabel.Position = [32 795 67 22];
            app.MovementListBoxLabel.Text = 'Movement';

            % Create MovementListBox
            app.MovementListBox = uilistbox(app.LeftPanel);
            app.MovementListBox.ValueChangedFcn = createCallbackFcn(app, @updateSpinnerValue);
            app.MovementListBox.Items = {};
            app.MovementListBox.Position = [32 306 235 490];
            app.MovementListBox.Value = {};

            % Create ThresholdSpinnerLabel
            app.ThresholdSpinnerLabel = uilabel(app.LeftPanel);
            app.ThresholdSpinnerLabel.HorizontalAlignment = 'left';
            app.ThresholdSpinnerLabel.Position = [32 278 63 22];
            app.ThresholdSpinnerLabel.Text = 'Threshold';

            % Create ThresholdSpinner
            app.ThresholdSpinner = uispinner(app.LeftPanel);
            app.ThresholdSpinner.ValueChangedFcn = createCallbackFcn(app, @updateThreshold, true);
            app.ThresholdSpinner.Step = 0.05;
            app.ThresholdSpinner.Limits = [-1 1.1];
            app.ThresholdSpinner.Position = [32 241 234 38];

            % Create StartButton
            app.StartButton = uibutton(app.LeftPanel, 'push');
            app.StartButton.ButtonPushedFcn = createCallbackFcn(app, @startRecording, true);
            app.StartButton.Position = [32 130 234 30];
            app.StartButton.Text = 'Start';

            % Create TimesEditFieldLabel
            app.TimeLabel = uilabel(app.LeftPanel);
            app.TimeLabel.Position = [33 180 67 22];
            app.TimeLabel.Text = 'Time [s]';

            % Create TimesEditField
            app.Time = uieditfield(app.LeftPanel, 'numeric');
            app.Time.Limits = [0 Inf];
            app.Time.Position = [115 180 150 22];
            app.Time.Value = 30;
            
%             % Create MovingAverageEditFieldLabel
%             app.MovingAverageLabel = uilabel(app.LeftPanel);
%             app.MovingAverageLabel.Position = [33 200 67 22];
%             app.MovingAverageLabel.Text = 'MA Order';
% 
%             % Create MovingAverageEditField
%             app.MovingAverage = uieditfield(app.LeftPanel, 'numeric');
%             app.MovingAverage.Limits = [0 10];
%             app.MovingAverage.Position = [115 200 150 22];
%             app.MovingAverage.Value = 0;

            % Create SaveVariablesButton
            app.SaveVariablesButton = uibutton(app.LeftPanel, 'push');
            app.SaveVariablesButton.ButtonPushedFcn = createCallbackFcn(app, @saveSettings, true);
            app.SaveVariablesButton.Position = [33 37 232 30];
            app.SaveVariablesButton.Text = 'Save data to .mat';
            
            app.UploadCoeffButton = uibutton(app.LeftPanel, 'push');
            app.UploadCoeffButton.ButtonPushedFcn = createCallbackFcn(app, @uploadNNCoefficients, true);
            app.UploadCoeffButton.Position = [33 77 232 30];
            app.UploadCoeffButton.Text = 'Update NN thresholds';
            
            % Create RightPanel
            app.RightPanel = uipanel(app.GridLayout);
            app.RightPanel.Layout.Row = 1;
            app.RightPanel.Layout.Column = 2;

            % Create Panel
            app.Panel = uipanel(app.RightPanel);
            app.Panel.Position = [20 58 1200 779];
            
            % Create PredictedmovementLabel
            app.PredictedmovementLabel = uilabel(app.RightPanel);
            app.PredictedmovementLabel.Position = [400 20 400 22];
            app.PredictedmovementLabel.Text = 'Predicted movement:';
            app.PredictedmovementLabel.FontSize = 15;

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = app_NetworkThresholdsMixed(alc, serialObj, recordingData, network)
        
            app.alc = alc;
            app.serialObj = serialObj;
            app.recordingData = recordingData;
            app.network = network;
            
            %--------------------------------------------------------------
            % Create UIFigure and components
            %--------------------------------------------------------------
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)
            
          
            %--------------------------------------------------------------
            % Prepare recording window
            %--------------------------------------------------------------
            
            app.MovementListBox.Items = app.recordingData.movements(1:end-1);
            nMovements = length(app.recordingData.movements);

            recordingTime = app.Time.Value;

            app.axesList = cell(nMovements,2);
            app.linesList = cell(nMovements,2);
            app.thresholdList = cell(nMovements,1);
            
         
            t = tiledlayout(app.Panel,nMovements,2);
            t.TileSpacing = 'compact';
            t.Padding = 'compact';
            
            for mov=1:nMovements
                
                % Create axes and lines list for the outVector plots
                app.axesList{mov,1} = nexttile(t);
                %ylabel(app.axesList{mov,1},app.recordingData.movements{mov});
                xlim(app.axesList{mov,1},[0 recordingTime])
                ylim(app.axesList{mov,1},[0 1.3])
                yticks(app.axesList{mov,1},[0 0.25 0.5 0.75 1])
                app.linesList{mov,1} = animatedline('Parent', app.axesList{mov,1},'Color', [0 0.4470 0.7410]);
                text('Parent', app.axesList{mov,1}, 'Position', [1 1.2], 'String', app.recordingData.movements{mov}, 'Color', 'k')
                              
                if mov == 1
                    title('Predicted likelihood vector', 'FontSize', 15,'Parent', app.axesList{mov,1})
                end
                
                 % Create axes and lines list for the outMov plots
                app.axesList{mov,2} = nexttile(t);
                
                xlim(app.axesList{mov,2},[0 recordingTime])
                ylim(app.axesList{mov,2},[0 1.3])
                yticks(app.axesList{mov,2},[0 1])
                app.linesList{mov,2} = animatedline('Parent', app.axesList{mov,2},'Color', [0 0.4470 0.7410]);
                text('Parent', app.axesList{mov,2}, 'Position', [1 1.2], 'String', app.recordingData.movements{mov}, 'Color', 'k')
                if mov == 1
                    title('Predicted movement', 'FontSize', 15,'Parent', app.axesList{mov,2})
                end

            end
            
            app.alc.getNNParameters(app.serialObj);
            % Add thresholds
            
            if numel(app.network.networkThresholds) ~= (nMovements-1)
                app.network.networkThresholds = zeros(nMovements-1,1);
            end
            
            for mov=1:(nMovements-1)
                threshold = app.alc.NNCoefficients.threshold(mov);
                if threshold == 0
                    app.thresholdList{mov,1} = yline('Parent', app.axesList{mov}, 0.5, '--','Threshold');  
                    app.network.networkThresholds(mov) = 0.5;
                else
                    app.thresholdList{mov,1} = yline('Parent', app.axesList{mov}, threshold, '--','Threshold');
                    app.network.networkThresholds(mov) = threshold;
                end
                    
            end
            
           

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