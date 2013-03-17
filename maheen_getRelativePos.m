function [ posX1,posY1,posX2,posY2 ] = maheen_getRelativePos( bPts1,bPts2 )
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
posX1=0;
    posY1=0;
    posX2=0;
    posY2=0;
    
    if bPts1(1,1)<bPts2(1,1)
        if bPts1(1,3)<bPts2(1,1)
            posX1=-2;
            posX2=2;
        elseif bPts2(1,3)<bPts1(1,3)
            posX1=0;
            posX2=0;
        else
            posX1=-1;
            posX2=1;
        end    
    else
        if bPts2(1,3)<bPts1(1,1)
            posX1=2;
            posX2=-2;
        elseif bPts1(1,3)<bPts2(1,3)
            posX1=0;
            posX2=0;
        else
            posX1=1;
            posX2=-1;
        end
    end
    
    
    if bPts1(2,1)<bPts2(2,1)
        if bPts1(2,3)<bPts2(2,1)
            posY1=-2;
            posY2=2;
        elseif bPts2(2,3)<bPts1(2,3)
            posY1=0;
            posY2=0;
        else
            posY1=-1;
            posY2=1;
        end
    else
        if bPts2(2,3)<bPts1(2,1)
            posY1=2;
            posY2=-2;
        elseif bPts1(2,3)<bPts2(2,3)
            posY1=0;
            posY2=0;
        else
            posY1=1;
            posY2=-1;
        end
    end

end

