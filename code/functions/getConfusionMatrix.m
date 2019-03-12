function [confusionMatrix, rates] = getConfusionMatrix(labels, predictions)
% Assumes a table of -1  1 
%                  -1 TN FN
%                   1 FP TN

numberOfImages = length(predictions);
comparison = (labels==predictions);
predictedFaces = sum(predictions==1);
% Calculate accuracy of the model
accuracy = sum(comparison) / numberOfImages;
fprintf('Prediction: %d face, %d non-face\n', predictedFaces, numberOfImages-predictedFaces);


confusionMatrix = confusionmat(labels, predictions);
TP = confusionMatrix(2,2);
FP = confusionMatrix(1,2);
FN = confusionMatrix(2,1);
TN = confusionMatrix(1,1);

rates.recall = TP / (TP+FN);
rates.precision = TP / (TP+FP);
rates.specificity = TN / (TN+FP);
rates.f1 = 2*TP / (2*TP + FN + FP);
rates.falseAlarm = FP / (FP + TN);

fprintf('Accuracy of model: %.2f%%\n', 100*accuracy);
end

