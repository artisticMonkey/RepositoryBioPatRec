classdef app_AnalyseRecording < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                     matlab.ui.Figure
        GridLayout                   matlab.ui.container.GridLayout
        LeftPanel                    matlab.ui.container.Panel
        MovementsListBoxLabel        matlab.ui.control.Label
        MovementsListBox             matlab.ui.control.ListBox
        RecordingNumberListBoxLabel  matlab.ui.control.Label
        RecordingNumberListBox       matlab.ui.control.ListBox
        RunButton                    matlab.ui.control.Button
        SaveButton                   matlab.ui.control.Button
        SelectActionDropDownLabel    matlab.ui.control.Label
        SelectActionDropDown         matlab.ui.control.DropDown
        RightPanel                   matlab.ui.container.Panel
        MainLabel                    matlab.ui.control.Label
        
        % User defined properties
        alc
        network
        recordingData
        callingApp
    end
      


    % Properties that correspond to apps with auto-reflow
    properties (Access = private)
        onePanelWidth = 576;
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Value changed function: MovementsListBox
        function updateRecordingNumber(app, ~)
            selectedMovement = app.MovementsListBox.Value;
            selectedMovementIndex = find(strcmp(app.recordingData.movements, selectedMovement));
            fieldName = app.recordingData.movementFields{selectedMovementIndex};
            nRecordings = app.recordingData.movementRecordings.(fieldName).nRecordings;
            app.RecordingNumberListBox.Items = sprintfc('%d',1:nRecordings);
        end

        % Button pushed function: RunButton
        function runAction(app, ~)
            if strcmp(app.SelectActionDropDown.Value, 'Plot selection')
                plotRecordings(app)
            
            elseif strcmp(app.SelectActionDropDown.Value, 'Delete selected recording')
                deleteRecording(app)
                
            else
                uialert(app.UIFigure,'Not yet implemented','Error')
            end
            
        end
        
        function plotRecordings(app)
            
            selectedMovement = app.MovementsListBox.Value;
            selectedMovementIndex = strcmp(app.recordingData.movements, selectedMovement);
            fieldName = app.recordingData.movementFields{selectedMovementIndex};
            
            % Get data 
            data = app.recordingData.movementRecordings.(fieldName).data;
            nChannels = app.alc.numberOfActiveChannels;
            
            % Get correct recording indexes
            selectedRecordings = str2double(app.RecordingNumberListBox.Value);
            nSelectedRecordings = numel(selectedRecordings);
            if nSelectedRecordings < 1
                uialert(app.UIFigure,'Select recordings to plot first','Error')
                return
            end
            
            nRecordings = app.recordingData.movementRecordings.(fieldName).nRecordings;
            samples = app.recordingData.movementRecordings.(fieldName).samples;
            
            indexes = [];
            startIndex = 1;
            selectedRecordingsStart = 1;
            
            for rec=1:nRecordings
                if any(selectedRecordings == rec)
                    indexes = [indexes startIndex:(startIndex+samples(rec)-1)];
                    selectedRecordingsStart = [selectedRecordingsStart startIndex+samples(rec)-1];
                end
                startIndex = startIndex+samples(rec);
            end
            
            
            % Plot data
            t = tiledlayout(app.RightPanel,nChannels,1);
            t.TileSpacing = 'compact';
            t.Padding = 'compact';
            
            for ch=1:nChannels
                ax = nexttile(t);
                plot(ax, data(indexes,ch))
                ylabel(ax, sprintf('Ch%i',app.alc.activeChannels(ch)))
                for rec=1:length(selectedRecordings)
                    xline(ax, selectedRecordingsStart(rec),'-', sprintf('Rec%i',selectedRecordings(rec)))
                end
            end
            
            app.MainLabel.Text = 'Recoding plotted';
            
        end
        
        function deleteRecording(app)
            selectedMovement = app.MovementsListBox.Value;
            selectedMovementIndex = strcmp(app.recordingData.movements, selectedMovement);
            fieldName = app.recordingData.movementFields{selectedMovementIndex};
            
            % Get correct recording indexes
            selectedRecordings = str2double(app.RecordingNumberListBox.Value);
            nSelectedRecordings = numel(selectedRecordings);
            if nSelectedRecordings < 1
                uialert(app.UIFigure,'Select at least one recording to be deleted','Error')
                return
            end
            
            nRecordings = app.recordingData.movementRecordings.(fieldName).nRecordings;
            samples = app.recordingData.movementRecordings.(fieldName).samples;
            
            indexes = [];
            startIndex = 1;
            
            for rec=1:nRecordings
                if any(selectedRecordings == rec)
                    indexes = [indexes startIndex:(startIndex+samples(rec)-1)];  
                end
                startIndex = startIndex+samples(rec);
            end

            selection = uiconfirm(app.UIFigure,sprintf('Delete recording: %i? \n',selectedRecordings),'Confirm deletion',...
                        'Icon','warning');
            if strcmp(selection, 'Cancel')
                return
            end
           
           % Delete selected recordings 
           app.recordingData.movementRecordings.(fieldName).data(indexes,:) = [];
           app.recordingData.movementRecordings.(fieldName).samples(selectedRecordings) = [];
           app.recordingData.movementRecordings.(fieldName).nRecordings = nRecordings - nSelectedRecordings;
           % Update GUI
           updateRecordingNumber(app)
           app.MainLabel.Text = 'Recording(s) deleted';
            
        end

        % Button pushed function: SaveButton
        function saveData(app, ~)
            % Update recordingData.data in case some recordings were deleted
            data = [];
            labels = [];
            for mov=1:numel(app.recordingData.movementFields)
                fieldName = app.recordingData.movementFields{mov};
                data = [data; app.recordingData.movementRecordings.(fieldName).data];
                nSamples = sum(app.recordingData.movementRecordings.(fieldName).samples);
                labels = [labels; mov*ones(nSamples,1)];
            end
            
            app.recordingData.data = data;
            app.recordingData.labels = labels;
            
            % If this app was called by another app, return recordinData by
            % reference. Otherwise save data to file
            
            if isempty(app.callingApp)
                alcRec.alc = app.alc;
                alcRec.recordingData = app.recordingData;
                if ~isempty(app.network)
                	alcRec.network = app.network;
                end
                alcRec.mov = app.recordingData.movements;
                alcRec.movFields = app.recordingData.movementFields;
                fileName = sprintf('alcRec_%s.mat', datestr(now,'yyyy-mm-dd HH-MM'));
                save(fileName , 'alcRec');
                app.MainLabel.Text = 'Data saved to file';
            else
                % Pass back to the calling app by reference
                app.callingApp.recordingData = app.recordingData;
                updateMovementListValues(app.callingApp)
                app.MainLabel.Text = 'Data passed to main GUI';
            end
        end

        % Changes arrangement of the app based on UIFigure width
        function updateAppLayout(app, ~)
            currentFigureWidth = app.UIFigure.Position(3);
            if(currentFigureWidth <= app.onePanelWidth)
                % Change to a 2x1 grid
                app.GridLayout.RowHeight = {625, 625};
                app.GridLayout.ColumnWidth = {'1x'};
                app.RightPanel.Layout.Row = 2;
                app.RightPanel.Layout.Column = 1;
            else
                % Change to a 1x2 grid
                app.GridLayout.RowHeight = {'1x'};
                app.GridLayout.ColumnWidth = {245, '1x'};
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
            app.UIFigure.Position = [100 100 1131 625];
            app.UIFigure.Name = 'Analyse recording session';
            app.UIFigure.SizeChangedFcn = createCallbackFcn(app, @updateAppLayout, true);

            % Create GridLayout
            app.GridLayout = uigridlayout(app.UIFigure);
            app.GridLayout.ColumnWidth = {245, '1x'};
            app.GridLayout.RowHeight = {'1x'};
            app.GridLayout.ColumnSpacing = 0;
            app.GridLayout.RowSpacing = 0;
            app.GridLayout.Padding = [0 0 0 0];
            app.GridLayout.Scrollable = 'on';

            % Create LeftPanel
            app.LeftPanel = uipanel(app.GridLayout);
            app.LeftPanel.Layout.Row = 1;
            app.LeftPanel.Layout.Column = 1;

            % Create MovementsListBoxLabel
            app.MovementsListBoxLabel = uilabel(app.LeftPanel);
            app.MovementsListBoxLabel.HorizontalAlignment = 'right';
            app.MovementsListBoxLabel.Position = [15 572 68 22];
            app.MovementsListBoxLabel.Text = 'Movements';

            % Create MovementsListBox
            app.MovementsListBox = uilistbox(app.LeftPanel);
            app.MovementsListBox.Items = {};
            app.MovementsListBox.Multiselect = 'on';
            app.MovementsListBox.ValueChangedFcn = createCallbackFcn(app, @updateRecordingNumber, true);
            app.MovementsListBox.Position = [15 396 210 177];
            app.MovementsListBox.Value = {};

            % Create RecordingNumberListBoxLabel
            app.RecordingNumberListBoxLabel = uilabel(app.LeftPanel);
            app.RecordingNumberListBoxLabel.HorizontalAlignment = 'right';
            app.RecordingNumberListBoxLabel.Position = [15 355 105 22];
            app.RecordingNumberListBoxLabel.Text = 'Recording number';

            % Create RecordingNumberListBox
            app.RecordingNumberListBox = uilistbox(app.LeftPanel);
            app.RecordingNumberListBox.Items = {};
            app.RecordingNumberListBox.Multiselect = 'on';
            app.RecordingNumberListBox.Position = [15 209 210 147];
            app.RecordingNumberListBox.Value = {};

            % Create RunButton
            app.RunButton = uibutton(app.LeftPanel, 'push');
            app.RunButton.ButtonPushedFcn = createCallbackFcn(app, @runAction, true);
            app.RunButton.Position = [15 97 210 22];
            app.RunButton.Text = 'Run';

            % Create SaveButton
            app.SaveButton = uibutton(app.LeftPanel, 'push');
            app.SaveButton.ButtonPushedFcn = createCallbackFcn(app, @saveData, true);
            app.SaveButton.Position = [15 18 210 22];
            app.SaveButton.Text = 'Save';
            
            % Create MainLabel
            app.MainLabel = uilabel(app.LeftPanel);
            app.MainLabel.HorizontalAlignment = 'center';
            app.MainLabel.Position = [15 58 210 22];
            app.MainLabel.Text = '';

            % Create SelectActionDropDownLabel
            app.SelectActionDropDownLabel = uilabel(app.LeftPanel);
            app.SelectActionDropDownLabel.HorizontalAlignment = 'right';
            app.SelectActionDropDownLabel.Position = [15 152 75 22];
            app.SelectActionDropDownLabel.Text = 'Select action';

            % Create SelectActionDropDown
            app.SelectActionDropDown = uidropdown(app.LeftPanel);
            app.SelectActionDropDown.Items = {'Plot selection', 'Delete selected recording', 'Analyse', 'Update MVC'};
            app.SelectActionDropDown.Position = [15 131 205 22];
            app.SelectActionDropDown.Value = 'Plot selection';

            % Create RightPanel
            app.RightPanel = uipanel(app.GridLayout);
            app.RightPanel.Layout.Row = 1;
            app.RightPanel.Layout.Column = 2;

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = app_AnalyseRecording(varargin)
            %--------------------------------------------------------------
            % Create UIFigure and components
            %--------------------------------------------------------------
            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)
            
            %--------------------------------------------------------------
            % Load data
            %--------------------------------------------------------------
            if nargin == 0
                file = uigetfile('*.mat');
                app.UIFigure.Visible = 'on';
                if file == 0
                    return
                end
                load(file, 'alcRec')
                app.alc = alcRec.alc;
                app.recordingData = alcRec.recordingData;
                if ~isempty(alcRec.network)
                    app.network = alcRec.network;
                end
                app.MovementsListBox.Items = app.recordingData.movements;
                
            elseif nargin == 1
                app.callingApp = varargin{1};
                if isprop(app.callingApp, 'recordingData') && isprop(app.callingApp, 'alc') 
                     % Create local copies 
                    app.recordingData = app.callingApp.recordingData;
                    app.alc = app.callingApp.alc;
                    app.MovementsListBox.Items = app.recordingData.movements;
                else
                    delete(app)
                    
                end
                
            else
                delete(app)
                
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