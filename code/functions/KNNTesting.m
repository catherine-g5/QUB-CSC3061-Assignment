function prediction = KNNTesting(testImage,modelNN, K)
k = K;

distance = zeros(size(modelNN.neighbours,1),1);

for i=1:size(modelNN.neighbours,1) 
    distance(i) = EuclideanDistance(testImage, modelNN.neighbours(i));
end

minimumValues = zeros(k,1);
minimumIndexes = zeros(k,1);
for i=1:k
  [minimumValues(i),minimumIndexes(i)] = min(distance);
  distance(minimumIndexes(i)) = [];
end

minimumLabels = modelNN.labels(minimumIndexes, 1);
possibleLabels = unique(modelNN.labels);
votesLabels = zeros(size(possibleLabels, 1), 1);

for i=1:size(possibleLabels)
    votesLabels(i) = sum(minimumLabels==possibleLabels(i));
end
[maxVal, maxIndex] = max(votesLabels);

prediction = possibleLabels(maxIndex);
end

