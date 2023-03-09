classdef UnitTest1_SetGetParameters< matlab.unittest.TestCase
    
    properties
        serialObj
    end
    
    methods
        function testCase = UnitTest1_SetGetParameters()
            delete(instrfindall);
            ports = serialportlist;
            [index,inputMade] = listdlg('ListString',ports, 'SelectionMode','single');

            if ~inputMade
                error('UnitTests1:ListDialogError','No Port Selected')
            end
            comPort = ports(index);

            testCase.serialObj = ALC.createSerialObject(comPort);
            
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
        
        %% Test set command and control mode
        %------------------------------------------------------------------
        % Switch between command mode and control mode
        function testCommandMode(testCase)
            
            alc = ALC();
            fprintf('\n')
            expectedMode = 1;
            pause(0.1);
            alc.setCommandMode(testCase.serialObj)
            
            testCase.verifyEqual(alc.alcdMode,expectedMode);
            
            expectedMode = 0;
            pause(0.1);
            alc.setControlMode(testCase.serialObj)
            
            testCase.verifyEqual(alc.alcdMode,expectedMode);
        end
        
        %% Test enables/disables
        
        %% Set signal acquisition parameter commands
        %------------------------------------------------------------------
        
        function testIncorrectSamplingFrequency(testCase)
            % to be added - ensure the filter is not enabled
            alc = ALC();
            fprintf('\n')
            alc.getStatus(testCase.serialObj);
            pause(0.1);
            expectedFrequency = alc.samplingFrequency;
            
            % Set and invalid test frequency (sF!=100 && sF!=150 && sF!=250
            % && sF!=500 && sF!=1000 && sF!=2000) - those are the valid
            % test frequencies
            incorrectFrequency = 10000;
            alc.setSamplingFrequency(testCase.serialObj, incorrectFrequency)
            pause(0.1);
            alc.getStatus(testCase.serialObj);
            pause(0.1);
            %actualFrequency = alc.samplingFrequency;
            %testCase.verifyEqual(actualFrequency,expectedFrequency);
            expectedEnable = 0; % not enabled
            testCase.verifyEqual(alc.filterEnable,expectedEnable);
            
            % Set another invalid test frequency 
            incorrectFrequency = 0;
            alc.setSamplingFrequency(testCase.serialObj, incorrectFrequency)
            pause(0.1);
            alc.getStatus(testCase.serialObj);
            pause(0.1);
            %actualFrequency = alc.samplingFrequency;
            %testCase.verifyEqual(actualFrequency,expectedFrequency);
            expectedEnable = 0; % not enabled
            testCase.verifyEqual(alc.filterEnable,expectedEnable);
            
            % Set another invalid test frequency 
            incorrectFrequency = 2;
            alc.setSamplingFrequency(testCase.serialObj, incorrectFrequency)
            pause(0.1);
            alc.getStatus(testCase.serialObj);
            pause(0.1);
            %actualFrequency = alc.samplingFrequency;
            %testCase.verifyEqual(actualFrequency,expectedFrequency);
            expectedEnable = 0; % not enabled
            testCase.verifyEqual(alc.filterEnable,expectedEnable);
        end
        
        function testNegativeSamplingFrequency(testCase)
            alc = ALC();
            fprintf('\n')
            alc.getStatus(testCase.serialObj);
            pause(0.1);
            expectedFrequency = alc.samplingFrequency;
            
            % Set and invalid test frequency (sF!=100 && sF!=150 && sF!=250
            % && sF!=500 && sF!=1000 && sF!=2000) - those are the valid
            % test frequencies
            incorrectFrequency = -200;
            alc.setSamplingFrequency(testCase.serialObj, incorrectFrequency)
            pause(0.1);
            alc.getStatus(testCase.serialObj);
            pause(0.1);
            
            expectedEnable = 0; % not enabled
            
            testCase.verifyEqual(alc.filterEnable,expectedEnable);
            
            
        end
        
        function testSamplingFrequency(testCase)
            
            alc = ALC();
            fprintf('\n')
            expectedFrequency = 250;
            pause(0.1);
            alc.setSamplingFrequency(testCase.serialObj, expectedFrequency)
            pause(0.1);
            alc.getStatus(testCase.serialObj);
            actualFrequency = alc.samplingFrequency;
            
            testCase.verifyEqual(actualFrequency,expectedFrequency);
            
            % Reset sampling frequency
            
            expectedFrequency = 1000;
            pause(0.1);
            alc.setSamplingFrequency(testCase.serialObj, expectedFrequency)
            pause(0.1);
            alc.getStatus(testCase.serialObj);
            actualFrequency = alc.samplingFrequency;
            
            testCase.verifyEqual(actualFrequency,expectedFrequency);
            
        end
        
        function testCompressionEnable(testCase)
            alc = ALC();
            fprintf('\n')
            expectedEnable = 0;
            pause(0.1);
            alc.setCompressionEnable(testCase.serialObj, expectedEnable)
            
            testCase.verifyEqual(alc.compressionEnable,expectedEnable);
            
            expectedEnable = 1;
            pause(0.1);
            alc.setCompressionEnable(testCase.serialObj, expectedEnable)
            
            testCase.verifyEqual(alc.compressionEnable,expectedEnable);
            
        end
        %% Test set/get signal processing parameter commands
        %------------------------------------------------------------------
        function testFiltersEnabled(testCase)
            alc = ALC();
            fprintf('\n')
            expectedEnable = 0;
            pause(0.1);
            alc.setFiltersEnabled(testCase.serialObj, expectedEnable)
            
            testCase.verifyEqual(alc.filterEnable,expectedEnable);
            
            expectedEnable = 1;
            pause(0.1);
            alc.setFiltersEnabled(testCase.serialObj, expectedEnable)
            
            testCase.verifyEqual(alc.filterEnable,expectedEnable);
        end
        
        function testCombFilterParameters(testCase)
            alc = ALC();
            fprintf('\n')
            expectedEnable = 1;
            expectedOrder = 10;
            expectedCoefficients = [1 2 3];
            pause(0.1);
            alc.setCombParameter(testCase.serialObj, expectedEnable,  expectedOrder, expectedCoefficients);
            pause(0.1);
            alc.getCombParameter(testCase.serialObj);
            actualEnable = alc.combFilterEnable;
            actualOrder = alc.combFilterOrder;
            actualCoefficients = alc.combFilterCoefficients;
            
            testCase.verifyEqual(actualEnable,expectedEnable);
            testCase.verifyEqual(actualOrder,expectedOrder);
            testCase.verifyEqual(actualCoefficients,expectedCoefficients);
            
            % Reset comb filter
            expectedEnable = 0;
            expectedOrder = 0;
            expectedCoefficients = [0 0 0];
            pause(0.1);
            alc.setCombParameter(testCase.serialObj, expectedEnable,  expectedOrder, expectedCoefficients);
            pause(0.1);
            alc.getCombParameter(testCase.serialObj);
            actualEnable = alc.combFilterEnable;
            actualOrder = alc.combFilterOrder;
            actualCoefficients = alc.combFilterCoefficients;
            
            testCase.verifyEqual(actualEnable,expectedEnable);
            testCase.verifyEqual(actualOrder,expectedOrder);
            testCase.verifyEqual(actualCoefficients,expectedCoefficients);
        end
        
        % this will break everything at the moment - but further
        % development is needed for this type of error
