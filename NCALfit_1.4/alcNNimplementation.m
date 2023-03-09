    alc = ALC();
    prostheticOutput = alc.convertMovementArrayToProstheticOutput(patRec.mov, patRec.movOutIdx);
    weights = ones(7,48);%patRec.patRecTrained.net.Layers(3).Weights;
    for i = 1:7
        if i < 4
            weights(i,:) = weights(i,:)*i;
        else
            weights(i,:) = weights(i,:)./i;
        end
    end
    bias = zeros(7,1); %patRec.patRecTrained.net.Layers(3).Bias;
    
    
    NNCoefficients.nActiveClasses = patRec.nOuts;
    NNCoefficients.nFeatureSets = size(weights,2);
    NNCoefficients.weights = weights;
    NNCoefficients.bias = bias;
    NNCoefficients.threshold = patRec.networkThresholds;
    NNCoefficients.prostheticOutput = prostheticOutput;
    NNCoefficients.mean = zeros(1,48);%patRec.normSets.nMean;
    NNCoefficients.std = ones(1,48);%patRec.normSets.nStd;
    
    %%------------------
    
    featVector = zeros(80,1);
    for i=1:12
        featVector(i) = i-1;
    end

    %%------------------
     newSample = zeros(NNCoefficients.nFeatureSets,1);
     for i=1:NNCoefficients.nFeatureSets
        newSample(i) = (featVector(i) - NNCoefficients.mean(i))/NNCoefficients.std(i);
     end
     
     %%-----------------
     
     for i=1:NNCoefficients.nActiveClasses
        % Multiply input with weights
        fClassification(i) =  NNCoefficients.weights(i,:)*newSample; 
        % Add bias
        fClassification(i) = fClassification(i) + NNCoefficients.bias(i);
        % Apply ReLU f(x) = max(x,0)
        fClassification(i) = max(fClassification(i),0);
     end
     
    %%-------------------------------------------------------
    %% Softmax layer
    %%-------------------------------------------------------
    maxActivation = 0.0;

    % Get max value in array
    for i=1:NNCoefficients.nActiveClasses
      if fClassification(i) > maxActivation 
          maxActivation = fClassification(i);
      end
    end
    
    % Sum of exponentials
    sumActivationOutputs = 0;
    for i=1:NNCoefficients.nActiveClasses
        sumActivationOutputs = sumActivationOutputs+ exp(fClassification(i) - maxActivation);
    end

    % Calculate softmax
    offset = maxActivation + log(sumActivationOutputs);
    for i=1:NNCoefficients.nActiveClasses
        fClassification(i) = exp(fClassification(i) - offset);
    end
    
    %-------------------------------------------------------
    % Thresholding
    %-------------------------------------------------------
    % Last movement in the NN is Rest
    outClassIndex = NNCoefficients.nActiveClasses;
    maxProbability = fClassification(NNCoefficients.nActiveClasses);


    % If a movement has a higher probability than Rest and it's probability is over the set threshold, it's the new outClass
    for i=1:(NNCoefficients.nActiveClasses-1)
        if (fClassification(i) > maxProbability)&& (fClassification(i) > NNCoefficients.threshold(i))
            outClassIndex = i;
            maxProbability = fClassification(i);
        end
    end

    %% Convert outClassIndex from the BioPatRec format to the assigned prosthetic output

    outClassIndex = NNCoefficients.prostheticOutput(outClassIndex);


    %% ----------------------------------------
    
    tmp_net = patRec.patRecTrained.net.saveobj;
    tmp_net.Layers(3).Weights = NNCoefficients.weights; 
    tmp_net.Layers(3).Bias = NNCoefficients.bias; 
    patRec.patRecTrained.net = patRec.patRecTrained.net.loadobj(tmp_net);
    %classify(patRec.patRecTrained.net, testDigitData);

    outCell = activations(patRec.patRecTrained.net,newSample,'softmax');
    outVector = outCell{:};