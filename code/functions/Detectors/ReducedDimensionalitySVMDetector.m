function [boundingBoxes] = ReducedDimensionalitySVMDetector(model,image, windowSize, nDimensions)
    row = 1;
    col = 1;
    steps = 5;
    [maxCol, maxRow] = size(image);

    windowMax = 1;
    for y = col:steps:maxCol-windowSize(2)   
        for x = row:steps:maxRow-windowSize(1)
            windowMax = windowMax + 1;
        end
    end

    results = zeros(windowMax,1);
    boundingBox = zeros(windowMax,2);
    windowNumber = 1;
    %pBar = textprogressbar(windowMax*2);
    
    for y = col:3:maxCol-windowSize(2)   
        for x = row:3:maxRow-windowSize(1)
            po = [x, y, windowSize(1) - 1, windowSize(2) - 1];
            img{windowNumber} = imcrop(image, po);
            windowNumber = windowNumber+1;
            %pBar(windowNumber)
        end
    end
    
    img = cell2mat(img);
    [eigenVectors, eigenvalues, meanX, TrainLDA] = PrincipalComponentAnalysis(double(img), nDimensions);
     
    for i = 1:windowMax-1
        results(i) = SVMTesting(TrainLDA(i,:),model);
        boundingBox(i, 1) = x;
        boundingBox(i, 2) = y;
        boundingBox(i, 3) = x + windowSize(1);
        boundingBox(i, 4) = y + windowSize(2);
        pBar(i + windowNumber)
    end
    
    boundingBoxes = boundingBox(results == 1, :);
end

