ccc
outputDir='maheen_dataForGTModels';
load(fullfile(outputDir,'predAndFileNamesCompiled_problemCases_Final.mat'));
nameTextFile=fullfile(outputDir,'perModelOrientFiles_problemCases_Final');
mkdir(nameTextFile);

dirGroups=dir(fullfile(outputDir,'skp_groupings'));
dirGroups=dirGroups(3:end);
nameGroups=cell(numel(dirGroups),1);
nameGroupsSplitCell=cell(numel(dirGroups),4);
for i=1:numel(nameGroups)
    nameGroups{i}=dirGroups(i).name;
    nameGroupsSplitCell(i,:)=regexp(dirGroups(i).name,'[#\.]','split');
end

for fileNo=1:size(namesAndOrientAll,1)
    orientVec=namesAndOrientAll{fileNo,2};
    if isempty(orientVec)
        display('what')
        namesAndOrientAll{fileNo,1}
    end
    
    idx=find(strcmp(namesAndOrientAll{fileNo,1},nameGroupsSplitCell(:,3)));
    
    f=fopen(fullfile(nameTextFile,[ nameGroups{idx}]),'w');
    for compsIndex=1:length(orientVec)
        fprintf(f,'%d\n',orientVec(compsIndex));
    end
    fclose(f);
end

return
%%
ccc
%%this part compiles the predictions for gtModels. since we've saved the
%%mergeLabels, we don't need to read in the cat and group files

predAndDirCell=cell(2,16);
for compNo=8:16
    inputDirPred=fullfile('maheen_dataForGTModels','minDistWallMethod_problemFinal');
    load(fullfile(inputDirPred,['predictionClosestWallAll_' num2str(compNo) '.mat']),'direcTest','predAllLong');
    nameDirecTest=cell(1,numel(direcTest));
    for j=1:numel(direcTest)
        nameDirecTest{j}=direcTest(j).name;
    end
    predAndDirCell{1,compNo}=predAllLong';
    predAndDirCell{2,compNo}=nameDirecTest;
end
for compNo=1:7
    inputDirPred=fullfile('maheen_dataForGTModels','corrCellsAll_problemFinal');
    load(fullfile(inputDirPred,['predictionsAll_tempEqualImRemoved_' num2str(compNo) '.mat']),'direcTest','predMat');
    nameDirecTest=cell(1,numel(direcTest));
    for j=1:numel(direcTest)
        nameDirecTest{j}=direcTest(j).name;
    end
    predAndDirCell{1,compNo}=predMat(4,:);
    predAndDirCell{2,compNo}=nameDirecTest;
end



load('D:\ResearchCMU\lustre\jasonli1\code\MATLAB\maheen_dataForGTModels\mergeLabelsAll_problemFinal.mat')
bin=cellfun(@isempty,mergeLabelsAll(1,:));
mergeLabelsAll(:,bin)=[];

names=mergeLabelsAll(1,:);
orientVecAll=cell(size(names));
errorLog=cell(1,0);
for indNames=1:numel(names)
    name=names{indNames};
    mergeLabels=mergeLabelsAll{2,indNames};
    if isempty(mergeLabels)
        fname=(['maheen_dataForGTModels\skp_category_new_problemNew\' name '.txt']);
        skpCat=maheen_getMatFromFile(fname);
        noComp=size(skpCat);
    else
        noComp=size(mergeLabels{2,1});
    end
    orientVec=zeros(noComp);
    
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
            mergeLabels{1,indMerge}
            errorLog=[errorLog, name];
            continue
        end
        predOfComp=predCurr(bin);
        orientVec(mergeLabels{2,indMerge})=predOfComp;
        
    end
    
    orientVecAll{indNames}=orientVec;
end

namesAndOrientAll=cell(size(names,2),2);
namesAndOrientAll(:,1)=names(:);
namesAndOrientAll(:,2)=orientVecAll(:);

outputDir='maheen_dataForGTModels';
save(fullfile(outputDir,'predAndFileNamesCompiled_problemCases_Final.mat'),'namesAndOrientAll','predAndDirCell','errorLog');