%         function testIncorrectCombFilterParameters(testCase)
%             alc = ALC();
%             fprintf('\n')
%             expectedEnable = 1;
%             expectedOrder = 300; %255 is the highest for a uint8_t
%             expectedCoefficients = [1 2 3];
%             pause(0.1);
%             alc.setCombParameter(testCase.serialObj, expectedEnable,  expectedOrder, expectedCoefficients);
%             pause(0.1);
%             alc.getCombParameter(testCase.serialObj);
%             actualEnable = alc.combFilterEnable;
%             actualOrder = alc.combFilterOrder;
%             actualCoefficients = alc.combFilterCoefficients;
%             
%             testCase.verifyEqual(actualEnable,expectedEnable);
%             testCase.verifyEqual(actualOrder,expectedOrder);
%             testCase.verifyEqual(actualCoefficients,expectedCoefficients);
%         end
       
        function testDifferenceFilterParameters(testCase)
            alc = ALC();
            fprintf('\n')
            expectedCoefficients = [1:16]';
            expectedEnable = 1;
            pause(0.1);
            alc.setDifferenceFilterParameter(testCase.serialObj, expectedEnable, expectedCoefficients);
            pause(0.1);
            alc.getDifferenceFilterParameter(testCase.serialObj);
            actualEnable = alc.differenceFilterEnable;
            actualCoefficients = alc.differenceFilterCoefficients;
            
            testCase.verifyEqual(actualEnable,expectedEnable);
            testCase.verifyEqual(actualCoefficients,expectedCoefficients);
            
            % Reset difference filter
            expectedCoefficients = zeros(16,1);
            expectedEnable = 0;
            pause(0.1);
            alc.setDifferenceFilterParameter(testCase.serialObj, expectedEnable, expectedCoefficients);
            pause(0.1);
            alc.getDifferenceFilterParameter(testCase.serialObj);
            actualEnable = alc.differenceFilterEnable;
            actualCoefficients = alc.differenceFilterCoefficients;
            
            testCase.verifyEqual(actualEnable,expectedEnable);
            testCase.verifyEqual(actualCoefficients,expectedCoefficients);
        end
        
        %% Test on/off Raw Acqusition 
        %------------------------------------------------------------------            
        function testRawACQ(testCase)
            % FSM state: ACQUIRE_EMG = 1
            % Mode: Command Mode = 1
            alc = ALC();
            fprintf('\n')
            expectedALCDState = 1;   
            expectedALCDMode = 1;
            alc.startRawACQ(testCase.serialObj);
            pause(0.4);% was pause(0.4)
            actualACQ_EMG = alc.alcdState;
            actualALCDMode = alc.alcdMode;
            testCase.verifyEqual(actualACQ_EMG,expectedALCDState);
            testCase.verifyEqual(actualALCDMode,expectedALCDMode);
            pause(0.1);
            alc.stopACQ(testCase.serialObj);
            pause(0.1);
            expectedALCDState = 0;
            actualACQ_EMG = alc.alcdState;
            testCase.verifyEqual(actualACQ_EMG,expectedALCDState);
        end
         
        %% Test on/off Features ACQ
        function teststartFeaturesACQ(testCase)
            % FSM state: ACQUIRE_INCREMENT_TW = 2
            % Mode: STREAMING_FEATURES = 4 
            alc = ALC();
            fprintf('\n')
            expectedALCDState = 2;
            expectedALCDMode = 4;
            alc.startFeaturesACQ(testCase.serialObj);
            pause(0.1);
            actualACQ_EMG = alc.alcdState;
            actualALCDMode = alc.alcdMode;
            testCase.verifyEqual(actualACQ_EMG,expectedALCDState);
            testCase.verifyEqual(actualALCDMode,expectedALCDMode);
            pause(0.1);
            alc.stopACQ(testCase.serialObj);
            pause(0.1);
            expectedALCDState = 0;
            actualACQ_EMG = alc.alcdState;
            testCase.verifyEqual(actualACQ_EMG,expectedALCDState);
            
        end
        
          %% Test on/off ClosedLoop ACQ
        function teststartClosedLoopACQ(testCase)
            % FSM state: ACQUIRE_INCREMENT_TW = 2
            % Mode: STREAM_FEATURES_AND_CONTROL = 6
            alc = ALC();
            fprintf('\n')
            expectedALCDState = 2;  
            expectedALCDMode = 6;
            alc.startClosedLoopACQ(testCase.serialObj);
            pause(0.1);
            actualACQ_EMG = alc.alcdState;
            actualALCDMode = alc.alcdMode;
            testCase.verifyEqual(actualACQ_EMG,expectedALCDState);
            testCase.verifyEqual(actualALCDMode,expectedALCDMode);
            pause(0.1);
            alc.stopACQ(testCase.serialObj);
            pause(0.1);
            expectedALCDState = 0;
            actualACQ_EMG = alc.alcdState;
            testCase.verifyEqual(actualACQ_EMG,expectedALCDState);
            
        end
        %% Test on/off Closed Loop Sensing
        function teststartSensoryACQ(testCase)
            % FSM state: ACQUIRE_INCREMENT_TW = 2
            % Mode: STREAM_SENSORS_AND_CONTROL = 7
            alc = ALC();
            fprintf('\n')
            expectedALCDState = 2;  
            expectedALCDMode = 7;
            alc.startSensoryACQ(testCase.serialObj);
            pause(0.1);
            actualACQ_EMG = alc.alcdState;
            actualALCDMode = alc.alcdMode;
            testCase.verifyEqual(actualACQ_EMG,expectedALCDState);
            testCase.verifyEqual(actualALCDMode,expectedALCDMode);
            pause(0.1);
            alc.stopACQ(testCase.serialObj);
            pause(0.1);
            expectedALCDState = 0;
            actualACQ_EMG = alc.alcdState;
            testCase.verifyEqual(actualACQ_EMG,expectedALCDState); 
        end       
        
        
        
        %% Test set/get feature processing parameter commands
        %------------------------------------------------------------------      
        function testFeatureParameters(testCase)
            alc = ALC();
            fprintf('\n')
            expectedtWs = 50;
            expectedoWs = 25;
            expectedEnabledFeatures = randi([0, 1], [1, 5]);
            expectedNumberOfActiveFeatures = sum(expectedEnabledFeatures);
            pause(0.1);
            alc.setFeatureParameters(testCase.serialObj,expectedtWs,expectedoWs, ...
                expectedNumberOfActiveFeatures,expectedEnabledFeatures)
            pause(0.1);
            alc.getStatus(testCase.serialObj);
            actualtWs = alc.timeWindowSamples;
            actualoWs = alc.overlappingSamples;
            actualNumberOfActiveFeatures = alc.numberOfActiveFeatures;
            
            %ToDO add actualEnabledFeatures
            
            testCase.verifyEqual(actualtWs,expectedtWs);
            testCase.verifyEqual(actualoWs,expectedoWs);
            testCase.verifyEqual(actualNumberOfActiveFeatures,expectedNumberOfActiveFeatures);
            
            % Reset feature parameters
            
            expectedtWs = 100;
            expectedoWs = 0;
            expectedEnabledFeatures = [1 0 0 0 0];
            expectedNumberOfActiveFeatures = length(find(expectedEnabledFeatures));
            pause(0.1);
            alc.setFeatureParameters(testCase.serialObj,expectedtWs,expectedoWs, ...
                expectedNumberOfActiveFeatures,expectedEnabledFeatures)
            pause(0.1);
            alc.getStatus(testCase.serialObj);
            actualtWs = alc.timeWindowSamples;
            actualoWs = alc.overlappingSamples;
            actualNumberOfActiveFeatures = alc.numberOfActiveFeatures;
            
            %ToDO add actualEnabledFeatures
            
            testCase.verifyEqual(actualtWs,expectedtWs);
            testCase.verifyEqual(actualoWs,expectedoWs);
            testCase.verifyEqual(actualNumberOfActiveFeatures,expectedNumberOfActiveFeatures);
            
        end
        
        function testMaskParameters(testCase)
            alc = ALC();
            fprintf('\n')
            expectedCoefficients = reshape(1:25,5,5);
            pause(0.1);
            alc.setMaskingParameters(testCase.serialObj, expectedCoefficients);
            pause(0.1);
            alc.getMaskingParameters(testCase.serialObj);
            actualCoefficients = alc.maskCoefficients;
            
            testCase.verifyEqual(actualCoefficients,expectedCoefficients);
            
            % Reset mask
            expectedCoefficients = zeros(5,5);
            pause(0.1);
            alc.setMaskingParameters(testCase.serialObj, expectedCoefficients);
            pause(0.1);
            alc.getMaskingParameters(testCase.serialObj);
            actualCoefficients = alc.maskCoefficients;
            
            testCase.verifyEqual(actualCoefficients,expectedCoefficients);
        end
        
        %% Test set/get control parameter commands
        %------------------------------------------------------------------  
        function testNNParameters(testCase)
            alc = ALC();
            fprintf('\n')
            
            expectedParameters.nActiveClasses = randi([2 alc.numberOfClasses]);
            expectedParameters.nFeatureSets = randi([1 alc.numberOfFeatures])*randi([1 alc.numberOfChannels]);
            expectedParameters.weights = -1 + 2*rand(expectedParameters.nActiveClasses,expectedParameters.nFeatureSets);
            expectedParameters.bias = -1 + 2*rand(expectedParameters.nActiveClasses,1);
            expectedParameters.threshold = rand(expectedParameters.nActiveClasses-1,1);
            expectedParameters.prostheticOutput = randi([0,130],expectedParameters.nActiveClasses,1);
            expectedParameters.mean = rand(expectedParameters.nFeatureSets,1);
            expectedParameters.std = rand(expectedParameters.nFeatureSets,1);
            expectedParameters.propThreshold = rand(expectedParameters.nActiveClasses-1,2);
            expectedParameters.floorNoise = rand(1,1);
            expectedParameters.switchThreshold = rand(1,1);
            expectedParameters.streamEnable = 0;
            pause(0.1);
            alc.setNNParameters(testCase.serialObj,expectedParameters)
            alc.getNNParameters(testCase.serialObj)
            
            testCase.verifyEqual(alc.NNCoefficients.nActiveClasses, expectedParameters.nActiveClasses, 'RelTol',0.001);
            testCase.verifyEqual(alc.NNCoefficients.nFeatureSets, expectedParameters.nFeatureSets, 'RelTol',0.001);
            testCase.verifyEqual(alc.NNCoefficients.weights(1:expectedParameters.nActiveClasses,1:expectedParameters.nFeatureSets), expectedParameters.weights, 'RelTol',0.001);
            testCase.verifyEqual(alc.NNCoefficients.bias(1:expectedParameters.nActiveClasses), expectedParameters.bias, 'RelTol',0.001);
            testCase.verifyEqual(alc.NNCoefficients.threshold(1:expectedParameters.nActiveClasses-1), expectedParameters.threshold, 'RelTol',0.001);
            testCase.verifyEqual(alc.NNCoefficients.prostheticOutput(1:expectedParameters.nActiveClasses), expectedParameters.prostheticOutput);
            testCase.verifyEqual(alc.NNCoefficients.mean(1:expectedParameters.nFeatureSets), expectedParameters.mean, 'RelTol',0.001);
            testCase.verifyEqual(alc.NNCoefficients.std(1:expectedParameters.nFeatureSets), expectedParameters.std, 'RelTol',0.001);
            testCase.verifyEqual(alc.NNCoefficients.propThreshold(1:expectedParameters.nActiveClasses-1,:), expectedParameters.propThreshold, 'RelTol',0.001);
            testCase.verifyEqual(alc.NNCoefficients.floorNoise, expectedParameters.floorNoise, 'RelTol',0.001);
            testCase.verifyEqual(alc.NNCoefficients.switchThreshold, expectedParameters.switchThreshold, 'RelTol',0.001);
            
            
            % Reset NN parameters 
            expectedParameters.nActiveClasses = alc.numberOfClasses;
            expectedParameters.nFeatureSets = alc.featuresSize;
            expectedParameters.weights = zeros(alc.numberOfClasses,alc.featuresSize);
            expectedParameters.bias = zeros(alc.numberOfClasses,1);
            expectedParameters.threshold = zeros(alc.numberOfClasses-1,1);
            expectedParameters.prostheticOutput = zeros(alc.numberOfClasses,1);
            expectedParameters.mean = zeros(alc.featuresSize,1);
            expectedParameters.std = zeros(alc.featuresSize,1);
            expectedParameters.propThreshold = zeros(expectedParameters.nActiveClasses-1,2);
            expectedParameters.floorNoise = 0;
            expectedParameters.switchThreshold = 0;
            expectedParameters.streamEnable = 0;
            pause(0.1);
            alc.setNNParameters(testCase.serialObj,expectedParameters)
            alc.getNNParameters(testCase.serialObj)
            
            testCase.verifyEqual(alc.NNCoefficients.nActiveClasses, expectedParameters.nActiveClasses);
            testCase.verifyEqual(alc.NNCoefficients.nFeatureSets, expectedParameters.nFeatureSets);
            testCase.verifyEqual(alc.NNCoefficients.weights, expectedParameters.weights);
            testCase.verifyEqual(alc.NNCoefficients.bias, expectedParameters.bias);
            testCase.verifyEqual(alc.NNCoefficients.threshold, expectedParameters.threshold);
            testCase.verifyEqual(alc.NNCoefficients.prostheticOutput, expectedParameters.prostheticOutput);
            testCase.verifyEqual(alc.NNCoefficients.mean, expectedParameters.mean);
            testCase.verifyEqual(alc.NNCoefficients.std, expectedParameters.std);
            testCase.verifyEqual(alc.NNCoefficients.propThreshold, expectedParameters.propThreshold, 'RelTol',0.001);
            testCase.verifyEqual(alc.NNCoefficients.floorNoise, expectedParameters.floorNoise);
            testCase.verifyEqual(alc.NNCoefficients.switchThreshold, expectedParameters.switchThreshold, 'RelTol',0.001);
            
            
        end
        
        function testControlAlgorithm(testCase)
            
            alc = ALC();
            fprintf('\n')
            
            
            % Set to majority vote
            expectedAlgorithm = 1;
            expectedSteps = 5;
            pause(0.1);
            alc.setControlAlgorithm(testCase.serialObj,expectedAlgorithm,expectedSteps,0)
            alc.getStatus(testCase.serialObj)
            
            testCase.verifyEqual(alc.controlAlgorithm,expectedAlgorithm);
            testCase.verifyEqual(alc.mvSteps,expectedSteps);
            
            % Set ramp
            expectedAlgorithm = 2;
            expectedRampLength = 3;
            expectedRampMode = 1;
            pause(0.1);
            alc.setControlAlgorithm(testCase.serialObj,expectedAlgorithm,expectedRampLength, expectedRampMode)
            alc.getStatus(testCase.serialObj)
            testCase.verifyEqual(alc.controlAlgorithm,expectedAlgorithm);
            testCase.verifyEqual(alc.rampLength, expectedRampLength );
            testCase.verifyEqual(alc.rampMode, expectedRampMode);
            
            % Set to no algorithm
            expectedAlgorithm = 0;
            pause(0.1);
            alc.setControlAlgorithm(testCase.serialObj,expectedAlgorithm,0,0)
            alc.getStatus(testCase.serialObj)
            testCase.verifyEqual(alc.controlAlgorithm,expectedAlgorithm);
            
            
            % Set DelicateGrasp
            expectedAlgorithm = 3;
            pause(0.1);
            alc.setControlAlgorithm(testCase.serialObj,expectedAlgorithm,0,0)
            alc.getStatus(testCase.serialObj)
            testCase.verifyEqual(alc.controlAlgorithm,expectedAlgorithm)

            % this doesnt work as the NCALfit code throws an exception - we
            % could test that ... idk
