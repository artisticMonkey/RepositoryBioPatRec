classdef IntegrationTest1_HandMovements < matlab.unittest.TestCase
    %IntegrationTest1_HandMovements tests for hand movements
    %   Tests All Movements Depending on Hand
    
    properties
        serialObj
        hand
        arm
    end
    
    methods
        function testCase = IntegrationTest1_HandMovements()
            delete(instrfindall);
            ports = serialportlist;
            [index,inputMade] = listdlg('ListString',ports, 'SelectionMode','single');
            
            if ~inputMade
                error('IntegrationTest1:ListDialogError','No Port Selected')
                return;
            end
            comPort = ports(index);
            
            testCase.serialObj = ALC.createSerialObject(comPort);
            %% Select a Hand Setup
            handSetups = ["OBSensor", "OBSpeed", "MiaHand", "BeBionic", "OBSensorWBridge", "OBSpeedWBridge"];
            
            % to be added - the different arms
            [index,inputMade] = listdlg('ListString',handSetups, 'SelectionMode','single');
            if ~inputMade
                return;
            end
            testCase.hand = handSetups(index);
            %% Hand Setup
            armSetups = ["Ottobock Arm","Wrist only"];
            [index,inputMade] = listdlg('ListString',armSetups, 'SelectionMode','single');
            
            if ~inputMade
                error('IntegrationTest1:ListDialogError','No Hand Selected')
                return;
            end
            testCase.arm = armSetups(index);
            
            
            
            clc;
            
        end
        
    end
    
    methods (Test)
        function testexecuteMovementHandOpenClose(testCase)
            runTest = 1;
            init_strength = 22;
            alc = ALC();
            pause(0.1);
            alc.setCommandMode(testCase.serialObj)
            for i =1:10
                if (runTest == 1)
                    
                    movementStruct.movIndex = 1; % Hand Open
                    movementStruct.strength(1:3) = init_strength; % Set All strengths to 30
                    %                     while(alc.openHand.pwmOutput == 0)
                    %                         pause(0.1);
                    %                         alc.getStatus(testCase.serialObj);
                    %                     end
                    pause(0.1)
                    alc.executeMovement(testCase.serialObj, movementStruct);
                    pause(1.5)
                    movementStruct.movIndex = 2; % Hand close
                    alc.executeMovement(testCase.serialObj, movementStruct);
                end
                pause(1.5);
                init_strength = init_strength + 3;
            end
            movementStruct.movIndex = 0; % Rest
            alc.executeMovement(testCase.serialObj, movementStruct);
            testResults = ["Yes", "No"];
            % to be added - the different arms
            [index,inputMade] = listdlg('PromptString','Did the hand open and close multiple (10) times?','ListString',testResults, 'SelectionMode','single');
            if ~inputMade
                testCase.verifyFail()
                return;
            end
            result = testResults(index);
            testCase.verifyEqual(result,"Yes");
        end
        
        function testexecuteMovementWristPronateSupinate(testCase)
            switch testCase.hand
                case "OBSensorWBridge"
                    runTest = 1;
                case "OBSpeedWBridge"
                    runTest = 1;
                otherwise
                    % dont run test
                    runTest = 0;
                    testCase.assumeFail(); % the test does not run - so incomplete this is expected
                    %testCase.results('This hand does not have this movement');
            end
            if (runTest == 1)
                alc = ALC();
                pause(0.1);
                alc.setCommandMode(testCase.serialObj)
                movementStruct.movIndex = 4; % Pronatation
                movementStruct.strength(1:3) = 30; % Set All strengths to 30
                pause(0.1)
                alc.executeMovement(testCase.serialObj, movementStruct);
                pause(2)
                movementStruct.movIndex = 8; % Supination
                alc.executeMovement(testCase.serialObj, movementStruct);
                testResults = ["Yes", "No"];
                % to be added - the different arms
                [index,inputMade] = listdlg('PromptString','Did the Wrist Pronate and Supinate?','ListString',testResults, 'SelectionMode','single');
                if ~inputMade
                    testCase.verifyFail()
                    return;
                end
                result = testResults(index);
                testCase.verifyEqual(result,"Yes");
            end
            
        end
        
        function testexecuteMovementElbowFlexExtend(testCase)
            % OB arm - does not flex and extend - it just locks and unlocks
            alc = ALC();
            pause(0.1);
            alc.setCommandMode(testCase.serialObj)
            switch testCase.arm
                case "Not Defined"
                    runTest = 1;
                otherwise
                    % dont run test
                    runTest = 0;
                    
                    testCase.assumeFail(); % the test does not run - so incomplete this is expected
                    %testCase.results('This hand does not have this movement');
            end
            if (runTest ==1)
                
                movementStruct.movIndex = 16; % Flex
                movementStruct.strength(1:3) = 30; % Set All strengths to 30
                pause(0.1)
                alc.executeMovement(testCase.serialObj, movementStruct);
                pause(2)
                movementStruct.movIndex = 32; % Extend
                alc.executeMovement(testCase.serialObj, movementStruct);
                testResults = ["Yes", "No"];
                % to be added - the different arms
                [index,inputMade] = listdlg('PromptString','Did the Elbow Flex and Extend?','ListString',testResults, 'SelectionMode','single');
                if ~inputMade
                    testCase.verifyFail()
                    return;
                end
                result = testResults(index);
                testCase.verifyEqual(result,"Yes");
            end
        end
        
        function testexecuteMovementThumbFlexExtend(testCase)
            switch testCase.hand
                case "MiaHand"
                    runTest = 1;
                case "BeBionic"
                    runTest = 1;
                otherwise
                    % dont run test
                    runTest = 0;
                    testCase.assumeFail(); % the test does not run - so incomplete this is expected
            end
            if (runTest == 1)
                alc = ALC();
                pause(0.1);
                alc.setCommandMode(testCase.serialObj)
                movementStruct.movIndex = 65; % Flex
                movementStruct.strength(1:3) = 30; % Set All strengths to 30
                pause(0.1)
                alc.executeMovement(testCase.serialObj, movementStruct);
                pause(2)
                movementStruct.movIndex = 66; % Extend
                alc.executeMovement(testCase.serialObj, movementStruct);
                testResults = ["Yes", "No"];
                % to be added - the different arms
                [index,inputMade] = listdlg('PromptString','Did the Thumb Flex and Extend?','ListString',testResults, 'SelectionMode','single');
                if ~inputMade
                    testCase.verifyFail()
                    return;
                end
                result = testResults(index);
                testCase.verifyEqual(result,"Yes");
            end
        end
        
        function testexecuteMovementIndexFlexExtend(testCase)
            switch testCase.hand
                case "MiaHand"
                    runTest = 1;
                case "BeBionic"
                    runTest = 1;
                otherwise
                    % dont run test
                    runTest = 0;
                    testCase.assumeFail(); % the test does not run - so incomplete this is expected
            end
            if (runTest == 1)
                alc = ALC();
                pause(0.1);
                alc.setCommandMode(testCase.serialObj)
                movementStruct.movIndex = 68; % Flex
                movementStruct.strength(1:3) = 30; % Set All strengths to 30
                pause(0.1)
                alc.executeMovement(testCase.serialObj, movementStruct);
                pause(2)
                movementStruct.movIndex = 72; % Extend
                alc.executeMovement(testCase.serialObj, movementStruct);
                testResults = ["Yes", "No"];
                % to be added - the different arms
                [index,inputMade] = listdlg('PromptString','Did the Index Flex and Extend?','ListString',testResults, 'SelectionMode','single');
                if ~inputMade
                    testCase.verifyFail()
                    return;
                end
                result = testResults(index);
                testCase.verifyEqual(result,"Yes");
            end
        end
        
        function testexecuteMovementMiddleFlexExtend(testCase)
            switch testCase.hand
                case "MiaHand"
                    runTest = 1;
                case "BeBionic"
                    runTest = 1;
                otherwise
                    % dont run test
                    runTest = 0;
                    testCase.assumeFail(); % the test does not run - so incomplete this is expected
            end
            if (runTest == 1)
                alc = ALC();
                pause(0.1);
                alc.setCommandMode(testCase.serialObj)
                movementStruct.movIndex = 80; % Flex
                movementStruct.strength(1:3) = 30; % Set All strengths to 30
                pause(0.1)
                alc.executeMovement(testCase.serialObj, movementStruct);
                pause(2)
                movementStruct.movIndex = 96; % Extend
                alc.executeMovement(testCase.serialObj, movementStruct);
                testResults = ["Yes", "No"];
                % to be added - the different arms
                [index,inputMade] = listdlg('PromptString','Did the Middle Finger Flex and Extend?','ListString',testResults, 'SelectionMode','single');
                if ~inputMade
                    testCase.verifyFail()
                    return;
                end
                result = testResults(index);
                testCase.verifyEqual(result,"Yes");
            end
        end
        
        function testexecuteMovementSwitchGrasp(testCase)
            switch testCase.hand
                case "MiaHand"
                    runTest = 1;
                case "BeBionic"
                    runTest = 1;
                otherwise
                    % dont run test
                    runTest = 0;
                    testCase.assumeFail(); % the test does not run - so incomplete this is expected
            end
            if (runTest == 1)
                alc = ALC();
                pause(0.1);
                alc.setCommandMode(testCase.serialObj)
                movementStruct.movIndex = 128; % Switch 1 time
                movementStruct.strength(1:3) = 30; % Set All strengths to 30
                pause(0.1)
                alc.executeMovement(testCase.serialObj, movementStruct);
                pause(2)
                movementStruct.movIndex = 128; % Switch again
                alc.executeMovement(testCase.serialObj, movementStruct);
                testResults = ["Yes", "No"];
                % to be added - the different arms
                [index,inputMade] = listdlg('PromptString','Did the grasp change?','ListString',testResults, 'SelectionMode','single');
                if ~inputMade
                    testCase.verifyFail()
                    return;
                end
                result = testResults(index);
                testCase.verifyEqual(result,"Yes");
            end
        end
        
        function testexecuteMovementElbowLockUnlock(testCase)
            switch testCase.arm
                case "Ottobock Arm"
                    runTest = 1;
                otherwise
                    % dont run test
                    runTest = 0;
                    testCase.assumeFail(); % the test does not run - so incomplete this is expected
            end
            if (runTest == 1)
                alc = ALC();
                pause(0.1);
                alc.setCommandMode(testCase.serialObj)
                movementStruct.movIndex = 129; % Switch
                movementStruct.strength(1:3) = 30; % Set All strengths to 30
                pause(0.1)
                alc.executeMovement(testCase.serialObj, movementStruct);
                pause(2)
                movementStruct.movIndex = 129; % Switch
                alc.executeMovement(testCase.serialObj, movementStruct);
                testResults = ["Yes", "No"];
                % to be added - the different arms
                [index,inputMade] = listdlg('PromptString','Did the Elbow Lock and Unlock?','ListString',testResults, 'SelectionMode','single');
                if ~inputMade
                    testCase.verifyFail()
                    return;
                end
                result = testResults(index);
                testCase.verifyEqual(result,"Yes");
            end
        end
        
        function testexecuteMovementCocontractionLockUnlock(testCase)
            alc = ALC();
            pause(0.1);
            alc.setCommandMode(testCase.serialObj)
            switch testCase.arm
                case "Not Defined"
                    runTest = 1;
                otherwise
                    % dont run test
                    runTest = 0;
                    testCase.assumeFail(); % the test does not run - so incomplete this is expected
            end
            if (runTest ==1)
                movementStruct.movIndex = 130; % Switch
                movementStruct.strength(1:3) = 30; % Set All strengths to 30
                pause(0.1)
                alc.executeMovement(testCase.serialObj, movementStruct);
                pause(2)
                movementStruct.movIndex = 130; % Switch
                alc.executeMovement(testCase.serialObj, movementStruct);
                testResults = ["Yes", "No"];
                % to be added - the different arms
                [index,inputMade] = listdlg('PromptString','Did the Cocontraction Movement Occur?','ListString',testResults, 'SelectionMode','single');
                if ~inputMade
                    testCase.verifyFail()
                    return;
                end
                result = testResults(index);
                testCase.verifyEqual(result,"Yes");
            end
        end
        
        function testexecuteMovementRest(testCase)
            alc = ALC();
            pause(0.1);
            alc.setCommandMode(testCase.serialObj)
            movementStruct.movIndex = 1; % Open
            movementStruct.strength(1:3) = 30; % Set All strengths to 30
            pause(0.1)
            alc.executeMovement(testCase.serialObj, movementStruct);
            pause(1.5)
            movementStruct.movIndex = 0; % Rest
            movementStruct.strength(1:3) = 30; % Set All strengths to 30
            pause(0.1)
            alc.executeMovement(testCase.serialObj, movementStruct);
            
            % Close and Rest
            movementStruct.movIndex = 2; % Open
            movementStruct.strength(1:3) = 30; % Set All strengths to 30
            pause(0.1)
            alc.executeMovement(testCase.serialObj, movementStruct);
            pause(1.5)
            movementStruct.movIndex = 0; % Rest
            movementStruct.strength(1:3) = 30; % Set All strengths to 30
            pause(0.1)
            alc.executeMovement(testCase.serialObj, movementStruct);
            testResults = ["Yes", "No"];
            % to be added - the different arms
            [index,inputMade] = listdlg('PromptString','Did the hand open and close with rest?','ListString',testResults, 'SelectionMode','single');
            if ~inputMade
                testCase.verifyFail()
                return;
            end
            result = testResults(index);
            testCase.verifyEqual(result,"Yes");
            save('intTest1.mat','testCase');
        end
        
    end
end

