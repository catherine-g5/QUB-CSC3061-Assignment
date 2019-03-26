clearvars
close all

nDimensions = 15;

% Load all images & labels
[images,labels] = loadFaceImages('face_all.cdataset',1);
[~,~,~,TestPCA] = PrincipalComponentAnalysis(images,nDimensions);

% Fit SVM model
modelSVM = fitcsvm(TestPCA,labels);

% Create cross-validated classifier
cvmodelSVM = crossval(modelSVM,'Kfold',10);

% Predict class labels for testing data
results = kfoldPredict(cvmodelSVM);

getConfusionMatrix(labels,results);