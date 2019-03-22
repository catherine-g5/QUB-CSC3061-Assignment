clearvars
close all

addpath('functions/SVM-KM');
addpath('images');
addpath('functions');
addpath('dataset');
nDimensions = 18;

[trainImages,trainLabels] = loadFaceImages('face_train.cdataset',1);
[eigenVectors, eigenvalues, meanX, TrainPCA] = PrincipalComponentAnalysis(trainImages, nDimensions);
reducedDimensionalitySVMModel = SVMTraining(TrainPCA, trainLabels);

[testImages, testLabels] = loadFaceImages('face_test.cdataset',1);
[eigenVectors, eigenvalues, meanX, TrainLDA] = PrincipalComponentAnalysis(testImages, nDimensions);

results = zeros(size(testImages,1),1);

for i=1:size(testImages,1)
    results(i) = SVMTesting(TrainLDA(i,:),reducedDimensionalitySVMModel);
end

getConfusionMatrix(testLabels, results);

save reducedDimensionality_SVM reducedDimensionalitySVMModel 