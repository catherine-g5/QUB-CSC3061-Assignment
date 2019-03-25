function [Iout] = enhanceContrast(Iin)
%ENHANCECONTRAST Enhances contrast of image using linear stretching
%Enable or disable contrast enhancement in convertImage.m
m = 255/(max(Iin)-min(Iin));
c = -m * min(Iin);
LUT=[];

for i=0:255
    if i<(-c/m)
        LUT(i+1)=0;
    elseif i>((255-c)/m)
        LUT(i+1)=255;
    else
        LUT(i+1) = (m*i)+c;
    end
end

for i=1:size(Iin,2)
    O = LUT(Iin(1,i)+1);
    Iout(1,i) = round(O);
end
end

