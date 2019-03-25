clear all
close all

%% Training
sampling=1;
[trainImages,trainLabels,testImages,testLabels] = loadImages(0,sampling);
trainGabor = getGabor(trainImages);
gaborSVMModel = SVMTraining(trainGabor, trainLabels);
fprintf('Training done\n');

%% Testing
testGabor = getGabor(testImages);
numberOfImages = size(testGabor,1);
results = zeros(numberOfImages,1);

for i=1:numberOfImages
    thisImg = testGabor(i,:);
    results(i) = SVMTesting(thisImg,gaborSVMModel);
end
getConfusionMatrix(testLabels, results);

save gabor_SVM gaborSVMModel