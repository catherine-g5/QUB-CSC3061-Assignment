clearvars
close all

kValue = [1,3,5,10];
nDimensions = 15;

% Load all images & labels
[images,labels] = loadFaceImages('face_all.cdataset',1);
[~,~,~,TestPCA] = PrincipalComponentAnalysis(images,nDimensions);

for k=1:numel(kValue)
    % Fit KNN model
    modelKNN = fitcknn(TestPCA,labels,'NumNeighbors',kValue(k));
    
    % Create cross-validated classifier
    cvmodelKNN = crossval(modelKNN,'Kfold',10);
    
    % Predict class labels for testing data
    results = kfoldPredict(cvmodelKNN);
    
    fprintf('KNN with K equal to %d \n', kValue(k));
    getConfusionMatrix(labels,results);
end