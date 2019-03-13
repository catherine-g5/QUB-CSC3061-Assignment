clear all
close all

%% Training
addpath('functions/SVM-KM');
addpath('images');
addpath('functions');
addpath('dataset');
sampling=1;
kValue = [1, 3, 5, 10];
[trainImages, trainLabels] = loadFaceImages('face_train.cdataset',sampling);
trainHOG = getHOG(trainImages);
NNmodel = KNNTraining(trainHOG, trainLabels);
fprintf('Training done\n');

%% Testing
[testImages, testLabels] = loadFaceImages('face_test.cdataset',sampling);
testHOG = getHOG(testImages);
numberOfImages = size(testHOG,1);
results = zeros(numberOfImages,1);

for k = 1:numel(kValue)
    results = zeros(numberOfImages,1);

    for i=1:numberOfImages
        thisImg = testHOG(i,:);
        results(i) = KNNTesting(thisImg, NNmodel, kValue(k));
    end

    fprintf('KNN with k=%d\n',kValue(k));
    
    getConfusionMatrix(testLabels, results);
end

save hog_KNN NNmodel 