comPort = '/dev/tty.usbserial-A106TXYO'
baudRate = 460800;
delete(instrfindall);    
serialObj = serialport(comPort, baudRate, 'Databits', 8, 'Byteorder', 'big-endian');

ALC.testConnection(serialObj);

alc = ALC();

minActivationThreshold = 10;
sensitivity = 1;
minimumSpeed = 20;
maximumSpeed = 50;
minModulationSpeedStep = 3;
maxModulationSpeedStep = 8;
minPWM = 10;
maxPWM = 100;
alc.setCommandMode(serialObj)
alc.setMiaHandControlParameters(serialObj,minActivationThreshold, sensitivity, minimumSpeed,maximumSpeed, ...
                                          minModulationSpeedStep, maxModulationSpeedStep, minPWM, maxPWM)
alc.setControlMode(serialObj)


%% ---

data = alc.acquireTWs(serialObj,50)

%% ---
parameterStruct.strengthFilterLength = 5;
alc.setProportionalControlParameters(serialObj,parameterStruct)

%%
alc.getNNParameters(serialObj)

alc.setNNParameters(serialObj,alc.NNCoefficients)