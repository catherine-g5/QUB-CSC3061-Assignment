function [vector] = convertImage(filename)
%CONVERTIMAGE Summary of this function goes here
%   Detailed explanation goes here
I=imread(filename);
if size(I,3)>1
    I=rgb2gray(I);
end
vector = reshape(I,1, size(I, 1) * size(I, 2));
vector = double(vector); % / 255;   
end

