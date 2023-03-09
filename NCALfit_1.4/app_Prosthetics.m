classdef app_Prosthetics < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                        matlab.ui.Figure
        TabGroup                        matlab.ui.container.TabGroup
        MainLabel                       matlab.ui.control.Label
        
        
        OttobockHandTab                         matlab.ui.container.Tab
        OB_MovementsListBoxLabel                matlab.ui.control.Label
        OB_MovementsListBox                     matlab.ui.control.ListBox
        OB_MotorSpeedHandLabel                  matlab.ui.control.Label
        OB_MotorSpeedHandEditField              matlab.ui.control.NumericEditField
        OB_MotorSpeedWristLabel                 matlab.ui.control.Label
        OB_MotorSpeedWristEditField             matlab.ui.control.NumericEditField
        OB_MotorSpeedElbowLabel                 matlab.ui.control.Label
        OB_MotorSpeedElbowEditField             matlab.ui.control.NumericEditField
        OB_SaveSettingsButton                   matlab.ui.control.Button
        OB_ExecutemovementButton                matlab.ui.control.Button
        OB_HandSpeedLabel                       matlab.ui.control.Label
        OB_HandMaxSpeedEditField                matlab.ui.control.NumericEditField
        OB_HandMinSpeedEditField                matlab.ui.control.NumericEditField
        OB_WristSpeedLabel                      matlab.ui.control.Label
        OB_WristMinSpeedEditField               matlab.ui.control.NumericEditField
        OB_WristMaxSpeedEditField               matlab.ui.control.NumericEditField
        OB_ElbowSpeedLabel                      matlab.ui.control.Label
        OB_ElbowMinSpeedEditField               matlab.ui.control.NumericEditField
        OB_ElbowMaxSpeedEditField               matlab.ui.control.NumericEditField
        OB_SensitivityLabel                      matlab.ui.control.Label
        OB_SensitivityEditField                 matlab.ui.control.NumericEditField
        OB_MaximumLabel                         matlab.ui.control.Label
        OB_MinimumLabel                         matlab.ui.control.Label
        
        
        MiaHandTab                              matlab.ui.container.Tab
        Mia_MovementsListBoxLabel               matlab.ui.control.Label
        Mia_MovementsListBox                    matlab.ui.control.ListBox
        Mia_MotorSpeedThumbLabel                matlab.ui.control.Label
        Mia_MotorSpeedThumbEditField            matlab.ui.control.NumericEditField
        Mia_MotorSpeedIndexLabel                matlab.ui.control.Label
        Mia_MotorSpeedIndexEditField            matlab.ui.control.NumericEditField
        Mia_MotorSpeedMRLLabel                  matlab.ui.control.Label
        Mia_MotorSpeedMRLEditField              matlab.ui.control.NumericEditField
        Mia_Motor1MinSpeedEditField             matlab.ui.control.NumericEditField
        Mia_Motor2MinSpeedEditField             matlab.ui.control.NumericEditField
        Mia_Motor3MinSpeedEditField             matlab.ui.control.NumericEditField
        Mia_MaximumLabel                        matlab.ui.control.Label
        Mia_MinimumLabel                        matlab.ui.control.Label
        Mia_Motor1Label                         matlab.ui.control.Label
        Mia_Motor1MaxSpeedEditField             matlab.ui.control.NumericEditField
        Mia_Motor2Label                         matlab.ui.control.Label
        Mia_Motor2MaxSpeedEditField             matlab.ui.control.NumericEditField
        Mia_Motor3Label                         matlab.ui.control.Label
        Mia_Motor3MaxSpeedEditField             matlab.ui.control.NumericEditField
        Mia_GraspEnableLabel                    matlab.ui.control.Label
        Mia_GraspEnableEditField                matlab.ui.control.NumericEditField
        Mia_SensitivityLabel                    matlab.ui.control.Label
        Mia_SensitivityEditField                matlab.ui.control.NumericEditField
        Mia_ForceControleEnabledLabel           matlab.ui.control.Label
        Mia_ForceControleEnabledEditField       matlab.ui.control.NumericEditField
        Mia_PWMLabel                            matlab.ui.control.Label
        Mia_PWMEditField                        matlab.ui.control.NumericEditField
        Mia_GraspStepSizeLabel                  matlab.ui.control.Label
        Mia_GraspStepSizeEditField              matlab.ui.control.NumericEditField
        Mia_GraspDiscretizationLabel            matlab.ui.control.Label
        Mia_GraspDiscretizationEditField        matlab.ui.control.NumericEditField
        Mia_SaveSettingsButton                  matlab.ui.control.Button
        Mia_ExecutemovementButton               matlab.ui.control.Button
        Mia_GraspModeLabel                      matlab.ui.control.Label
        Mia_GraspModeDropDown                   matlab.ui.control.DropDown
        
        Mia_SwitchEnableLabel                   matlab.ui.control.Label
        Mia_SwitchTimeLabel                    matlab.ui.control.Label
        Mia_SwitchThresholdLabel                matlab.ui.control.Label
        Mia_SwitchEnableEditField               matlab.ui.control.NumericEditField
        Mia_SwitchTimeEditField                matlab.ui.control.NumericEditField
        Mia_SwitchThresholdEditField            matlab.ui.control.NumericEditField
        
        BeBionicHandTab                         matlab.ui.container.Tab
        
        % User defined properties
        serialObj 
        alc
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: SaveSettingsButton
        function saveSettings_OB(app, ~)
            
            handParam.sensitivity = app.OB_SensitivityEditField.Value;
            handParam.handMinimumSpeed = app.OB_HandMinSpeedEditField.Value;
            handParam.handMaximumSpeed = app.OB_HandMaxSpeedEditField.Value;
            
            handParam.wristMinimumSpeed = app.OB_WristMinSpeedEditField.Value;
            handParam.wristMaximumSpeed = app.OB_WristMaxSpeedEditField.Value;
            
            handParam.elbowMinimumSpeed = app.OB_ElbowMinSpeedEditField.Value;
            handParam.elbowMaximumSpeed = app.OB_ElbowMaxSpeedEditField.Value;
            
            handParam.switchPauseCounter = 0; 
            
            app.alc.setHandControlParameters(app.serialObj,handParam)
            app.MainLabel.Text = 'OB parameters saved';
            
        end
        
        function saveSettings_Mia(app, ~)
            
            handParameters.graspControlMode = find(contains(app.Mia_GraspModeDropDown.Items,app.Mia_GraspModeDropDown.Value));
            handParameters.graspStepSize = app.Mia_GraspStepSizeEditField.Value;
            handParameters.graspDiscretization = app.Mia_GraspDiscretizationEditField.Value;
            handParameters.graspModeEnabled = app.Mia_GraspEnableEditField.Value;
            handParameters.forceControlEnabled = app.Mia_ForceControleEnabledEditField.Value;
            handParameters.holdOpenEnabled = app.Mia_SwitchEnableEditField.Value;
            handParameters.holdOpenTime = app.Mia_SwitchTimeEditField.Value;
            handParameters.holdOpenThreshold = app.Mia_SwitchThresholdEditField.Value;

          
            app.alc.setMiaHandControlParameters(app.serialObj,handParameters)
            app.MainLabel.Text = 'Mia parameters saved';
            
        end
        
        
        function executeMovement_OB(app, ~)
            selectedMovement = app.OB_MovementsListBox.Value;
            if isempty(selectedMovement)
                uialert(app.UIFigure,'Select a movement','Error')
                return
            end
            
            movementStruct.movIndex = app.alc.movementIndex(contains(app.alc.movementNames,selectedMovement));
            
            movementStruct.strength(1) = app.OB_MotorSpeedHandEditField.Value;
            movementStruct.strength(2) = app.OB_MotorSpeedWristEditField.Value;
            movementStruct.strength(3) = app.OB_MotorSpeedElbowEditField.Value;
            
            app.alc.executeMovement(app.serialObj, movementStruct)
            app.MainLabel.Text = 'Movement command sent';
        end
        
        function executeMovement_Mia(app, ~)
            selectedMovement = app.Mia_MovementsListBox.Value;
            if isempty(selectedMovement)
                uialert(app.UIFigure,'Select a movement','Error')
                return
            end
            
            movementStruct.movIndex = app.alc.movementIndex(contains(app.alc.movementNames,selectedMovement));
            
            movementStruct.strength(1) = app.Mia_MotorSpeedThumbEditField.Value;
            movementStruct.strength(2) = app.Mia_MotorSpeedIndexEditField.Value;
            movementStruct.strength(3) = app.Mia_MotorSpeedMRLEditField.Value;
            
            app.alc.executeMovement(app.serialObj, movementStruct)  
            app.MainLabel.Text = 'Movement command sent';
        end
        
        function updateTab(app, ~)
            switch app.TabGroup.SelectedTab.Title
                case 'Mia Hand'
                       % Get up to date parameters
                    app.alc.getMiaHandControlParameters(app.serialObj)
                    
                    app.Mia_GraspModeDropDown.Value = app.Mia_GraspModeDropDown.Items(app.alc.miaParameters.graspControlMode);
                    app.Mia_GraspStepSizeEditField.Value = app.alc.miaParameters.graspStepSize;
                    app.Mia_GraspDiscretizationEditField.Value = app.alc.miaParameters.graspDiscretization;
                    app.Mia_GraspEnableEditField.Value = app.alc.miaParameters.graspModeEnabled;
                    app.Mia_ForceControleEnabledEditField.Value = app.alc.miaParameters.forceControlEnabled;
                    app.Mia_SwitchEnableEditField.Value = app.alc.miaParameters.holdOpenEnabled;
                    app.Mia_SwitchTimeEditField.Value = app.alc.miaParameters.holdOpenTime;
                    app.Mia_SwitchThresholdEditField.Value = app.alc.miaParameters.holdOpenThreshold;
            end
            
        end
        
        function updateGUI(app, ~)
            switch app.alc.handInUse
                case {0,1} % Generic or Ottobock hand
                    app.TabGroup.SelectedTab = app.OttobockHandTab;
                    app.OB_MovementsListBox.Items = app.alc.movementNamesOB;
                    app.OB_HandMaxSpeedEditField.Value = app.alc.handMaximumSpeed;
                    app.OB_HandMinSpeedEditField.Value = app.alc.handMinimumSpeed;
                    app.OB_WristMaxSpeedEditField.Value = app.alc.wristMaximumSpeed;
                    app.OB_WristMinSpeedEditField.Value = app.alc.wristMinimumSpeed;
                    app.OB_ElbowMaxSpeedEditField.Value = app.alc.elbowMaximumSpeed;
                    app.OB_ElbowMinSpeedEditField.Value = app.alc.elbowMinimumSpeed;
                    app.OB_SensitivityEditField.Value = app.alc.sensitivity;
                case 2 % Mia hand 
                    app.TabGroup.SelectedTab = app.MiaHandTab;
                    app.Mia_MovementsListBox.Items = app.alc.movementNamesMia;
                    
                    % Get up to date parameters
                    app.alc.getMiaHandControlParameters(app.serialObj)
                    
                    app.Mia_GraspModeDropDown.Value = app.Mia_GraspModeDropDown.Items(app.alc.miaParameters.graspControlMode);
                    app.Mia_GraspStepSizeEditField.Value = app.alc.miaParameters.graspStepSize;
                    app.Mia_GraspDiscretizationEditField.Value = app.alc.miaParameters.graspDiscretization;
                    app.Mia_GraspEnableEditField.Value = app.alc.miaParameters.graspModeEnabled;
                    app.Mia_ForceControleEnabledEditField.Value = app.alc.miaParameters.forceControlEnabled;
                    app.Mia_SwitchEnableEditField.Value = app.alc.miaParameters.holdOpenEnabled;
                    app.Mia_SwitchTimeEditField.Value = app.alc.miaParameters.holdOpenTime;
                    app.Mia_SwitchThresholdEditField.Value = app.alc.miaParameters.holdOpenThreshold;
                    
                    
            end
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 964 443];
            app.UIFigure.Name = 'Prosthetics Settings';
            
            % Create Main label
            app.MainLabel = uilabel(app.UIFigure);
            app.MainLabel.HorizontalAlignment = 'center';
            app.MainLabel.Position = [300 10 400 22];
            app.MainLabel.Text = '';
            app.MainLabel.FontSize = 14;

            % Create TabGroup
            app.TabGroup = uitabgroup(app.UIFigure);
            app.TabGroup.SelectionChangedFcn = createCallbackFcn(app, @updateTab, true);
            app.TabGroup.Position = [40 40 860 392];

            % Create OttobockHandTab
            app.OttobockHandTab = uitab(app.TabGroup);
            app.OttobockHandTab.Title = 'Ottobock Hand';

            % Create HandspeedEditFieldLabel
            app.OB_HandSpeedLabel = uilabel(app.OttobockHandTab);
            app.OB_HandSpeedLabel.Position = [530 298 71 22];
            app.OB_HandSpeedLabel.Text = 'Hand speed';

            % Create HandspeedEditField
            app.OB_HandMaxSpeedEditField = uieditfield(app.OttobockHandTab, 'numeric');
            app.OB_HandMaxSpeedEditField.Position = [625 298 100 22];

            % Create HandMinspeedEditField
            app.OB_HandMinSpeedEditField = uieditfield(app.OttobockHandTab, 'numeric');
            app.OB_HandMinSpeedEditField.Position = [727 298 100 22];

            % Create MovementsListBoxLabel
            app.OB_MovementsListBoxLabel = uilabel(app.OttobockHandTab);
            app.OB_MovementsListBoxLabel.Position = [32 306 119 22];
            app.OB_MovementsListBoxLabel.Text = 'Movements';

            % Create MovementsListBox
            app.OB_MovementsListBox = uilistbox(app.OttobockHandTab);
            app.OB_MovementsListBox.Items = {};
            app.OB_MovementsListBox.Position = [32 96 119 201];
            app.OB_MovementsListBox.Value = {};

            % Create MotorSpeedOpenclosehandEditFieldLabel
            app.OB_MotorSpeedHandLabel = uilabel(app.OttobockHandTab);
            app.OB_MotorSpeedHandLabel.Position = [190 292 104 28];
            app.OB_MotorSpeedHandLabel.Text = {'Motor Speed % '; '(Open/close hand)'};

            % Create MotorSpeedOpenclosehandEditField
            app.OB_MotorSpeedHandEditField = uieditfield(app.OttobockHandTab, 'numeric');
            app.OB_MotorSpeedHandEditField.Limits = [0 100];
            app.OB_MotorSpeedHandEditField.Position = [259 261 100 22];
            app.OB_MotorSpeedHandEditField.Value = 30;

            % Create MotorSpeedSupinationPronationEditFieldLabel
            app.OB_MotorSpeedWristLabel = uilabel(app.OttobockHandTab);
            app.OB_MotorSpeedWristLabel.Position = [190 207 125 28];
            app.OB_MotorSpeedWristLabel.Text = {'Motor Speed % '; '(Supination/Pronation)'};

            % Create MotorSpeedSupinationPronationEditField
            app.OB_MotorSpeedWristEditField = uieditfield(app.OttobockHandTab, 'numeric');
            app.OB_MotorSpeedWristEditField.Limits = [0 100];
            app.OB_MotorSpeedWristEditField.Position = [259 176 100 22];
            app.OB_MotorSpeedWristEditField.Value = 30;

            % Create MotorSpeedFlexExtendElbowLabel
            app.OB_MotorSpeedElbowLabel = uilabel(app.OttobockHandTab);
            app.OB_MotorSpeedElbowLabel.Position = [190 127 112 28];
            app.OB_MotorSpeedElbowLabel.Text = {'Motor Speed %'; '(Flex/Extend Elbow)'};

            % Create MotorSpeedFlexExtendElbowEditField
            app.OB_MotorSpeedElbowEditField = uieditfield(app.OttobockHandTab, 'numeric');
            app.OB_MotorSpeedElbowEditField.Limits = [0 100];
            app.OB_MotorSpeedElbowEditField.Position = [259 96 100 22];
            app.OB_MotorSpeedElbowEditField.Value = 30;

            % Create SaveSettingsButton
            app.OB_SaveSettingsButton = uibutton(app.OttobockHandTab, 'push');
            app.OB_SaveSettingsButton.ButtonPushedFcn = createCallbackFcn(app, @saveSettings_OB, true);
            app.OB_SaveSettingsButton.Position = [635 12 194 32];
            app.OB_SaveSettingsButton.Text = 'Save Settings';

            % Create ExecutemovementButton
            app.OB_ExecutemovementButton = uibutton(app.OttobockHandTab, 'push');
            app.OB_ExecutemovementButton.ButtonPushedFcn = createCallbackFcn(app, @executeMovement_OB, true);
            app.OB_ExecutemovementButton.Position = [165 12 194 32];
            app.OB_ExecutemovementButton.Text = 'Execute movement';

            % Create WristspeedEditFieldLabel
            app.OB_WristSpeedLabel = uilabel(app.OttobockHandTab);
            app.OB_WristSpeedLabel.Position = [530 273 69 22];
            app.OB_WristSpeedLabel.Text = 'Wrist speed';

            % Create WristspeedEditField
            app.OB_WristMinSpeedEditField = uieditfield(app.OttobockHandTab, 'numeric');
            app.OB_WristMinSpeedEditField.Position = [727 273 100 22];

            % Create WristMaxspeedEditField
            app.OB_WristMaxSpeedEditField = uieditfield(app.OttobockHandTab, 'numeric');
            app.OB_WristMaxSpeedEditField.Position = [625 273 100 22];

            % Create ElbowspeedEditFieldLabel
            app.OB_ElbowSpeedLabel = uilabel(app.OttobockHandTab);
            app.OB_ElbowSpeedLabel.Position = [530 248 75 22];
            app.OB_ElbowSpeedLabel.Text = 'Elbow speed';

            % Create ElbowspeedEditField
            app.OB_ElbowMinSpeedEditField = uieditfield(app.OttobockHandTab, 'numeric');
            app.OB_ElbowMinSpeedEditField.Position = [727 248 100 22];

            % Create ElbowMaxspeedEditField
            app.OB_ElbowMaxSpeedEditField = uieditfield(app.OttobockHandTab, 'numeric');
            app.OB_ElbowMaxSpeedEditField.Position = [625 248 100 22];

            % Create SensitivityEditFieldLabel
            app.OB_SensitivityLabel = uilabel(app.OttobockHandTab);
            app.OB_SensitivityLabel.Position = [530 215 60 22];
            app.OB_SensitivityLabel.Text = 'Sensitivity';

            % Create SensitivityEditField
            app.OB_SensitivityEditField = uieditfield(app.OttobockHandTab, 'numeric');
            app.OB_SensitivityEditField.Position = [727 215 100 22];

            % Create MaximumLabel
            app.OB_MaximumLabel = uilabel(app.OttobockHandTab);
            app.OB_MaximumLabel.Position = [650 327 58 22];
            app.OB_MaximumLabel.Text = 'Maximum';

            % Create MinimumLabel
            app.OB_MinimumLabel = uilabel(app.OttobockHandTab);
            app.OB_MinimumLabel.Position = [748 327 55 22];
            app.OB_MinimumLabel.Text = 'Minimum';

            % Create MiaHandTab
            app.MiaHandTab = uitab(app.TabGroup);
            app.MiaHandTab.Title = 'Mia Hand';

            % Create MovementsListBox_2Label
            app.Mia_MovementsListBoxLabel = uilabel(app.MiaHandTab);
            app.Mia_MovementsListBoxLabel.Position = [32 306 119 22];
            app.Mia_MovementsListBoxLabel.Text = 'Movements';

            % Create MovementsListBox_2
            app.Mia_MovementsListBox = uilistbox(app.MiaHandTab);
            app.Mia_MovementsListBox.Items = {};
            app.Mia_MovementsListBox.Position = [32 96 119 201];
            app.Mia_MovementsListBox.Value = {};

            % Create MotorSpeedFlexExtendThumbEditFieldLabel
            app.Mia_MotorSpeedThumbLabel = uilabel(app.MiaHandTab);
            app.Mia_MotorSpeedThumbLabel.Position = [190 292 116 28];
            app.Mia_MotorSpeedThumbLabel.Text = {'Motor Speed % '; '(Flex/Extend Thumb)'};

            % Create MotorSpeedFlexExtendThumbEditField
            app.Mia_MotorSpeedThumbEditField = uieditfield(app.MiaHandTab, 'numeric');
            app.Mia_MotorSpeedThumbEditField.Limits = [0 100];
            app.Mia_MotorSpeedThumbEditField.Position = [259 261 100 22];
            app.Mia_MotorSpeedThumbEditField.Value = 30;

            % Create MotorSpeedFlexExtendIndexEditFieldLabel
            app.Mia_MotorSpeedIndexLabel = uilabel(app.MiaHandTab);
            app.Mia_MotorSpeedIndexLabel.Position = [190 207 108 28];
            app.Mia_MotorSpeedIndexLabel.Text = {'Motor Speed % '; '(Flex/Extend Index)'};

            % Create MotorSpeedFlexExtendIndexEditField
            app.Mia_MotorSpeedIndexEditField = uieditfield(app.MiaHandTab, 'numeric');
            app.Mia_MotorSpeedIndexEditField.Limits = [0 100];
            app.Mia_MotorSpeedIndexEditField.Position = [259 176 100 22];
            app.Mia_MotorSpeedIndexEditField.Value = 30;

            % Create MotorSpeedFlexExtendMRLEditFieldLabel
            app.Mia_MotorSpeedMRLLabel = uilabel(app.MiaHandTab);
            app.Mia_MotorSpeedMRLLabel.Position = [190 127 104 28];
            app.Mia_MotorSpeedMRLLabel.Text = {'Motor Speed %'; '(Flex/Extend MRL)'};

            % Create MotorSpeedFlexExtendMRLEditField
            app.Mia_MotorSpeedMRLEditField = uieditfield(app.MiaHandTab, 'numeric');
            app.Mia_MotorSpeedMRLEditField.Limits = [0 100];
            app.Mia_MotorSpeedMRLEditField.Position = [259 96 100 22];
            app.Mia_MotorSpeedMRLEditField.Value = 30;

           
            % Mia_SwitchEnableLabel
            app.Mia_SwitchEnableLabel = uilabel(app.MiaHandTab);
            app.Mia_SwitchEnableLabel.Position = [530 298 170 22];
            app.Mia_SwitchEnableLabel.Text = 'Open Switch Enable';

            %Create Mia_SwitchEnableEditField 
            app.Mia_SwitchEnableEditField = uieditfield(app.MiaHandTab, 'numeric');
            app.Mia_SwitchEnableEditField.Position = [727 298 100 22];
            app.Mia_SwitchEnableEditField.Value = 1;
            
            % Mia_SwitchTimeLabel
            app.Mia_SwitchTimeLabel = uilabel(app.MiaHandTab);
            app.Mia_SwitchTimeLabel.Position = [530 273 170 22];
            app.Mia_SwitchTimeLabel.Text = 'Open Switch Time';

            % Create Mia_SwitchTimeEditField
            app.Mia_SwitchTimeEditField = uieditfield(app.MiaHandTab, 'numeric');
            app.Mia_SwitchTimeEditField.Position = [727 273 100 22];
            app.Mia_SwitchTimeEditField.Value = 20;

            % Create Mia_SwitchThresholdLabel
            app.Mia_SwitchThresholdLabel = uilabel(app.MiaHandTab);
            app.Mia_SwitchThresholdLabel.Position = [530 248 170 22];
            app.Mia_SwitchThresholdLabel.Text = 'Open Switch Threshold';

            % Create Mia_SwitchThresholdEditField
            app.Mia_SwitchThresholdEditField = uieditfield(app.MiaHandTab, 'numeric');
            app.Mia_SwitchThresholdEditField.Position = [727 248 100 22];
            app.Mia_SwitchThresholdEditField.Value = 50;
             

            % Create GraspEnableOnOffEditFieldLabel
            app.Mia_GraspEnableLabel = uilabel(app.MiaHandTab);
            app.Mia_GraspEnableLabel.Position = [530 160 124 22];
            app.Mia_GraspEnableLabel.Text = 'Grasp Enable [On/Off]';

            % Create GraspEnableOnOffEditField
            app.Mia_GraspEnableEditField = uieditfield(app.MiaHandTab, 'numeric');
            app.Mia_GraspEnableEditField.Position = [727 160 100 22];
            app.Mia_GraspEnableEditField.Limits = [0 1];



            % Create Mia_ForceControleEnabledLabel
            app.Mia_ForceControleEnabledLabel = uilabel(app.MiaHandTab);
            app.Mia_ForceControleEnabledLabel.Position = [530 131 170 22];
            app.Mia_ForceControleEnabledLabel.Text = 'Force Controle Enable [On/Off]';

            % Create Mia_ForceControleEnabledEditField
            app.Mia_ForceControleEnabledEditField = uieditfield(app.MiaHandTab, 'numeric');
            app.Mia_ForceControleEnabledEditField.Position = [727 131 100 22];
            app.Mia_ForceControleEnabledEditField.Limits = [0 1];

     

            % Create Mia_GraspStepSizeLabel
            app.Mia_GraspStepSizeLabel = uilabel(app.MiaHandTab);
            app.Mia_GraspStepSizeLabel.Position = [530 103 96 22];
            app.Mia_GraspStepSizeLabel.Text = 'Grasp Step Size';

            % Create Mia_GraspStepSizeEditField
            app.Mia_GraspStepSizeEditField = uieditfield(app.MiaHandTab, 'numeric');
            app.Mia_GraspStepSizeEditField.Position = [727 103 100 22];
            app.Mia_GraspStepSizeEditField.Value = 3;

            % Mia_GraspDiscretizationLabel
            app.Mia_GraspDiscretizationLabel = uilabel(app.MiaHandTab);
            app.Mia_GraspDiscretizationLabel.Position = [530 77 114 22];
            app.Mia_GraspDiscretizationLabel.Text = 'Grasp Discretization';

            % Create Mia_GraspDiscretizationEditField
            app.Mia_GraspDiscretizationEditField = uieditfield(app.MiaHandTab, 'numeric');
            app.Mia_GraspDiscretizationEditField.Position = [727 77 100 22];
            app.Mia_GraspDiscretizationEditField.Value = 10;

            % Create Mia_SaveSettingsButton
            app.Mia_SaveSettingsButton = uibutton(app.MiaHandTab, 'push');
            app.Mia_SaveSettingsButton.ButtonPushedFcn = createCallbackFcn(app, @saveSettings_Mia, true);
            app.Mia_SaveSettingsButton.Position = [635 12 194 32];
            app.Mia_SaveSettingsButton.Text = 'Save Settings';

            % Create ExecutemovementButton_2
            app.Mia_ExecutemovementButton = uibutton(app.MiaHandTab, 'push');
            app.Mia_ExecutemovementButton.ButtonPushedFcn = createCallbackFcn(app, @executeMovement_Mia, true);
            app.Mia_ExecutemovementButton.Position = [165 12 194 32];
            app.Mia_ExecutemovementButton.Text = 'Execute movement';

            % Create GraspModeDropDownLabel
            app.Mia_GraspModeLabel = uilabel(app.MiaHandTab);
            app.Mia_GraspModeLabel.Position = [530 53 72 22];
            app.Mia_GraspModeLabel.Text = 'Grasp Mode';

            % Create Mia_GraspModeDropDown
            app.Mia_GraspModeDropDown = uidropdown(app.MiaHandTab);
            app.Mia_GraspModeDropDown.Items = {'Position', 'Speed', 'Unidirectional'};
            app.Mia_GraspModeDropDown.Position = [699 53 128 22];
            app.Mia_GraspModeDropDown.Value = 'Speed';

            % Create BeBionicHandTab
            app.BeBionicHandTab = uitab(app.TabGroup);
            app.BeBionicHandTab.Title = 'BeBionic Hand';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = app_Prosthetics(handles)

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
            % Get ALC parameters
            %--------------------------------------------------------------
            app.alc = ALC();
            app.alc.getRecSettings(app.serialObj);
            app.alc.getStatus(app.serialObj);
            app.alc.getMiaHandControlParameters(app.serialObj);

            app.updateGUI();
            
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