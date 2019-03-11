% Trains and tests an SVM model for classifying images as face or non-face.
% Uses full image as feature descriptor.
clearvars
close all

addpath('SVM-KM');
addpath('functions');
addpath('dataset');
%% training

% Load the training images & labels
[images,labels] = loadFaceImages('face_train.cdataset',1);

% Train the SVM model
modelSVM = SVMTraining(images, labels);

%% testing

[images,labels] = loadFaceImages('face_test.cdataset',1);

% Classify each testing image using the trained model

% Preallocate results array
results = zeros(size(images,1),1);

for i=1:size(images,1)
    test_image = images(i,:);
    results(i) = SVMTesting(test_image,modelSVM);
end

%% evaluation

% Compare given classification of each testing image to its true class
comparison = (labels==results);

% Calculate accuracy of the model
accuracy = sum(comparison) / length(comparison);
fprintf('Accuracy of SVM model: %.2f%%\n', 100*accuracy);

save fullImage_SVM modelSVM