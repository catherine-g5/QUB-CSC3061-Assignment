function [features] = getGabor(images)
% Returns gabor features for each image in matrix
numberOfImages = size(images,1);
features=[];
    for i = 1:numberOfImages
        thisImg = reshape(images(i,:),27,18);
        thisImg = uint8(thisImg);
        gab = gabor_feature_vector(thisImg);
        features=[features; gab];
    end
end
