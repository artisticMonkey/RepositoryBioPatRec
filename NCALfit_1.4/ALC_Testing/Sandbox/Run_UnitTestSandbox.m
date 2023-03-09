clear
clc

%% Importing
import mlreportgen.report.*
import mlreportgen.dom.*
import matlab.unittest.TestSuite
import matlab.unittest.TestRunner
import matlab.unittest.plugins.CodeCoveragePlugin
import matlab.unittest.plugins.codecoverage.CoverageReport
import matlab.unittest.parameters.Parameter



data = "external data";
newData = {data};
param = Parameter.fromData('Data',newData);
%suite = TestSuite.fromClass(?UnitTestSandbox,'ExternalParameters',param);
suite = TestSuite.fromClass(?UnitTestSandbox)
runner = TestRunner.withNoPlugins;
results=runner.run(suite);