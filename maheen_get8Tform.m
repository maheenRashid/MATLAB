function [ imgCell ] = maheen_getTforms( img )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
imgCell=cell(1,7);
for i=1:4
    angle=i*90;
    imgCell{i}=imrotate(img,angle);
end

    imgCell{5}=flipud(img);
    imgCell{7}=fliplr(imgCell{5});
    imgCell{6}=fliplr(img);
%     imgCell{8}=flipud(imgCell{7});




end