%             % Set Inertial
%             expectedAlgorithm = 4;
%             pause(0.1);
%             alc.setControlAlgorithm(testCase.serialObj,expectedAlgorithm,0,0)
%             alc.getStatus(testCase.serialObj)
%             testCase.verifyEqual(alc.controlAlgorithm,expectedAlgorithm)
            
            
%             % Set undefined Control Algorithm
%             expectedAlgorithm = 99;
%             alc.setControlAlgorithm(testCase.serialObj,expectedAlgorithm,0,0)
%             alc.getStatus(testCase.serialObj)
%             testCase.verifyEqual(alc.controlAlgorithm,expectedAlgorithm)
        end
   
        
        function testExtraChannels(testCase)
            
            alc = ALC();
            fprintf('\n')

            expectedExtraChannels = rand(8,16);
            
            pause(0.1)
            alc.setExtraChannels(testCase.serialObj, expectedExtraChannels)
            
            pause(0.1)
            alc.getExtraChannels(testCase.serialObj)
            
            testCase.verifyEqual(alc.extraChannelsMatrix,expectedExtraChannels, 'RelTol',0.001);
            
            % Reset
            expectedExtraChannels = zeros(8,16);
            
            pause(0.1)
            alc.setExtraChannels(testCase.serialObj, expectedExtraChannels)
            
            pause(0.1)
            alc.getExtraChannels(testCase.serialObj)
            
            testCase.verifyEqual(alc.extraChannelsMatrix,expectedExtraChannels, 'RelTol',0.001);
            

        end
        
        %% Test Update LDA Coefficients 
        function testUpdateLDACoeff(testCase)
            %UPDATE_LDA_COEFF
            % check controlMode
            % check coeffecients
            % check handshaking
        end
       

        
