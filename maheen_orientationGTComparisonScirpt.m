ccc

for compNo=1:8

dirName='maheen_findOrientationSolid';
dirNameCurr=fullfile(dirName,[num2str(compNo) '_projDims_new_3d']);
outputdirSpec=fullfile(dirName,'groundTruthNew');

load(fullfile(outputdirSpec,['orientation_' num2str(compNo) '_withMoreTemp.mat']),'orientation','direc','orientationSingleVec','map');
gtOrient=orientation;
gtOrientVec=orientationSingleVec;
gtCount=gtOrientVec>0;
templateIdx=find(gtCount==1);
% figure out template

for templateNo=templateIdx'
% templateNo=2;
load(fullfile(dirNameCurr,direc(templateNo).name));

imCell1=imCellAll(gtOrientVec(templateNo),:);
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
save(fullfile(outputdirSpec,num2str(compNo),['predictedOrientation_' num2str(compNo) '_' num2str(templateNo) '_justRot_withMoreTemp.mat']),'orientation','cellCorr');

end
end
return
ccc
for compNo=1:8

dirName='maheen_findOrientationSolid';
dirNameCurr=fullfile(dirName,[num2str(compNo) '_projDims_new_3d']);
outputdirSpec=fullfile(dirName,'groundTruthNew');

load(fullfile(outputdirSpec,['orientation_' num2str(compNo) '.mat']),'orientation','imNo','direc');
symBin=orientation>0;
symBin=sum(symBin,2);
symBin=find(symBin>1);
orientationSingleVec=orientation(:,1);
map=1:numel(orientationSingleVec);
map=map';
for i=1:numel(symBin)
    currOrient=orientation(symBin(i),:);
    for j=2:numel(currOrient)
        if currOrient(j)==0
            break
        end
        orientationSingleVec=[orientationSingleVec;currOrient(j)];
        map=[map;symBin(i)];
        direc=[direc;direc(symBin(i))];
    end
end
save(fullfile(outputdirSpec,['orientation_' num2str(compNo) '_withMoreTemp.mat']),'orientation','direc','orientationSingleVec','map');

end

return
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

for templateNo=templateIdx'
% templateNo=2;
load(fullfile(dirNameCurr,direc(templateNo).name));

imCell1=imCellAll(gtOrient(templateNo,1),:);
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
save(fullfile(outputdirSpec,num2str(compNo),['predictedOrientation_' num2str(compNo) '_' num2str(templateNo) '_justRot_withMoreTemp.mat']),'orientation','cellCorr');

end
end