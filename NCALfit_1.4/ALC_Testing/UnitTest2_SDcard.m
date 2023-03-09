classdef UnitTest2_SDcard< matlab.unittest.TestCase
    
    properties
        serialObj
        comPort
    end
    
    methods
        function testCase = UnitTest2_SDcard()
            instrreset;
            ports = serialportlist;
            [index,inputMade] = listdlg('ListString',ports, 'SelectionMode','single');

            if ~inputMade
                error('UnitTests2:ListDialogError','No Port Selected')
            end
            testCase.comPort = ports(index);

            testCase.serialObj = ALC.createSerialObject(testCase.comPort);
            
            clc;
            
        end
    end
    
    methods (Test)
        function testConnectiontoALC(testCase)
            fprintf('\n')
            pause(0.1);
            connectionFlag = ALC.testConnection(testCase.serialObj);
            assertTrue(testCase,connectionFlag)
        end
        
        %% Write random data to SD card
        %------------------------------------------------------------------

        function testSDrandom(testCase)
            
            % Create alc object
            alc = ALC();
            
            % Set all parameters
            expectedFrequency = 250;
            expectedCompressionEnable = randi([0, 1]);
            expectedFilterEnable = randi([0, 1]);
            expectedCombEnable = randi([0, 1]);
            expectedCombOrder = randi([1 15]);
            expectedCombCoefficients = rand(1,3);
            expectedDifferenceEnable = randi([0, 1]);
            expectedDifferenceCoefficients = randi([0, 100], [1, 16]);
            
            
            % Expected feature parameter
            expectedtWs = 50;
            expectedoWs = 25;
            expectedEnabledFeatures = randi([0, 1], [1, 5]);
            expectedNumberOfActiveFeatures = sum(expectedEnabledFeatures);
            
            % Expected Mask parameters
            expectedMaskEnable = 1;
            expectedMaskCoefficients = rand(5,5);
            
            % Expected OB hand parameters
            expectedOBparameters.sensitivity = rand(1);
            expectedOBparameters.handMinimumSpeed = randi([0, 50]);
            expectedOBparameters.handMaximumSpeed = randi([51, 100]);
            expectedOBparameters.wristMinimumSpeed = randi([0, 50]);
            expectedOBparameters.wristMaximumSpeed = randi([51, 100]);
            expectedOBparameters.elbowMinimumSpeed = randi([0, 50]);
            expectedOBparameters.elbowMaximumSpeed = randi([51, 100]);
            expectedOBparameters.switchPauseCounter = randi([0, 100]);
            
            % Expected Mia hand parameters
            expectedMiaParameters.graspControlMode = randi([0, 1]);
            expectedMiaParameters.graspStepSize = randi([0, 255]);
            expectedMiaParameters.graspDiscretization = randi([0, 255]);
            expectedMiaParameters.graspModeEnabled = randi([0, 1]);
            expectedMiaParameters.forceControlEnabled = randi([0, 1]);
            expectedMiaParameters.holdOpenEnabled = randi([0, 1]);
            expectedMiaParameters.holdOpenTime = randi([0, 255]);
            expectedMiaParameters.holdOpenThreshold = randi([0, 255]);
            
            % Threshold Ratio parameters
            expectedThresholdRatioParameters = rand(1,2);
            
            % Expected NN parameters
            expectedNNParameters.nActiveClasses = randi([2 alc.numberOfClasses]);
            expectedNNParameters.nFeatureSets = randi([1 alc.numberOfFeatures])*randi([1 alc.numberOfChannels]);
            expectedNNParameters.weights = -1 + 2*rand(expectedNNParameters.nActiveClasses,expectedNNParameters.nFeatureSets);
            expectedNNParameters.bias = -1 + 2*rand(expectedNNParameters.nActiveClasses,1);
            expectedNNParameters.threshold = rand(expectedNNParameters.nActiveClasses-1,1);
            expectedNNParameters.prostheticOutput = randi([0,130],expectedNNParameters.nActiveClasses,1);
            expectedNNParameters.mean = rand(expectedNNParameters.nFeatureSets,1);
            expectedNNParameters.std = rand(expectedNNParameters.nFeatureSets,1);
            expectedNNParameters.propThreshold = rand(expectedNNParameters.nActiveClasses-1,2);
            expectedNNParameters.floorNoise = rand(1,1);
            expectedNNParameters.switchThreshold = rand(1,1);
            expectedNNParameters.streamEnable = 0;
            
            % Expected Stimulation parameters
            
            expectedStimParameters.mode = randi([0, 5]);
            expectedStimParameters.channel = randi([0, 15]);
            expectedStimParameters.amplitude = 50; % Figure out which values can be used
            expectedStimParameters.pulseWidth = randi([1, 50]);
            expectedStimParameters.frequency = randi([1, 100]);
            expectedStimParameters.repetitions = randi([1, 255]);
            expectedStimParameters.modAmpTop = randi([1, 100]);
            expectedStimParameters.modAmpLow = randi([1, 30]);
            expectedStimParameters.modPWTop = randi([1, 50]);
            expectedStimParameters.modPWLow = randi([1, 50]);
            expectedStimParameters.modFreqTop = randi([1, 100]);
            expectedStimParameters.modFreqLow = randi([1, 100]);
            expectedStimParameters.DESCenable = randi([0, 1]);
            expectedStimParameters.DESCchannel = randi([0, 15]);
            expectedStimParameters.DESCamplitude = randi([1, 100]);
            expectedStimParameters.DESCpulseWidth = randi([1, 50]);
            expectedStimParameters.DESCfrequency = randi([1, 100]);
            expectedStimParameters.DESCrepetitions = randi([1, 255]);
            expectedStimParameters.DESCatSlips = randi([0, 1]);
            
            % Extra channels
            expectedExtraChannels = rand(8,16);

            %% Write all parameters
            fprintf('\n')
            
            pause(0.1);
            alc.setSamplingFrequency(testCase.serialObj, expectedFrequency)
            pause(0.1);
            alc.setCompressionEnable(testCase.serialObj, expectedCompressionEnable) 
            pause(0.1);
            alc.setFiltersEnabled(testCase.serialObj, expectedFilterEnable)
            pause(0.1);
            alc.setCombParameter(testCase.serialObj, expectedCombEnable,  expectedCombOrder, expectedCombCoefficients);
            pause(0.1)
            alc.setDifferenceFilterParameter(testCase.serialObj, expectedDifferenceEnable, expectedDifferenceCoefficients);
            pause(0.1)
            alc.setFeatureParameters(testCase.serialObj,expectedtWs,expectedoWs, expectedNumberOfActiveFeatures,expectedEnabledFeatures)
            pause(0.1);
            alc.setMaskingParameters(testCase.serialObj, expectedMaskCoefficients);
            pause(0.1);
            alc.setHandControlParameters(testCase.serialObj, expectedOBparameters)
            pause(0.1);
            alc.setMiaHandControlParameters(testCase.serialObj, expectedMiaParameters)
            pause(0.1);
            alc.setThresholdRatioParameters(testCase.serialObj, expectedThresholdRatioParameters)
            pause(0.1);
            alc.setNNParameters(testCase.serialObj,expectedNNParameters)
            pause(0.1);
            alc.setStimParameters(testCase.serialObj,expectedStimParameters)
            pause(0.1)
            alc.setExtraChannels(testCase.serialObj, expectedExtraChannels)
            
            %% Pause to turn off/on the ALC
            clear('alc')
            delete(testCase.serialObj);
            instrreset;
            fprintf('Deleting serial object and cleaning up\n')
            
            fig = uifigure;
            selection = '';
            while  ~strcmp(selection, 'Continue')
                selection = uiconfirm(fig,'Restart the ALC. Click "Continue" when the bluetooth connection is paired again','Restart ALC','Icon','info', 'Options',{'Continue'});
            end
            close(fig)
            
            testCase.serialObj = ALC.createSerialObject(testCase.comPort);
            flush(testCase.serialObj)
            %% Read all parameters
            % Create new alc object
            alc = ALC();
            alc.getAllParameters(testCase.serialObj);


            
            %% Compare expected to actual parameters
            % Sampling Frequency
            testCase.verifyEqual(alc.samplingFrequency,expectedFrequency);
            % Compression algorithm enable
            testCase.verifyEqual(alc.compressionEnable,1); % This should always be enabled after boot
            % Filter enable
            testCase.verifyEqual(alc.filterEnable,expectedFilterEnable);
            % Comb filter
            testCase.verifyEqual(alc.combFilterEnable,expectedCombEnable);
            testCase.verifyEqual(alc.combFilterOrder,expectedCombOrder);
            testCase.verifyEqual(alc.combFilterCoefficients,expectedCombCoefficients,'RelTol',0.001);
            % Difference filter
            testCase.verifyEqual(alc.differenceFilterEnable,expectedDifferenceEnable);
            testCase.verifyEqual(alc.differenceFilterCoefficients,expectedDifferenceCoefficients');
            % Feature parameters
            testCase.verifyEqual(alc.timeWindowSamples,expectedtWs);
            testCase.verifyEqual(alc.overlappingSamples,expectedoWs);
            if alc.controlMode == 0 || alc.controlMode == 3
                testCase.verifyEqual(alc.featuresEnabled, [1 0 0 0 0])
            elseif alc.controlMode == 4
                testCase.verifyEqual(alc.numberOfActiveFeatures,4);
                testCase.verifyEqual(alc.featuresEnabled, [1 0 1 1 1])
            else
                testCase.verifyEqual(alc.numberOfActiveFeatures,4);
                testCase.verifyEqual(alc.featuresEnabled, [1 1 1 1 0])
            end
            % Mask parameters
            testCase.verifyEqual(alc.maskEnable,expectedMaskEnable);
            testCase.verifyEqual(alc.maskCoefficients,expectedMaskCoefficients, 'RelTol',0.001);
            % OB hand parameters
            testCase.verifyEqual(alc.sensitivity, expectedOBparameters.sensitivity, 'RelTol',0.001);
            testCase.verifyEqual(alc.handMinimumSpeed,expectedOBparameters.handMinimumSpeed);
            testCase.verifyEqual(alc.handMaximumSpeed,expectedOBparameters.handMaximumSpeed);
            testCase.verifyEqual(alc.wristMinimumSpeed,expectedOBparameters.wristMinimumSpeed);
            testCase.verifyEqual(alc.wristMaximumSpeed,expectedOBparameters.wristMaximumSpeed);
            testCase.verifyEqual(alc.elbowMinimumSpeed,expectedOBparameters.elbowMinimumSpeed);
            testCase.verifyEqual(alc.elbowMaximumSpeed,expectedOBparameters.elbowMaximumSpeed);
            testCase.verifyEqual(alc.switchPauseCounter,expectedOBparameters.switchPauseCounter);
             % Mia hand parameters
            testCase.verifyEqual(alc.miaParameters.graspControlMode, expectedMiaParameters.graspControlMode);
            testCase.verifyEqual(alc.miaParameters.graspStepSize, expectedMiaParameters.graspStepSize);
            testCase.verifyEqual(alc.miaParameters.graspDiscretization,expectedMiaParameters.graspDiscretization);
            testCase.verifyEqual(alc.miaParameters.graspModeEnabled,expectedMiaParameters.graspModeEnabled);
            testCase.verifyEqual(alc.miaParameters.forceControlEnabled,expectedMiaParameters.forceControlEnabled);
            testCase.verifyEqual(alc.miaParameters.holdOpenEnabled,expectedMiaParameters.holdOpenEnabled);
            testCase.verifyEqual(alc.miaParameters.holdOpenTime,expectedMiaParameters.holdOpenTime);
            testCase.verifyEqual(alc.miaParameters.holdOpenThreshold,expectedMiaParameters.holdOpenThreshold);
            
            % Threshold Ratio Parameters
            testCase.verifyEqual(alc.thresholdRatioParameters, expectedThresholdRatioParameters,'RelTol',0.001)
            
            % NN parameters           
            testCase.verifyEqual(alc.NNCoefficients.nActiveClasses, expectedNNParameters.nActiveClasses, 'RelTol',0.001);
            testCase.verifyEqual(alc.NNCoefficients.nFeatureSets, expectedNNParameters.nFeatureSets, 'RelTol',0.001);
            testCase.verifyEqual(alc.NNCoefficients.weights(1:expectedNNParameters.nActiveClasses,1:expectedNNParameters.nFeatureSets), expectedNNParameters.weights, 'RelTol',0.001);
            testCase.verifyEqual(alc.NNCoefficients.bias(1:expectedNNParameters.nActiveClasses), expectedNNParameters.bias, 'RelTol',0.001);
            testCase.verifyEqual(alc.NNCoefficients.threshold(1:expectedNNParameters.nActiveClasses-1), expectedNNParameters.threshold, 'RelTol',0.001);
            testCase.verifyEqual(alc.NNCoefficients.prostheticOutput(1:expectedNNParameters.nActiveClasses), expectedNNParameters.prostheticOutput);
            testCase.verifyEqual(alc.NNCoefficients.mean(1:expectedNNParameters.nFeatureSets), expectedNNParameters.mean, 'RelTol',0.001);
            testCase.verifyEqual(alc.NNCoefficients.std(1:expectedNNParameters.nFeatureSets), expectedNNParameters.std, 'RelTol',0.001);
            testCase.verifyEqual(alc.NNCoefficients.propThreshold(1:expectedNNParameters.nActiveClasses-1,:), expectedNNParameters.propThreshold, 'RelTol',0.001);
            testCase.verifyEqual(alc.NNCoefficients.floorNoise, expectedNNParameters.floorNoise, 'RelTol',0.001);
            testCase.verifyEqual(alc.NNCoefficients.switchThreshold, expectedNNParameters.switchThreshold, 'RelTol',0.001);
            % Stimulation parameters
            testCase.verifyEqual(alc.stimParameters.mode , expectedStimParameters.mode);
            testCase.verifyEqual(alc.stimParameters.channel , expectedStimParameters.channel);
            testCase.verifyEqual(alc.stimParameters.amplitude , expectedStimParameters.amplitude);
            testCase.verifyEqual(alc.stimParameters.pulseWidth , expectedStimParameters.pulseWidth);
            testCase.verifyEqual(alc.stimParameters.frequency , expectedStimParameters.frequency);
            testCase.verifyEqual(alc.stimParameters.repetitions , expectedStimParameters.repetitions);
            testCase.verifyEqual(alc.stimParameters.modAmpTop , expectedStimParameters.modAmpTop);
            testCase.verifyEqual(alc.stimParameters.modAmpLow , expectedStimParameters.modAmpLow);
            testCase.verifyEqual(alc.stimParameters.modPWTop , expectedStimParameters.modPWTop);
            testCase.verifyEqual(alc.stimParameters.modPWLow , expectedStimParameters.modPWLow);
            testCase.verifyEqual(alc.stimParameters.modFreqTop , expectedStimParameters.modFreqTop);
            testCase.verifyEqual(alc.stimParameters.modFreqLow , expectedStimParameters.modFreqLow);
            testCase.verifyEqual(alc.stimParameters.DESCenable , expectedStimParameters.DESCenable);
            testCase.verifyEqual(alc.stimParameters.DESCchannel , expectedStimParameters.DESCchannel);
            testCase.verifyEqual(alc.stimParameters.DESCamplitude , expectedStimParameters.DESCamplitude);
            testCase.verifyEqual(alc.stimParameters.DESCpulseWidth , expectedStimParameters.DESCpulseWidth);
            testCase.verifyEqual(alc.stimParameters.DESCfrequency , expectedStimParameters.DESCfrequency);
            testCase.verifyEqual(alc.stimParameters.DESCrepetitions , expectedStimParameters.DESCrepetitions);
            testCase.verifyEqual(alc.stimParameters.DESCatSlips , expectedStimParameters.DESCatSlips);
            %Extra channels
            testCase.verifyEqual(alc.extraChannelsMatrix, expectedExtraChannels, 'RelTol',0.001);
           
        end
        
        %% Reset SD card
        %------------------------------------------------------------------

        function testSDreset(testCase)
            
            clear('alc')
            delete(testCase.serialObj);
            instrreset;
          
            
            testCase.serialObj = ALC.createSerialObject(testCase.comPort);
            fprintf('\n')
            flush(testCase.serialObj)
            % Create alc object
            alc = ALC();
            
            % Set all parameters
            expectedFrequency = 1000;
            expectedCompressionEnable = 1;
            expectedFilterEnable = 1;
            expectedCombEnable = 0;
            expectedCombOrder = 0;
            expectedCombCoefficients = [0 0 0];
            expectedDifferenceEnable = 0;
            expectedDifferenceCoefficients = zeros(16,1);
            
            
            % Expected feature parameter
            expectedtWs = 100;
            expectedoWs = 0;
            expectedEnabledFeatures = [1 0 0 0 0];
            expectedNumberOfActiveFeatures = sum(expectedEnabledFeatures);
            
            % Expected Mask parameters
            expectedMaskEnable = 0;
            expectedMaskCoefficients = zeros(5,5);
            
            % Expected OB hand parameters
            expectedOBparameters.sensitivity = 1;
            expectedOBparameters.handMinimumSpeed = 22;
            expectedOBparameters.handMaximumSpeed = 60;
            expectedOBparameters.wristMinimumSpeed = 30;
            expectedOBparameters.wristMaximumSpeed = 100;
            expectedOBparameters.elbowMinimumSpeed = 20;
            expectedOBparameters.elbowMaximumSpeed = 50;
            expectedOBparameters.switchPauseCounter = 0;
            
            % Expected Mia hand parameters
            expectedMiaParameters.graspControlMode = 0;
            expectedMiaParameters.graspStepSize = 0;
            expectedMiaParameters.graspDiscretization = 0;
            expectedMiaParameters.graspModeEnabled = 0;
            expectedMiaParameters.forceControlEnabled = 0;
            expectedMiaParameters.holdOpenEnabled = 0;
            expectedMiaParameters.holdOpenTime = 0;
            expectedMiaParameters.holdOpenThreshold = 0;
            
            % Threshold Ratio parameters
            expectedThresholdRatioParameters = [0 0];
            
            % Expected NN parameters
            expectedNNParameters.nActiveClasses = alc.numberOfClasses;
            expectedNNParameters.nFeatureSets = alc.featuresSize;
            expectedNNParameters.weights = zeros(alc.numberOfClasses,alc.featuresSize);
            expectedNNParameters.bias = zeros(alc.numberOfClasses,1);
            expectedNNParameters.threshold = zeros(alc.numberOfClasses-1,1);
            expectedNNParameters.prostheticOutput = zeros(alc.numberOfClasses,1);
            expectedNNParameters.mean = zeros(alc.featuresSize,1);
            expectedNNParameters.std = zeros(alc.featuresSize,1);
            expectedNNParameters.propThreshold = zeros(expectedNNParameters.nActiveClasses-1,2);
            expectedNNParameters.floorNoise = 0;
            expectedNNParameters.switchThreshold = 0;
            expectedNNParameters.streamEnable = 0;
            
            % Expected Stimulation parameters
            
            expectedStimParameters.mode = 5;
            expectedStimParameters.channel = 0;
            expectedStimParameters.amplitude = 0; % Figure out which values can be used
            expectedStimParameters.pulseWidth = 0;
            expectedStimParameters.frequency = 0;
            expectedStimParameters.repetitions = 0;
            expectedStimParameters.modAmpTop = 0;
            expectedStimParameters.modAmpLow = 0;
            expectedStimParameters.modPWTop = 0;
            expectedStimParameters.modPWLow = 0;
            expectedStimParameters.modFreqTop = 0;
            expectedStimParameters.modFreqLow = 0;
            expectedStimParameters.DESCenable = 0;
            expectedStimParameters.DESCchannel = 0;
            expectedStimParameters.DESCamplitude = 0;
            expectedStimParameters.DESCpulseWidth = 0;
            expectedStimParameters.DESCfrequency = 0;
            expectedStimParameters.DESCrepetitions = 0;
            expectedStimParameters.DESCatSlips = 0;
            
            % Extra channels
            expectedExtraChannels = zeros(8,16);

            

            %% Write all parameters
            fprintf('\n')
            
            pause(0.1);
            alc.setSamplingFrequency(testCase.serialObj, expectedFrequency)
            pause(0.1);
            alc.setCompressionEnable(testCase.serialObj, expectedCompressionEnable) 
            pause(0.1);
            alc.setFiltersEnabled(testCase.serialObj, expectedFilterEnable)
            pause(0.1);
            alc.setCombParameter(testCase.serialObj, expectedCombEnable,  expectedCombOrder, expectedCombCoefficients);
            pause(0.1)
            alc.setDifferenceFilterParameter(testCase.serialObj, expectedDifferenceEnable, expectedDifferenceCoefficients);
            pause(0.1)
            alc.setFeatureParameters(testCase.serialObj,expectedtWs,expectedoWs, expectedNumberOfActiveFeatures,expectedEnabledFeatures)
            pause(0.1);
            alc.setMaskingParameters(testCase.serialObj, expectedMaskCoefficients);
            pause(0.1);
            alc.setHandControlParameters(testCase.serialObj, expectedOBparameters)
            pause(0.1);
            alc.setMiaHandControlParameters(testCase.serialObj, expectedMiaParameters)
            pause(0.1);
            alc.setThresholdRatioParameters(testCase.serialObj, expectedThresholdRatioParameters)
            pause(0.1);
            alc.setNNParameters(testCase.serialObj,expectedNNParameters)
            pause(0.1);
            alc.setStimParameters(testCase.serialObj,expectedStimParameters)
            pause(0.1)
            alc.setExtraChannels(testCase.serialObj, expectedExtraChannels)
            
            %% Pause to turn off/on the ALC
            clear('alc')
            delete(testCase.serialObj);
            instrreset;
            fprintf('Deleting serial object and cleaning up\n')
            
            fig = uifigure;
            selection = '';
            while  ~strcmp(selection, 'Continue')
                selection = uiconfirm(fig,'Restart the ALC. Click "Continue" when the bluetooth connection is paired again','Restart ALC','Icon','info', 'Options',{'Continue'});
            end
            close(fig)
            pause(0.1);
            testCase.serialObj = ALC.createSerialObject(testCase.comPort);
            pause(0.1);
            flush(testCase.serialObj)
            %% Read all parameters
            % Create new alc object
            alc = ALC();
            pause(0.1);
            alc.getAllParameters(testCase.serialObj);


            
            %% Compare expected to actual parameters
            % Sampling Frequency
            testCase.verifyEqual(alc.samplingFrequency,expectedFrequency);
            % Compression algorithm enable
            testCase.verifyEqual(alc.compressionEnable,1); % This should always be enabled after boot
            % Filter enable
            testCase.verifyEqual(alc.filterEnable,expectedFilterEnable);
            % Comb filter
            testCase.verifyEqual(alc.combFilterEnable,expectedCombEnable);
            testCase.verifyEqual(alc.combFilterOrder,expectedCombOrder);
            testCase.verifyEqual(alc.combFilterCoefficients,expectedCombCoefficients,'RelTol',0.001);
            % Difference filter
            testCase.verifyEqual(alc.differenceFilterEnable,expectedDifferenceEnable);
            testCase.verifyEqual(alc.differenceFilterCoefficients,expectedDifferenceCoefficients);
            % Feature parameters
            testCase.verifyEqual(alc.timeWindowSamples,expectedtWs);
            testCase.verifyEqual(alc.overlappingSamples,expectedoWs);
            if alc.controlMode == 0 || alc.controlMode == 3
                testCase.verifyEqual(alc.featuresEnabled, [1 0 0 0 0])
            elseif alc.controlMode == 4
                testCase.verifyEqual(alc.numberOfActiveFeatures,4);
                testCase.verifyEqual(alc.featuresEnabled, [1 0 1 1 1])
            else
                testCase.verifyEqual(alc.numberOfActiveFeatures,4);
                testCase.verifyEqual(alc.featuresEnabled, [1 1 1 1 0])
            end
            % Mask parameters
            testCase.verifyEqual(alc.maskEnable,expectedMaskEnable);
            testCase.verifyEqual(alc.maskCoefficients,expectedMaskCoefficients, 'RelTol',0.001);
            % OB hand parameters
            testCase.verifyEqual(alc.sensitivity, expectedOBparameters.sensitivity, 'RelTol',0.001);
            testCase.verifyEqual(alc.handMinimumSpeed,expectedOBparameters.handMinimumSpeed);
            testCase.verifyEqual(alc.handMaximumSpeed,expectedOBparameters.handMaximumSpeed);
            testCase.verifyEqual(alc.wristMinimumSpeed,expectedOBparameters.wristMinimumSpeed);
            testCase.verifyEqual(alc.wristMaximumSpeed,expectedOBparameters.wristMaximumSpeed);
            testCase.verifyEqual(alc.elbowMinimumSpeed,expectedOBparameters.elbowMinimumSpeed);
            testCase.verifyEqual(alc.elbowMaximumSpeed,expectedOBparameters.elbowMaximumSpeed);
            testCase.verifyEqual(alc.switchPauseCounter,expectedOBparameters.switchPauseCounter);
             % Mia hand parameters
            testCase.verifyEqual(alc.miaParameters.graspControlMode, expectedMiaParameters.graspControlMode);
            testCase.verifyEqual(alc.miaParameters.graspStepSize, expectedMiaParameters.graspStepSize);
            testCase.verifyEqual(alc.miaParameters.graspDiscretization,expectedMiaParameters.graspDiscretization);
            testCase.verifyEqual(alc.miaParameters.graspModeEnabled,expectedMiaParameters.graspModeEnabled);
            testCase.verifyEqual(alc.miaParameters.forceControlEnabled,expectedMiaParameters.forceControlEnabled);
            testCase.verifyEqual(alc.miaParameters.holdOpenEnabled,expectedMiaParameters.holdOpenEnabled);
            testCase.verifyEqual(alc.miaParameters.holdOpenTime,expectedMiaParameters.holdOpenTime);
            testCase.verifyEqual(alc.miaParameters.holdOpenThreshold,expectedMiaParameters.holdOpenThreshold);
            
            % Threshold Ratio Parameters
            testCase.verifyEqual(alc.thresholdRatioParameters, expectedThresholdRatioParameters,'RelTol',0.001)
            
            % NN parameters           
            testCase.verifyEqual(alc.NNCoefficients.nActiveClasses, expectedNNParameters.nActiveClasses, 'RelTol',0.001);
            testCase.verifyEqual(alc.NNCoefficients.nFeatureSets, expectedNNParameters.nFeatureSets, 'RelTol',0.001);
            testCase.verifyEqual(alc.NNCoefficients.weights(1:expectedNNParameters.nActiveClasses,1:expectedNNParameters.nFeatureSets), expectedNNParameters.weights, 'RelTol',0.001);
            testCase.verifyEqual(alc.NNCoefficients.bias(1:expectedNNParameters.nActiveClasses), expectedNNParameters.bias, 'RelTol',0.001);
            testCase.verifyEqual(alc.NNCoefficients.threshold(1:expectedNNParameters.nActiveClasses-1), expectedNNParameters.threshold, 'RelTol',0.001);
            testCase.verifyEqual(alc.NNCoefficients.prostheticOutput(1:expectedNNParameters.nActiveClasses), expectedNNParameters.prostheticOutput);
            testCase.verifyEqual(alc.NNCoefficients.mean(1:expectedNNParameters.nFeatureSets), expectedNNParameters.mean, 'RelTol',0.001);
            testCase.verifyEqual(alc.NNCoefficients.std(1:expectedNNParameters.nFeatureSets), expectedNNParameters.std, 'RelTol',0.001);
            testCase.verifyEqual(alc.NNCoefficients.propThreshold(1:expectedNNParameters.nActiveClasses-1,:), expectedNNParameters.propThreshold, 'RelTol',0.001);
            testCase.verifyEqual(alc.NNCoefficients.floorNoise, expectedNNParameters.floorNoise, 'RelTol',0.001);
            testCase.verifyEqual(alc.NNCoefficients.switchThreshold, expectedNNParameters.switchThreshold, 'RelTol',0.001);
            % Stimulation parameters
            testCase.verifyEqual(alc.stimParameters.mode , expectedStimParameters.mode);
            testCase.verifyEqual(alc.stimParameters.channel , expectedStimParameters.channel);
            testCase.verifyEqual(alc.stimParameters.amplitude , expectedStimParameters.amplitude);
            testCase.verifyEqual(alc.stimParameters.pulseWidth , expectedStimParameters.pulseWidth);
            testCase.verifyEqual(alc.stimParameters.frequency , expectedStimParameters.frequency);
            testCase.verifyEqual(alc.stimParameters.repetitions , expectedStimParameters.repetitions);
            testCase.verifyEqual(alc.stimParameters.modAmpTop , expectedStimParameters.modAmpTop);
            testCase.verifyEqual(alc.stimParameters.modAmpLow , expectedStimParameters.modAmpLow);
            testCase.verifyEqual(alc.stimParameters.modPWTop , expectedStimParameters.modPWTop);
            testCase.verifyEqual(alc.stimParameters.modPWLow , expectedStimParameters.modPWLow);
            testCase.verifyEqual(alc.stimParameters.modFreqTop , expectedStimParameters.modFreqTop);
            testCase.verifyEqual(alc.stimParameters.modFreqLow , expectedStimParameters.modFreqLow);
            testCase.verifyEqual(alc.stimParameters.DESCenable , expectedStimParameters.DESCenable);
            testCase.verifyEqual(alc.stimParameters.DESCchannel , expectedStimParameters.DESCchannel);
            testCase.verifyEqual(alc.stimParameters.DESCamplitude , expectedStimParameters.DESCamplitude);
            testCase.verifyEqual(alc.stimParameters.DESCpulseWidth , expectedStimParameters.DESCpulseWidth);
            testCase.verifyEqual(alc.stimParameters.DESCfrequency , expectedStimParameters.DESCfrequency);
            testCase.verifyEqual(alc.stimParameters.DESCrepetitions , expectedStimParameters.DESCrepetitions);
            testCase.verifyEqual(alc.stimParameters.DESCatSlips , expectedStimParameters.DESCatSlips);
            %Extra channels
            testCase.verifyEqual(alc.extraChannelsMatrix, expectedExtraChannels, 'RelTol',0.001);
           
        end
        
        
        function testgetSDBlocks(testCase)
            clear('alc')
            delete(testCase.serialObj);
            instrreset;
            fprintf('Deleting serial object and cleaning up\n')
            
            fig = uifigure;
            selection = '';
            while  ~strcmp(selection, 'Continue')
                selection = uiconfirm(fig,'Restart the ALC. Click "Continue" when the bluetooth connection is paired again','Restart ALC','Icon','info', 'Options',{'Continue'});
            end
            close(fig)
            pause(0.1);
            testCase.serialObj = ALC.createSerialObject(testCase.comPort);
            pause(0.1);
            flush(testCase.serialObj)
            %% Do Test
            alc = ALC();
            pause(0.1)
            alc.getSDBlockID(testCase.serialObj);
            currID = alc.sdBlockID;
            alc.getStatus(testCase.serialObj);
            pause(0.1);
            currSDBlocks = alc.sdBlocks;
            alc.getSDBlocks(testCase.serialObj,1,0);
            pause(0.1)
            alc.getStatus(testCase.serialObj);
            % debug this and see how things go
            testCase.verifyNotEqual(alc.sdBlocks, currSDBlocks)
            pause(0.1)
            alc.resetSDBlockID(testCase.serialObj);
            pause(0.1)
            alc.getStatus(testCase.serialObj);
            testCase.verifyEqual(alc.sdCard,1)
            alc.getSDBlockID(testCase.serialObj);
            testCase.verifyNotEqual(alc.sdBlockID,currID);
        end
        
        
    
        
    end
end