%         function testsetTooBigHandControlParameters(testCase)
%             %  default settings from GUI autofill
%             alc = ALC();
%             expectedhandParameters.sensitivity = 1;
%             expectedhandParameters.handMinimumSpeed = 300; % this should fail
%             expectedhandParameters.handMaximumSpeed = 60;
%             expectedhandParameters.wristMinimumSpeed = 30;
%             expectedhandParameters.wristMaximumSpeed = 100;
%             expectedhandParameters.elbowMinimumSpeed = 20;
%             expectedhandParameters.elbowMaximumSpeed = 50;
%             expectedhandParameters.switchPauseCounter = 0; % i am not sure what this is
%             
%             alc.setHandControlParameters(testCase.serialObj,expectedhandParameters);
%             pause(0.1)
% %             str = strcat(string(expectedhandParameters.handMinimumSpeed)," is too big for datatype ","uint8");
% %             
% %             testCase.verifyError(testCase,alc.setHandControlParameters(testCase.serialObj,expectedhandParameters),'ALCwrite:TooBig');
% %             pause(0.1)
% %             alc.getStatus(testCase.serialObj);
%             
%             %lasterror = lasterr;
%             %testCase.verifyError(str,lasterror,identifier)
%             testCase.verifyEqual(alc.sensitivity,expectedhandParameters.sensitivity);
%             testCase.verifyEqual(alc.handMinimumSpeed,expectedhandParameters.handMinimumSpeed);
%             testCase.verifyEqual(alc.handMaximumSpeed,expectedhandParameters.handMaximumSpeed);
%             testCase.verifyEqual(alc.wristMinimumSpeed,expectedhandParameters.wristMinimumSpeed);
%             testCase.verifyEqual(alc.wristMaximumSpeed,expectedhandParameters.wristMaximumSpeed);
%             testCase.verifyEqual(alc.elbowMinimumSpeed,expectedhandParameters.elbowMinimumSpeed);
%             testCase.verifyEqual(alc.elbowMaximumSpeed,expectedhandParameters.elbowMaximumSpeed);
%             testCase.verifyEqual(alc.switchPauseCounter,expectedhandParameters.switchPauseCounter);
%             
%         end
        
    function testsetMotorEnable(testCase)
        alc = ALC();
        expectedflag =1;
        alc.setMotorEnable(testCase.serialObj, expectedflag);
        pause(0.1)
        alc.getStatus(testCase.serialObj);
        testCase.verifyEqual(alc.motorEnable ,expectedflag);
        pause(0.1)
        % reset value
        alc.setMotorEnable(testCase.serialObj, 0);
    end
    
    
