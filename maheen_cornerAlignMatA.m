ccc
% compNo=1;
for compNo=1:16
load(['maheen_mergedComp\matA_rot_duplicatesRemoved_' num2str(compNo)]);
newA=cell(size(A));
for i=1:length(A)
    temp=A{i};
    allCoord=temp(1:2:end);
    allCoord=reshape(allCoord,size(allCoord,2),1);
    minAll=min(cell2mat(allCoord));
    minAll=minAll(1,:);
    for j=1:2:size(temp,2)
        tempFace=temp{j};
        tempFace=tempFace-repmat(minAll,size(tempFace,1),1);
        temp{j}=tempFace;
    end
    newA{i}=temp;
end
A=newA;
save(['maheen_nonmergedComp\matA_rot_duplicatesRemoved_cornerAligned_' num2str(compNo)],'A');
end