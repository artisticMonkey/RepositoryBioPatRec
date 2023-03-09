classdef IntegrationTest2_TimingTests < matlab.unittest.TestCase
    %IntegrationTest2_TimingTests tests for timing on ALC
    
    %ToDo:
    % - add timing constraints for stimulation at same time?
    
    properties
        serialObj
        hand
        testname
        testName
        maxTime
        threshold
        loops
        stimParams
    end
    
    methods
        function testCase = IntegrationTest2_TimingTests()
            testNames = ["testEMG","sdSaving","commUART","alcInit"];
            [index,inputMade] = listdlg('ListString',testNames, 'SelectionMode','single');
            
            if ~inputMade
                error('IntegrationTest2:ListDialogError','No Port Selected')
            end
            testName = testNames(index);
            testCase.testname = testName;
            testCase.testName=testName;
            %ask if the alc has been programmed properly
            
           uiwait(msgbox('Did you flash the proper code - see wiki for details'))
            
            %set test acceptance values
            switch testName
                case 'testEMG'
                    testCase.maxTime.FeatExtPulseWidth = 2400; %us
                    testCase.maxTime.ClassPulseWidth = 2400;
                    testCase.maxTime.SensorySigPulseWidth = 2400;
                    testCase.maxTime.OutMovPulseWidth = 2400;
                    testCase.maxTime.TasksPulseWidth = 110000;
                    testCase.maxTime.TasksPeriod = 200000;
                    
                    testCase.maxTime.EMG_ACGIntPW = 5000; %5
                    testCase.maxTime.EMG_ACGIntPeriod = 2000;
                    Test_type = '_EMG_Acquisition';
                case 'sdSaving'
                    testCase.maxTime.FeatExtPulseWidth = 450; %us
                    testCase.maxTime.ClassPulseWidth = 250;
                    testCase.maxTime.SensorySigPulseWidth = 50;
                    testCase.maxTime.OutMovPulseWidth = 30;%used to be 30
                    testCase.maxTime.TasksPulseWidth = 1.1e5;%300;
                    testCase.maxTime.TasksPeriod = 210000;
                    
                    testCase.maxTime.EMG_ACGIntPW = 5000; %3000
                    testCase.maxTime.EMG_ACGIntPeriod = 1400500;
                    Test_type = '_SD_Saving';
                case 'commUART'
                    testCase.maxTime.FeatExtPulseWidth = 450; %used to be 65
                    testCase.maxTime.ClassPulseWidth = 250;
                    testCase.maxTime.SensorySigPulseWidth = 10;
                    testCase.maxTime.OutMovPulseWidth = 35;
                    testCase.maxTime.TasksPulseWidth = 1.1e5;%380;
                    testCase.maxTime.TasksPeriod = 200000;
                    
                    testCase.maxTime.EMG_ACGIntPW = 20;
                    testCase.maxTime.EMG_ACGIntPeriod = 12;
                    Test_type = '_commUART';
                case 'alcInit'
                    testCase.maxTime.FeatExtPulseWidth = 450; %us - used to be 100
                    testCase.maxTime.ClassPulseWidth = 250;
                    testCase.maxTime.SensorySigPulseWidth = 60;
                    testCase.maxTime.OutMovPulseWidth = 35;
                    testCase.maxTime.TasksPulseWidth = 540;%380
                    testCase.maxTime.TasksPeriod = 200000;
                    
                    testCase.maxTime.EMG_ACGIntPW = 100;
                    testCase.maxTime.EMG_ACGIntPeriod = 25;
                    Test_type = '_alcInit';
                otherwise
                    
            end
            testname = 'ALC1.4_DMA_tw50_o0_Not_Loosing_Samples';
            testCase.testname = append(testname,Test_type);
            
             handNames = ["SensorHand","None"];
            [index,inputMade] = listdlg('ListString',handNames, 'SelectionMode','single');
            if ~inputMade
                error('IntegrationTest2:ListDialogError','No Arm Selected')
            end
            hand = handNames(index);
            testCase.hand=hand;
            
            answer = questdlg('Do you want to Stimulate?','Setting');
            switch answer
                case 'Yes'
                    prompt = {'Stim Freq (Hz):','Amp (mA):',"PulseWidth (us)","Num Pulses","Channel"};
                    dlgtitle = 'Test Parameters';
                    dims = [1 35];
                    definput = {'30','250','250','255','3'}; %other - none etc
                    definput = inputdlg(prompt,dlgtitle,dims,definput);
                    testCase.stimParams=definput;
                otherwise
            end
            
            
            % other test parameters
            prompt = {'Number of Loops:','Threshold:'};
            dlgtitle = 'Test Parameters';
            dims = [1 35];
            definput = {'20','1.5'}; %other - none etc
            definput = inputdlg(prompt,dlgtitle,dims,definput);
            testCase.loops=str2double(definput(1));
            testCase.threshold =str2double(definput(2));
            % connect to ALC
            delete(instrfindall);
            ports = serialportlist;
            
            [index,inputMade] = listdlg('ListString',ports, 'SelectionMode','single');
            
            if ~inputMade
                error('IntegrationTest2:ListDialogError','No Port Selected')
            end
            comPort = ports(index);
            
            testCase.serialObj = ALC.createSerialObject(comPort);
            
        end
    end
    
    methods (Test)
        function testTiming(testCase)
            alc = ALC();
            %% Set Control Mode
            alc.setControlMode(testCase.serialObj)
            if(~isempty(testCase.stimParams))
                alc.getRecSettings(testCase.serialObj);
                pause(0.1);
                
                save('data.mat','alc');
            end
            %% Run Test
            %logging for debugging 
            log(testCase,strcat('Test Name: ',testCase.testName))
            log(testCase,convertCharsToStrings(testCase.hand))
            log(testCase,strcat('Threshold value: ',num2str(testCase.threshold)))
            log(testCase,strcat('Number of loops: ',num2str(testCase.loops)))
            error = 0;
            %threshold = 1.5;
            %TestConditions.threshold=threshold;
            pin1_waveform = [];
            pin2_waveform = [];
            pin1_PulseWidth_fext = [];
            pin1_PulseWidth_clas = [];
            pin1_PulseWidth_sprs = [];
            pin1_PulseWidth_omov = [];
            pin1_PulsePeriod = [];
            pin1_PulseWidth = [];
            pin2_PulseWidth = [];
            pin2_PulsePeriod = [];
            
            %loop_cycles = 20;
            %             TestConditions.loop_cycles=loop_cycles;
            %% Run loop_cycles number of times - some loops might fail that is why we run multiple times
            %TestConditions.loop_cycles=loop_cycles;
            
            %% Run loop_cycles number of times - some loops might fail that is why we run multiple times
            for i = 1:1:testCase.loops
                if(~isempty(testCase.stimParams))
                    channel=str2double(testCase.stimParams(5))-1;
                    amplitude=str2double(testCase.stimParams(2));
                    pulseWidth=str2double(testCase.stimParams(3));
                    frequency=str2double(testCase.stimParams(1));
                    pulses=str2double(testCase.stimParams(4));
                    alc.sendStimCommand(testCase.serialObj, channel, amplitude, pulseWidth, frequency, pulses)
                end
                loop_message = 'Loop %d \n';
                fprintf(loop_message,i);
                
                % Initialize the scope object
                myScope = oscilloscope();
                
                % The address of the oscilloscope
                myScope.Resource = 'USB::0x0699::0x0408::C031188::INSTR';
                
                % Connect the scope
                connect(myScope);
                
                % Enable channel 1 (GPIO1) and channel 2 (GPIO2)
                enableChannel(myScope, 'CH1');
                enableChannel(myScope, 'CH2');
                
                % Set the acquisition time and number of samples
                Acquisition_Time = 4; %in seconds
                NumSamples = 5e6;
                set(myScope,'AcquisitionTime',Acquisition_Time);
                set(myScope, 'WaveformLength',NumSamples);
                
                % Start the acquisition
                disp('Start')
                pause(4);
                
                % End the acquisition
                disp('End');
                
                % Get the waveform
                [ch1 ch2] = getWaveform(myScope);
                
                % Disconnect the oscilloscope
                disconnect(myScope);
                % file_name = 'HandSensorsAcquisition.mat';
                % load(file_name);
                
                %Get the data
                pin1_temp = find(ch1 > -0.5);
                pin2_temp = find(ch2 > -0.5);
                
                % if the following line does not work - check connection
                pin1_data = ch1(pin1_temp(1):length(ch1));
                pin2_data = ch2(pin2_temp(1):length(ch2));
                
                pin1_waveform = [pin1_waveform pin1_data];
                pin2_waveform = [pin2_waveform pin2_data];
                % Process the GPIO1
                % Get the location of rising edges
                
                pin1_RisingEdge = find(diff(pin1_data) > testCase.threshold);
                pin1_FallingEdge = find(diff(pin1_data) < -testCase.threshold);
                
                if length(pin1_RisingEdge) ~= length(pin1_FallingEdge)
                    disp('Error in getting the edges of GPIO1')
                else
                    if (strcmp(testCase.hand,'SensorHand'))
                        for i = 1:4:length(pin1_RisingEdge)-3
                            if (((pin1_FallingEdge(i) - pin1_RisingEdge(i)) > 0) && ((pin1_FallingEdge(i+1) - pin1_RisingEdge(i+1)) > 0) && ((pin1_FallingEdge(i+2) - pin1_RisingEdge(i+2)) > 0)&& ((pin1_FallingEdge(i+3) - pin1_RisingEdge(i+3)) > 0))
                                pin1_PulseWidth_fext_temp = pin1_FallingEdge(i) - pin1_RisingEdge(i);
                                pin1_PulseWidth_clas_temp = pin1_FallingEdge(i+1) - pin1_RisingEdge(i+1);
                                pin1_PulseWidth_sprs_temp = pin1_FallingEdge(i+2) - pin1_RisingEdge(i+2);
                                pin1_PulseWidth_omov_temp = pin1_FallingEdge(i+3) - pin1_RisingEdge(i+3);
                                pin1_PulseWidth_temp = (pin1_FallingEdge(i+3) - pin1_RisingEdge(i))*0.8 - 30;
                                pin1_PulseWidth_fext = [pin1_PulseWidth_fext pin1_PulseWidth_fext_temp*0.8];
                                pin1_PulseWidth_clas = [pin1_PulseWidth_clas pin1_PulseWidth_clas_temp*0.8];
                                pin1_PulseWidth_sprs = [pin1_PulseWidth_sprs pin1_PulseWidth_sprs_temp*0.8];
                                pin1_PulseWidth_omov = [pin1_PulseWidth_omov pin1_PulseWidth_omov_temp*0.8];
                                pin1_PulseWidth = [pin1_PulseWidth pin1_PulseWidth_temp];
                                error = 0;
                            else
                                disp('Error in getting the edges of GPIO1')
                                error = 1;
                            end
                        end
                        for i = 5:5:length(pin1_RisingEdge)-4
                            if (error ~= 1)
                                pin1_PulsePeriod_Temp = (pin1_RisingEdge(i) - pin1_RisingEdge(i-4))*0.8 - 30;
                                pin1_PulsePeriod = [pin1_PulsePeriod pin1_PulsePeriod_Temp];
                                
                            end
                        end
                    else
                        for i = 1:3:length(pin1_RisingEdge)-3
                            if (((pin1_FallingEdge(i) - pin1_RisingEdge(i)) > 0) && ((pin1_FallingEdge(i+1) - pin1_RisingEdge(i+1)) > 0) && ((pin1_FallingEdge(i+2) - pin1_RisingEdge(i+2)) > 0))
                                pin1_PulseWidth_fext_temp = pin1_FallingEdge(i) - pin1_RisingEdge(i);
                                pin1_PulseWidth_clas_temp = pin1_FallingEdge(i+1) - pin1_RisingEdge(i+1);
                                pin1_PulseWidth_omov_temp = pin1_FallingEdge(i+2) - pin1_RisingEdge(i+2);
                                pin1_PulseWidth_temp = (pin1_FallingEdge(i+3) - pin1_RisingEdge(i))*0.8-20;
                                
                                pin1_PulseWidth_fext = [pin1_PulseWidth_fext pin1_PulseWidth_fext_temp*0.8];
                                pin1_PulseWidth_clas = [pin1_PulseWidth_clas pin1_PulseWidth_clas_temp*0.8];
                                pin1_PulseWidth_omov = [pin1_PulseWidth_omov pin1_PulseWidth_omov_temp*0.8];
                                pin1_PulseWidth = [pin1_PulseWidth pin1_PulseWidth_temp];
                            else
                                disp('Error in getting the edges of GPIO1')
                                break
                            end
                        end
                        for i = 4:4:length(pin1_RisingEdge)-3
                            if (((pin1_FallingEdge(i) - pin1_RisingEdge(i)) > 0) && ((pin1_FallingEdge(i+1) - pin1_RisingEdge(i+1)) > 0) && ((pin1_FallingEdge(i+2) - pin1_RisingEdge(i+2)) > 0))
                                pin1_PulsePeriod_Temp = (pin1_RisingEdge(i) - pin1_RisingEdge(i-3))*0.8-20;
                                pin1_PulsePeriod = [pin1_PulsePeriod pin1_PulsePeriod_Temp];
                            else
                                disp('Error in getting the edges of GPIO1')
                                break
                            end
                        end
                    end
                end
                
                
                
                %Process the GPIO2
                %Get the state levels
                pin2_sLevel = dsp.StateLevels;
                pin2_Levels = pin2_sLevel(pin2_data');
                
                %Compute Pulse Metrics
                pin2_pMetrics = dsp.PulseMetrics('StateLevels', pin2_Levels, 'CycleOutputPort',true);
                [pin2_pulse, pin2_cycle] = pin2_pMetrics(pin2_data');
                
                if (error ~= 1)
                    pin2_PulseWidth = [pin2_PulseWidth pin2_pulse.Width'*0.8];
                    pin2_PulsePeriod = [pin2_PulsePeriod pin2_cycle.Period'*0.8];
                    
                end
            end
            
            clc;
            diary log.txt
            diary ON
            disp('All Loops Ran to Completion')
            if(~isempty(testCase.stimParams))
               save('data.mat','testCase','-append');
            else
                save('data.mat','testCase');
            end
            pause(0.1)
            try
                assert(~isempty(pin1_PulseWidth),'IntegrationTest:TestFailed',"No test data was acquired for Pin1 - Check Test Hardware Connections") %ensure there is is data

                %% Test Results
                disp('GPIO 1');
                
                pin1_message_PulseWidth_fext = 'Feature extraction task has a pulse width of %4.2f +/- %4.2f us\n';
                pin1_message_PulseWidth_clas = 'Classification task has a pulse width of %4.2f +/- %4.2f us\n';
                pin1_message_PulseWidth_omov = 'Output movement task has a pulse width of %4.2f +/- %4.2f us\n';
                pin1_message_PulseWidth = 'The tasks has a pulse width of %4.2f +/- %4.2f us\n';
                pin1_message_PulsePeriod = 'The tasks have a period of %4.2f +/- %4.2f us\n';
                
                fprintf(pin1_message_PulseWidth_fext,mean(pin1_PulseWidth_fext),std(pin1_PulseWidth_fext));
                data.FeatExtPulseWidth = mean(pin1_PulseWidth_fext);
                data.FeatExtPulseWidthStd=std(pin1_PulseWidth_fext);
                fprintf(pin1_message_PulseWidth_clas,mean(pin1_PulseWidth_clas),std(pin1_PulseWidth_clas));
                data.ClassPulseWidth = mean(pin1_PulseWidth_clas);
                data.ClassPulseWidthStd = std(pin1_PulseWidth_clas);
                if (strcmp(testCase.hand,'SensorHand'))
                    pin1_message_PulseWidth_sprs = 'Sensory signal processing task has a pulse width of %4.2f +/- %4.2f us\n';
                    fprintf(pin1_message_PulseWidth_sprs,mean(pin1_PulseWidth_sprs),std(pin1_PulseWidth_sprs));
                    data.SensorySigPulseWidth=mean(pin1_PulseWidth_sprs);
                    data.SensorySigPulseWidthStd=std(pin1_PulseWidth_sprs);
                end
                fprintf(pin1_message_PulseWidth_omov,mean(pin1_PulseWidth_omov),std(pin1_PulseWidth_omov));
                data.OutMovPulseWidth=mean(pin1_PulseWidth_omov);
                data.OutMovPulseWidthStd=std(pin1_PulseWidth_omov);
                fprintf(pin1_message_PulseWidth,mean(pin1_PulseWidth) - 30,std(pin1_PulseWidth)); %Need to subtract the delay of 20us (30 or 20 -Kurt)
                data.TasksPulseWidth=mean(pin1_PulseWidth) - 30;
                data.TasksPulseWidthStd=std(pin1_PulseWidth) - 30;
                fprintf(pin1_message_PulsePeriod,mean(pin1_PulsePeriod) - 30,std(pin1_PulsePeriod));%Need to subtract the delay of 20us
                data.TasksPeriod=mean(pin1_PulsePeriod) - 30;
                data.TasksPeriodStd=std(pin1_PulsePeriod) - 30;
                
                
                %Display the pulse width and pulse period
                disp('GPIO 2');
                pin2_message_PulseWidth = 'The interrupt task has a pulse width of %4.2f +/- %4.2f us\n';
                pin2_message_PulsePeriod = 'The interrupt task has a pulse period of %4.2f +/- %4.2f us\n';
                fprintf(pin2_message_PulseWidth,mean(pin2_PulseWidth),std(pin2_PulseWidth));
                data.Pin2InterruptPulseWidth=mean(pin2_PulseWidth);
                data.Pin2InterruptPulseWidthStd=std(pin2_PulseWidth);
                fprintf(pin2_message_PulsePeriod,mean(pin2_PulsePeriod),std(pin2_PulsePeriod));
                data.Pin2InterruptPeriod=mean(pin2_PulsePeriod);
                data.Pin2InterruptPeriodStd=std(pin2_PulsePeriod);
                
                save('data.mat', 'data','-append');
                
                %% Verifying Test Results
                %FeatExtract Pulse width is smaller than max 
                testCase.log('Trying Feat Extract')
                testCase.verifyLessThan(  data.FeatExtPulseWidth+data.FeatExtPulseWidthStd, testCase.maxTime.FeatExtPulseWidth )
                testCase.log('Feat Extract ran')
                testCase.log('Trying Classification')
                testCase.verifyLessThan(data.ClassPulseWidth+data.ClassPulseWidthStd, testCase.maxTime.ClassPulseWidth)
                testCase.log('Classification ran')
                if (strcmp(testCase.hand,'SensorHand'))
                    testCase.log('Trying Sensory signal')
                    testCase.verifyLessThan(data.SensorySigPulseWidth+data.SensorySigPulseWidthStd, testCase.maxTime.SensorySigPulseWidth)
                    testCase.log('Sensory signal ran')
                end
                testCase.log('Trying Out Movement')
                testCase.verifyLessThan(data.OutMovPulseWidth+data.OutMovPulseWidthStd,testCase.maxTime.OutMovPulseWidth)
                testCase.log('Out Movement ran')
                testCase.log('Trying Task PW')
                testCase.verifyLessThan(data.TasksPulseWidth+data.TasksPulseWidthStd, testCase.maxTime.TasksPulseWidth)
                testCase.log('Task PW ran')
                testCase.log('Trying Task Period')
                testCase.verifyLessThan(data.TasksPeriod+data.TasksPeriodStd, testCase.maxTime.TasksPeriod)
                testCase.log('Task Period ran')
                testCase.log('Trying Pin2 PW')
                testCase.verifyLessThan(data.Pin2InterruptPulseWidth+data.Pin2InterruptPulseWidthStd, testCase.maxTime.EMG_ACGIntPW)
                testCase.log('Pin2 PW ran')
                testCase.log('Trying Pin2 Period')
                testCase.verifyLessThan(data.Pin2InterruptPeriod+data.Pin2InterruptPeriodStd, testCase.maxTime.EMG_ACGIntPeriod)
                testCase.log('Pin2 Period ran') 
                %% Plotting
                testCase.testname = strrep(testCase.testname,'_',' ');
                figure(1);
                histogram(pin2_PulseWidth,200);
                xlabel('Time [us]');
                ylabel('Number of samples');
                legend('GPIO2 EMG Acquisition Pulse Width Histogram');
                saveas(gcf,append(testCase.testname,'_hist_pin2_PulsePeriod.png'));
                
                figure(2);
                histogram(pin1_PulsePeriod,200);
                xlabel('Time [us]');
                ylabel('Number of samples');
                legend('GPIO1 Pulse Period Histogram');
                saveas(gcf,append(testCase.testname,'_hist_pin1_PulsePeriod.png'));
                
                figure(3);
                plot(pin1_PulseWidth(1:end), '.');
                xlabel('Sample #');
                ylabel('Time [us]');
                legend('GPIO1 Pulse Width');
                saveas(gcf,append(testCase.testname, '_pin1_PulseWidth.png'));
                
                figure(4);
                plot(pin1_PulsePeriod(1:end), '.');
                xlabel('Sample #');
                ylabel('Time [us]');
                legend('GPIO1 Pulse Period');
                saveas(gcf,append(testCase.testname, '_pin1_PulsePeriod.png'));
                
                figure(5);
                plot(pin1_PulseWidth_fext(1:end), '.');
                xlabel('Sample #');
                ylabel('Time [us]');
                legend('GPIO1 Feature Extraction Pulse Width');
                saveas(gcf,append(testCase.testname, '_pin1_PulseWidth_fext.png'));
                
                figure(6);
                plot(pin1_PulseWidth_clas(1:end), '.');
                xlabel('Sample #');
                ylabel('Time [us]');
                legend('GPIO1 Classification Pulse Width');
                saveas(gcf,append(testCase.testname, '_pin1_PulseWidth_clas.png'));
                
                figure(7);
                plot(pin1_PulseWidth_omov(1:end), '.');
                xlabel('Sample #');
                ylabel('Time [us]');
                legend('GPIO1 Output Movement Pulse Width');
                saveas(gcf,append(testCase.testname, '_pin1_PulseWidth_omov.png'));
                
                len= min([1500,length(pin2_PulseWidth)]);
                figure(8);
                plot(pin2_PulseWidth(1:len), '.');
                xlabel('Sample #');
                ylabel('Time [us]');
                legend('GPIO2 Pulse Width');
                saveas(gcf,append(testCase.testname, '_pin2_PulseWidth.png'));
                
                len= min([1500,length(pin2_PulsePeriod)]);
                figure(9);
                plot(pin2_PulsePeriod(1:len), '.');
                xlabel('Sample #');
                ylabel('Time [us]');
                legend('GPIO2 Pulse Period');
                saveas(gcf,append(testCase.testname, '_pin2_PulsePeriod.png'));
                
                if (strcmp(testCase.hand,'SensorHand'))
                    figure(10);
                    plot(pin1_PulseWidth_sprs(1:end), '.');
                    xlabel('Sample #');
                    ylabel('Time [us]');
                    legend('GPIO1 Sensory Signal Processing Pulse Width');
                    saveas(gcf,append(testCase.testname, '_pin1_PulseWidth_sprs.png'));
                    save(append(testCase.testname, '.mat'), 'pin1_waveform', 'pin2_waveform','pin1_PulseWidth','pin1_PulsePeriod', 'pin1_PulseWidth_fext','pin1_PulseWidth_clas','pin1_PulseWidth_sprs','pin1_PulseWidth_omov','pin2_PulseWidth','pin2_PulsePeriod');
                else
                    save(append(testCase.testname, '.mat'), 'pin1_waveform', 'pin2_waveform','pin1_PulseWidth','pin1_PulsePeriod', 'pin1_PulseWidth_fext','pin1_PulseWidth_clas','pin1_PulseWidth_omov','pin2_PulseWidth','pin2_PulsePeriod');
                end
            diary OFF    
                
            catch exception
                
                ErrMsg=exception.message;
                X = [' Test Failed because ',ErrMsg];
                disp(X)
                testCase.verifyFail(ErrMsg);
                diary OFF
                
            end
        end
        
    end
    
end