ccc
outputDir='maheen_rewritingSkpsWithOrient';
load(fullfile(outputDir,'predAndFileNamesCompiled.mat'),'namesAndOrientAll');
nameTextFile=fullfile(outputDir,'perModelOrientFiles');

for fileNo=1:size(namesAndOrientAll,1)
    orientVec=namesAndOrientAll{fileNo,2};
    if isempty(orientVec)
        continue
    end
    
    f=fopen(fullfile(nameTextFile,[ namesAndOrientAll{fileNo,1} '.txt']),'w');
    for compsIndex=1:length(orientVec)
        fprintf(f,'%d\n',orientVec(compsIndex));
    end
    fclose(f);
end

return
%%
ccc

predAndDirCell=cell(2,16);
for compNo=8:16
    inputDirPred=fullfile('maheen_findOrientationSolid','minDistWallMethod');
    load(fullfile(inputDirPred,['predictionClosestWallAll_' num2str(compNo) '.mat']),'direcTest','predAllLong');
    nameDirecTest=cell(1,numel(direcTest));
    for j=1:numel(direcTest)
        nameDirecTest{j}=direcTest(j).name;
    end
    predAndDirCell{1,compNo}=predAllLong';
    predAndDirCell{2,compNo}=nameDirecTest;
end
for compNo=1:7
    inputDirPred=fullfile('maheen_findOrientationSolid','groundTruthMoreTemplate');
    load(fullfile(inputDirPred,['predictionsAll_tempEqualImRemoved_' num2str(compNo) '.mat']),'direcTest','predMat');
    nameDirecTest=cell(1,numel(direcTest));
    for j=1:numel(direcTest)
        nameDirecTest{j}=direcTest(j).name;
    end
    predAndDirCell{1,compNo}=predMat(4,:);
    predAndDirCell{2,compNo}=nameDirecTest;
end



skpMatFilesDir='D:\ResearchCMU\lustre\Image-Modeling\OSMesa-Renderer\skp_groupings\';
d_results = dir(skpMatFilesDir);
names=cell(length(d_results)-2,1);
for fileIndex = 3:(length(d_results))
    temp=regexp(d_results(fileIndex).name,'\.','split');
    names{fileIndex-2}=temp{1};
end

orientVecAll=cell(size(names));
for indNames=1:numel(names)
name=names{indNames};
fname=(['D:\ResearchCMU\lustre\Image-Modeling\OSMesa-Renderer\skp_groupings\' name '.txt']);
skpGroup=maheen_getMatFromFile(fname);
fname=(['maheen_newLabels\' name '.txt']);
skpCat=maheen_getMatFromFile(fname);
if numel(skpGroup)~=numel(skpCat)
    continue
end
% load(['../../results_All/' name '.mat']);
    
mergeLabels=maheen_labelGroups(skpCat,skpGroup);
orientVec=zeros(size(skpCat));
for indMerge=1:size(mergeLabels,2)
    nameOfFile=[name '_' num2str(indMerge) '.mat'];
    if mergeLabels{1,indMerge}>16
        continue
    end
    direcCurr=predAndDirCell{2,mergeLabels{1,indMerge}};
    predCurr=predAndDirCell{1,mergeLabels{1,indMerge}};
    bin=strcmp(nameOfFile,direcCurr);
    if sum(bin)~=1
        disp('error')
        name
        indNames
        indMerge
        break
    end
    predOfComp=predCurr(bin);
    orientVec(mergeLabels{2,indMerge})=predOfComp;
    
end

orientVecAll{indNames}=orientVec;
end

namesAndOrientAll=cell(size(names,1),2);
namesAndOrientAll(:,1)=names(:);
namesAndOrientAll(:,2)=orientVecAll(:);

outputDir='maheen_rewritingSkpsWithOrient';
save(fullfile(outputDir,'predAndFileNamesCompiled.mat'),'namesAndOrientAll','predAndDirCell');