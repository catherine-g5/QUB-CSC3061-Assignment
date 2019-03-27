function [Iout] = enhanceContrast(Iin)
%ENHANCECONTRAST Enhances contrast of image using method specified by the
%variable enhancementType
%Enable or disable contrast enhancement in convertImage.m

enhancementType=3; % 1=linear stretching, 2=power law, 3=hist equalisation
gamma=1; %gamma value for power law

numberOfPixels=size(Iin,2);
LUT=[];

%% Create lookup table for chosen method
% i+1 used for LUT index because MATLAB starts indexing at 1
if enhancementType==1
    m = 255/(max(Iin)-min(Iin));
    c = -m * min(Iin);
    for i=0:255
        if i<(-c/m)
            LUT(i+1)=0;
        elseif i>((255-c)/m)
            LUT(i+1)=255;
        else
            LUT(i+1) = (m*i)+c;
        end
    end
elseif enhancementType==2
    for i=0:255
        LUT(i+1) = round((i^gamma)/(255^(gamma-1)));
    end
elseif enhancementType==3
    np=numberOfPixels/256;
    h=hist(Iin,256);
    ch=0;
    for i=0:255
        ch = ch+h(1,i+1);
        LUT(i+1) = max(0,round((256*ch)/numberOfPixels)-1);
    end
end

%% Get output pixel values from LUT

for i=1:numberOfPixels
    O = LUT(Iin(1,i)+1);
    Iout(1,i) = round(O);
end
end

