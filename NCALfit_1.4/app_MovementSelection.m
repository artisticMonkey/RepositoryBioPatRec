classdef app_MovementSelection < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                       matlab.ui.Figure
        GridLayout                     matlab.ui.container.GridLayout
        LeftPanel                      matlab.ui.container.Panel
        SelectMovementListBox          matlab.ui.control.ListBox
        SelectMovementLabel            matlab.ui.control.Label
        AddMovementButton              matlab.ui.control.Button
        InstructionsLabel              matlab.ui.control.Label
        RightPanel                     matlab.ui.container.Panel
        SelectedMovementListBox        matlab.ui.control.ListBox
        SelectedMovementsLabel         matlab.ui.control.Label
        DeleteMovementButton           matlab.ui.control.Button
        ConfirmSelectionButton         matlab.ui.control.Button
        
         % User defined properties
         alc
         callingApp
         selectedMovements
         selectedMovementsSwe
    end

    % Properties that correspond to apps with auto-reflow
    properties (Access = private)
        onePanelWidth = 576;
    end

    % Callbacks that handle component events
    methods (Access = private)
               
        function addMovement(app, ~)
            selection = app.SelectMovementListBox.Value;
            
            selectionIndex = contains(app.alc.movementNames,selection);
            sortedSelection = app.alc.movementNames(selectionIndex);
            sortedSelectionSwe = app.alc.movementNamesSwe(selectionIndex);
            
            if numel(sortedSelection) > 1
                sortedSelection = cellstr(strjoin(sortedSelection, ' + '));
                sortedSelectionSwe = cellstr(strjoin(sortedSelectionSwe, ' + '));
            end
            
            if any(strcmp(app.SelectedMovementListBox.Items, sortedSelection))
                uialert(app.UIFigure,'Movement already selected','Error')
                
            else
                app.selectedMovements = [app.selectedMovements sortedSelection];
                app.selectedMovementsSwe = [app.selectedMovementsSwe sortedSelectionSwe];
                
                app.SelectedMovementListBox.Items = app.selectedMovements;
            end
        end
        
        function deleteMovement(app, ~)
            selection = app.SelectedMovementListBox.Value;
            selectionIndex = strcmp(app.SelectedMovementListBox.Items, selection);
            app.selectedMovements(selectionIndex) = [];
            app.selectedMovementsSwe(selectionIndex) = [];
            app.SelectedMovementListBox.Items = app.selectedMovements;
        end
        
        function confirmSelection(app,~)
            updateMovement(app.callingApp, app.selectedMovements, app.selectedMovementsSwe)
            delete(app)
        end

        % Changes arrangement of the app based on UIFigure width
        function updateAppLayout(app, ~)
            currentFigureWidth = app.UIFigure.Position(3);
            if(currentFigureWidth <= app.onePanelWidth)
                % Change to a 2x1 grid
                app.GridLayout.RowHeight = {643, 643};
                app.GridLayout.ColumnWidth = {'1x'};
                app.RightPanel.Layout.Row = 2;
                app.RightPanel.Layout.Column = 1;
            else
                % Change to a 1x2 grid
                app.GridLayout.RowHeight = {'1x'};
                app.GridLayout.ColumnWidth = {298, '1x'};
                app.RightPanel.Layout.Row = 1;
                app.RightPanel.Layout.Column = 2;
            end
        end
        
        % Key press function: UIFigure
        function UIFigureKeyPress(app, event)
            key = event.Key;
            switch key
                case 'return'
                    if numel(app.SelectMovementListBox.Value)>0
                        app.addMovement();
                    end
               
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
            app.UIFigure.Position = [100 100 711 643];
            app.UIFigure.Name = 'Movement Selection';
            app.UIFigure.SizeChangedFcn = createCallbackFcn(app, @updateAppLayout, true);

            % Create GridLayout
            app.GridLayout = uigridlayout(app.UIFigure);
            app.GridLayout.ColumnWidth = {298, '1x'};
            app.GridLayout.RowHeight = {'1x'};
            app.GridLayout.ColumnSpacing = 0;
            app.GridLayout.RowSpacing = 0;
            app.GridLayout.Padding = [0 0 0 0];
            app.GridLayout.Scrollable = 'on';

            % Create LeftPanel
            app.LeftPanel = uipanel(app.GridLayout);
            app.LeftPanel.Layout.Row = 1;
            app.LeftPanel.Layout.Column = 1;

            % Create SelectMovementListBox
            app.SelectMovementListBox = uilistbox(app.LeftPanel);
            app.SelectMovementListBox.Multiselect = 'on';
            app.SelectMovementListBox.Position = [34 175 229 389];
            app.SelectMovementListBox.Value = {'Item 1'};

            % Create SelectMovementLabel
            app.SelectMovementLabel = uilabel(app.LeftPanel);
            app.SelectMovementLabel.Position = [34 596 99 22];
            app.SelectMovementLabel.Text = 'Select movement';

            % Create AddMovementButton
            app.AddMovementButton = uibutton(app.LeftPanel, 'push');
            app.AddMovementButton.ButtonPushedFcn = createCallbackFcn(app, @addMovement, true);
            app.AddMovementButton.Position = [33 120 230 22];
            app.AddMovementButton.Text = 'Add selection to movements';

            % Create InstructionsLabel
            app.InstructionsLabel = uilabel(app.LeftPanel);
            app.InstructionsLabel.HorizontalAlignment = 'center';
            app.InstructionsLabel.Position = [33 62 229 28];
            app.InstructionsLabel.Text = {'Selecte multiple movements to train '; 'them simulatenously'};

            % Create RightPanel
            app.RightPanel = uipanel(app.GridLayout);
            app.RightPanel.Layout.Row = 1;
            app.RightPanel.Layout.Column = 2;

            % Create SelectedMovementListBox
            app.SelectedMovementListBox = uilistbox(app.RightPanel);
            app.SelectedMovementListBox.Items = {};
            app.SelectedMovementListBox.Position = [36 175 345 389];
            app.SelectedMovementListBox.Value = {};

            % Create SelectedMovementsLabel
            app.SelectedMovementsLabel = uilabel(app.RightPanel);
            app.SelectedMovementsLabel.Position = [36 596 119 22];
            app.SelectedMovementsLabel.Text = 'Selected movements';

            % Create DeleteMovementButton
            app.DeleteMovementButton = uibutton(app.RightPanel, 'push');
            app.DeleteMovementButton.ButtonPushedFcn = createCallbackFcn(app, @deleteMovement, true);
            app.DeleteMovementButton.Position = [94 120 230 22];
            app.DeleteMovementButton.Text = 'Delete selected movement';

            % Create ConfirmSelectionButton
            app.ConfirmSelectionButton = uibutton(app.RightPanel, 'push');
            app.ConfirmSelectionButton.ButtonPushedFcn = createCallbackFcn(app, @confirmSelection, true);
            app.ConfirmSelectionButton.Position = [94 49 230 22];
            app.ConfirmSelectionButton.Text = 'Confirm selection';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = app_MovementSelection(callingApp)
            
            app.callingApp = callingApp;
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
            
            %--------------------------------------------------------------
            % Populated app
            %--------------------------------------------------------------
            app.SelectMovementListBox.Items = app.alc.movementNames;
            

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