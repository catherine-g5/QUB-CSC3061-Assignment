% Trains and tests an SVM model for classifying images as face or non-face.
% Uses full image as feature descriptor.
clearvars
close all

addpath('functions/SVM-KM');
addpath('images');
addpath('functions');
addpath('dataset');
%% training

% Load the training images & labels
[trainImages,trainLabels,testImages,testLabels] = loadImages(0,1);

% Train the SVM model
fullImageSVMModel = SVMTraining(trainImages, trainLabels);

%% testing

% Classify each testing image using the trained model

% Preallocate results array
results = zeros(size(testImages,1),1);

for i=1:size(testImages,1)
    test_image = testImages(i,:);
    results(i) = SVMTesting(test_image,fullImageSVMModel);
end

%% evaluation

getConfusionMatrix(testLabels, results);

save fullImage_SVM fullImageSVMModel