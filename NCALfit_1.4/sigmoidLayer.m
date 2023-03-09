classdef sigmoidLayer < nnet.layer.Layer
methods
        function layer = sigmoidLayer(name) 
            % Set layer name
            layer.Name = name;
            
            % Set layer description
            layer.Description = 'sigmoidLayer'; 
        end
        function Z = predict(layer,X)
            % Forward input data through the layer and output the result
            Z = sigmoid(X);
        end

    end
end