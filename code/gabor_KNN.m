clear all
close all

%% Training
sampling=1;
kValue = [1, 3, 5, 10];
[trainImages, trainLabels] = loadFaceImages('face_train.cdataset',sampling);
trainGabor = getGabor(trainImages);
NNmodel = KNNTraining(trainGabor, trainLabels);
fprintf('Training done\n');

%% Testing
[testImages, testLabels] = loadFaceImages('face_test.cdataset',sampling);
testGabor = getGabor(testImages);
numberOfImages = size(testGabor,1);
results = zeros(numberOfImages,1);

for k = 1:numel(kValue)
    results = zeros(numberOfImages,1);

    for i=1:numberOfImages
        results(i) = KNNTesting(testGabor(i,:), NNmodel, kValue(k));
    end

    fprintf('KNN with k=%d',kValue(k));
    getAccuracy(testLabels, results);
end