clearvars
close all

addpath('images');
kValue = [1, 3, 5, 10];
nDimensions = 15;

[trainImages,trainLabels] = loadFaceImages('face_train.cdataset',1);
[eigenVectors, eigenvalues, meanX, TrainPCA] = PrincipalComponentAnalysis(trainImages, nDimensions);

modelNN = KNNTraining(TrainPCA, trainLabels);

[testImages,testLabels] = loadFaceImages('face_test.cdataset',1);
[eigenVectors, eigenvalues, meanX, TestPCA] = PrincipalComponentAnalysis(testImages, nDimensions);

for k = 1:numel(kValue)
    results = zeros(size(testImages,1),1);

    for i=1:size(testImages,1)
        results(i) = KNNTesting(TestPCA(i,:),modelNN, kValue(k));
    end

    comparison = (testLabels==results);

    accuracy = sum(comparison) / length(results);
    fprintf('KNN with N equal to %d \n', kValue(k));
    fprintf('Accuracy of KNN model: %.2f%%\n', 100*accuracy);
end
save reducedDimensionality_NN modelNN 