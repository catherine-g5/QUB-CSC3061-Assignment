clearvars
close all

addpath('functions/SVM-KM');
addpath('images');
addpath('functions');
addpath('dataset');
kValue = [1, 3, 5, 10];

[trainImages,trainLabels] = loadFaceImages('face_train.cdataset',1);
modelNN = KNNTraining(trainImages, trainLabels);

[testImages,testLabels] = loadFaceImages('face_test.cdataset',1);

for k = 1:numel(kValue)
    results = zeros(size(testImages,1),1);

    for i=1:size(testImages,1)
        test_image = testImages(i,:);
        results(i) = KNNTesting(test_image,modelNN, kValue(k));
    end

    getConfusionMatrix(testLabels, results)
end

save fullImage_NN modelNN 