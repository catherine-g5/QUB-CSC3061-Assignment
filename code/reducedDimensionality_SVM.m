clearvars
close all

addpath('SVM-KM');
addpath('images');
addpath('functions');
addpath('dataset');
nDimensions = 15;

[trainImages,trainLabels] = loadFaceImages('face_train.cdataset',1);
[eigenVectors, eigenvalues, meanX, TrainPCA] = PrincipalComponentAnalysis(trainImages, nDimensions);
modelSVM = SVMTraining(TrainPCA, trainLabels);

[testImages, testLabels] = loadFaceImages('face_test.cdataset',1);
[eigenVectors, eigenvalues, meanX, TrainLDA] = PrincipalComponentAnalysis(testImages, nDimensions);

results = zeros(size(testImages,1),1);

for i=1:size(testImages,1)
    results(i) = SVMTesting(TrainLDA(i,:),modelSVM);
end

comparison = (testLabels==results);

accuracy = sum(comparison) / length(comparison);
fprintf('Accuracy of SVM model: %.2f%%\n', 100*accuracy);

save reducedDimensionality_SVM modelSVM 