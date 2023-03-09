classdef NeuralNetworks < handle
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    properties (Constant)
        supportedArchitectures = {'1LayerFFNNReLU', '1LayerFFNNSigmoidMixed'};
    end
    properties
        X               % Input Data
        Y               % Lables
        XNormalized
        XTraining
        YTraining
        XValidation
        YValidation
        XTest
        YTest
        
        nInputs
        nOutputs
        movOutIdx
        
        meanVector
        stdVector
        
        architecture
        options
        layers
        net
        
        networkThresholds
        proportionalThresholds
    end
    
    methods
        
        %% Class constructor
        %------------------------------------------------------------------
        function self = NeuralNetworks(X,Y, architectureName)
            % X: Input data in format [nSamples, nFeatures]
            % Y: Lables in format [nSamples, 1]
            % architectureName: Name of the NN architecture
            
            self.X = X;
            self.Y = Y;
            
            if any(strcmp(self.supportedArchitectures, architectureName))
                self.architecture = architectureName;
            else
                error('Nonsupported architecture')
            end
            
            self.normalizeDataSet;
            
            self.splitDataSet;
            
            if strcmp(self.architecture, '1LayerFFNNReLU')
                self.create1LayerFFNNReLU;
            elseif strcmp(self.architecture, '1LayerFFNNSigmoidMixed')
                self.create1LayerFFNNSigmoidMixed;
            end
            % Create options
            self.createNetworkOptions;
            % Train Network
            self.net = trainNetwork(self.XTraining',self.YTraining',self.layers,self.options);
            % Test Network
            self.testNetwork;
            
            
            
        end
        
        function normalizeDataSet(self)
            
            self.meanVector = mean(self.X);
            self.stdVector = std(self.X);
            self.XNormalized = (self.X - self.meanVector)./self.stdVector;
        end
        
        function splitDataSet(self)
            % split data set
            [trainIndex,valIndex,testIndex] = dividerand(size(self.X,1),0.6,0.2,0.2);
            
            
            self.XTraining = self.XNormalized(trainIndex,:);
            self.YTraining = self.Y(trainIndex,:);
            self.XValidation = self.XNormalized(valIndex,:);
            self.YValidation = self.Y(valIndex,:);
            self.XTest = self.XNormalized(testIndex,:);
            self.YTest = self.Y(testIndex,:);
            
        end
        
        function create1LayerFFNNReLU(self)
            self.nInputs = size(self.X,2);
            self.nOutputs = length(unique(self.Y));
            self.movOutIdx = num2cell(1:self.nOutputs);
            
            self.YTraining = categorical(self.YTraining);
            self.YValidation = categorical(self.YValidation);
            self.YTest = categorical(self.YTest);
            
            
        	self.layers = [
                sequenceInputLayer(self.nInputs,"Name","Input")
                dropoutLayer(0.1,"Name","Dropout")
                fullyConnectedLayer(self.nOutputs,"Name","WeightsLayer")
                reluLayer("Name","ReLU")
                softmaxLayer("Name","Softmax")
                classificationLayer("Name","Classoutput")];

        end
        
        function create1LayerFFNNSigmoidMixed(self)
            self.nInputs = size(self.X,2);
            self.nOutputs = size(self.Y,2);
            %self.movOutIdx = num2cell(1:self.nOutputs);

            
             self.layers = [
                sequenceInputLayer(self.nInputs,"Name","Input")
                dropoutLayer(0.1,"Name","Dropout")
                fullyConnectedLayer(self.nOutputs,"Name","WeightsLayer")
                sigmoidLayer("sigmoid")
                binaryClassificationLayer("Classoutput")];
        end
        
        function createNetworkOptions(self)
            
            %Training options
            maxEpochs = 1000;
            miniBatchSize = size(self.XTraining,2);
            
            self.options = trainingOptions('adam', ...
            'InitialLearnRate',0.001, ...
            'ExecutionEnvironment','cpu', ...
            'GradientThreshold',1, ...
            'L2Regularization', 0.01, ...
            'MaxEpochs',maxEpochs, ...
            'ValidationData',{self.XValidation',self.YValidation'}, ...
            'MiniBatchSize',miniBatchSize, ...
            'SequenceLength','longest', ...
            'Shuffle','every-epoch', ...
            'Verbose',0, ...
            'Plots','training-progress');
        end
        
        function testNetwork(self)
            if strcmp(self.architecture, '1LayerFFNNReLU')
                YPred = classify(self.net,self.XTest');
                figure
                plotconfusion(self.YTest',YPred)
            elseif strcmp(self.architecture, '1LayerFFNNSigmoidMixed')
                YPred = predict(self.net,self.XTest');
                % Add something here for mixed classes
                
            end
            
        end
        
        function extractWeights(self)
            
        end
    end
end

