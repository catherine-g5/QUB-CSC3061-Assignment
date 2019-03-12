clear all
close all

%% Training
sampling=1;
[trainImages, trainLabels] = loadFaceImages('face_train.cdataset',sampling);
trainGabor = getGabor(trainImages);
SVMmodel = SVMTraining(trainGabor, trainLabels);
fprintf('Training done\n');

%% Testing
[testImages, testLabels] = loadFaceImages('face_test.cdataset',sampling);
testGabor = getGabor(testImages);
numberOfImages = size(testGabor,1);
results = zeros(numberOfImages,1);

for i=1:numberOfImages
    thisImg = testGabor(i,:);
    results(i) = SVMTesting(thisImg,SVMmodel);
end
getConfusionMatrix(testLabels, results)

save gabor_SVM SVMmodel