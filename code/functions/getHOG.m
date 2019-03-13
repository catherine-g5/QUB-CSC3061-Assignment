function [features] = getHOG(images)
% Returns gabor features for each image in matrix
numberOfImages = size(images,1);
features=[];
    for i = 1:numberOfImages
        thisImg = reshape(images(i,:),27,18);
        thisImg = uint8(thisImg);
        gab = hog_feature_vector(thisImg);
        features=[features; gab];
    end
end



