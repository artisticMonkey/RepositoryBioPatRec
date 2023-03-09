classdef IntegrationTest3_StimulationTest < matlab.unittest.TestCase
    %IntegrationTest3_StimulationTest tests for stimulation on ALC
    %
    
    %% ToDo
    % - Change area under stim curve a warning and not an error
    %
    %----------------------------------------------------------------------
    
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
        function testCase = IntegrationTest3_StimulationTest()
            % connect to ALC
            delete(instrfindall);
            ports = serialportlist;
            
            [index,inputMade] = listdlg('ListString',ports, 'SelectionMode','single');
            
            if ~inputMade
                error('IntegrationTest3:ListDialogError','No Port Selected')
            end
            comPort = ports(index);
            
            testCase.serialObj = ALC.createSerialObject(comPort);
            uiwait(msgbox('Set oscilliscope vertical parameter to 50 mV on Ch1'))
        end
    end
    
    methods(Test)
        
        function testSendStimCommand(testCase)
            % currently verifies with 10 percent error (+-5%)
            alc=ALC();
            channel = 14-1; %5
            amplitude = 150;
            frequency = 50;
            pulseWidth = 250;
            pulses = 3.8*frequency; %maximal scope acq is 4 seconds
            %% Stim Resistor Val
            stim_resistor= 998; %ohms - as measured on the Fluke
            alc.setCommandMode(testCase.serialObj);
            pause(0.1)
            % Ensure NS is enabled
            write(testCase.serialObj,hex2dec('B3'),'char');
            reply = read(testCase.serialObj,1,'char');
            if reply == hex2dec('B3')
                write(testCase.serialObj,1,'char');
                reply = read(testCase.serialObj,1,'char');
                if reply == hex2dec('B3')
                    disp('enabled')
                    %                     if(enableNS)
                    %                         set(handles.t_msg,'String','Neurostimulator enabled');
                    %                     else
                    %                         set(handles.t_msg,'String','Neurostimulator disabled');
                    %                     end
                else
                    error('StimulationTest:NSInvalidSecondResponse','Error Setting Neurostimulator enable');
                end
            else
                error('StimulationTest:NSInvalidFirstResponse','Error Setting Neurostimulator enable');
            end
            
            myScope = oscilloscope();
            
            % The address of the oscilloscope
            myScope.Resource = 'USB::0x0699::0x0408::C031188::INSTR';
            
            % Connect the scope
            connect(myScope);
            % Start the acquisition
            disp('Start')
            % Enable channel 1 (GPIO1) and channel 2 (GPIO2)
            enableChannel(myScope, 'CH1');
            % Set the acquisition time and number of samples
            Acquisition_Time = 4; %in seconds - four seconds is the max for oscillosocpe
            NumSamples = 5e6; %if you change this - you will need to change a lot of the hardcoded numbers
            set(myScope,'AcquisitionTime',Acquisition_Time);
            set(myScope, 'WaveformLength',NumSamples);
            answer = alc.sendStimCommand(testCase.serialObj, channel, amplitude, pulseWidth, frequency, pulses);
            pause(0.1)
            answer = alc.sendStimCommand(testCase.serialObj, channel, amplitude, pulseWidth, frequency, pulses);
            %verify that the correct data has been written to ALC
            try
                errorMsg = strcat('Stimulation parameters not written to ALC,',answer, ' returned expected ACK_OK');
                assert(all(answer=='ACK_OK'),"StimulationTestError:StimParamsNotSet",errorMsg);
            catch exception
                rethrow(exception)
                %ErrMsg=exception.message;
                %testCase.verifyFail(ErrMsg);
            end
            pause(Acquisition_Time-0.2) % 0.23 - most accurate to get  -0.35 acquisition minus a time which was more accurate at polling the majority of samples
            % End the acquisition
            disp('End');
            % Get the waveform
            %[ch1] = getWaveform(myScope);
            [ch1] = readWaveform(myScope);
            % Disconnect the oscilloscope
            disconnect(myScope);
            %% verify data
            maxStim = [];
            maxStimUp = [];
            aveStim = [];
            aveStimUp =[];
            pulseWidthMeas =[];
            stim_begMat = [];
            area_down =[];
            area_up=[];
            stim_tail_mag=[];
            
            index =1;
            pulse_count = 0;
            fs = pulseWidth/1000000;
            fs2 = 0.00000000000000000000001;%1000
            % filter the data
            ch1 = lowpass(ch1,fs);
            x=1:1:length(ch1);
            ch1b=lowpass(ch1,fs2);
            while pulse_count<pulses && (~isempty(index))
                stimDown_beg = find(ch1(index:end) <  - 0.66*amplitude/1000,1)+index;
                
                stimDown_end = find(ch1(stimDown_beg:end) > -0.66*amplitude/1000,1)+stimDown_beg;
                stimUp_beg = find(ch1(stimDown_end:end)>0.02,1)+stimDown_end;
                stimUp_end = find(ch1(stimUp_beg:end)<0.012,1)+stimUp_beg;
                %stim_end_end = find(diff(ch1(stim_end_beg:end))<-6,1)+stim_end_beg;
                stimDown_beg = stimDown_beg - 10;
                
                %getting a more accurate edge of the up pulse
                if ~isempty(stimDown_beg)
                    [val,ind]=findpeaks(ch1(stimDown_end:stimDown_end+200));
                    if length(ind)==1
                        stimUp_beg=(ind(1))+stimDown_end;
                    elseif length(ind)==2
                        stimUp_beg=(ind(2))+stimDown_end;
                    else
                        stimUp_beg=(ind(3))+stimDown_end;
                    end
                end
                
                
                if ~isempty(stimDown_beg)
                    maxStim = [maxStim,min(ch1(stimDown_beg:stimDown_end) )];
                    maxStimUp = [maxStimUp,max(ch1(stimUp_beg:stimUp_end) )];
                    aveStim_now=mean(ch1(stimDown_beg:stimDown_end) );
                    aveStim = [aveStim,aveStim_now];
                    aveStimUp_now=max(ch1(stimUp_beg:stimUp_end) );
                    aveStimUp = [aveStimUp,aveStimUp_now];
                    pulseWidthMeas = [pulseWidthMeas,10e5*Acquisition_Time/NumSamples*(stimDown_end-stimDown_beg)];
                    stim_begMat = [stim_begMat,stimDown_beg];
                    area_down = [area_down,abs(aveStim_now*(stimDown_end-stimDown_beg))];
                    area_up = [area_up,abs(aveStimUp_now*(stimUp_end-stimDown_end))];
                    %stim_tail=[stim_tail;find( ch1(stimUp_end:stimUp_end+round((stimUp_end-stimUp_beg)/6))<0)];
                    pulse_count= pulse_count+1;
                    %Get the stim_tail
                    %figure(2)
                    millisecondDelay=50; %% +50 - 1 ms delay
                    %findpeaks(abs(ch1(stimUp_end+millisecondDelay:stimUp_end+round((stimUp_end-stimUp_beg)/6))))
                    stim_tail_mag = [stim_tail_mag,max(abs(ch1(stimUp_end:stimUp_end+round((stimUp_end-stimUp_beg)/6))))];
                end
                figure(1)
                %hold on
                xplt=x(stimDown_beg-round((stimDown_end-stimDown_beg)/3):stimUp_end+round((stimUp_end-stimUp_beg)/6));
                yplt=ch1(stimDown_beg-round((stimDown_end-stimDown_beg)/3):stimUp_end+round((stimUp_end-stimUp_beg)/6));
                plot(xplt,yplt)
                hold on
                %plot(x,ch1(stimDown_beg-round((stimDown_end-stimDown_beg)/3):stimUp_end+round((stimUp_end-stimUp_beg)/6)))
                plot(stimDown_beg,ch1(stimDown_beg),'ro',stimDown_end,ch1(stimDown_end),'ro',stimUp_beg,ch1(stimUp_beg),'bo',stimUp_end,ch1(stimUp_end),'bo')
                title('The last stimulation - filtered')
                ylabel('volts')
                xlabel('samples')
                hold off
                index = stimUp_end;
            end
            frequencyMeas=1./(diff(stim_begMat)*Acquisition_Time/NumSamples);
            
            %% Verification
            % Check if we have the exact amount of pulses +/- 2%
            % Scope most likely misses the first 2-3 pulses
            testCase.log('Executing: pulse_count')
            testCase.verifyEqual(pulse_count,pulses, 'RelTol',0.02);
            testCase.log('pulse_count ran')
            % Check if we have the exact amount of pulse width +/- 5%
            testCase.log('Executing: pulseWidthMeas')
            testCase.verifyEqual(pulseWidthMeas, pulseWidth*ones(1,length(pulseWidthMeas)), 'RelTol',0.05)
            testCase.log('pulseWidthMeas ran')
            % Check if the average stim (down) is acceptable +/- 6%
            testCase.log('Executing: aveStim')
            testCase.verifyEqual(aveStim, -amplitude/stim_resistor*ones(1,length(aveStim)), 'RelTol',0.06)
            testCase.log('aveStim ran')
            % Check to see max stim down is acceptable +/- 9%
            testCase.log('Executing: maxStim')
            testCase.verifyEqual(maxStim, -amplitude/stim_resistor*ones(1,length(maxStim)), 'RelTol',0.09)
            testCase.log('maxStim ran')
            % Check to see frequency is acceptable +/- 1%
            testCase.log('Executing: frequencyMeas')
            testCase.verifyEqual(frequencyMeas, (frequency)*ones(1,length(frequencyMeas)),'RelTol',0.01);
            testCase.log('frequencyMeas ran')
            %Check to see area up = area down is acceptable +/- 10%
            testCase.log('Executing: area_down (actual), area_up (expected)')
            testCase.verifyEqual(area_down,area_up,'RelTol',0.1); %a  how much is acceptable?
            testCase.log('area_down,area_up ran')
            %Check to see stim tail is small or zero +/- 10%
            testCase.log('Executing: stim tail')
            testCase.verifyEqual(stim_tail_mag,0.000002*stim_resistor*ones(1,length(stim_tail_mag)),'RelTol',0.1); %a  how much is acceptable?
            testCase.log('stim tail ran')
            
        end
        
    end
    
end