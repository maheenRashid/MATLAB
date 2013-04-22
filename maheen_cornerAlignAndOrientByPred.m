function [ newA ] = maheen_cornerAlignAndOrientByPred( A,predsCurr )
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
newA=A;
    for compInd=1:numel(A)
        compCurr=A{1,compInd};
        angle=predsCurr(compInd)*pi/2;
        rot90=[cos(angle) -sin(angle);sin(angle) cos(angle)];
        for i=1:2:numel(compCurr)
            currFace=compCurr{1,i};
            currFace=currFace';
            currFace(1:2,:)=rot90*currFace(1:2,:);
            compCurr{1,i}=currFace';
        end
        
        allCoord=compCurr(1:2:end);
        allCoord=reshape(allCoord,size(allCoord,2),1);
        minAll=min(cell2mat(allCoord));
        minAll=minAll(1,:);
        for j=1:2:size(compCurr,2)
            tempFace=compCurr{j};
            tempFace=tempFace-repmat(minAll,size(tempFace,1),1);
            compCurr{j}=tempFace;
        end
        
        
        newA{1,compInd}=compCurr;
    end

end

