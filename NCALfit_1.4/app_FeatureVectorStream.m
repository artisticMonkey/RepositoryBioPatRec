classdef app_FeatureVectorStream < matlab.apps.AppBase

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
            alc.getNNParameters(app.serialObj);
            
             % Activate streaming
            alc.NNCoefficients.streamEnable = 1;
            alc.setNNParameters(app.serialObj,alc.NNCoefficients)
            
            nClasses = alc.NNCoefficients.nActiveClasses;
                     
            sF = alc.samplingFrequency;
            tWs = alc.timeWindowSamples;
            
            
            %--------------------------------------------------------------
            % Get values needed for plotting
            %--------------------------------------------------------------
            recordingTime = app.Time.Value; 
            nWindows = sF/tWs*recordingTime;
            timeVector = linspace(0,recordingTime,nWindows);       
            outputVector = zeros(nWindows, nClasses);
            outputStrength = zeros(nWindows, 3);
            outputMAV = zeros(nWindows,1);
            
            %--------------------------------------------------------------
            % Start acquisition and update plots
            %--------------------------------------------------------------
            for class=1:nClasses+1
            	clearpoints(app.linesList{class,1});
            	xlim(app.axesList{class,1},[0 recordingTime])
            end

            alc.setControlMode(app.serialObj)
            
            tic;
            for win = 1:nWindows
                % Receive ALC Data
                
                outputVector(win,:) = read(app.serialObj,nClasses,'single'); 

                outputIndex = read(app.serialObj,1,'uint8'); 
                
                outputStrength(win,:) = read(app.serialObj,3,'uint8'); 
                
                outputMAV(win,:) = read(app.serialObj,1,'single'); 
                
                string_PredictedMovement = alc.decodeOutIndex(outputIndex);

                 % Update plot
                for class=1:nClasses
                        addpoints(app.linesList{class,1},timeVector(win),outputVector(win,class));
                end
                
                addpoints(app.linesList{end,1},timeVector(win),outputMAV(win));
               % drawnow limitrate
                 
               app.MovementLabel.Text = string_PredictedMovement;
               
               app.SpeedLabel.Text = sprintf('Speed motor 1: %i \t Speed motor 2: %i \t Speed motor 3: %i', ...
                                                outputStrength(win,1),outputStrength(win,2),outputStrength(win,3));
               
            end
            toc
            
            
            
            %--------------------------------------------------------------
            % Stop acquisistion
            %--------------------------------------------------------------            
            alc.setCommandMode(app.serialObj)
            
             % Activate streaming
            alc.NNCoefficients.streamEnable = 0;
            alc.setNNParameters(app.serialObj,alc.NNCoefficients)
            
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
        function app = app_FeatureVectorStream(handles)
            
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
            alc.getNNParameters(app.serialObj);
                        
            nClasses = alc.NNCoefficients.nActiveClasses;
            
            recordingTime = app.Time.Value;

            app.axesList = cell(nClasses+1,1);
            app.linesList = cell(nClasses+1,1);
            
         
            t = tiledlayout(app.Panel,nClasses+1,1);
            t.TileSpacing = 'compact';
            t.Padding = 'compact';

            for class=1:nClasses
                app.axesList{class,1} = nexttile(t);
                outIndex = alc.NNCoefficients.prostheticOutput(class);
                movementName = alc.decodeOutIndex(outIndex);
                if contains(movementName, '+')
                    movementName = strsplit(movementName{:},'+');
                end
                ylabel(app.axesList{class,1},movementName);
                
                ylim(app.axesList{class,1},[-0.1 1.1])
                yticks(app.axesList{class,1},[0 0.25 0.5 0.75 1])
                xlim(app.axesList{class,1},[0 recordingTime])
                app.linesList{class,1} = animatedline('Parent', app.axesList{class,1});
                app.linesList{class,1}.LineWidth = 2;
                
            end
            
            app.axesList{end,1} = nexttile(t);
            ylabel(app.axesList{end,1},'meanMAV');
            xlim(app.axesList{end,1},[0 recordingTime])
            app.linesList{end,1} = animatedline('Parent', app.axesList{end,1}, 'Color',[0 0.4470 0.7410]);
            app.linesList{end,1}.LineWidth = 2;
            


            
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