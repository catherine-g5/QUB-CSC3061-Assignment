function [boundingBoxes] = GaborSVMDetector(model,image, windowSize)
    row = 1;
    col = 1;
    [maxCol, maxRow] = size(image);

    windowMax = 1;
    for y = col:maxCol-windowSize(2)   
        for x = row:maxRow-windowSize(1)
            windowMax = windowMax+1;
        end
    end

    results = zeros(windowMax,1);
    boundingBox = zeros(windowMax,2);
    windowNumber = 1;

    for y = col:maxCol-windowSize(2)   
        for x = row:maxRow-windowSize(1)
            po = [x, y, windowSize(1), windowSize(2)];
            img = imcrop(image, po); 
            gab = gabor_feature_vector(img);
            results(windowNumber) = SVMTesting(gab,model);
            boundingBox(windowNumber, 1) = x;
            boundingBox(windowNumber, 2) = y;
            windowNumber = windowNumber+1;
        end
    end

    boundingBoxes = boundingBox(results == 1, :);
end