%     function testSetMiaHandControlParametersSSSA(testCase)
%         alc = ALC();
%         %%Expected Mia Parameters - standards from original object
% %         alc.getStatus(testCase.serialObj);
% %         curMiaMinActivationThreshold = alc.miaMinActivationThreshold;
% %         curMiaSensitivity = alc.miaSensitivity;
% %         curMiaMinimumSpeed = alc.miaMinimumSpeed;
% %         curMiaMaximumSpeed = alc.miaMaximumSpeed;
% %         curMiaMinModulationSpeedStep = alc.miaMinModulationSpeedStep;
% %         curMiaMaxModulationSpeedStep = alc.miaMaxModulationSpeedStep;
% %         curMiaMinPwm = alc.miaMinPwm;
% %         curMiaMaxPWM = alc.miaMaxPWM;
%         
%         expectmiaMinActivationThreshold = 12;
%         expectmiaSensitivity = 1.0;
%         expectmiaMinimumSpeed = 2;
%         expectmiaMaximumSpeed = 60;
%         expectmiaMinModulationSpeedStep = 2;
%         expectmiaMaxModulationSpeedStep = 6;
%         expectmiaMinPwm = 40;
%         expectmiaMaxPWM = 70;
%         
%         alc.setMiaHandControlParametersSSSA(testCase.serialObj,expectmiaMinActivationThreshold, expectmiaSensitivity, expectmiaMinimumSpeed,expectmiaMaximumSpeed, ...
%                                           expectmiaMinModulationSpeedStep, expectmiaMaxModulationSpeedStep, expectmiaMinPwm, expectmiaMaxPWM);
%         pause(5)
%         
%         alc.getStatus(testCase.serialObj);
%         pause(0.2)
%         testCase.verifyEqual(alc.miaMinActivationThreshold,expectmiaMinActivationThreshold);
%         testCase.verifyEqual(alc.miaSensitivity,expectmiaSensitivity);
%         testCase.verifyEqual(alc.miaMinimumSpeed,expectmiaMinimumSpeed);
%         testCase.verifyEqual(alc.miaMaximumSpeed,expectmiaMaximumSpeed);
%         testCase.verifyEqual(alc.miaMinModulationSpeedStep,expectmiaMinModulationSpeedStep);
%         testCase.verifyEqual(alc.miaMaxModulationSpeedStep,expectmiaMaxModulationSpeedStep);
%         testCase.verifyEqual(alc.miaMinPwm,expectmiaMinPwm);
%         testCase.verifyEqual(alc.miaMaxPwm,expectmiaMaxPwm);
%         pause(0.1)
%         % reset ALC mia params
% %         alc.setMiaHandControlParametersSSSA(testCase.serialObj,curMiaMinActivationThreshold, curMiaSensitivity, curMiaMinimumSpeed,curMiaMaximumSpeed, ...
% %                                           curMiaMinModulationSpeedStep, curMiaMaxModulationSpeedStep, curMiaMinPwm, curMiaMaxPWM);
%      end

