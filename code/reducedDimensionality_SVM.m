clearvars
close all

addpath('SVM-KM');
addpath('images');

[trainImages,trainLabels] = loadFaceImages('face_train.cdataset',1);

modelSVM = SVMTraining(trainImages, trainLabels);

[testImages, testLabels] = loadFaceImages('face_test.cdataset',1);

results = zeros(size(testImages,1),1);

for i=1:size(testImages,1)
    test_image = testImages(i,:);
    results(i) = SVMTesting(test_image,modelSVM);
end

comparison = (testLabels==results);

accuracy = sum(comparison) / length(comparison);
fprintf('Accuracy of SVM model: %.2f%%\n', 100*accuracy);