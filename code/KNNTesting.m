function prediction = KNNTesting(testImage,modelNN, K)
k = K;

distance = zeros(size(modelNN.neighbours,1),1);

for i=1:size(modelNN.neighbours,1) 
    distance(i) = EuclideanDistance(testImage, modelNN.neighbours(i));
end


minimumValue = min(distance);
minimumIndex = find(minimumValue==distance)

prediction = modelNN.labels(minimumIndex(1))
end

