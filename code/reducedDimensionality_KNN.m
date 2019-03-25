clearvars
close all

addpath('functions/SVM-KM');
addpath('images');
addpath('functions');
addpath('dataset');
kValue = [1, 3, 5, 10];
nDimensions = 15;

[trainImages,trainLabels,testImages,testLabels] = loadImages(0,1);
[eigenVectors, eigenvalues, meanX, TrainPCA] = PrincipalComponentAnalysis(trainImages, nDimensions);

modelNN = KNNTraining(TrainPCA, trainLabels);

[eigenVectors, eigenvalues, meanX, TestPCA] = PrincipalComponentAnalysis(testImages, nDimensions);

for k = 1:numel(kValue)
    results = zeros(size(testImages,1),1);

    for i=1:size(testImages,1)
        results(i) = KNNTesting(TestPCA(i,:),modelNN, kValue(k));
    end

    fprintf('KNN with N equal to %d \n', kValue(k));
    getConfusionMatrix(testLabels, results);
end

save reducedDimensionality_NN modelNN 