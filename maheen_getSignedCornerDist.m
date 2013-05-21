function [distX,distY] = maheen_getSignedCornerDist( pos,distCell)
% ,face,pred )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%posMat=[posX1,posY1,posX2,posY2];
posX1=pos(1);
posY1=pos(2);
posX2=pos(3);
posY2=pos(4);

% distsX=distCell{1};
% distsY=distCell{2};

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
    if abs(posX1)==2
        dist=-dists(2,1);
    else
        dist=[-dists(2,1) -dists(2,2)];
    end
elseif posX1==posX2
    if dists(1,1)<=0
    dist=[-abs(dists(1,1)),-abs(dists(2,2)) 0];
    else
    dist=[abs(dists(1,1)),abs(dists(2,2)) 0];
    end
else
    if abs(posX1)==2
        dist=dists(1,2);
    else
        dist=[dists(1,2) dists(1,1)];
    end
end


end



% if posX1<0
%     if posY1<0
%         distX=[-distsX(2,1)];
%         distY=[];
%     elseif posY1==0
%         distX=[];
%         distY=[];
%     else
%         distX=[];
%         distY=[];
%     end
% elseif posX1==0
%     if posY1<0
%         distX=[];
%         distY=[];
%     elseif posY1==0
%         distX=[];
%         distY=[];
%     else
%         distX=[];
%         distY=[];
%     end
% else
%     if posY1<0
%         distX=[];
%         distY=[];
%     elseif posY1==0
%         distX=[];
%         distY=[];
%     else
%         distX=[];
%         distY=[];
%     end
% end
