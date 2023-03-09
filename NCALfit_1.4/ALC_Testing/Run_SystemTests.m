clear
clc

%% ToDo
% - Make a seperate file to run each system test so the question in the end
%   makes sense

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
rpt_title=strcat(DateString,"- AllSystemTests");
rpt = Report(rpt_title,'pdf');
append(rpt, TitlePage('Title','SystemTests'));

prompt = {'Enter your name:','Enter ALC Name/Num:', 'NCALFit Branch:', 'ALC Branch','Power Source'};
dlgtitle = 'Test Settings';
dims = [1 35];
definput = {'Tester','Test ALC','NCALfit1.4', 'ALC1.4','Arm'};
definput = inputdlg(prompt,dlgtitle,dims,definput);
if isempty(definput)
    error('RunSystemTests:InputDialogError','No Settings Set')
end
append(rpt,DateString);
append(rpt, strcat("Name of Tester: ",definput(1)));
append(rpt, strcat("ALC name: ",definput(2))); 
append(rpt,definput(3));
append(rpt,definput(4));
append(rpt,strcat("Power Source: ",definput(5)));
append(rpt, "----------------------------------")
%% Ask about coverage
inputString = ["No", "Yes"];
[index,inputMade] = listdlg('PromptString','Code Coverage?','ListString',inputString, 'SelectionMode','single');

% if ~inputMade
%     return;
% end
if ~any(inputMade) 
    error('RunSystemTests:ListDialogError','No Coverage Option Selected')
end

coverage = index - 1; % a 1 or 0


%% Run Tests
tests = ["SystemTest1_HandMovements","SystemTest2_StimulationTest"];
[index,inputMade] = listdlg('ListString',tests, 'SelectionMode','single');

if ~inputMade
    error('RunSystemTests:ListDialogError','No Test Selected')
end
test = tests(index);

suiteName = strcat(test,".m");

suite = testsuite(suiteName);
%suite = testsuite({'SystemTest1_HandMovements.m'});
for i=1:length(suite)
    if suite(1,i).ProcedureName == test
        s1= suite(1,i);
    end
end
runner = TestRunner.withNoPlugins;
if coverage 
    runner.addPlugin(CodeCoveragePlugin.forFolder(pwd, ...
   'Producing',CoverageReport('ALCSystemTestCoverage', ...
   'MainFile','ALCSystemTests.html')))
end
runner.addPlugin(LoggingPlugin.withVerbosity(2));
pdfFile = strcat('temp.pdf');
runner.addPlugin(TestReportPlugin.producingPDF(pdfFile,'IncludingCommandWindowText',true,'IncludingPassingDiagnostics',true,'LoggingLevel',4));

results=runner.run(suite);
%results = runtests('UnitTest1_SetGetParameters');
for i=1:length(results)
    vec(i) = results(1,i).Duration;
end
runtime = sum(vec);
phrase = strcat("Time to Complete: ", string(runtime)," seconds");
append(rpt,phrase);
for i=1:length(results)
   if (results(i).Passed ==1)
       append(rpt,strcat(results(i).Name," test was successful"))
   elseif (results(i).Failed ==1)
       colorfulStyle = {Bold,Color('red')};
       p1 = Paragraph(strcat(results(i).Name," test failed"));
       p1.Style = colorfulStyle;
       append(rpt,p1)
       if(isfield(results(i).Details,'DiagnosticRecord'))
           p2 = Paragraph(results(i).Details.DiagnosticRecord.Report);
       else
           p2 = Paragraph("Details not available");
       end
       p2.Style = colorfulStyle;
       append(rpt,p2)
   else
       append(rpt,strcat(results(i).Name," test was incomplete"))
   end
end

%%Asking User For Details
answer = questdlg('Did the Test Run Properly','Results');
switch answer
    case 'Yes'
        f = msgbox("Upload Test Results to Test Report Record Folder on NAS");
    otherwise
        append(rpt,"Test Failed!!!!!!!")
        prompt = {'Any Notes?'};
        dlgtitle = 'Test Notes';
        dims = [1 35];
        definput = {'none'};
        notes = inputdlg(prompt,dlgtitle,dims,definput);
        append(rpt,"Notes:")
        append(rpt,notes)
        close all
end

close(rpt)
if coverage
   pause(1)
   web('ALCSystemTestCoverage/ALCSystemTests.html') 
end
inputFiles = {strcat(rpt_title,'.pdf'), pdfFile};
outputFileName = strcat(rpt_title,'.pdf');
mergePdfs(inputFiles, outputFileName);
rptview(outputFileName)


