ccc
for compNo=1:16
load(['maheen_nonmergedComp\matA_rot_' num2str(compNo)],'A');
sizes=zeros(1,size(A,2));

for numCat=1:numel(sizes)
    sizes(1,numCat)=size(A{1,numCat},2);
end

[uniqueSizes,ind,indSizes]=unique(sizes);
newA=cell(1,0);
for i=1:numel(ind)
     bin=uniqueSizes(i)==sizes;
     currCats=A(:,bin);
     newA=[newA currCats(1,1)];
end
A=newA;
save(['maheen_nonmergedComp\matA_rot_duplicatesRemoved_' num2str(compNo)],'A');
end