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
fullImageSVMModel = SVMTraining(images, labels);

%% testing

% Classify each testing image using the trained model

% Preallocate results array
results = zeros(size(images,1),1);

for i=1:size(images,1)
    test_image = images(i,:)
    results(i) = SVMTesting(test_image,fullImageSVMModel);
end

%% evaluation

getConfusionMatrix(labels, results);

save fullImage_SVM fullImageSVMModel