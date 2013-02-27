ccc
dirName='maheen_findOrientationSolid';
outputdirSpec=fullfile(dirName,'groundTruthNew');

result=zeros(6,8);
for compNo=1:8
load(fullfile(outputdirSpec,['comparison_' num2str(compNo) '_justRot.mat']),'accu','cellComparison','cellGT','cellPredict');
accu1=accu(:,accu(1,:)>0);
[~,ind]=max(accu1(1,:));
result(1:3,compNo)=accu1(:,ind(1));
result(4:6,compNo)=mean(accu1,2);
end
save(fullfile(outputdirSpec,'result.mat'),'result');



return
ccc
%load gt
%load predict

map=[1 6;2 7;3 8;4 5];

for compNo=1:8

dirName='maheen_findOrientationSolid';
dirNameCurr=fullfile(dirName,'groundTruthNew',num2str(compNo));
% [num2str(compNo) '_projDims_new_3d']);
outputdirSpec=fullfile(dirName,'groundTruthNew');

load(fullfile(outputdirSpec,['orientation_' num2str(compNo) '.mat']),'orientation','imNo','direc');
gtOrient=orientation;

gtCount=gtOrient>0;
gtCount=sum(gtCount,2);
tempIdx=find(gtCount==1);

accu=zeros(3,numel(tempIdx));
cellComparison=cell(1,numel(tempIdx));
cellGT=cellComparison;
cellPredict=cellGT;
for templateNo=tempIdx'
% templateNo=tempIdx(1)
% templateNo
load(fullfile(dirNameCurr,['predictedOrientation_' num2str(compNo) '_' num2str(templateNo) '_justRot.mat']),'orientation','cellCorr');

comparison=zeros(numel(orientation),1);

for imNo=1:numel(orientation)
if gtCount(imNo)==0 || orientation(imNo)== 0
    continue
end

rowGt=gtOrient(imNo,:);
for i=1:gtCount(imNo)
    currGt=gtOrient(imNo,i);
    if orientation(imNo)==currGt;
%     if sum(orientation(imNo)==map(currGt,:))~=0
        comparison(imNo)=1;
        break
    end
end
% pause
end
cellComparison{templateNo}=comparison;
cellGT{templateNo}=gtOrient;
cellPredict{templateNo}=orientation;
bin=gtCount==0;
bin(templateNo)=true;
comparison(bin)=[];
% comparison(templateNo)=[];

accu(1,templateNo)=sum(comparison)/numel(comparison)*100;
accu(2,templateNo)=sum(comparison);
accu(3,templateNo)=numel(comparison);

end
% return
save(fullfile(outputdirSpec,['comparison_' num2str(compNo) '_justRot.mat']),'accu','cellComparison','cellGT','cellPredict');

end