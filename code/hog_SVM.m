clear all
close all

%% Training
addpath('functions/SVM-KM');
addpath('images');
addpath('functions');
addpath('dataset');
sampling=1;
[trainImages, trainLabels] = loadFaceImages('face_train.cdataset',sampling);
trainHOG = getHOG(trainImages);
hogSVMModel = SVMTraining(trainHOG, trainLabels);
fprintf('Training done\n');

%% Testing
[testImages, testLabels] = loadFaceImages('face_test.cdataset',sampling);
testHOG = getHOG(testImages);
numberOfImages = size(testHOG,1);
results = zeros(numberOfImages,1);

for i=1:numberOfImages
    thisImg = testHOG(i,:);
    results(i) = SVMTesting(thisImg,hogSVMModel);
end
getConfusionMatrix(testLabels, results);

save hog_SVM hogSVMModel