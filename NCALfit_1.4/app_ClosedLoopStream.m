classdef app_ClosedLoopStream < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                matlab.ui.Figure
        StartButton             matlab.ui.control.Button
        TimesLabel              matlab.ui.control.Label
        Time                    matlab.ui.control.NumericEditField
        UIAxes                  matlab.ui.control.UIAxes
        Panel                   matlab.ui.container.Panel
        MovementLabel           matlab.ui.control.Label
        PredictedmovementLabel  matlab.ui.control.Label
        SpeedLabel              matlab.ui.control.Label
        
        % User defined properties
        serialObj 
        axesList 
        linesList
        
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: StartButton
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
            
            %--------------------------------------------------------------
            % Get values needed for plotting
            %--------------------------------------------------------------
            recordingTime = app.Time.Value; 
            nWindows = sF/tWs*recordingTime;
            timeVector = linspace(0,recordingTime,nWindows);       
            featureData = zeros(nWindows,nCh, nFeatures);
            
            %--------------------------------------------------------------
            % Start acquisition and update plots
            %--------------------------------------------------------------
            for feature=1:nFeatures
                for ch=1:nCh
                    clearpoints(app.linesList{ch,feature});
                    xlim(app.axesList{ch,feature},[0 recordingTime])
                end
            end

            alc.startClosedLoopACQ(app.serialObj)
            
            tic;
            for win = 1:nWindows
                % Receive ALC Data
                for feature=1:nFeatures
                    featureData(win,:,feature) = read(app.serialObj,nCh,'single'); 
                end
                
                movement.moveIndex = read(app.serialObj,1,'uint8');   
                movement.activLevel1 = read(app.serialObj,1,'uint8');
                movement.activLevel2 = read(app.serialObj,1,'uint8');
                movement.activLevel3 = read(app.serialObj,1,'uint8');
                
                string_PredictedMovement = alc.decodeOutIndex(movement.moveIndex);

                 % Update plot
                for feature=1:nFeatures
                    for ch=1:nCh
                        addpoints(app.linesList{ch,feature},timeVector(win),featureData(win,ch,feature));
                    end
                end
               % drawnow limitrate
                 
               app.MovementLabel.Text = string_PredictedMovement;
               app.SpeedLabel.Text = sprintf('Speed motor 1: %i \t Speed motor 2: %i \t Speed motor 3: %i', ...
                                                movement.activLevel1,movement.activLevel2,movement.activLevel3);
            end
            toc
            save('Features.mat','featureData')
            %--------------------------------------------------------------
            % Stop acquisistion
            %--------------------------------------------------------------            
            alc.stopACQ(app.serialObj)  
        end
        

    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            screensize = get( groot, 'Screensize' );
            uiPosition = [screensize(1)+screensize(3)*0.1, screensize(2)+screensize(4)*0.1, ...
                                     screensize(3)*0.8, screensize(4)*0.8];
            
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = uiPosition;
            app.UIFigure.Name = 'Closed Loop Streaming';
            %app.UIFigure.Color = 'white';
                     
            % Create Panel
            app.Panel = uipanel(app.UIFigure);
            app.Panel.Position = [10 50, uiPosition(3)-20 uiPosition(4)-60];
            app.Panel.BackgroundColor = 'white';

            % Create StartButton
            app.StartButton = uibutton(app.UIFigure, 'push');
            app.StartButton.ButtonPushedFcn = createCallbackFcn(app, @startRecording, true);
            app.StartButton.Position = [50 20 100 22];
            app.StartButton.Text = 'Start';

            % Create TimesLabel
            app.TimesLabel = uilabel(app.UIFigure);
            app.TimesLabel.HorizontalAlignment = 'right';
            app.TimesLabel.Position = [175 20 100 22];
            app.TimesLabel.Text = 'Time[s]';

            % Create Time
            app.Time = uieditfield(app.UIFigure, 'numeric');
            app.Time.Position = [225 20 100 22];
            app.Time.Value = 10;
            
            % Create MovementLabel
            app.MovementLabel = uilabel(app.UIFigure);
            app.MovementLabel.FontSize = 14;
            app.MovementLabel.Position = [800 20 100 22];
            app.MovementLabel.Text = 'Rest';

            % Create PredictedmovementLabel
            app.PredictedmovementLabel = uilabel(app.UIFigure);
            app.PredictedmovementLabel.Position = [600 20 200 22];
            app.PredictedmovementLabel.Text = 'Predicted movement:';
            
            % Create SpeedLabel
            app.SpeedLabel = uilabel(app.UIFigure);
            app.SpeedLabel.Position = [1000 20 500 22];
            app.SpeedLabel.Text = sprintf('Speed motor 1: %i \t Speed motor 2: %i \t Speed motor 3: %i', 0,0,0);

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = app_ClosedLoopStream(handles)
            
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
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)
            
            %--------------------------------------------------------------
            % Prepare recording window
            %--------------------------------------------------------------
            alc = ALC();
            % Get current parameters from ALC
            alc.getRecSettings(app.serialObj);
            nCh = alc.numberOfActiveChannels;
            nFeatures = alc.numberOfActiveFeatures;
            
            recordingTime = app.Time.Value;

            app.axesList = cell(nCh,nFeatures);
            app.linesList = cell(nCh,nFeatures);
            
         
            t = tiledlayout(app.Panel,nCh,nFeatures);
            t.TileSpacing = 'compact';
            t.Padding = 'compact';

            for ch=1:nCh
                for feature=1:nFeatures
                    app.axesList{ch,feature} = nexttile(t);
                    if nCh < 8 && feature == 1
                        ylabel(app.axesList{ch,feature},sprintf('Channel %i', alc.activeChannels(ch)));
                        
                    elseif feature ==1
                        ylabel(app.axesList{ch,feature},sprintf('Ch %i', alc.activeChannels(ch)));
   
                    end
                    xlim(app.axesList{ch,feature},[0 recordingTime])
                    app.linesList{ch,feature} = animatedline('Parent', app.axesList{ch,feature});
                    app.linesList{ch,feature}.LineWidth = 2;
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

            %--------------------------------------------------------------
            % Compability for old NCALFit
            %--------------------------------------------------------------

             delete(instrfindall);

            
            delete(app.UIFigure)
        end
    end
end