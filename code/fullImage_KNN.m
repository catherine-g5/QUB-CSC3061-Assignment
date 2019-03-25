clearvars
close all

addpath('functions/SVM-KM');
addpath('images');
addpath('functions');
addpath('dataset');
kValue = [1, 3, 5, 10];

[trainImages,trainLabels,testImages,testLabels] = loadImages(0,1);
modelNN = KNNTraining(trainImages, trainLabels);

for k = 1:numel(kValue)
    results = zeros(size(testImages,1),1);

    for i=1:size(testImages,1)
        test_image = testImages(i,:);
        results(i) = KNNTesting(test_image,modelNN, kValue(k));
    end
    
    fprintf('KNN with N equal to %d \n', kValue(k));
    getConfusionMatrix(testLabels, results);
end

save fullImage_NN modelNN 