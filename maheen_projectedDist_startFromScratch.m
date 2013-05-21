function [ distX,distY ] =maheen_projectedDist_startFromScratch( bPts1,bPts2 )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    projX1=sort(bPts1(1,[1 3]));
    projX2=sort(bPts2(1,[1 3]));
    
    projY1=sort(bPts1(2,[1 3]));
    projY2=sort(bPts2(2,[1 3]));

    distY=zeros(2);
    for i=1:2
        for j=1:2
            distY(i,j)=projY1(i)-projY2(j);
        end
    end
    
    distX=zeros(2);
    for i=1:2
        for j=1:2
            distX(i,j)=projX1(i)-projX2(j);
        end
    end

end

