clc

answers=["Start From Beginning","Run Model"];
[index,inputMade] = listdlg('ListString',answers,'SelectionMode','Single');
status=answers(index);
switch status
    case "Start From Beginning"
        clear
        if isfolder('slprj')
            rmdir slprj s
        end
        if isfile('simulinkData.mat')
            delete('simulinkData.mat')
        end
        SetupUnitTest3
        addpath(genpath(pwd))
        rtwbuild('SignalOutTest')
        answer = questdlg('Ready To Run Model?','Yes');
        switch answer
            case 'Yes'
                tg.start
            otherwise
                disp("Test Not Run")
        end
        
    case "Run Model"
        answer = questdlg('Ready To Run Model?','Yes');
        switch answer
            case 'Yes'
                tg.start
            otherwise
                disp("Test Not Run")
        end
    otherwise
end

