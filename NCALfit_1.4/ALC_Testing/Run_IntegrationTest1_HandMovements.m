clear
clc


import mlreportgen.report.*
import mlreportgen.dom.*
import matlab.unittest.TestSuite
import matlab.unittest.TestRunner
import matlab.unittest.plugins.TestReportPlugin
import matlab.unittest.plugins.CodeCoveragePlugin
import matlab.unittest.plugins.codecoverage.CoverageReport
import matlab.unittest.plugins.LoggingPlugin


close all
mlreportgen.utils.rptviewer.closeAll()

%% Get Test Conditions
prompt = {'Enter your name:','Enter ALC Name/Num:', 'NCALFit Branch:', 'ALC Branch'};
dlgtitle = 'Test Settings';

dims = [1 35];
definput = {'Tester','Test ALC','NCALfit1.4', 'ALC1.4'}; %other - none etc
definput = inputdlg(prompt,dlgtitle,dims,definput);
if isempty(definput)
    error('IntegrationTests:InputDialogError','Cancel Selected')
end



suite = testsuite({'IntegrationTest1_HandMovements.m'});
runner = TestRunner.withNoPlugins;
runner.addPlugin(LoggingPlugin.withVerbosity(2));
pdfFile = strcat('temp.pdf');
runner.addPlugin(TestReportPlugin.producingPDF(pdfFile,'IncludingCommandWindowText',true,'IncludingPassingDiagnostics',true,'LoggingLevel',4));
results=runner.run(suite);

load('intTest1.mat');
%% Upload Test Parameters
t = datetime('now');
DateString = datestr(t);
DateString(DateString==':')='-';
rpt_title=strcat(DateString,"- IntegrationTest1_",testCase.hand,"_",testCase.arm);
rpt = Report(rpt_title,'pdf');

append(rpt,TitlePage('Title','Execute Hand Movements'));
append(rpt,DateString);
append(rpt, strcat("Name of Tester: ",definput(1)));
append(rpt, strcat("ALC name: ",definput(2)));
append(rpt,definput(3));
append(rpt,definput(4));
append(rpt,strcat("Hand: ",testCase.hand));
append(rpt,strcat("Arm: ",testCase.arm));
close(rpt);

inputFiles = {strcat(rpt_title,'.pdf'), pdfFile};
outputFileName = strcat(rpt_title,'.pdf');
mergePdfs(inputFiles, outputFileName);
%delete(strcat(rpt_title,'.pdf'))
delete(pdfFile)
delete('intTest1.mat')
rptview(outputFileName);
%rptview(pdfFile);