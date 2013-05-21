function [ face1 ] = maheen_getFacingBin( pos,pred1 )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
if pred1==1
    posRel=pos(2);
    posNonRel=pos(1);
elseif pred1==2
    posRel=pos(1);
    posNonRel=pos(2);
elseif pred1==3
    posRel=-1*pos(2);
    posNonRel=pos(1);
elseif pred1==4
    posRel=-1*pos(1);
    posNonRel=pos(2);
end

if posRel>1
    face1=1;
elseif posRel<-1
    face1=-1;
elseif posRel>0 && posNonRel==0
    face1=1;
elseif posRel<0 && posNonRel==0
    face1=-1;
else
    face1=0;
end

end

