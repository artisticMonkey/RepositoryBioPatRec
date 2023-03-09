classdef app_ExtraChannels < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure            matlab.ui.Figure
        GridLayout          matlab.ui.container.GridLayout
        LeftPanel           matlab.ui.container.Panel
        LoadFromFileButton  matlab.ui.control.Button
        SaveToFileButton    matlab.ui.control.Button
        ResetMatrixButton   matlab.ui.control.Button
        WriteButton         matlab.ui.control.Button
        ReadButton          matlab.ui.control.Button
        RightPanel          matlab.ui.container.Panel

        Channel17Label      matlab.ui.control.Label
        Channel18Label      matlab.ui.control.Label
        Channel19Label      matlab.ui.control.Label
        Channel20Label      matlab.ui.control.Label
        Channel21Label      matlab.ui.control.Label
        Channel22Label      matlab.ui.control.Label
        Channel23Label      matlab.ui.control.Label
        Channel24Label      matlab.ui.control.Label
        Ch1coeffLabel       matlab.ui.control.Label
        Ch2coeffLabel       matlab.ui.control.Label
        Ch3coeffLabel       matlab.ui.control.Label
        Ch4coeffLabel       matlab.ui.control.Label
        Ch5coeffLabel       matlab.ui.control.Label
        Ch6coeffLabel       matlab.ui.control.Label
        Ch7coeffLabel       matlab.ui.control.Label
        Ch8coeffLabel       matlab.ui.control.Label
        Ch9coeffLabel       matlab.ui.control.Label
        Ch10coeffLabel      matlab.ui.control.Label
        Ch11coeffLabel      matlab.ui.control.Label
        Ch12coeffLabel      matlab.ui.control.Label
        Ch13coeffLabel      matlab.ui.control.Label
        Ch14coeffLabel      matlab.ui.control.Label
        Ch15coeffLabel      matlab.ui.control.Label
        Ch16coeffLabel      matlab.ui.control.Label
        
        EditField_1           matlab.ui.control.NumericEditField
        EditField_2         matlab.ui.control.NumericEditField
        EditField_3         matlab.ui.control.NumericEditField
        EditField_4         matlab.ui.control.NumericEditField
        EditField_5         matlab.ui.control.NumericEditField
        EditField_6         matlab.ui.control.NumericEditField
        EditField_7         matlab.ui.control.NumericEditField
        EditField_8         matlab.ui.control.NumericEditField
        EditField_9         matlab.ui.control.NumericEditField
        EditField_10        matlab.ui.control.NumericEditField
        EditField_11        matlab.ui.control.NumericEditField
        EditField_12        matlab.ui.control.NumericEditField
        EditField_13        matlab.ui.control.NumericEditField
        EditField_14        matlab.ui.control.NumericEditField
        EditField_15        matlab.ui.control.NumericEditField
        EditField_16        matlab.ui.control.NumericEditField
        EditField_17        matlab.ui.control.NumericEditField
        EditField_18        matlab.ui.control.NumericEditField
        EditField_19        matlab.ui.control.NumericEditField
        EditField_20        matlab.ui.control.NumericEditField
        EditField_21        matlab.ui.control.NumericEditField
        EditField_22        matlab.ui.control.NumericEditField
        EditField_23        matlab.ui.control.NumericEditField
        EditField_24        matlab.ui.control.NumericEditField
        EditField_25        matlab.ui.control.NumericEditField
        EditField_26        matlab.ui.control.NumericEditField
        EditField_27        matlab.ui.control.NumericEditField
        EditField_28        matlab.ui.control.NumericEditField
        EditField_29        matlab.ui.control.NumericEditField
        EditField_30        matlab.ui.control.NumericEditField
        EditField_31        matlab.ui.control.NumericEditField
        EditField_32        matlab.ui.control.NumericEditField
        EditField_33        matlab.ui.control.NumericEditField
        EditField_34        matlab.ui.control.NumericEditField
        EditField_35        matlab.ui.control.NumericEditField
        EditField_36        matlab.ui.control.NumericEditField
        EditField_37        matlab.ui.control.NumericEditField
        EditField_38        matlab.ui.control.NumericEditField
        EditField_39        matlab.ui.control.NumericEditField
        EditField_40        matlab.ui.control.NumericEditField
        EditField_41        matlab.ui.control.NumericEditField
        EditField_42        matlab.ui.control.NumericEditField
        EditField_43        matlab.ui.control.NumericEditField
        EditField_44        matlab.ui.control.NumericEditField
        EditField_45        matlab.ui.control.NumericEditField
        EditField_46        matlab.ui.control.NumericEditField
        EditField_47        matlab.ui.control.NumericEditField
        EditField_48        matlab.ui.control.NumericEditField
        EditField_49        matlab.ui.control.NumericEditField
        EditField_50        matlab.ui.control.NumericEditField
        EditField_51        matlab.ui.control.NumericEditField
        EditField_52        matlab.ui.control.NumericEditField
        EditField_53        matlab.ui.control.NumericEditField
        EditField_54        matlab.ui.control.NumericEditField
        EditField_55        matlab.ui.control.NumericEditField
        EditField_56        matlab.ui.control.NumericEditField
        EditField_57        matlab.ui.control.NumericEditField
        EditField_58        matlab.ui.control.NumericEditField
        EditField_59        matlab.ui.control.NumericEditField
        EditField_60        matlab.ui.control.NumericEditField
        EditField_61        matlab.ui.control.NumericEditField
        EditField_62        matlab.ui.control.NumericEditField
        EditField_63        matlab.ui.control.NumericEditField
        EditField_64        matlab.ui.control.NumericEditField
        EditField_65        matlab.ui.control.NumericEditField
        EditField_66        matlab.ui.control.NumericEditField
        EditField_67        matlab.ui.control.NumericEditField
        EditField_68        matlab.ui.control.NumericEditField
        EditField_69        matlab.ui.control.NumericEditField
        EditField_70        matlab.ui.control.NumericEditField
        EditField_71        matlab.ui.control.NumericEditField
        EditField_72        matlab.ui.control.NumericEditField
        EditField_73        matlab.ui.control.NumericEditField
        EditField_74        matlab.ui.control.NumericEditField
        EditField_75        matlab.ui.control.NumericEditField
        EditField_76        matlab.ui.control.NumericEditField
        EditField_77        matlab.ui.control.NumericEditField
        EditField_78        matlab.ui.control.NumericEditField
        EditField_79        matlab.ui.control.NumericEditField
        EditField_80        matlab.ui.control.NumericEditField
        EditField_81        matlab.ui.control.NumericEditField
        EditField_82        matlab.ui.control.NumericEditField
        EditField_83        matlab.ui.control.NumericEditField
        EditField_84        matlab.ui.control.NumericEditField
        EditField_85        matlab.ui.control.NumericEditField
        EditField_86        matlab.ui.control.NumericEditField
        EditField_87        matlab.ui.control.NumericEditField
        EditField_88        matlab.ui.control.NumericEditField
        EditField_89        matlab.ui.control.NumericEditField
        EditField_90        matlab.ui.control.NumericEditField
        EditField_91        matlab.ui.control.NumericEditField
        EditField_92        matlab.ui.control.NumericEditField
        EditField_93        matlab.ui.control.NumericEditField
        EditField_94        matlab.ui.control.NumericEditField
        EditField_95        matlab.ui.control.NumericEditField
        EditField_96        matlab.ui.control.NumericEditField
        EditField_97        matlab.ui.control.NumericEditField
        EditField_98        matlab.ui.control.NumericEditField
        EditField_99        matlab.ui.control.NumericEditField
        EditField_100       matlab.ui.control.NumericEditField
        EditField_101       matlab.ui.control.NumericEditField
        EditField_102       matlab.ui.control.NumericEditField
        EditField_103       matlab.ui.control.NumericEditField
        EditField_104       matlab.ui.control.NumericEditField
        EditField_105       matlab.ui.control.NumericEditField
        EditField_106       matlab.ui.control.NumericEditField
        EditField_107       matlab.ui.control.NumericEditField
        EditField_108       matlab.ui.control.NumericEditField
        EditField_109       matlab.ui.control.NumericEditField
        EditField_110       matlab.ui.control.NumericEditField
        EditField_111       matlab.ui.control.NumericEditField
        EditField_112       matlab.ui.control.NumericEditField
        EditField_113       matlab.ui.control.NumericEditField
        EditField_114       matlab.ui.control.NumericEditField
        EditField_115       matlab.ui.control.NumericEditField
        EditField_116       matlab.ui.control.NumericEditField
        EditField_117       matlab.ui.control.NumericEditField
        EditField_118       matlab.ui.control.NumericEditField
        EditField_119       matlab.ui.control.NumericEditField
        EditField_120       matlab.ui.control.NumericEditField
        EditField_121       matlab.ui.control.NumericEditField
        EditField_122       matlab.ui.control.NumericEditField
        EditField_123       matlab.ui.control.NumericEditField
        EditField_124       matlab.ui.control.NumericEditField
        EditField_125       matlab.ui.control.NumericEditField
        EditField_126       matlab.ui.control.NumericEditField
        EditField_127       matlab.ui.control.NumericEditField
        EditField_128       matlab.ui.control.NumericEditField
        MainLabel               matlab.ui.control.Label
        
        % User defined properties
        serialObj 
        alc
        callingApp
    end

    % Properties that correspond to apps with auto-reflow
    properties (Access = private)
        onePanelWidth = 576;
    end

    % Callbacks that handle component events
    methods (Access = private)

        function updateNumberFields(app, extraChannelsMatrix)
            extraChannelArray = reshape(extraChannelsMatrix.',1,[]);
            for field=1:128
                fieldName = sprintf('EditField_%i',field);
                app.(fieldName).Value =  extraChannelArray(field);
            end
        end
        
        function extraChannelsMatrix = getNumberFields(app)
            extraChannelArray = zeros(128,1);
            for field=1:128
                fieldName = sprintf('EditField_%i',field);
                extraChannelArray(field,1) = app.(fieldName).Value;
            end
            extraChannelsMatrix = reshape(extraChannelArray, 16, [])';
        end
        
        % Button pushed function: LoadFromFileButton
        function loadFromFile(app, ~)
            app.UIFigure.Visible = 'off';
            file = uigetfile('*.mat');
            app.UIFigure.Visible = 'on';
            if file == 0
                return
            end
            selectedFile = load(file);
            if isfield(selectedFile, 'extraChannelsMatrix')
                extraChannelsMatrix = selectedFile.extraChannelsMatrix;
                if (size(extraChannelsMatrix,1) == 8 && size(extraChannelsMatrix,2) == 16)
                    app.updateNumberFields(extraChannelsMatrix)
                    app.MainLabel.Text = 'Extra channel matrix loaded from file';
                else
                    uialert(app.UIFigure,'Wrong dimensions of matrix','Error')
                    app.MainLabel.Text = 'Extra channel matrix not loaded';
                end
                
            else
                uialert(app.UIFigure,'Not a extra channel save file','Error')
                app.MainLabel.Text = 'Extra channel matrix not loaded';
            end
            
                
            
            
            
            
        end

        % Button pushed function: SaveToFileButton
        function saveToFile(app, ~)
            extraChannelsMatrix = app.alc.extraChannelsMatrix;
            save('extraChannelsMatrix.mat' , 'extraChannelsMatrix');
            app.MainLabel.Text = 'Extra channel matrix saved to file';
        end

        % Button pushed function: ResetMatrixButton
        function resetMatrix(app, ~)
            app.updateNumberFields(zeros(8,16))
            app.MainLabel.Text = 'Extra channel matrix reset';
        end

        % Button pushed function: ReadButton
        function readFromALC(app, ~)
            app.alc.getExtraChannels(app.serialObj);
            app.updateNumberFields(app.alc.extraChannelsMatrix);
            app.MainLabel.Text = 'Extra channel matrix read from ALC';
        end

        % Button pushed function: WriteButton
        function writeToALC(app, ~)
            extraChannelsMatrix = app.getNumberFields();
            app.alc.setExtraChannels(app.serialObj, extraChannelsMatrix);
            app.MainLabel.Text = 'Extra channel matrix written to ALC';
        end

        % Changes arrangement of the app based on UIFigure width
        function updateAppLayout(app, ~)
            currentFigureWidth = app.UIFigure.Position(3);
            if(currentFigureWidth <= app.onePanelWidth)
                % Change to a 2x1 grid
                app.GridLayout.RowHeight = {494, 494};
                app.GridLayout.ColumnWidth = {'1x'};
                app.RightPanel.Layout.Row = 2;
                app.RightPanel.Layout.Column = 1;
            else
                % Change to a 1x2 grid
                app.GridLayout.RowHeight = {'1x'};
                app.GridLayout.ColumnWidth = {182, '1x'};
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
            app.UIFigure.Position = [100 100 1306 487];
            app.UIFigure.Name = 'ALC extra channels';
            app.UIFigure.SizeChangedFcn = createCallbackFcn(app, @updateAppLayout, true);

            % Create GridLayout
            app.GridLayout = uigridlayout(app.UIFigure);
            app.GridLayout.ColumnWidth = {182, '1x'};
            app.GridLayout.RowHeight = {'1x'};
            app.GridLayout.ColumnSpacing = 0;
            app.GridLayout.RowSpacing = 0;
            app.GridLayout.Padding = [0 0 0 0];
            app.GridLayout.Scrollable = 'on';

            % Create LeftPanel
            app.LeftPanel = uipanel(app.GridLayout);
            app.LeftPanel.Layout.Row = 1;
            app.LeftPanel.Layout.Column = 1;

            % Create LoadFromFileButton
            app.LoadFromFileButton = uibutton(app.LeftPanel, 'push');
            app.LoadFromFileButton.ButtonPushedFcn = createCallbackFcn(app, @loadFromFile, true);
            app.LoadFromFileButton.Position = [22 424 138 22];
            app.LoadFromFileButton.Text = 'Load from file';

            % Create SaveToFileButton
            app.SaveToFileButton = uibutton(app.LeftPanel, 'push');
            app.SaveToFileButton.ButtonPushedFcn = createCallbackFcn(app, @saveToFile, true);
            app.SaveToFileButton.Position = [22 381 138 22];
            app.SaveToFileButton.Text = 'Save to file';

            % Create ResetMatrixButton
            app.ResetMatrixButton = uibutton(app.LeftPanel, 'push');
            app.ResetMatrixButton.ButtonPushedFcn = createCallbackFcn(app, @resetMatrix, true);
            app.ResetMatrixButton.Position = [22 339 138 22];
            app.ResetMatrixButton.Text = 'Reset matrix';

            % Create WriteButton
            app.WriteButton = uibutton(app.LeftPanel, 'push');
            app.WriteButton.ButtonPushedFcn = createCallbackFcn(app, @writeToALC, true);
            app.WriteButton.Position = [22 29 138 22];
            app.WriteButton.Text = 'Write to ALC';

            % Create ReadButton
            app.ReadButton = uibutton(app.LeftPanel, 'push');
            app.ReadButton.ButtonPushedFcn = createCallbackFcn(app, @readFromALC, true);
            app.ReadButton.Position = [22 68 138 22];
            app.ReadButton.Text = 'Read from ALC';

            % Create RightPanel
            app.RightPanel = uipanel(app.GridLayout);
            app.RightPanel.Layout.Row = 1;
            app.RightPanel.Layout.Column = 2;

            % Create Channel17Label
            app.Channel17Label = uilabel(app.RightPanel);
            app.Channel17Label.Position = [37 400 66 22];
            app.Channel17Label.Text = 'Channel 17';

            % Create Channel18Label
            app.Channel18Label = uilabel(app.RightPanel);
            app.Channel18Label.Position = [37 352 66 22];
            app.Channel18Label.Text = 'Channel 18';

            % Create Channel19Label
            app.Channel19Label = uilabel(app.RightPanel);
            app.Channel19Label.Position = [37 304 66 22];
            app.Channel19Label.Text = 'Channel 19';

            % Create Channel20Label
            app.Channel20Label = uilabel(app.RightPanel);
            app.Channel20Label.Position = [37 256 66 22];
            app.Channel20Label.Text = 'Channel 20';

            % Create Channel21Label
            app.Channel21Label = uilabel(app.RightPanel);
            app.Channel21Label.Position = [37 208 66 22];
            app.Channel21Label.Text = 'Channel 21';

            % Create Channel22Label
            app.Channel22Label = uilabel(app.RightPanel);
            app.Channel22Label.Position = [37 160 66 22];
            app.Channel22Label.Text = 'Channel 22';

            % Create Channel23Label
            app.Channel23Label = uilabel(app.RightPanel);
            app.Channel23Label.Position = [37 112 66 22];
            app.Channel23Label.Text = 'Channel 23';

            % Create Channel24Label
            app.Channel24Label = uilabel(app.RightPanel);
            app.Channel24Label.Position = [37 65 66 22];
            app.Channel24Label.Text = 'Channel 24';

            % Create Ch1coeffLabel
            app.Ch1coeffLabel = uilabel(app.RightPanel);
            app.Ch1coeffLabel.HorizontalAlignment = 'center';
            app.Ch1coeffLabel.Position = [149 445 36 28];
            app.Ch1coeffLabel.Text = {'Ch1 '; 'coeff.'};

            % Create Ch2coeffLabel
            app.Ch2coeffLabel = uilabel(app.RightPanel);
            app.Ch2coeffLabel.HorizontalAlignment = 'center';
            app.Ch2coeffLabel.Position = [208 445 36 28];
            app.Ch2coeffLabel.Text = {'Ch2'; 'coeff.'};

            % Create Ch3coeffLabel
            app.Ch3coeffLabel = uilabel(app.RightPanel);
            app.Ch3coeffLabel.HorizontalAlignment = 'center';
            app.Ch3coeffLabel.Position = [269 445 36 28];
            app.Ch3coeffLabel.Text = {'Ch3 '; 'coeff.'};

            % Create Ch4coeffLabel
            app.Ch4coeffLabel = uilabel(app.RightPanel);
            app.Ch4coeffLabel.HorizontalAlignment = 'center';
            app.Ch4coeffLabel.Position = [330 445 36 28];
            app.Ch4coeffLabel.Text = {'Ch4 '; 'coeff.'};

            % Create Ch5coeffLabel
            app.Ch5coeffLabel = uilabel(app.RightPanel);
            app.Ch5coeffLabel.HorizontalAlignment = 'center';
            app.Ch5coeffLabel.Position = [391 445 36 28];
            app.Ch5coeffLabel.Text = {'Ch5 '; 'coeff.'};

            % Create Ch6coeffLabel
            app.Ch6coeffLabel = uilabel(app.RightPanel);
            app.Ch6coeffLabel.HorizontalAlignment = 'center';
            app.Ch6coeffLabel.Position = [452 445 36 28];
            app.Ch6coeffLabel.Text = {'Ch6 '; 'coeff.'};

            % Create Ch7coeffLabel
            app.Ch7coeffLabel = uilabel(app.RightPanel);
            app.Ch7coeffLabel.HorizontalAlignment = 'center';
            app.Ch7coeffLabel.Position = [513 445 36 28];
            app.Ch7coeffLabel.Text = {'Ch7 '; 'coeff.'};

            % Create Ch8coeffLabel
            app.Ch8coeffLabel = uilabel(app.RightPanel);
            app.Ch8coeffLabel.HorizontalAlignment = 'center';
            app.Ch8coeffLabel.Position = [575 445 36 28];
            app.Ch8coeffLabel.Text = {'Ch8 '; 'coeff.'};

            % Create Ch9coeffLabel
            app.Ch9coeffLabel = uilabel(app.RightPanel);
            app.Ch9coeffLabel.HorizontalAlignment = 'center';
            app.Ch9coeffLabel.Position = [636 445 36 28];
            app.Ch9coeffLabel.Text = {'Ch9 '; 'coeff.'};

            % Create Ch10coeffLabel
            app.Ch10coeffLabel = uilabel(app.RightPanel);
            app.Ch10coeffLabel.HorizontalAlignment = 'center';
            app.Ch10coeffLabel.Position = [699 445 38 28];
            app.Ch10coeffLabel.Text = {'Ch10 '; 'coeff.'};

            % Create Ch11coeffLabel
            app.Ch11coeffLabel = uilabel(app.RightPanel);
            app.Ch11coeffLabel.HorizontalAlignment = 'center';
            app.Ch11coeffLabel.Position = [760 445 38 28];
            app.Ch11coeffLabel.Text = {'Ch11 '; 'coeff.'};

            % Create Ch12coeffLabel
            app.Ch12coeffLabel = uilabel(app.RightPanel);
            app.Ch12coeffLabel.HorizontalAlignment = 'center';
            app.Ch12coeffLabel.Position = [821 445 38 28];
            app.Ch12coeffLabel.Text = {'Ch12 '; 'coeff.'};

            % Create Ch13coeffLabel
            app.Ch13coeffLabel = uilabel(app.RightPanel);
            app.Ch13coeffLabel.HorizontalAlignment = 'center';
            app.Ch13coeffLabel.Position = [882 445 38 28];
            app.Ch13coeffLabel.Text = {'Ch13 '; 'coeff.'};

            % Create Ch14coeffLabel
            app.Ch14coeffLabel = uilabel(app.RightPanel);
            app.Ch14coeffLabel.HorizontalAlignment = 'center';
            app.Ch14coeffLabel.Position = [943 445 36 28];
            app.Ch14coeffLabel.Text = {'Ch14'; 'coeff.'};

            % Create Ch15coeffLabel
            app.Ch15coeffLabel = uilabel(app.RightPanel);
            app.Ch15coeffLabel.HorizontalAlignment = 'center';
            app.Ch15coeffLabel.Position = [1004 445 38 28];
            app.Ch15coeffLabel.Text = {'Ch15 '; 'coeff.'};

            % Create Ch16coeffLabel
            app.Ch16coeffLabel = uilabel(app.RightPanel);
            app.Ch16coeffLabel.HorizontalAlignment = 'center';
            app.Ch16coeffLabel.Position = [1065 445 38 28];
            app.Ch16coeffLabel.Text = {'Ch16 '; 'coeff.'};
            
            
            % Create EditField_1
            app.EditField_1 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_1.HorizontalAlignment = 'center';
            app.EditField_1.Position = [146 400 33 22];

            app.EditField_2 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_2.HorizontalAlignment = 'center';
            app.EditField_2.Position = [208 401 33 22];

            % Create EditField_3
            app.EditField_3 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_3.HorizontalAlignment = 'center';
            app.EditField_3.Position = [270 401 33 22];

            % Create EditField_4
            app.EditField_4 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_4.HorizontalAlignment = 'center';
            app.EditField_4.Position = [331 401 33 22];

            % Create EditField_5
            app.EditField_5 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_5.HorizontalAlignment = 'center';
            app.EditField_5.Position = [392 401 33 22];

            % Create EditField_6
            app.EditField_6 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_6.HorizontalAlignment = 'center';
            app.EditField_6.Position = [453 401 33 22];

            % Create EditField_7
            app.EditField_7 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_7.HorizontalAlignment = 'center';
            app.EditField_7.Position = [514 401 33 22];

            % Create EditField_8
            app.EditField_8 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_8.HorizontalAlignment = 'center';
            app.EditField_8.Position = [575 401 33 22];

            % Create EditField_9
            app.EditField_9 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_9.HorizontalAlignment = 'center';
            app.EditField_9.Position = [636 401 33 22];

            % Create EditField_10
            app.EditField_10 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_10.HorizontalAlignment = 'center';
            app.EditField_10.Position = [697 400 33 22];

            % Create EditField_11
            app.EditField_11 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_11.HorizontalAlignment = 'center';
            app.EditField_11.Position = [758 401 33 22];

            % Create EditField_12
            app.EditField_12 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_12.HorizontalAlignment = 'center';
            app.EditField_12.Position = [819 401 33 22];

            % Create EditField_13
            app.EditField_13 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_13.HorizontalAlignment = 'center';
            app.EditField_13.Position = [880 401 33 22];

            % Create EditField_14
            app.EditField_14 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_14.HorizontalAlignment = 'center';
            app.EditField_14.Position = [941 400 33 22];

            % Create EditField_15
            app.EditField_15 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_15.HorizontalAlignment = 'center';
            app.EditField_15.Position = [1002 401 33 22];

            % Create EditField_16
            app.EditField_16 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_16.HorizontalAlignment = 'center';
            app.EditField_16.Position = [1063 400 33 22];

            % Create EditField_17
            app.EditField_17 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_17.HorizontalAlignment = 'center';
            app.EditField_17.Position = [146 351 33 22];

            % Create EditField_18
            app.EditField_18 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_18.HorizontalAlignment = 'center';
            app.EditField_18.Position = [208 351 33 22];

            % Create EditField_19
            app.EditField_19 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_19.HorizontalAlignment = 'center';
            app.EditField_19.Position = [270 351 33 22];

            % Create EditField_20
            app.EditField_20 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_20.HorizontalAlignment = 'center';
            app.EditField_20.Position = [331 351 33 22];

            % Create EditField_21
            app.EditField_21 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_21.HorizontalAlignment = 'center';
            app.EditField_21.Position = [392 351 33 22];

            % Create EditField_22
            app.EditField_22 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_22.HorizontalAlignment = 'center';
            app.EditField_22.Position = [453 351 33 22];

            % Create EditField_23
            app.EditField_23 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_23.HorizontalAlignment = 'center';
            app.EditField_23.Position = [514 351 33 22];

            % Create EditField_24
            app.EditField_24 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_24.HorizontalAlignment = 'center';
            app.EditField_24.Position = [575 351 33 22];

            % Create EditField_25
            app.EditField_25 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_25.HorizontalAlignment = 'center';
            app.EditField_25.Position = [636 351 33 22];

            % Create EditField_26
            app.EditField_26 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_26.HorizontalAlignment = 'center';
            app.EditField_26.Position = [697 351 33 22];

            % Create EditField_27
            app.EditField_27 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_27.HorizontalAlignment = 'center';
            app.EditField_27.Position = [758 351 33 22];

            % Create EditField_28
            app.EditField_28 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_28.HorizontalAlignment = 'center';
            app.EditField_28.Position = [819 351 33 22];

            % Create EditField_29
            app.EditField_29 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_29.HorizontalAlignment = 'center';
            app.EditField_29.Position = [880 351 33 22];

            % Create EditField_30
            app.EditField_30 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_30.HorizontalAlignment = 'center';
            app.EditField_30.Position = [941 351 33 22];

            % Create EditField_31
            app.EditField_31 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_31.HorizontalAlignment = 'center';
            app.EditField_31.Position = [1002 351 33 22];

            % Create EditField_32
            app.EditField_32 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_32.HorizontalAlignment = 'center';
            app.EditField_32.Position = [1063 351 33 22];

            % Create EditField_33
            app.EditField_33 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_33.HorizontalAlignment = 'center';
            app.EditField_33.Position = [146 304 33 22];

            % Create EditField_34
            app.EditField_34 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_34.HorizontalAlignment = 'center';
            app.EditField_34.Position = [208 304 33 22];

            % Create EditField_35
            app.EditField_35 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_35.HorizontalAlignment = 'center';
            app.EditField_35.Position = [270 304 33 22];

            % Create EditField_36
            app.EditField_36 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_36.HorizontalAlignment = 'center';
            app.EditField_36.Position = [331 304 33 22];

            % Create EditField_37
            app.EditField_37 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_37.HorizontalAlignment = 'center';
            app.EditField_37.Position = [392 304 33 22];

            % Create EditField_38
            app.EditField_38 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_38.HorizontalAlignment = 'center';
            app.EditField_38.Position = [453 304 33 22];

            % Create EditField_39
            app.EditField_39 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_39.HorizontalAlignment = 'center';
            app.EditField_39.Position = [514 304 33 22];

            % Create EditField_40
            app.EditField_40 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_40.HorizontalAlignment = 'center';
            app.EditField_40.Position = [575 304 33 22];

            % Create EditField_41
            app.EditField_41 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_41.HorizontalAlignment = 'center';
            app.EditField_41.Position = [636 304 33 22];

            % Create EditField_42
            app.EditField_42 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_42.HorizontalAlignment = 'center';
            app.EditField_42.Position = [697 304 33 22];

            % Create EditField_43
            app.EditField_43 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_43.HorizontalAlignment = 'center';
            app.EditField_43.Position = [758 304 33 22];

            % Create EditField_44
            app.EditField_44 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_44.HorizontalAlignment = 'center';
            app.EditField_44.Position = [819 304 33 22];

            % Create EditField_45
            app.EditField_45 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_45.HorizontalAlignment = 'center';
            app.EditField_45.Position = [880 304 33 22];

            % Create EditField_46
            app.EditField_46 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_46.HorizontalAlignment = 'center';
            app.EditField_46.Position = [941 304 33 22];

            % Create EditField_47
            app.EditField_47 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_47.HorizontalAlignment = 'center';
            app.EditField_47.Position = [1002 304 33 22];

            % Create EditField_48
            app.EditField_48 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_48.HorizontalAlignment = 'center';
            app.EditField_48.Position = [1063 304 33 22];

            % Create EditField_49
            app.EditField_49 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_49.HorizontalAlignment = 'center';
            app.EditField_49.Position = [146 256 33 22];

            % Create EditField_50
            app.EditField_50 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_50.HorizontalAlignment = 'center';
            app.EditField_50.Position = [208 256 33 22];

            % Create EditField_51
            app.EditField_51 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_51.HorizontalAlignment = 'center';
            app.EditField_51.Position = [270 256 33 22];

            % Create EditField_52
            app.EditField_52 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_52.HorizontalAlignment = 'center';
            app.EditField_52.Position = [331 256 33 22];

            % Create EditField_53
            app.EditField_53 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_53.HorizontalAlignment = 'center';
            app.EditField_53.Position = [392 256 33 22];

            % Create EditField_54
            app.EditField_54 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_54.HorizontalAlignment = 'center';
            app.EditField_54.Position = [453 256 33 22];

            % Create EditField_55
            app.EditField_55 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_55.HorizontalAlignment = 'center';
            app.EditField_55.Position = [514 256 33 22];

            % Create EditField_56
            app.EditField_56 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_56.HorizontalAlignment = 'center';
            app.EditField_56.Position = [575 256 33 22];

            % Create EditField_57
            app.EditField_57 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_57.HorizontalAlignment = 'center';
            app.EditField_57.Position = [636 256 33 22];

            % Create EditField_58
            app.EditField_58 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_58.HorizontalAlignment = 'center';
            app.EditField_58.Position = [697 256 33 22];

            % Create EditField_59
            app.EditField_59 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_59.HorizontalAlignment = 'center';
            app.EditField_59.Position = [758 256 33 22];

            % Create EditField_60
            app.EditField_60 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_60.HorizontalAlignment = 'center';
            app.EditField_60.Position = [819 256 33 22];

            % Create EditField_61
            app.EditField_61 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_61.HorizontalAlignment = 'center';
            app.EditField_61.Position = [880 256 33 22];

            % Create EditField_62
            app.EditField_62 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_62.HorizontalAlignment = 'center';
            app.EditField_62.Position = [941 256 33 22];

            % Create EditField_63
            app.EditField_63 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_63.HorizontalAlignment = 'center';
            app.EditField_63.Position = [1002 256 33 22];

            % Create EditField_64
            app.EditField_64 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_64.HorizontalAlignment = 'center';
            app.EditField_64.Position = [1063 256 33 22];

            % Create EditField_65
            app.EditField_65 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_65.HorizontalAlignment = 'center';
            app.EditField_65.Position = [146 208 33 22];

            % Create EditField_66
            app.EditField_66 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_66.HorizontalAlignment = 'center';
            app.EditField_66.Position = [208 208 33 22];

            % Create EditField_67
            app.EditField_67 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_67.HorizontalAlignment = 'center';
            app.EditField_67.Position = [270 208 33 22];

            % Create EditField_68
            app.EditField_68 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_68.HorizontalAlignment = 'center';
            app.EditField_68.Position = [331 208 33 22];

            % Create EditField_69
            app.EditField_69 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_69.HorizontalAlignment = 'center';
            app.EditField_69.Position = [392 208 33 22];

            % Create EditField_70
            app.EditField_70 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_70.HorizontalAlignment = 'center';
            app.EditField_70.Position = [453 208 33 22];

            % Create EditField_71
            app.EditField_71 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_71.HorizontalAlignment = 'center';
            app.EditField_71.Position = [514 208 33 22];

            % Create EditField_72
            app.EditField_72 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_72.HorizontalAlignment = 'center';
            app.EditField_72.Position = [575 208 33 22];

            % Create EditField_73
            app.EditField_73 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_73.HorizontalAlignment = 'center';
            app.EditField_73.Position = [636 208 33 22];

            % Create EditField_74
            app.EditField_74 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_74.HorizontalAlignment = 'center';
            app.EditField_74.Position = [697 208 33 22];

            % Create EditField_75
            app.EditField_75 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_75.HorizontalAlignment = 'center';
            app.EditField_75.Position = [758 208 33 22];

            % Create EditField_76
            app.EditField_76 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_76.HorizontalAlignment = 'center';
            app.EditField_76.Position = [819 208 33 22];

            % Create EditField_77
            app.EditField_77 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_77.HorizontalAlignment = 'center';
            app.EditField_77.Position = [880 208 33 22];

            % Create EditField_78
            app.EditField_78 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_78.HorizontalAlignment = 'center';
            app.EditField_78.Position = [941 208 33 22];

            % Create EditField_79
            app.EditField_79 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_79.HorizontalAlignment = 'center';
            app.EditField_79.Position = [1002 208 33 22];

            % Create EditField_80
            app.EditField_80 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_80.HorizontalAlignment = 'center';
            app.EditField_80.Position = [1063 208 33 22];

            % Create EditField_81
            app.EditField_81 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_81.HorizontalAlignment = 'center';
            app.EditField_81.Position = [146 160 33 22];

            % Create EditField_82
            app.EditField_82 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_82.HorizontalAlignment = 'center';
            app.EditField_82.Position = [208 160 33 22];

            % Create EditField_83
            app.EditField_83 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_83.HorizontalAlignment = 'center';
            app.EditField_83.Position = [270 160 33 22];

            % Create EditField_84
            app.EditField_84 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_84.HorizontalAlignment = 'center';
            app.EditField_84.Position = [331 160 33 22];

            % Create EditField_85
            app.EditField_85 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_85.HorizontalAlignment = 'center';
            app.EditField_85.Position = [392 160 33 22];

            % Create EditField_86
            app.EditField_86 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_86.HorizontalAlignment = 'center';
            app.EditField_86.Position = [453 160 33 22];

            % Create EditField_87
            app.EditField_87 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_87.HorizontalAlignment = 'center';
            app.EditField_87.Position = [514 160 33 22];

            % Create EditField_88
            app.EditField_88 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_88.HorizontalAlignment = 'center';
            app.EditField_88.Position = [575 160 33 22];

            % Create EditField_89
            app.EditField_89 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_89.HorizontalAlignment = 'center';
            app.EditField_89.Position = [636 160 33 22];

            % Create EditField_90
            app.EditField_90 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_90.HorizontalAlignment = 'center';
            app.EditField_90.Position = [697 160 33 22];

            % Create EditField_91
            app.EditField_91 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_91.HorizontalAlignment = 'center';
            app.EditField_91.Position = [758 160 33 22];

            % Create EditField_92
            app.EditField_92 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_92.HorizontalAlignment = 'center';
            app.EditField_92.Position = [819 160 33 22];

            % Create EditField_93
            app.EditField_93 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_93.HorizontalAlignment = 'center';
            app.EditField_93.Position = [880 160 33 22];

            % Create EditField_94
            app.EditField_94 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_94.HorizontalAlignment = 'center';
            app.EditField_94.Position = [941 160 33 22];

            % Create EditField_95
            app.EditField_95 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_95.HorizontalAlignment = 'center';
            app.EditField_95.Position = [1002 160 33 22];

            % Create EditField_96
            app.EditField_96 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_96.HorizontalAlignment = 'center';
            app.EditField_96.Position = [1063 160 33 22];

            % Create EditField_97
            app.EditField_97 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_97.HorizontalAlignment = 'center';
            app.EditField_97.Position = [146 112 33 22];

            % Create EditField_98
            app.EditField_98 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_98.HorizontalAlignment = 'center';
            app.EditField_98.Position = [208 112 33 22];

            % Create EditField_99
            app.EditField_99 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_99.HorizontalAlignment = 'center';
            app.EditField_99.Position = [270 112 33 22];

            % Create EditField_100
            app.EditField_100 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_100.HorizontalAlignment = 'center';
            app.EditField_100.Position = [331 112 33 22];

            % Create EditField_101
            app.EditField_101 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_101.HorizontalAlignment = 'center';
            app.EditField_101.Position = [392 112 33 22];

            % Create EditField_102
            app.EditField_102 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_102.HorizontalAlignment = 'center';
            app.EditField_102.Position = [453 112 33 22];

            % Create EditField_103
            app.EditField_103 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_103.HorizontalAlignment = 'center';
            app.EditField_103.Position = [514 112 33 22];

            % Create EditField_104
            app.EditField_104 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_104.HorizontalAlignment = 'center';
            app.EditField_104.Position = [575 112 33 22];

            % Create EditField_105
            app.EditField_105 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_105.HorizontalAlignment = 'center';
            app.EditField_105.Position = [636 112 33 22];

            % Create EditField_106
            app.EditField_106 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_106.HorizontalAlignment = 'center';
            app.EditField_106.Position = [697 112 33 22];

            % Create EditField_107
            app.EditField_107 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_107.HorizontalAlignment = 'center';
            app.EditField_107.Position = [758 112 33 22];

            % Create EditField_108
            app.EditField_108 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_108.HorizontalAlignment = 'center';
            app.EditField_108.Position = [819 112 33 22];

            % Create EditField_109
            app.EditField_109 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_109.HorizontalAlignment = 'center';
            app.EditField_109.Position = [880 112 33 22];

            % Create EditField_110
            app.EditField_110 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_110.HorizontalAlignment = 'center';
            app.EditField_110.Position = [941 112 33 22];

            % Create EditField_111
            app.EditField_111 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_111.HorizontalAlignment = 'center';
            app.EditField_111.Position = [1002 112 33 22];

            % Create EditField_112
            app.EditField_112 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_112.HorizontalAlignment = 'center';
            app.EditField_112.Position = [1063 112 33 22];

            % Create EditField_113
            app.EditField_113 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_113.HorizontalAlignment = 'center';
            app.EditField_113.Position = [146 65 33 22];

            % Create EditField_114
            app.EditField_114 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_114.HorizontalAlignment = 'center';
            app.EditField_114.Position = [208 65 33 22];

            % Create EditField_115
            app.EditField_115 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_115.HorizontalAlignment = 'center';
            app.EditField_115.Position = [270 65 33 22];

            % Create EditField_116
            app.EditField_116 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_116.HorizontalAlignment = 'center';
            app.EditField_116.Position = [331 65 33 22];

            % Create EditField_117
            app.EditField_117 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_117.HorizontalAlignment = 'center';
            app.EditField_117.Position = [392 65 33 22];

            % Create EditField_118
            app.EditField_118 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_118.HorizontalAlignment = 'center';
            app.EditField_118.Position = [453 65 33 22];

            % Create EditField_119
            app.EditField_119 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_119.HorizontalAlignment = 'center';
            app.EditField_119.Position = [514 65 33 22];

            % Create EditField_120
            app.EditField_120 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_120.HorizontalAlignment = 'center';
            app.EditField_120.Position = [575 65 33 22];

            % Create EditField_121
            app.EditField_121 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_121.HorizontalAlignment = 'center';
            app.EditField_121.Position = [636 65 33 22];

            % Create EditField_122
            app.EditField_122 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_122.HorizontalAlignment = 'center';
            app.EditField_122.Position = [697 65 33 22];

            % Create EditField_123
            app.EditField_123 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_123.HorizontalAlignment = 'center';
            app.EditField_123.Position = [758 65 33 22];

            % Create EditField_124
            app.EditField_124 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_124.HorizontalAlignment = 'center';
            app.EditField_124.Position = [819 65 33 22];

            % Create EditField_125
            app.EditField_125 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_125.HorizontalAlignment = 'center';
            app.EditField_125.Position = [880 65 33 22];

            % Create EditField_126
            app.EditField_126 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_126.HorizontalAlignment = 'center';
            app.EditField_126.Position = [941 65 33 22];

            % Create EditField_127
            app.EditField_127 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_127.HorizontalAlignment = 'center';
            app.EditField_127.Position = [1002 65 33 22];

            % Create EditField_128
            app.EditField_128 = uieditfield(app.RightPanel, 'numeric');
            app.EditField_128.HorizontalAlignment = 'center';
            app.EditField_128.Position = [1063 65 33 22];

            % Create Label
            app.MainLabel = uilabel(app.RightPanel);
            app.MainLabel.HorizontalAlignment = 'center';
            app.MainLabel.FontSize = 20;
            app.MainLabel.FontWeight = 'bold';
            app.MainLabel.Position = [6 15 1112 27];
            app.MainLabel.Text = '';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = app_ExtraChannels(varargin)

%--------------------------------------------------------------
            % Create UIFigure and components
            %--------------------------------------------------------------
            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)
            
            %--------------------------------------------------------------
            % Handle input
            %--------------------------------------------------------------
            % If app is called without an input
            if nargin == 0
                ports = serialportlist;
                [index,inputMade] = listdlg('PromptString',{'Select ALC port'},'ListString',ports, 'SelectionMode','single');

                if ~inputMade
                    delete(app);
                    return;
                end
                app.UIFigure.Visible = 'on'; 
                comPort = ports(index);

                app.serialObj = ALC.createSerialObject(comPort);
                ALC.testConnection(app.serialObj);
                app.alc = ALC();
                
            % If app is called with an input   
            elseif nargin == 1
                callingApp = varargin{1};
                if isprop(callingApp, 'serialObj') && isprop(callingApp, 'alc') % app called from another NCALfit app
                    app.callingApp = varargin{1};
                    app.serialObj = app.callingApp.serialObj;
                    ALC.testConnection(app.serialObj);
                    app.alc = app.callingApp.alc;
                    
                elseif isfield(callingApp,'obj') % Compability for old NCALFit        

                    obj = callingApp.obj;
                    comPort = obj.Port;
                    baudRate = obj.BaudRate;

                    instrreset;                
                    app.serialObj = serialport(comPort, baudRate, 'Databits', 8, ...
                    'Byteorder', 'big-endian');

                    ALC.testConnection(app.serialObj);
                    app.alc = ALC();

                else
                    delete(app)
                    
                end
                
            else
                delete(app)
                
            end
            
            app.alc.getExtraChannels(app.serialObj);
            app.updateNumberFields(app.alc.extraChannelsMatrix);

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