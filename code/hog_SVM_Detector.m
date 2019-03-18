% Imports
addpath('functions');
addpath('functions/SVM-KM');
addpath('functions/Detectors');

% TODO - Add in a loop to load in all images
im = imread('images/im2.jpg'); % Loads in test image 
imshow(im); % Shows Image

load('hog_SVM.mat'); % Model name is SVM Model
windowSize = [18, 27]; % Window Size is the size of the test set images

% Gets boundingboxes for the test image, this should indicate a face
% detected
bBoxes = SVMDetector(SVMmodel, im, windowSize);

% Goes through all of the bounding boxes and displays them on the image
for i = 1:size(bBoxes,1) 
    rectangle('Position',[bBoxes(i, 1),bBoxes(i, 2),windowSize(1),windowSize(2)],'LineWidth',1, 'EdgeColor','r')
end


