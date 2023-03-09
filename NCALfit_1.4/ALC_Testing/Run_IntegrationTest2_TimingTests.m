clear;
clc;

import mlreportgen.report.*
import mlreportgen.dom.*
import matlab.unittest.TestSuite
import matlab.unittest.TestRunner
import matlab.unittest.plugins.TestReportPlugin
import matlab.unittest.plugins.CodeCoveragePlugin
import matlab.unittest.plugins.codecoverage.CoverageReport
import matlab.unittest.plugins.LoggingPlugin
yourFolder = "IntegrationTestData";
if ~exist(yourFolder, 'dir')
       mkdir(yourFolder)
end


close all
mlreportgen.utils.rptviewer.closeAll()

t = datetime('now');
DateString = datestr(t);
DateString(DateString==':')='-';
rpt_title=strcat("IntegrationTestData/",DateString,"- IntegrationTests_");
rpt = Report(rpt_title,'pdf');

%% Get Test Conditions
prompt = {'Enter your name:','Enter ALC Name/Num:', 'NCALFit Branch:', 'ALC Branch'};
dlgtitle = 'Test Settings';

dims = [1 35];
definput = {'Tester','Test ALC','NCALfit1.4', 'ALC1.4'}; %other - none etc
definput = inputdlg(prompt,dlgtitle,dims,definput);
if isempty(definput)
    error('IntegrationTests:InputDialogError','Cancel Selected')
end

%results  = runtests('Timing_Test')

%% Run Test
suite = testsuite({'IntegrationTest2_TimingTests.m'});
runner = TestRunner.withNoPlugins;
runner.addPlugin(LoggingPlugin.withVerbosity(2));
pdfFile = 'IntegrationTestData/temp.pdf';
runner.addPlugin(TestReportPlugin.producingPDF(pdfFile,'IncludingCommandWindowText',true,'IncludingPassingDiagnostics',true,'LoggingLevel',4));
results=runner.run(suite);
%diary off
%% Load and report 
load('data.mat');

append(rpt,TitlePage('Title',testCase.testName));
append(rpt,DateString);
append(rpt, strcat("Name of Tester: ",definput(1)));
append(rpt, strcat("ALC name: ",definput(2)));
append(rpt,definput(3));
append(rpt,definput(4));
append(rpt,strcat("Hand: ",testCase.hand));
append(rpt,strcat("Loops: ",num2str(testCase.loops)));
append(rpt,strcat("Threshold: ",num2str(testCase.threshold)));
if(~isempty(testCase.stimParams))
    append(rpt,strcat("StimFreq: ",(testCase.stimParams{1,1})));
    append(rpt,strcat("StimAmp: ",(testCase.stimParams{2,1})));
    append(rpt,strcat("StimPulseWidth: ",(testCase.stimParams{3,1})));
    append(rpt,strcat("StimCount: ",(testCase.stimParams{4,1})));
    append(rpt,strcat("StimChannel: ",(testCase.stimParams{5,1})));
    append(rpt,strcat("SamplingFreq:", alc.samplingFrequency));
    append(rpt,strcat("timeWindowSamples:", alc.timeWindowSamples));
    append(rpt,strcat("overlappingSamples:", alc.overlappingSamples));
else
    append(rpt,strcat("No Stim"));
end
append(rpt, "----------------------------------")

if any(results.Failed)
    res_phrase = "Test Failed";
else
    res_phrase = "Test Passed";
end
colorfulStyle = {Bold,Color('red')};
p1 = Paragraph(res_phrase);
p1.Style = colorfulStyle;
append(rpt,p1)
if any(results.Failed)
    % add diagnostic to test
    append(rpt, "----------------------------------")
    append(rpt,"For Debugging here is the console output")
    fileID = fopen('log.txt','r');
    formatSpec = '%c';
    logData = fscanf(fileID,formatSpec);
    append(rpt,logData)
    fclose(fileID);
end
append(rpt, "----------------------------------")
 % has data and testCase
phrase = strcat("Time to Complete: ",string(results.Duration)," seconds"); %if this fails... the tests did not complete
append(rpt,phrase)
append(rpt, "Results");
append(rpt, "----------------------------------")
% Add Table of Results
if exist('data','var')
    T = struct2table(data);
    table = BaseTable(T(:,1:4));
    add(rpt,table);
    table.Title = 'Test Results';
    table = BaseTable(T(:,5:8));
    add(rpt,table);
    table = BaseTable(T(:,9:12));
    add(rpt,table);
    table = BaseTable(T(:,13:width(T)));
    add(rpt,table);
else
    append(rpt,'No timing data!')
end
append(rpt, "----------------------------------")
any(results.Failed)
prompt = {'Any Notes?'};
dlgtitle = 'Test Notes';
dims = [1 35];
definput = {'none'};
notes = inputdlg(prompt,dlgtitle,dims,definput);
append(rpt,"Notes:")
append(rpt,notes)
%dont add figures

%% Add Figures to Report
for i=1:9
    figure(i)
    figReporter0 = Figure(gcf);
    add(rpt,figReporter0);
end

close(rpt);
fulltitle = strcat(rpt_title,'.pdf');
newtitle =strcat(rpt_title,testCase.testName,'.pdf');
%movefile(fulltitle,newtitle)
% rptview(newtitle);
% open(pdfFile)
inputFiles = {strcat(rpt_title,'.pdf'), pdfFile};
outputFileName = newtitle;
mergePdfs(inputFiles, outputFileName); %uses Merge PDF-Documents toolbox by  Benjamin Großmann

%% End of script
delete(strcat(rpt_title,'.pdf'))
delete(pdfFile)
delete('data.mat')
delete('log.txt')
rptview(newtitle);

close all