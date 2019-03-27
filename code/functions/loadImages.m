function [trainImages,trainLabels,testImages,testLabels] = loadImages(split,sampling)
%LOADIMAGES Assigns images and labels for different splits of
%traning/testing sets

%   'split' (1-100) is the percentage of images to be used for training. 
%   split=0 uses given training/testing dataset files

%% Default datasets

if (split>100||split<0)
    split=0;
end
if split==0
    [trainImages,trainLabels] = loadFaceImages('face_train.cdataset',sampling);
    [testImages,testLabels] = loadFaceImages('face_test.cdataset',sampling);
else
    
%% Load training images 
    
    trainImages = [];
    trainLabels = [];
    
    %Get filenames of cropped images
    faces = dir('images/face/*.png');
    faces = {faces.name}';
    nonFaces = dir('images/non-face/*.png');
    nonFaces = {nonFaces.name}';
    %Get index of last image for each training set 
    posTrain = round((split/100)*numel(faces));
    negTrain = round((split/100)*numel(nonFaces));
    
    for im=1:sampling:posTrain
        filename = cell2mat(faces(im));
        filename = sprintf('images/face/%s',filename);
        [trainImages, trainLabels] = convertImage(filename,1,trainImages, trainLabels);
    end
    
    for im=1:sampling:negTrain
        filename = cell2mat(nonFaces(im));
        filename = sprintf('images/non-face/%s',filename);
        [trainImages, trainLabels] = convertImage(filename,-1,trainImages, trainLabels);
    end

%% Load testing images

    testImages = []; 
    testLabels = [];
    
    for im=posTrain+1:sampling:numel(faces)
        filename = cell2mat(faces(im));
        filename = sprintf('images/face/%s',filename);
        [testImages, testLabels] = convertImage(filename,1,testImages, testLabels);
    end
    
    for im=negTrain+1:sampling:numel(nonFaces)
        filename = cell2mat(nonFaces(im));
        filename = sprintf('images/non-face/%s',filename);
        [testImages, testLabels] = convertImage(filename,-1,testImages, testLabels);
    end
end
end