%% Test ProportionalControl Parameters
        function  testsetProportionalControlParameters(testCase)
            alc = ALC();
            expectparameterStruct.strengthFilterLength = 23; %random value as long as less that 255
            alc.setProportionalControlParameters(testCase.serialObj, expectparameterStruct);
            pause(0.1);
            alc.getStatus(testCase.serialObj);
            testCase.verifyEqual(alc.proportionalParameters.strengthFilterLength, expectparameterStruct.strengthFilterLength);
        end
        
        function testgetProportionalControlParamters(testCase)
            % tests to make sure that the getProp works - also resets the
            % value to 0
            alc = ALC();
            expectparameterStruct.strengthFilterLength = 0; %random value as long as less that 255 - note [] doesnt work currently
            alc.setProportionalControlParameters(testCase.serialObj, expectparameterStruct);           
            alc.getProportionalControlParameters(testCase.serialObj);
            pause(0.1);
            %alc.getStatus(testCase.serialObj);
            testCase.verifyEqual(alc.proportionalParameters.strengthFilterLength, expectparameterStruct.strengthFilterLength);
        end
        
        
        function testsetActiveChannels(testCase)
            alc = ALC();
            alc.getStatus(testCase.serialObj);
            curractiveChannels = alc.activeChannels;
            expectactiveChannels = [1 2 3 4];
            alc.setActiveChannels(testCase.serialObj, expectactiveChannels);
            pause(0.1);
            alc.getStatus(testCase.serialObj);
            testCase.verifyEqual(alc.activeChannels,expectactiveChannels);
            pause(0.1)
            alc.setActiveChannels(testCase.serialObj,curractiveChannels );
        end
        
        function testMaxActiveChannels(testCase)
            alc = ALC();
            alc.getStatus(testCase.serialObj);
            curractiveChannels = alc.activeChannels;
            sentChannels = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24];
            expectactiveChannels = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24];
            alc.setActiveChannels(testCase.serialObj, sentChannels);
            pause(0.1);
            alc.getStatus(testCase.serialObj);
            testCase.verifyEqual(alc.activeChannels,expectactiveChannels);
            pause(0.1)
            alc.setActiveChannels(testCase.serialObj,curractiveChannels );
        end
        
        function testsetFeatureCombinationCoefficients(testCase)
            % this has no verification of the data only handshaking in
            % function so that needs development
            alc = ALC();
            alc.getStatus(testCase.serialObj);
            curractiveChannels=alc.activeChannels;
            activeChannels = 6;
            enable = 1;
            coefficients = [1 3 490 123 3.4 7]; % I am not sure a typical length or a typical coefficient
            alc.setFeatureCombinationCoefficients(testCase.serialObj,enable,coefficients,activeChannels);
            pause(0.1)
            alc.setFeatureCombinationCoefficients(testCase.serialObj,0,zeros(1,length(curractiveChannels)),curractiveChannels);            
        end
        

