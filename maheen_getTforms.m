function [ imgCell ] = maheen_getTforms( img )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
imgCell=cell(1,8);
for j=[0,4]
    if j==0
        imgCurr=img;
    end
    if j==4
        imgCurr=img';
    end
    for i=1:4
        angle=i*90;
        imgCell{i+j}=imrotate(imgCurr,angle);
    end
end

%     imgCell{5}=flipud(img);
%     imgCell{7}=fliplr(imgCell{5});
%     imgCell{6}=fliplr(img);
%     imgCell{8}=flipud(imgCell{7});




end

