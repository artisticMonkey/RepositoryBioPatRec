classdef app_Status < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                    matlab.ui.Figure
        
        SignalAqcuisitionLabel      matlab.ui.control.Label
        SignalProcessingLabel       matlab.ui.control.Label
        FeatureProcessingLabel      matlab.ui.control.Label
        ControlLabel                matlab.ui.control.Label
        StimulationLabel            matlab.ui.control.Label
        VariousLabel                matlab.ui.control.Label
        
        SignalAqcuisitionUITable    matlab.ui.control.Table
        SignalProcessingUITable     matlab.ui.control.Table
        FeatureProcessingUITable    matlab.ui.control.Table
        ControlUITable              matlab.ui.control.Table
        StimulationUITable          matlab.ui.control.Table
        VariousUITable              matlab.ui.control.Table
        
        % User defined properties
        serialObj 
        alc
    end

    % Component initialization
    methods (Access = private)
        
        function updateSignalAqcuisitionParameter(app, ~)
            
            % Create output struct for cleaner handling of names and values
            s.samplingFrequency = app.alc.samplingFrequency;
            s.samplesPerWindow = app.alc.timeWindowSamples;
            s.overlappingSamplesPerWindow = app.alc.overlappingSamples;
            s.numberOfActiveChannels = app.alc.numberOfActiveChannels;
            s.activeChannels = string(num2str(app.alc.activeChannels));
            s.compressionEnabled = app.alc.compressionEnable;

            t = rows2vars(struct2table(s));
            app.SignalAqcuisitionUITable.Data = t;
        end
        
        function updateSignalProcessingParameter(app, ~)
            
            % Create output struct for cleaner handling of names and values
            s.notchFilterEnable = app.alc.filterEnable;
            s.combFilterEnable = app.alc.combFilterEnable;
            s.combFilterOrder =  app.alc.combFilterOrder;
            s.differenceFilterEnable = app.alc.differenceFilterEnable;
            s.maskEnable = app.alc.maskEnable;
            s.featureCombinationEnable = app.alc.featureCombinationEnable;
            s.artifactRemovalEnable = app.alc.nsArtifactRemovalEnable;
            s.artifactRemovalStimChannel = app.alc.nsArtifactRemovalStimChannel;

            t = rows2vars(struct2table(s));
            app.SignalProcessingUITable.Data = t;
        end
        
        function updateFeatureProcessingParameter(app, ~)
            
            % Create output struct for cleaner handling of names and values
            s.numberOfActiveFeatures = app.alc.numberOfActiveFeatures;
            
            index = nonzeros(app.alc.featuresEnabled.*[1 2 3 4 5]);
            s.activeFeatures = join(string(app.alc.featureNames(index)),", ");
            
            t = rows2vars(struct2table(s));
            app.FeatureProcessingUITable.Data = t;
        end
        
        function updateControlParameter(app, ~)
            
            % Create output struct for cleaner handling of names and values
            s.controlMode = string(app.alc.controlModeName{app.alc.controlMode+1});
            s.controlAlgorithm = string(app.alc.controlAlgorithmNames{app.alc.controlAlgorithm+1});
            s.thresholdRatioEnable = app.alc.thresholdRatioEnable;
            s.strengthFilter = app.alc.proportionalParameters.strengthFilterLength;
            s.holdOpenEnabled = app.alc.miaParameters.holdOpenEnabled;
            s.handSwitchMode = app.alc.handSwitchMode;   
            s.handMinimumSpeed = app.alc.handMinimumSpeed;      
            s.handMaximumSpeed = app.alc.handMaximumSpeed;   
            s.wristMinimumSpeed = app.alc.wristMinimumSpeed; 
            s.wristMaximumSpeed = app.alc.wristMaximumSpeed;
            s.elbowMinimumSpeed = app.alc.elbowMinimumSpeed;
            s.elbowMaximumSpeed = app.alc.elbowMaximumSpeed; 
            
            t = rows2vars(struct2table(s));
            app.ControlUITable.Data = t;
        end
        
        function updateStimulationParameter(app, ~)
            
            % Create output struct for cleaner handling of names and values
            s.stimulationEnabled = app.alc.nsEnable;
            s.mode = string(app.alc.stimulationModeName{app.alc.stimParameters.mode+1});
            s.DESCEnabled = app.alc.stimParameters.DESCenable;
            s.channel = app.alc.stimParameters.channel;
            s.amplitude = app.alc.stimParameters.amplitude;
            s.pulseWidth = app.alc.stimParameters.pulseWidth;
            s.frequency = app.alc.stimParameters.frequency;
            s.nPulses = app.alc.stimParameters.repetitions;
                
                
            
            t = rows2vars(struct2table(s));
            app.StimulationUITable.Data = t;
        end
        
        function updateVariousParameter(app, ~)
            
            % Create output struct for cleaner handling of names and values
            s.handInUse = string(app.alc.handNames{app.alc.handInUse+1});
            s.SDcardPresent = app.alc.sdCard;
            s.batteryVoltage = app.alc.vBattery;
            s.temperature = app.alc.temperature;
            
            t = rows2vars(struct2table(s));
            app.VariousUITable.Data = t;
        end
        

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 969 835];
            app.UIFigure.Name = 'Current ALC Satus';

            % Create SignalaqcuisitionparametersLabel
            app.SignalAqcuisitionLabel = uilabel(app.UIFigure);
            app.SignalAqcuisitionLabel.FontSize = 15;
            app.SignalAqcuisitionLabel.Position = [44 772 205 22];
            app.SignalAqcuisitionLabel.Text = 'Signal aqcuisition parameters';

            % Create SignalProcessingLabel
            app.SignalProcessingLabel = uilabel(app.UIFigure);
            app.SignalProcessingLabel.FontSize = 15;
            app.SignalProcessingLabel.Position = [44 506 207 22];
            app.SignalProcessingLabel.Text = 'Signal processing parameters';

            % Create FeatreProcessingLabel
            app.FeatureProcessingLabel = uilabel(app.UIFigure);
            app.FeatureProcessingLabel.FontSize = 15;
            app.FeatureProcessingLabel.Position = [44 238 215 22];
            app.FeatureProcessingLabel.Text = 'Feature processing parameters';

            % Create ControlparametersLabel
            app.ControlLabel = uilabel(app.UIFigure);
            app.ControlLabel.FontSize = 15;
            app.ControlLabel.Position = [517 772 135 22];
            app.ControlLabel.Text = 'Control parameters';

            % Create StimulationLabel
            app.StimulationLabel = uilabel(app.UIFigure);
            app.StimulationLabel.FontSize = 15;
            app.StimulationLabel.Position = [517 506 161 22];
            app.StimulationLabel.Text = 'Stimulation parameters';

            % Create VariousLabel
            app.VariousLabel = uilabel(app.UIFigure);
            app.VariousLabel.FontSize = 15;
            app.VariousLabel.Position = [517 238 135 22];
            app.VariousLabel.Text = 'Various parameters';
            
            % Create SignalAqcuisitionUITable
            app.SignalAqcuisitionUITable = uitable(app.UIFigure);
            app.SignalAqcuisitionUITable.ColumnName = {'Variable Name'; 'Value'};
            app.SignalAqcuisitionUITable.RowName = {};
            app.SignalAqcuisitionUITable.Position = [44 567 408 185];
            
            % Create SignalProcessingUITable _2
            app.SignalProcessingUITable  = uitable(app.UIFigure);
            app.SignalProcessingUITable .ColumnName = {'Variable Name'; 'Value'};
            app.SignalProcessingUITable .RowName = {};
            app.SignalProcessingUITable .Position = [44 301 408 185];

            % Create FeatureProcessingUITable 
            app.FeatureProcessingUITable  = uitable(app.UIFigure);
            app.FeatureProcessingUITable .ColumnName = {'Variable Name'; 'Value'};
            app.FeatureProcessingUITable .RowName = {};
            app.FeatureProcessingUITable .Position = [44 36 408 185];

            % Create ControlUITable 
            app.ControlUITable  = uitable(app.UIFigure);
            app.ControlUITable .ColumnName = {'Variable Name'; 'Value'};
            app.ControlUITable .RowName = {};
            app.ControlUITable .Position = [517 566 408 185];

            % Create StimulationUITable 
            app.StimulationUITable  = uitable(app.UIFigure);
            app.StimulationUITable .ColumnName = {'Variable Name'; 'Value'};
            app.StimulationUITable .RowName = {};
            app.StimulationUITable .Position = [517 300 408 185];

            % Create VariousUITable 
            app.VariousUITable  = uitable(app.UIFigure);
            app.VariousUITable .ColumnName = {'Variable Name'; 'Value'};
            app.VariousUITable .RowName = {};
            app.VariousUITable .Position = [517 35 408 185];

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = app_Status(handles)
            
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
            % Create status display
            %--------------------------------------------------------------
            app.alc = ALC();
            
            % Get current parameters from ALC
            app.alc.getAllParameters(app.serialObj);
            
            app.updateSignalAqcuisitionParameter();
            app.updateSignalProcessingParameter();
            app.updateFeatureProcessingParameter();
            app.updateControlParameter();
            app.updateStimulationParameter();
            app.updateVariousParameter();
            
            %--------------------------------------------------------------
            % Clean up
            %--------------------------------------------------------------
            delete(app.serialObj);
            if nargout == 0
                clear app
            end
            
        end

        % Code that executes before app deletion
        function delete(app)
            
            %--------------------------------------------------------------
            % Compability for old NCALFit
            %--------------------------------------------------------------

%             delete(instrfindall);

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end