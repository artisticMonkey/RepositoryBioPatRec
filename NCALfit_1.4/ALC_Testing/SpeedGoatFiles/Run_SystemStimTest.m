clc

% Start TCP/IP for - connecting to 2021a matlab
t=tcpip("0.0.0.0", 30000, 'NetworkRole', 'server');
fopen(t);

answers=["Build and Run","Run Model - Already Built"];
[index,inputMade] = listdlg('ListString',answers,'SelectionMode','Single');
if ~inputMade
    error('Run_SystemStimTest:ListDialogError','No Selection Made')
end
status=answers(index);
switch status
    case "Build and Run"
        clearvars -except t   
        if isfolder('slprj')
            rmdir slprj s
        end
        if isfile('simulinkData.mat')
            delete('simulinkData.mat')
        end
        createSineWavesStim
        addpath(genpath(pwd))
        rtwbuild('SpeedGoatSimulinkModel')
        
        fprintf(t, 'Hello');
        tg.start
        
        
    case "Run Model - Already Built"
                fprintf(t, 'Hello'); %write to the server
                %for i=1:23
                tg.start
                %pause(25)
                %end
         
    otherwise
end

