classdef binaryClassificationLayer < nnet.layer.RegressionLayer %ClassificationLayer
               
    properties
        % Vector of weights corresponding to the classes in the training
        % data
        ClassWeights
    end

    methods
        function layer = binaryClassificationLayer(name)
            % layer = weightedClassificationLayer(classWeights) creates a
            % weighted cross entropy loss layer. classWeights is a row
            % vector of weights corresponding to the classes in the order
            % that they appear in the training data.
            % 
            % layer = weightedClassificationLayer(classWeights, name)
            % additionally specifies the layer name. 

            % Set class weights
            %layer.ClassWeights = classWeights;

            % Set layer name
            layer.Name = name;
            

            % Set layer description
            layer.Description = 'Binary cross entropy';
        end
        
        function loss = forwardLoss(layer, Y, T)
            % loss = forwardLoss(layer, Y, T) returns the weighted cross
            % entropy loss between the predictions Y and the training
            % targets T.

             %N = size(Y,3);
             Y = squeeze(Y);
             T = squeeze(T);
           % W = ones(1,7);
            %loss = -sum(W*(T.*log(Y)))/N;
            
            dlX = dlarray(Y,'CB');
            
            loss = crossentropy(dlX,T,'TargetCategories','independent');
    
          %  loss = -sum(T.*log(Y))/N;
            
            %loss = crossentropy(Y,T);
        end
    end
end