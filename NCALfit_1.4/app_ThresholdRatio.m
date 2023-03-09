classdef app_ThresholdRatio < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                    matlab.ui.Figure
        GridLayout                  matlab.ui.container.GridLayout
        LeftPanel                   matlab.ui.container.Panel
        Panel                       matlab.ui.container.Panel
        TimeEditFieldLabel          matlab.ui.control.Label
        TimeEditField               matlab.ui.control.NumericEditField
        RecordButton                matlab.ui.control.Button
        RightPanel                  matlab.ui.container.Panel
        openThresholdSpinnerLabel   matlab.ui.control.Label
        openThresholdSpinner        matlab.ui.control.Spinner
        closeThresholdSpinnerLabel  matlab.ui.control.Label
        closeThresholdSpinner       matlab.ui.control.Spinner
        SaveButton                  matlab.ui.control.Button
        OutputPanel                 matlab.ui.container.Panel
        PredictedMovementLabel      matlab.ui.control.Label
        outIdxLabel                 matlab.ui.control.Label
        PredictedStrengthLabel      matlab.ui.control.Label
        outStrengthLabel            matlab.ui.control.Label
        
        % User defined properties
        serialObj 
        axesList 
        linesList
        thresholdList
        thresholdFlag
    end

    % Properties that correspond to apps with auto-reflow
    properties (Access = private)
        onePanelWidth = 576;
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Value changed function: openThresholdSpinner
        function updateOpenThreshold(app, ~)
            value = app.openThresholdSpinner.Value;
            % Update GUI
            app.thresholdList{1}.Value = value;    
        end

        % Value changed function: closeThresholdSpinner
        function updateClosedThreshold(app, ~)
            value = app.closeThresholdSpinner.Value;
            % Update GUI
            app.thresholdList{2}.Value = value;
            
        end

        % Button pushed function: SaveButton
        function saveSettings(app, ~)
            alc = ALC();
            thresholdRatioParameters= [app.thresholdList{1}.Value app.thresholdList{2}.Value];
            alc.setThresholdRatioParameters(app.serialObj, thresholdRatioParameters)
            
        end

        % Button pushed function: RecordButton
        function startRecording(app, ~)
            %--------------------------------------------------------------
            % Create ALC object and get current parameters
            %--------------------------------------------------------------
            alc = ALC();
            % Get current parameters from ALC
            alc.getRecSettings(app.serialObj);
                     
            sF = alc.samplingFrequency;
            tWs = alc.timeWindowSamples;
            nCh = alc.numberOfActiveChannels;
            nFeatures = alc.numberOfActiveFeatures;  
            
            if nFeatures > 1
                uialert(app.UIFigure,'Too many features for direct control','Error')
                return;
            end
            
            if nCh ~= 2
                uialert(app.UIFigure,'Wrong number of channels for direct control','Error')
                return;
            end
                
            
            %--------------------------------------------------------------
            % Get values needed for plotting
            %--------------------------------------------------------------
            recordingTime = app.TimeEditField.Value; 
            nWindows = sF/tWs*recordingTime;
            timeVector = linspace(0,recordingTime,nWindows);       
            featureData = zeros(nWindows,nCh);
            
            %--------------------------------------------------------------
            % Start acquisition and update plots
            %--------------------------------------------------------------
            for index=1:6
                clearpoints(app.linesList{index});
                if index ~= 6
                xlim(app.axesList{index},[0 recordingTime])
                end
            end
            
            alc.startClosedLoopACQ(app.serialObj)
            
            thresholdRatios = zeros(nWindows,2); 
            
            tic;
            for win = 1:nWindows
                % Receive ALC Data
                
                featureData(win,:) = read(app.serialObj,nCh,'single'); 
                
                thresholdRatios(win,1) = featureData(win,1)/featureData(win,2);
                thresholdRatios(win,2) = featureData(win,2)/featureData(win,1);

                movement.moveIndex = read(app.serialObj,1,'uint8');   
                movement.activLevel1 = read(app.serialObj,1,'uint8');
                movement.activLevel2 = read(app.serialObj,1,'uint8');
                movement.activLevel3 = read(app.serialObj,1,'uint8');
                
                string_PredictedMovement = alc.decodeOutIndex(movement.moveIndex);

                 % Update plot
                % harcoded that ch=1 open hand
                addpoints(app.linesList{1},timeVector(win),featureData(win,1));
                addpoints(app.linesList{2},timeVector(win),featureData(win,2));
                % CoContraction plot
                addpoints(app.linesList{3},timeVector(win),featureData(win,1));
                addpoints(app.linesList{4},timeVector(win),featureData(win,2));
                
                % Threshold Ratio plots
                addpoints(app.linesList{5},timeVector(win),thresholdRatios(win,1));
                addpoints(app.linesList{6},timeVector(win),thresholdRatios(win,2));
              
               % drawnow limitrate
                 
                app.outIdxLabel.Text = string_PredictedMovement;
                app.outStrengthLabel.Text = sprintf(' %i', movement.activLevel1);
                
                
            end
            toc
            %--------------------------------------------------------------
            % Stop acquisistion
            %--------------------------------------------------------------            
            alc.stopACQ(app.serialObj)     
            
            % Calculate thresholds
            openThreshold = 0.5*max(thresholdRatios(:,1));
            closeThreshold = 0.5*max(thresholdRatios(:,2));
            
            if 2*openThreshold > app.axesList{4}.YLim(2)
                ylim(app.axesList{4},[0 ceil(2*openThreshold)+1])
            end
            
            if 2*closeThreshold > app.axesList{5}.YLim(2)
                ylim(app.axesList{5},[0 ceil(2*closeThreshold)+1])
            end
            
            % Update threshold GUI values if non were set before
            if ~app.thresholdFlag
                app.thresholdList{1}.Value = openThreshold;
                app.thresholdList{2}.Value = closeThreshold;
                app.openThresholdSpinner.Value = openThreshold;
                app.closeThresholdSpinner.Value = closeThreshold;
                % Set step size to 5%
                stepSize = (openThreshold)/20;
                
                if stepSize ~= 0
                app.openThresholdSpinner.Step = stepSize;
                app.closeThresholdSpinner.Step = stepSize;
                end
            end
                
            
   
        end

        % Changes arrangement of the app based on UIFigure width
        function updateAppLayout(app, ~)
            currentFigureWidth = app.UIFigure.Position(3);
            if(currentFigureWidth <= app.onePanelWidth)
                % Change to a 2x1 grid
                app.GridLayout.RowHeight = {564, 564};
                app.GridLayout.ColumnWidth = {'1x'};
                app.RightPanel.Layout.Row = 2;
                app.RightPanel.Layout.Column = 1;
            else
                % Change to a 1x2 grid
                app.GridLayout.RowHeight = {'1x'};
                app.GridLayout.ColumnWidth = {704, '1x'};
                app.RightPanel.Layout.Row = 1;
                app.RightPanel.Layout.Column = 2;
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
            app.UIFigure.Position = [100 100 911 499];
            app.UIFigure.Name = 'app_ThresholdRatio';
            app.UIFigure.SizeChangedFcn = createCallbackFcn(app, @updateAppLayout, true);

            % Create GridLayout
            app.GridLayout = uigridlayout(app.UIFigure);
            app.GridLayout.ColumnWidth = {704, '1x'};
            app.GridLayout.RowHeight = {'1x'};
            app.GridLayout.ColumnSpacing = 0;
            app.GridLayout.RowSpacing = 0;
            app.GridLayout.Padding = [0 0 0 0];
            app.GridLayout.Scrollable = 'on';

            % Create LeftPanel
            app.LeftPanel = uipanel(app.GridLayout);
            app.LeftPanel.Layout.Row = 1;
            app.LeftPanel.Layout.Column = 1;

            % Create Panel
            app.Panel = uipanel(app.LeftPanel);
            app.Panel.Position = [9 66 681 422];

            % Create TimeEditFieldLabel
            app.TimeEditFieldLabel = uilabel(app.LeftPanel);
            app.TimeEditFieldLabel.HorizontalAlignment = 'right';
            app.TimeEditFieldLabel.Position = [21 22 32 22];
            app.TimeEditFieldLabel.Text = 'Time';

            % Create TimeEditField
            app.TimeEditField = uieditfield(app.LeftPanel, 'numeric');
            app.TimeEditField.Limits = [0 Inf];
            app.TimeEditField.Position = [68 22 100 22];
            app.TimeEditField.Value = 20;

            % Create RecordButton
            app.RecordButton = uibutton(app.LeftPanel, 'push');
            app.RecordButton.ButtonPushedFcn = createCallbackFcn(app, @startRecording, true);
            app.RecordButton.Position = [519 22 171 22];
            app.RecordButton.Text = 'Record';

            % Create RightPanel
            app.RightPanel = uipanel(app.GridLayout);
            app.RightPanel.Layout.Row = 1;
            app.RightPanel.Layout.Column = 2;

            % Create openThresholdSpinnerLabel
            app.openThresholdSpinnerLabel = uilabel(app.RightPanel);
            app.openThresholdSpinnerLabel.HorizontalAlignment = 'right';
            app.openThresholdSpinnerLabel.Position = [15 221 160 22];
            app.openThresholdSpinnerLabel.Text = 'Open Hand Threshold Ratio';

            % Create openThresholdSpinner
            app.openThresholdSpinner = uispinner(app.RightPanel);
            app.openThresholdSpinner.ValueChangedFcn = createCallbackFcn(app, @updateOpenThreshold, true);
            app.openThresholdSpinner.Position = [97 191 100 22];

            % Create closeThresholdSpinnerLabel
            app.closeThresholdSpinnerLabel = uilabel(app.RightPanel);
            app.closeThresholdSpinnerLabel.HorizontalAlignment = 'right';
            app.closeThresholdSpinnerLabel.Position = [15 135 160 22];
            app.closeThresholdSpinnerLabel.Text = 'Close Hand Threshold Ratio';

            % Create closeThresholdSpinner
            app.closeThresholdSpinner = uispinner(app.RightPanel);
            app.closeThresholdSpinner.ValueChangedFcn = createCallbackFcn(app, @updateClosedThreshold, true);
            app.closeThresholdSpinner.Position = [97 105 100 22];

            % Create SaveButton
            app.SaveButton = uibutton(app.RightPanel, 'push');
            app.SaveButton.ButtonPushedFcn = createCallbackFcn(app, @saveSettings, true);
            app.SaveButton.Position = [26 22 171 22];
            app.SaveButton.Text = 'Save';

            % Create OutputPanel
            app.OutputPanel = uipanel(app.RightPanel);
            app.OutputPanel.Position = [13 291 184 197];

            % Create PredictedMovementLabel
            app.PredictedMovementLabel = uilabel(app.OutputPanel);
            app.PredictedMovementLabel.Position = [13 135 121 22];
            app.PredictedMovementLabel.Text = 'Predicted Movement:';

            % Create outIdxLabel
            app.outIdxLabel = uilabel(app.OutputPanel);
            app.outIdxLabel.Position = [13 114 110 22];
            app.outIdxLabel.Text = '';

            % Create PredictedStrengthLabel
            app.PredictedStrengthLabel = uilabel(app.OutputPanel);
            app.PredictedStrengthLabel.Position = [13 70 110 22];
            app.PredictedStrengthLabel.Text = 'Predicted Strength:';

            % Create outStrengthLabel
            app.outStrengthLabel = uilabel(app.OutputPanel);
            app.outStrengthLabel.Position = [13 49 69 22];
            app.outStrengthLabel.Text = '';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = app_ThresholdRatio(handles)
            
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
            % Prepare recording window
            %--------------------------------------------------------------
            recordingTime = app.TimeEditField.Value;
            
            % Allocate axes, line and threshold lists
            app.axesList = cell(5,1);
            app.linesList = cell(6,1);
            app.thresholdList = cell(2,1);
            
            t = tiledlayout(app.Panel,2,3);
            t.TileSpacing = 'compact';
            t.Padding = 'compact';
            
            % Open hand            
            app.axesList{1} = nexttile(t);
            ylabel(app.axesList{1},sprintf('Open hand'));
            app.linesList{1} = animatedline('Parent', app.axesList{1}, 'Color',[0 0.4470 0.7410]);
            xlim(app.axesList{1},[0 recordingTime])
            app.linesList{1}.LineWidth = 2;
            
            % Close hand            
            app.axesList{2} = nexttile(t);
            ylabel(app.axesList{2},sprintf('Close hand'));
            app.linesList{2} = animatedline('Parent', app.axesList{2}, 'Color',[0.8500 0.3250 0.0980]);
            xlim(app.axesList{2},[0 recordingTime])
            app.linesList{2}.LineWidth = 2;
            
            % Cocontraction hand            
            app.axesList{3} = nexttile(t);
            ylabel(app.axesList{3},sprintf('Cocontraction'));
            app.linesList{3} = animatedline('Parent', app.axesList{3},'Color',[0 0.4470 0.7410]);
            app.linesList{4} = animatedline('Parent', app.axesList{3}, 'Color',[0.8500 0.3250 0.0980]);
            xlim(app.axesList{3},[0 recordingTime])
            app.linesList{3}.LineWidth = 2;
            app.linesList{4}.LineWidth = 2;
            
            % Open hand threshold ratio            
            app.axesList{4} = nexttile(t);
            ylabel(app.axesList{4},sprintf('Open Threshold Ratio'));
            app.linesList{5} = animatedline('Parent', app.axesList{4});
            xlim(app.axesList{4},[0 recordingTime])
            ylim(app.axesList{4},[0 inf])
            app.linesList{5}.LineWidth = 2;
            
             % Close hand threshold ratio            
            app.axesList{5} = nexttile(t);
            ylabel(app.axesList{5},sprintf('Close Threshold Ratio'));
            app.linesList{6} = animatedline('Parent', app.axesList{5});
            xlim(app.axesList{5},[0 recordingTime])
            ylim(app.axesList{5},[0 inf])
            app.linesList{6}.LineWidth = 2;
            
            alc = ALC();
            alc.getThresholdRatioParameters(app.serialObj)
            
            % Add upper threshold line
            app.thresholdList{1} = yline('Parent', app.axesList{4}, alc.thresholdRatioParameters(1), '-','Open ratio threshold');
            app.thresholdList{2} = yline('Parent', app.axesList{5}, alc.thresholdRatioParameters(2), '-','Close ratio threshold');
            app.thresholdList{1}.Visible = 1;
            app.thresholdList{2}.Visible = 1;
            
            app.thresholdFlag = 0;
            if alc.thresholdRatioParameters(1) > 0
                ylim(app.axesList{4},[0 2*ceil(alc.thresholdRatioParameters(1))])
                app.openThresholdSpinner.Value = alc.thresholdRatioParameters(1);
                app.thresholdFlag = 1;
            end
            
            if alc.thresholdRatioParameters(2) > 0
                ylim(app.axesList{5},[0 2*ceil(alc.thresholdRatioParameters(2))])
                app.closeThresholdSpinner.Value = alc.thresholdRatioParameters(2);
                app.thresholdFlag = 1;
            end
            


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