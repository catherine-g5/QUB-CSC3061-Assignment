function [] = getAccuracy(labels,results)
%GETACCURACY Calculate accuracy of the model
%   Detailed explanation goes here
numberOfImages = length(results);
comparison = (labels==results);
predictedFaces = sum(results==1);
% Calculate accuracy of the model
accuracy = sum(comparison) / numberOfImages;
fprintf('Prediction: %d face, %d non-face\n', predictedFaces, numberOfImages-predictedFaces);
fprintf('Accuracy of model: %.2f%%\n', 100*accuracy);
end

