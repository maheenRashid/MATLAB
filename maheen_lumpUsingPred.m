function [lump,lumpSorted,midDistRel,midDistRelSorted,midFlag ] = maheen_lumpUsingPred( pred1,distX,distY,midDist,face )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

X=distX;
Y=distY;

midDistRel=midDist;
midFlag=[1,1];
if size(midDistRel,2)>1
    if pred1==1||pred1==3
        if abs(face)==1
            midDistRel=midDist(:,4);
            midFlag=[2,2];
        else
            midDistRel=midDist(:,1);
            midFlag=[1,1];
        end
    elseif pred1==2||pred1==4
        if abs(face)==1
            midDistRel=midDist(:,1);
            midFlag=[1,1];
        else
            midDistRel=midDist(:,4);
            midFlag=[2,2];
        end
    end
end


if pred1==1 || pred1==3
    if abs(face)==1
        steady=2;
    else
        steady=1;
    end
else
    if abs(face)==1
        steady=1;
    else
        steady=2;
    end
end


if numel(distX)==2
    if pred1==1 ||pred1==3
        X=distX(1:2);
    else
        X=distX(2);
        if numel(distY)==3
            X=distX(1);
        end
    end
elseif numel(distX)==3
    if pred1==1 || pred1==3
        X=distX(1:2);
    elseif pred1==2
        X=distX(2);
    else
        X=distX(1);
    end
end

if numel(distY)==2
    if pred1==1 ||pred1==3
        Y=distY(2);
        if numel(distX)==3
            Y=distY(1);
        end
    else
        Y=distY(1:2);
    end
elseif numel(distY)==3
    if pred1==2 || pred1==4
        Y=distY(1:2);
    elseif pred1==1
        Y=distY(2);
    else
        Y=distY(1);
    end
end

if numel(X)>1
    lump=[X;[Y,Y]];
elseif numel(Y)>1
    lump=[[X,X];Y];
else
    lump=[X;Y];
end

if steady==1
    lumpSorted=lump;
    midDistRelSorted=midDistRel;
else
    lumpSorted=lump([2,1],:);
    midDistRelSorted=midDistRel([2,1],:);
end


end

