ccc

for compNo=1:8

dirName='maheen_findOrientationSolid';
dirNameCurr=fullfile(dirName,[num2str(compNo) '_projDims_new_3d']);
outputdirSpec=fullfile(dirName,'groundTruthNew');

load(fullfile(outputdirSpec,['orientation_' num2str(compNo) '.mat']),'orientation','imNo','direc');
gtOrient=orientation;

gtCount=gtOrient>0;
gtCount=sum(gtCount,2);
templateIdx=find(gtCount==1);
% figure out template
% templateIdx=templateIdx(1:5);
for templateNo=templateIdx'
% templateNo=2;
load(fullfile(dirNameCurr,direc(templateNo).name));

imCell1=imCellAll(gtOrient(templateNo),:);
% h=maheen_subPlotIm(imCell1);

orientation=zeros(numel(direc),1);

cellCorr=cell(1,numel(direc));
for j=1:numel(direc)
    if j==templateNo 
        continue
    end
    if gtCount(j)==0
        continue
    end
load(fullfile(dirNameCurr,direc(j).name));


imCellResult=imCellAll;

[corrs,allCorrs]=maheen_getObjCorr(imCell1,imCellResult);
[~,maxInd]=max(corrs(1:4));
% gtOrient(j,:)
% maxInd
% h1=maheen_subPlotIm(imCellResult(4,:));
% h2=maheen_subPlotIm(imCellResult(maxInd,:));

orientation(j)=maxInd;
cellCorr{j}=allCorrs;
% return
end
save(fullfile(outputdirSpec,num2str(compNo),['predictedOrientation_' num2str(compNo) '_' num2str(templateNo) '_justRot.mat']),'orientation','cellCorr');

end
end