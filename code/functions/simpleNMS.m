function [nmsBoxes] = simpleNMS(boundingBoxes, threshold, windowSize)
    nmsBoxes = boundingBoxes;
    
    pBar = textprogressbar(length(nmsBoxes) * length(nmsBoxes));
    
    for i = 1:size(nmsBoxes)
       thisBox = [nmsBoxes(i, 1), nmsBoxes(i, 2), windowSize(1) , windowSize(2)];
       thisBoxArea = windowSize(1) * windowSize(2);
       for j = 1:size(nmsBoxes)
           detectedBox = [nmsBoxes(j, 1), nmsBoxes(j, 2), windowSize(1) , windowSize(2)];
           intersectionArea = rectint(thisBox , detectedBox);
           
           deltaArea = intersectionArea / thisBoxArea;
           
           if (deltaArea > threshold)
              nmsBoxes(i, 1) = 0;
              nmsBoxes(i, 2) = 0;
           end
           
           pBar(i*i);
       end
    end
end

