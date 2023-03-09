clc

answers=["Start From Beginning - Build Model","Run Model - Model Already Built"];
[index,inputMade] = listdlg('ListString',answers,'SelectionMode','Single');
if ~inputMade
    error('Run_SpeedGoatSimulinkModel:ListDialogError','No Selection Made')
end

status=answers(index);
switch status
    case "Start From Beginning - Build Model"
        clear
        if isfolder('slprj')
            rmdir slprj s
        end
        if isfile('simulinkData.mat')
            delete('simulinkData.mat')
        end
        createSineWaves
        addpath(genpath(pwd))
        rtwbuild('SpeedGoatSimulinkModel')
        answer = questdlg('Ready To Run Model?','Yes');
        switch answer
            case 'Yes'
                tg.start
            otherwise
                disp("Test Not Run")
        end
        
    case "Run Model - Model Already Built"
        answer = questdlg('Ready To Run Model?','Yes');
        switch answer
            case 'Yes'
                
                %for i=1:23
                tg.start
                pause(25)
                %end
            otherwise
                disp("Test Not Run")
        end
    otherwise
end