%         
%         function unittestClassifier(testCase)
%             alc = ALC();
%             
%             alc.testClassifier(testCase.serialObj,testdata) 
%         end

%         function  unittestClassifierfeatVector(testCase)
%             
%             [outIdx, featVector] = alc.testClassifierfeatVector(testCase.serialObj, testData);
%         end

%         function unittestFeatureExtraction(testCase)
%             
%         end

        function  testgetActiveFeaturesVector(testCase)
            % ensures only valid features are set
            alc = ALC();
            featureNamesVector = ['Timothy', 'Peter', 'Distraction',...
                                   'tmabs','twl','tzc','tslpch2','tstd'];
            featureVector = alc.getActiveFeaturesVector(featureNamesVector);
            pause(0.1);
            testCase.verifyEqual(featureVector, [1 1 1 1 1]'); %sets all active that are valid
        end
        
%         %% Test setPatRecSettings
%         function testsetPatRecSettings(testCase)
%             alc = ALC();
%             pause(0.2);
%             alc.getStatus(testCase.serialObj);
%             pause(0.2);
%             curALC.sF=alc.samplingFrequency;
%             curALC.tW = alc.timeWindowSamples ;
%             curALC.wOverlap = alc.overlappingSamples  ;
%             curALC.enabledFeatures = alc.featuresEnabled  ;
%             curALC.nActiveFeatures=alc.numberOfActiveFeatures  ;
%             curALC.vCh = alc.activeChannels;
%             curALC.nM = alc.numberOfActiveMovements ;
%             patRec.sF = 500;
%             patRec.tW = 50;
%             patRec.wOverlap = 0;
%             %patRec.selFeatures =  [{'tmabs'},{'twl'},{'tzc'}]';
%             patRec.selFeatures =  ["tmabs","twl","tzc"];
%             patRec.vCh = [1     2     3     4     5     6     7     8     9    10    11    12    13    14    15    16];
%             patRec.nM = 8;
%             
%             pause(0.2);
%             alc.setPatRecSettings(testCase.serialObj,patRec);
%             pause(0.5);
%             alc.getStatus(testCase.serialObj);
%             pause(0.1);
%             testCase.verifyEqual(alc.samplingFrequency, patRec.sF);
%             testCase.verifyEqual(alc.timeWindowSamples , patRec.tW*patRec.sF);
%             testCase.verifyEqual(alc.overlappingSamples , patRec.wOverlap);
%             testCase.verifyEqual(alc.featuresEnabled, [1 1 1 0 0]');
%             testCase.verifyEqual(alc.numberOfActiveFeatures, 3);
%             testCase.verifyEqual(alc.activeChannels , patRec.vCh);
%             testCase.verifyEqual(alc.numberOfActiveMovements , patRec.nM);
%             alc.setPatRecSettings(testCase.serialObj, curALC);
%             pause(0.2);
%         end
%         
       function testexecuteMovementUnit(testCase)
           % executeMovement gets called. Nothing else verified
            alc = ALC();
            movementStruct.movIndex = 1; % Switch
            movementStruct.strength(1:3) = 30; % Set All strengths to 30
            pause(0.1)
            alc.executeMovement(testCase.serialObj, movementStruct);
            %pause(1);
       end
       
%        function testconvertMovementArrayToProstheticOutput(testCase)
%             alc = ALC();
%             movementArray = {'Open Hand', 'Close Hand', 'Pronation'};
%             movOutIdx = [1 2 4];
%             prostheticOutput=alc.convertMovementArrayToProstheticOutput(movementArray, movOutIdx);
%             
%        end

       function testconvertMovementNamesToProstheticOutput(testCase)
           alc = ALC();
           expectedIdx =[1 2 4 8 16 32 65 66 68 72 80 96 128 129 130 0]';
           movementNames       = {'Open Hand', 'Close Hand', 'Pronation', 'Supination', 'Flex Elbow', 'Extend Elbow', ...
                               'Thumb Extend', 'Thumb Flex','Index Extend', 'Index Flex', 'Middle Extend', 'Middle Flex', ...
                               'Switch Grasp', ...
                               'Lock/Unlock Elbow', 'Lock/Unlock Cocontraction', 'Rest'};
                           
           prostheticOutput = alc.convertMovementNamesToProstheticOutput(movementNames);
           testCase.verifyEqual(prostheticOutput,expectedIdx);
           
           expectedIdx = [0 0 0 16]';
           movementNames = {'Time to die', 'This is a test', 'Its over 9000', 'Flex Elbow'};
           prostheticOutput =alc.convertMovementNamesToProstheticOutput(movementNames);
           testCase.verifyEqual(prostheticOutput,expectedIdx);
           
       end
       
%        %% I need to figure out what this is supposed to do....
%        function testencodeLabelsOneHot(testCase)
%           alc = ALC();
%           labels = [1 2 0]';
%           movementNames={'Open Hand', 'Close Hand','Rest'}';
%           encodedLabels=alc.encodeLabelsOneHot(labels, movementNames);
%           
%           %labels = [0 0 1];
%           labels = [1 2 16]';
%           movementNames=[{'Open Hand', 'Close Hand','Flex Elbow'}]';
%           encodedLabels=alc.encodeLabelsOneHot(labels, movementNames);
%           
%        end
       
       
       function testdecodeOutIndex(testCase)
           alc = ALC();
           movIdx = [1 2];
           expectedMovements= [{'Open Hand'}    {'Close Hand'}];
           string_PredictedMovement = alc.decodeOutIndex(movIdx);
           testCase.verifyEqual(string_PredictedMovement,expectedMovements);
           
           movIdx = [45 2];
           expectedMovements= {'Close Hand'};
           string_PredictedMovement = alc.decodeOutIndex(movIdx);
           testCase.verifyEqual(string_PredictedMovement,expectedMovements);
           
           movIdx = [45 233];
           string_PredictedMovement = alc.decodeOutIndex(movIdx);
           if (isempty(string_PredictedMovement))
               testVal = true;
           else
               testVal  = false;
           end
           testCase.verifyTrue(testVal);
           
           
       end
    end
end