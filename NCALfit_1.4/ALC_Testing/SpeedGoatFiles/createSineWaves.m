sF = 500; %[Hz]
duration = 1; %[s]
timeVector = linspace(0,duration, duration*sF); 

sinFrequency = 10;
sinAmplitude = 1;

signalSegment = sin(2 * pi * timeVector * sinFrequency) +2.5;
restSegment = 2.5*ones(1,duration*sF);

data = [];
amplitudes = [0.5 1 2];
for i=1:3
    signalSegment = amplitudes(i)*sin(2 * pi * timeVector * sinFrequency) +2.5;
    channel1 = [signalSegment restSegment restSegment   restSegment restSegment   restSegment restSegment  ];
    channel2 = [restSegment   restSegment signalSegment restSegment restSegment   restSegment restSegment  ];
    channel3 = [restSegment   restSegment restSegment   restSegment signalSegment restSegment restSegment  ];
    channel4 = [restSegment   restSegment restSegment   restSegment restSegment   restSegment signalSegment];

    temp = [channel1; channel2; channel3; channel4];
    data = [data temp];
end

nSegments = 7*length(amplitudes);
totalTimeVector = linspace(0,duration*nSegments,duration*sF*nSegments);

data = [totalTimeVector; data];
save('simulinkData.mat','data');