classdef app_SensorStream < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                matlab.ui.Figure
        StartButton             matlab.ui.control.Button
        TimesLabel              matlab.ui.control.Label
        Time                    matlab.ui.control.NumericEditField
        UIAxes                  matlab.ui.control.UIAxes
        Panel                   matlab.ui.container.Panel
        NumericOutputLabel      matlab.ui.control.Label
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
          
            if 1==alc.handInUse %OBHand
                %nSens = 8; %iff streaming all
                nSens = 5;  %iff streaming the "useful" sensors
            elseif 2==alc.handInUse %MIAHand
                nSens = 9;
            else 
                uialert(app.UIFigure,'No sensors connected that can be streamed out','Error')
                return
            end
            
            %--------------------------------------------------------------
            % Get values needed for plotting
            %--------------------------------------------------------------
            recordingTime = app.Time.Value; 
            nWindows = sF/tWs*recordingTime;
            timeVector = linspace(0,recordingTime,nWindows);
            sensorData = zeros(nWindows,nSens);
            
            %--------------------------------------------------------------
            % Start acquisition and update plots
            %--------------------------------------------------------------
            for sensor=1:nSens
                    clearpoints(app.linesList{1,sensor});
                    xlim(app.axesList{1,sensor},[0 recordingTime])               
            end
            
            alc.startSensoryACQ(app.serialObj)
            
            tic;
            for win = 1:nWindows

               switch alc.handInUse
                    case 1      %OBHand
                        for sensor=1:nSens
                            sensorData(win,sensor) = read(app.serialObj,1,'uint8'); 
                        end
                                                
                    case 2      %MIAhand
                        
                        sensorData(win,:) = read(app.serialObj,nSens,'int16'); %read(app.serialObj,1,'uint8'); 
                        
                        app.NumericOutputLabel.Text = sprintf('Pos Thumb: %i \t\t Pos Index: %i \t\t\t\t Force Thumb: %i \t\t Force Index: %i', ...
                                                        sensorData(win,7),sensorData(win,9),sensorData(win,5),sensorData(win,2))
            
                    otherwise
                        %other
                end
                
                
                % Update plot
                for sensor=1:nSens
                        addpoints(app.linesList{1,sensor},timeVector(win),sensorData(win,sensor));
                end
                drawnow %limitrate
                
                
                
            end
            toc
            
            %--------------------------------------------------------------
            % Stop acquisistion
            %--------------------------------------------------------------            
            alc.stopACQ(app.serialObj)  
            save('SensorStream.mat','sensorData','alc'); 
            
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
            app.UIFigure.Name = 'Sensor Data Streaming';
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
            
            % Create PredictedmovementLabel
            app.NumericOutputLabel = uilabel(app.UIFigure);
            app.NumericOutputLabel.Position = [500 20 700 22];
            app.NumericOutputLabel.Text = sprintf('Pos Thumb: %i \t\t Pos Index: %i \t\t\t\t Force Thumb: %i \t\t Force Index: %i', 0,0,0,0)
            
            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = app_SensorStream(handles)
            
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

            if 1==alc.handInUse %OBHand
                %nSens = 8; %iff streaming all
                %yLabels = ["Ele.Auf", "Ele.Zu", "State", "Bugel", "Pad 1", "Pad 2", "Pad 3", "Strom"];
                nSens = 5;  %iff streaming the "useful" sensors
                yLabels = ["State", "Bugel", "Pad 1", "Pad 2", "Pad 3"];
            elseif 2==alc.handInUse %MIAHand
                nSens = 9;
                yLabels = ["Sens 1", "Sens 2", "Sens 3", "Sens 4", "Sens 5", "Sens 6", "Pos T", "Pos MRL", "Pos I"];
            else
                nSens =0;
                uialert(app.UIFigure,'No sensors connected that can be streamed out','Error')
                return
            end
            
            recordingTime = app.Time.Value;
            
            app.axesList = cell(nSens,1);
            app.linesList = cell(nSens,1);
                     
            t = tiledlayout(app.Panel,nSens,1);
            t.TileSpacing = 'compact';
            t.Padding = 'compact';
            
             %@AS: Make as many axes as you have signals to plot
            for sensor=1:nSens
                    app.axesList{1,sensor} = nexttile(t);

                    ylabel(app.axesList{1,sensor},sprintf(yLabels{sensor})); %make list of sensor names

                    xlim(app.axesList{1,sensor},[0 recordingTime])
                    app.linesList{1,sensor} = animatedline('Parent', app.axesList{1,sensor});
                    app.linesList{1,sensor}.LineWidth = 1;
                
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