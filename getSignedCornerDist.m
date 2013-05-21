function [signedDist1,signedDist2] = getSignedCornerDist( pos,distCell )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%posMat=[posX1,posY1,posX2,posY2];
posX1=pos(1);
posY1=pos(2);
posX2=pos(3);
posY2=pos(4);
distX=getRelDistSigned(posX1,posX2,distCell{1});
distY=getRelDistSigned(posY1,posY2,distCell{2});




end

%gets the signed horizontal and vertical distances between the components'
%bounding box points and the unsigned distance between the corners of both
%boxes. the ordering for distX and distY is [(min,min) (min,max);(max,min)
%(max,max)]. the ordering for cornerPoints is similarly looped with both
%sets of corners arranged in clockwise order starting from minx,miny.
function dist=getRelDistSigned(posX1,posX2,dists)

    if posX1<posX2
        dist=-dist(2,1);
    elseif posX1==posX2
        dist=[abs(dist(1,1)),abs(dist(2,2))];
    else
        dist=
    end


end
