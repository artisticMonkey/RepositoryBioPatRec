clear
clc

%% Importing
import mlreportgen.report.*
import mlreportgen.dom.*
import matlab.unittest.TestSuite
import matlab.unittest.TestRunner
import matlab.unittest.plugins.TestReportPlugin
import matlab.unittest.plugins.CodeCoveragePlugin
import matlab.unittest.plugins.codecoverage.CoverageReport
import matlab.unittest.plugins.LoggingPlugin

%% Setting Up Report
t = datetime('now');
DateString = datestr(t);
DateString(DateString==':')='-';
rpt_title=strcat(DateString,"- IntegrationTest3_StimulationTest");
rpt = Report(rpt_title,'pdf');
append(rpt, TitlePage('Title','StimulationTest'));

prompt = {'Enter your name:','Enter ALC Name/Num:', 'NCALFit Branch:', 'ALC Branch','Power Source'};
dlgtitle = 'Test Settings';
dims = [1 35];
definput = {'Tester','Test ALC','NCALfit1.4', 'ALC1.4','Arm'};
definput = inputdlg(prompt,dlgtitle,dims,definput);
append(rpt,DateString);
append(rpt, strcat("Name of Tester: ",definput(1)));
append(rpt, strcat("ALC name: ",definput(2))); 
append(rpt,definput(3));
append(rpt,definput(4));
append(rpt,strcat("Power Source: ",definput(5)));
append(rpt, "----------------------------------")


%% Run Tests
suite = testsuite({'IntegrationTest3_StimulationTest.m'});%'UnitTest3_ALCwrite.m'
runner = TestRunner.withNoPlugins;

runner.addPlugin(LoggingPlugin.withVerbosity(2));
pdfFile = strcat('temp.pdf');
runner.addPlugin(TestReportPlugin.producingPDF(pdfFile,'IncludingCommandWindowText',true,'IncludingPassingDiagnostics',true,'LoggingLevel',4));
results=runner.run(suite);

for i=1:length(results)
    vec(i) = results(1,i).Duration;
end
runtime = sum(vec);
phrase = strcat("Time to Complete: ", string(runtime)," seconds");
append(rpt,phrase);
append(rpt,"Scroll down for results");
close(rpt)


inputFiles = {strcat(rpt_title,'.pdf'), pdfFile};
outputFileName = strcat(rpt_title,'.pdf');
mergePdfs(inputFiles, outputFileName);
rptview(outputFileName)
