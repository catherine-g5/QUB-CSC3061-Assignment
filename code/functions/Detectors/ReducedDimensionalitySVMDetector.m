function [boundingBoxes] = ReducedDimensionalitySVMDetector(model,image, windowSize, nDimensions)
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
    pBar = textprogressbar(windowMax);
    
    for y = col:maxCol-windowSize(2)   
        for x = row:maxRow-windowSize(1)
            po = [x, y, windowSize(1) - 1, windowSize(2) - 1];
            img = imcrop(image, po);
            
            [eigenVectors, eigenvalues, meanX, TrainLDA] = PrincipalComponentAnalysis(double(img), nDimensions);

            results(windowNumber) = SVMTesting(TrainLDA,model);
            boundingBox(windowNumber, 1) = x;
            boundingBox(windowNumber, 2) = y;
            windowNumber = windowNumber+1;
            pBar(windowNumber)
        end
    end

    boundingBoxes = boundingBox(results == 1, :);
end

