classdef app_NetworkThresholds < matlab.apps.AppBase

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
        alcRec
        serialObj 
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
            % Create ALC object and get current parameters
            %--------------------------------------------------------------
            alc = ALC();
            
            % Update the ALC with the patRec settings
            % alc.setPatRecSettings(app.serialObj, app.patRec)
           
            % Get current parameters from ALC to double check 
            alc.getRecSettings(app.serialObj);
            sF = alc.samplingFrequency;
            tWs = alc.timeWindowSamples;
            
            movOutIdx = [];
            selectedMovements = [];
            index = 1;
            for field = 1: numel(app.alcRec.recordingData.movementFields)
                
                fieldName = app.alcRec.recordingData.movementFields{field};
                if ~isempty(app.alcRec.recordingData.movementRecordings.(fieldName).data)
                    movOutIdx = [movOutIdx; index];
                    selectedMovements = [selectedMovements; field];
                    index = index + 1;
                end
            end
            
            % DOUBLE CHECK THIS FUNCTION!
            prostheticOutput = alc.convertMovementArrayToProstheticOutput(app.alcRec.recordingData.movements(selectedMovements), num2cell(movOutIdx));
            
            
            
            %--------------------------------------------------------------
            % Get values needed for plotting
            %--------------------------------------------------------------
            
            nMovements = length(app.alcRec.antagonisticMovements);
            recordingTime = app.Time.Value; 
            nWindows = sF/tWs*recordingTime;
            timeVector = linspace(0,recordingTime,nWindows);       

            
            %--------------------------------------------------------------
            % Start acquisition and update plots
            %--------------------------------------------------------------
            for mov=1:(nMovements-1)
                    clearpoints(app.linesList{mov,1});
                    clearpoints(app.linesList{mov,2});
                    clearpoints(app.linesList{mov,3});
                    clearpoints(app.linesList{mov,4});
                    xlim(app.axesList{mov,1},[0 recordingTime])
                    xlim(app.axesList{mov,2},[0 recordingTime])
            end
            
            mov = mov+1;
            clearpoints(app.linesList{mov,1});
            clearpoints(app.linesList{mov,3});
            xlim(app.axesList{mov,1},[0 recordingTime])
            xlim(app.axesList{mov,2},[0 recordingTime])
            
            
            %--------------------------------------------------------------
            % Start acquisition and update plots
            %--------------------------------------------------------------
            % Activate streaming
            
            alc.getNNParameters(app.serialObj);
            alc.NNCoefficients.streamEnable = 1;
            alc.setNNParameters(app.serialObj,alc.NNCoefficients)
            alc.setCommandMode(app.serialObj)
            flush(app.serialObj)
            alc.setControlMode(app.serialObj)
            
            tic;
            
            for win = 1:nWindows
                % Receive ALC Data
                outVector = read(app.serialObj,alc.NNCoefficients.nActiveClasses,'single'); 

                outputIndex = read(app.serialObj,1,'uint8'); 
                
                outputStrength = read(app.serialObj,3,'uint8'); 
                
                outputMAV = read(app.serialObj,1,'single');                
                
                % Apply moving average

                if app.MovingAverage.Value > 0
                    for index=1:(app.MovingAverage.Value-1)
                        app.alcRec.movingAverageBuffer(index) = movingAverageBuffer(index+1);
                    end
                    app.alcRec.movingAverageBuffer(app.MovingAverage.Value) = outputIndex;

                    outputIndex = mode(nonzeros(movingAverageBuffer(1:app.MovingAverage.Value)));
                end
                
                % Prosthetic outputIndex to matlab numbering
                outMov = find(prostheticOutput==outputIndex);
                
                % Update plot
                outClass = 1;
                outPrediction = 1;
                epsilon = 0.01;
                
                for mov=1:(nMovements-1)
                        % Extend
                        addpoints(app.linesList{mov,1},timeVector(win),outVector(outPrediction)+epsilon);
                        if outPrediction == outMov
                            addpoints(app.linesList{outClass,3},timeVector(win),1);
                        else
                            addpoints(app.linesList{outClass,3},timeVector(win),epsilon);
                        end
                        outPrediction = outPrediction + 1;
                     
                        % Flex
                        addpoints(app.linesList{mov,2},timeVector(win),-outVector(outPrediction)-epsilon);
                        if outPrediction == outMov
                            addpoints(app.linesList{outClass,4},timeVector(win),-1);
                        else
                            addpoints(app.linesList{outClass,4},timeVector(win),-epsilon);
                        end
                        outClass = outClass + 1;
                        outPrediction = outPrediction + 1;
     
                end
                
                % Rest 
                mov = mov + 1;
                addpoints(app.linesList{mov,1},timeVector(win),outVector(outPrediction));
                if outPrediction == outMov
                    addpoints(app.linesList{outClass,3},timeVector(win),1);
                else
                    addpoints(app.linesList{outClass,3},timeVector(win),0);
                end
                
                
                drawnow limitrate
                
                app.PredictedmovementLabel.Text = sprintf('Predicted Movement: %s',app.alcRec.mov{outMov});
                
                
            end
            toc
            
            %--------------------------------------------------------------
            % Stop acquisistion
            %--------------------------------------------------------------            
            alc.setCommandMode(app.serialObj)
            % Deactivate streaming
            alc.NNCoefficients.streamEnable = 0;
            alc.setNNParameters(app.serialObj,alc.NNCoefficients)

        end
        
        % Value changed function: ThresholdSpinner
        function updateThreshold(app, ~)
            value = app.ThresholdSpinner.Value;

            selectedMovement = app.MovementListBox.Value;
            
            if isempty(selectedMovement)
                uialert(app.UIFigure,'Select movement first','Error')
                return
            end
            
            movementIndex = find(strcmp(app.alcRec.mov, selectedMovement));
            
            % Update GUI
            if mod(movementIndex,2)
                app.thresholdList{round(movementIndex/2),1}.Value = value;
            else
                app.thresholdList{round(movementIndex/2),2}.Value = value;
            end
          
            % Save value to alcRec           
            app.alcRec.networkThresholds(movementIndex) = value;

        end
        
        function saveSettings(app, ~)
            alcRec = app.alcRec;
            alcRec.networkThresholds = abs(alcRec.networkThresholds);
            save('alcRecNetwork.mat','alcRec')
        end
        
        % Update the GUI when the selected movement changes
        function updateSpinnerValue(app, ~)
            selectedMovement = app.MovementListBox.Value;
            movementIndex = strcmp(app.alcRec.mov, selectedMovement);
            app.ThresholdSpinner.Value = app.alcRec.networkThresholds(movementIndex);
        end
        
        function uploadNNCoefficients(app, ~)
            alc = ALC();
            alc.getNNParameters(app.serialObj);
            alc.NNCoefficients.threshold = abs(app.alcRec.networkThresholds); 
            alc.setNNParameters(app.serialObj,alc.NNCoefficients)
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
            app.ThresholdSpinner.Limits = [-1 1];
            app.ThresholdSpinner.Position = [32 241 234 38];

            % Create StartButton
            app.StartButton = uibutton(app.LeftPanel, 'push');
            app.StartButton.ButtonPushedFcn = createCallbackFcn(app, @startRecording, true);
            app.StartButton.Position = [32 147 234 30];
            app.StartButton.Text = 'Start';

            % Create TimesEditFieldLabel
            app.TimeLabel = uilabel(app.LeftPanel);
            app.TimeLabel.Position = [33 110 67 22];
            app.TimeLabel.Text = 'Time [s]';

            % Create TimesEditField
            app.Time = uieditfield(app.LeftPanel, 'numeric');
            app.Time.Limits = [0 Inf];
            app.Time.Position = [115 110 150 22];
            app.Time.Value = 30;
            
            % Create MovingAverageEditFieldLabel
            app.MovingAverageLabel = uilabel(app.LeftPanel);
            app.MovingAverageLabel.Position = [33 200 67 22];
            app.MovingAverageLabel.Text = 'MA Order';

            % Create MovingAverageEditField
            app.MovingAverage = uieditfield(app.LeftPanel, 'numeric');
            app.MovingAverage.Limits = [0 10];
            app.MovingAverage.Position = [115 200 150 22];
            app.MovingAverage.Value = 0;

            % Create SaveVariablesButton
            app.SaveVariablesButton = uibutton(app.LeftPanel, 'push');
            app.SaveVariablesButton.ButtonPushedFcn = createCallbackFcn(app, @saveSettings, true);
            app.SaveVariablesButton.Position = [33 37 232 30];
            app.SaveVariablesButton.Text = 'Save Variables';
            
            app.UploadCoeffButton = uibutton(app.LeftPanel, 'push');
            app.UploadCoeffButton.ButtonPushedFcn = createCallbackFcn(app, @uploadNNCoefficients, true);
            app.UploadCoeffButton.Position = [33 77 232 30];
            app.UploadCoeffButton.Text = 'Update Coefficients';
            
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
        function app = app_NetworkThresholds(handles)
        
            %--------------------------------------------------------------
            % Compability for old NCALFit
            %--------------------------------------------------------------
            if isfield(handles,'obj')
                obj = handles.obj;
                comPort = obj.Port;
                baudRate = obj.BaudRate;
                
                instrreset;               
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
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)
            
           
            %--------------------------------------------------------------
            % Load alcRec file
            %--------------------------------------------------------------
            app.UIFigure.Visible = 'off';
            file = uigetfile('*.mat');
            app.UIFigure.Visible = 'on';
            load(file, 'alcRec')
            app.alcRec = alcRec;
            
            %--------------------------------------------------------------
            % Load NN parameters from ALC
            %--------------------------------------------------------------
            
            alc = ALC();
            alc.getNNParameters(app.serialObj)
            
            %--------------------------------------------------------------
            % Add moving average struct to alcRec
            %--------------------------------------------------------------

            app.alcRec.movingAverageBuffer = zeros(10,1);

            %--------------------------------------------------------------
            % Prepare recording window
            %--------------------------------------------------------------
            
            app.MovementListBox.Items = app.alcRec.mov(1:end-1);
            
            app.alcRec.antagonisticMovements = unique(strtok(app.alcRec.mov),'stable');
            app.alcRec.antagonisticMovements(end) = [];
            
            % Hard coded
            if any(contains(app.alcRec.mov, 'Thumb Extend + Index Extend')) && any(contains(app.alcRec.mov, 'Thumb Flex + Index Flex'))
                app.alcRec.antagonisticMovements = [app.alcRec.antagonisticMovements 'Thumb + Index'];
            end
            
            if any(contains(app.alcRec.mov, 'Thumb Extend + Middle Extend')) && any(contains(app.alcRec.mov, 'Thumb Flex + Middle Flex'))
                app.alcRec.antagonisticMovements = [app.alcRec.antagonisticMovements 'Thumb + Middle'];
            end
            
            if any(contains(app.alcRec.mov, 'Index Extend + Middle Extend')) && any(contains(app.alcRec.mov, 'Index Flex + Middle Flex'))
                app.alcRec.antagonisticMovements = [app.alcRec.antagonisticMovements 'Index + Middle'];
            end
            
            if any(contains(app.alcRec.mov, 'Thumb Extend + Index Extend + Middle Extend')) && any(contains(app.alcRec.mov, 'Thumb Flex + Index Flex + Middle Flex'))
                app.alcRec.antagonisticMovements = [app.alcRec.antagonisticMovements 'Thumb + Index + Middle'];
            end
            
            if any(contains(app.alcRec.antagonisticMovements, 'Open')) && any(contains(app.alcRec.antagonisticMovements, 'Close'))
                app.alcRec.antagonisticMovements(contains(app.alcRec.antagonisticMovements, 'Open')) = [];
                app.alcRec.antagonisticMovements(contains(app.alcRec.antagonisticMovements, 'Close')) = [];
                app.alcRec.antagonisticMovements = ['Open/Close Hand' app.alcRec.antagonisticMovements];
            end
            
            if any(contains(app.alcRec.antagonisticMovements, 'Pronation')) && any(contains(app.alcRec.antagonisticMovements, 'Supination'))
                app.alcRec.antagonisticMovements(contains(app.alcRec.antagonisticMovements, 'Pronation')) = [];
                app.alcRec.antagonisticMovements(contains(app.alcRec.antagonisticMovements, 'Supination')) = [];
                app.alcRec.antagonisticMovements = [app.alcRec.antagonisticMovements 'Pronation/Supination'];
            end
            
            if any(contains(app.alcRec.antagonisticMovements, 'Extend')) && any(contains(app.alcRec.antagonisticMovements, 'Flex'))
                app.alcRec.antagonisticMovements(contains(app.alcRec.antagonisticMovements, 'Extend')) = [];
                app.alcRec.antagonisticMovements(contains(app.alcRec.antagonisticMovements, 'Flex')) = [];
                app.alcRec.antagonisticMovements = [app.alcRec.antagonisticMovements 'Extend/Flex Elbow'];
            end
            
            
            app.alcRec.antagonisticMovements = [app.alcRec.antagonisticMovements 'Rest'];
            
            nMovements = length(app.alcRec.antagonisticMovements);

            recordingTime = app.Time.Value;

            app.axesList = cell(nMovements,2);
            app.linesList = cell(nMovements,4);
            app.thresholdList = cell(nMovements,2);
            
         
            t = tiledlayout(app.Panel,nMovements,2);
            t.TileSpacing = 'compact';
            t.Padding = 'compact';
            
            for mov=1:(nMovements-1)
                
                % Create axes and lines list for the outVector plots
                app.axesList{mov,1} = nexttile(t);
                ylabel(app.axesList{mov,1},app.alcRec.antagonisticMovements{mov});
                xlim(app.axesList{mov,1},[0 recordingTime])
                ylim(app.axesList{mov,1},[-1.1 1.1])
                app.linesList{mov,1} = animatedline('Parent', app.axesList{mov,1},'Color', [0 0.4470 0.7410]);
                app.linesList{mov,2} = animatedline('Parent', app.axesList{mov,1},'Color', [0.8500 0.3250 0.0980]);
                text('Parent', app.axesList{mov,1}, 'Position', [1 0.9], 'String', 'Extend', 'Color', [0 0.4470 0.7410])
                text('Parent', app.axesList{mov,1}, 'Position', [1 -0.9], 'String', 'Flex','Color', [0.8500 0.3250 0.0980])
                
                if mov == 1
                    title('Predicted likelihood vector', 'FontSize', 15,'Parent', app.axesList{mov,1})
                end
                
                 % Create axes and lines list for the outMov plots
                app.axesList{mov,2} = nexttile(t);
                ylabel(app.axesList{mov,2},app.alcRec.antagonisticMovements{mov});
                xlim(app.axesList{mov,2},[0 recordingTime])
                ylim(app.axesList{mov,2},[-1.1 1.1])
                app.linesList{mov,3} = animatedline('Parent', app.axesList{mov,2},'Color', [0 0.4470 0.7410]);
                app.linesList{mov,4} = animatedline('Parent', app.axesList{mov,2},'Color', [0.8500 0.3250 0.0980]);
                if mov == 1
                    title('Predicted movement', 'FontSize', 15,'Parent', app.axesList{mov,2})
                end

            end
            
            % Rest
            mov = mov+1;
            app.axesList{mov,1} = nexttile(t);
            ylabel(app.axesList{mov,1},app.alcRec.antagonisticMovements{mov});
            xlim(app.axesList{mov,1},[0 recordingTime])
            ylim(app.axesList{mov,1},[-0.1 1.1])
            app.linesList{mov,1} = animatedline('Parent', app.axesList{mov,1},'Color', 'k');
            
            app.axesList{mov,2} = nexttile(t);
            ylabel(app.axesList{mov,2},app.alcRec.antagonisticMovements{mov});
            xlim(app.axesList{mov,2},[0 recordingTime])
            ylim(app.axesList{mov,2},[-0.1 1.1])
            app.linesList{mov,3} = animatedline('Parent', app.axesList{mov,2},'Color', 'k');
            
            % Add thresholds
            index = 0;
            for mov=1:(nMovements-1)
                index = index+1;
                app.thresholdList{mov,1} = yline('Parent', app.axesList{mov}, 0.5, '--','Threshold Extend');                    
                index = index+1;
                app.thresholdList{mov,2} = yline('Parent', app.axesList{mov}, -0.5, '--','Threshold Flex');
                
            end
            
            if ~isfield(app.alcRec, 'networkThresholds')
                app.alcRec.networkThresholds = 0.5*(-ones(1,index)).^(0:index-1);
            else
                app.alcRec.networkThresholds = app.alcRec.networkThresholds.*(-ones(1,index)).^(0:index-1);
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