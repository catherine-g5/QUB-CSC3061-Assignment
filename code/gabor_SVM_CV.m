clearvars
close all

% Load all images & labels
[images,labels] = loadFaceImages('face_all.cdataset',1);
gabor = getGabor(images);

% Fit SVM model
modelSVM = fitcsvm(gabor,labels);

% Create cross-validated classifier
cvmodelSVM = crossval(modelSVM,'Kfold',10);

% Predict class labels for testing data
results = kfoldPredict(cvmodelSVM);

getConfusionMatrix(labels,results);