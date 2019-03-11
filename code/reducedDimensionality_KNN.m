clearvars
close all

addpath('SVM-KM');
addpath('images');

[trainImages,trainLabels] = loadFaceImages('face_train.cdataset',1);

modelNN = KNNTraining(trainImages, trainLabels);

[testImages,testLabels] = loadFaceImages('face_test.cdataset',1);

results = zeros(size(testImages,1),1);

for i=1:size(testImages,1)
    index = i
    test_image = testImages(i,:);
    results(i) = KNNTesting(test_image,modelNN, 1);
end

comparison = (testLabels==results);

accuracy = sum(comparison) / length(results);
fprintf('Accuracy of KNN model: %.2f%%\n', 100*accuracy);