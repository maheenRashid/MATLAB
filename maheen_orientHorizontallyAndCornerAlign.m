ccc
for compNo=1:16
% compNo=15;
load(['D:\ResearchCMU\lustre\jasonli1\code\MATLAB\maheen_mergedComp\matA_orientedLengthWays_' num2str(compNo) '.mat']);
newA=A;
for compInd=1:numel(A)
    compCurr=A{1,compInd};
    rot90=[0 -1;1 0];
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
A=newA;
save(['D:\ResearchCMU\lustre\jasonli1\code\MATLAB\maheen_mergedComp\matA_orientedWidthWays_cornerAligned_' num2str(compNo) '.mat'],'A');

end