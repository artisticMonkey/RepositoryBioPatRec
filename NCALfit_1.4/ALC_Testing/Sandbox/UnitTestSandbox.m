classdef UnitTestSandbox < matlab.unittest.TestCase
    %IntegrationTest1_HandMovements tests for hand movements
    %   Tests All Movements Depending on Hand
    
    properties (TestParameter)
        %serialObj
        %hand
        %testName
        %data = 'default this isnt used';
        data
    end
    
    methods
        function testCase = UnitTestSandbox()
            testCase.data = "hi";
            
        end
    end
    
    methods (Test)
        function testTiming(testCase,data)
            disp(data)
        end
        function test2Timing(testCase)
           disp("data2") 
        end
    end
end
