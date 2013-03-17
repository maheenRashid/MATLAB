ccc
dirName='maheen_findOrientationSolid';
outputDir='maheen_statsUsingOrientation';
nameCellAll=cell(2,16);
for compNo=1:16
    dirNameCurr=fullfile(dirName,[num2str(compNo) '_projDims_new_3d']);
    direc=dir(dirNameCurr);
    direc=direc(3:end);
    nameCellTrim=cell(1,numel(direc));
    nameCell=cell(1,numel(direc));
    for nameNo=1:numel(direc)
        nameCurr=direc(nameNo).name;
        nameCell{nameNo}=nameCurr;
        k=regexp(nameCurr,'_','split');
        nameCellTrim{nameNo}=k{1};
    end
    nameCellAll{1,compNo}=nameCellTrim;
    nameCellAll{2,compNo}=nameCell;
end

binMatchAll=cell(16);
idxMatchAll=cell(16);
for compNo1=1:16
    for compNo2=compNo1:16
        name1=nameCellAll{1,compNo1};
        binMatch=zeros(size(name1));
        idxMatch=cell(size(name1));
        for i=1:numel(name1)
            name2=nameCellAll{1,compNo2};
            if compNo1==compNo2
                name2{i}=[];
            end
            indMatch=find(strcmp(name1(i),name2));
            if ~isempty(indMatch)
                binMatch(i)=1;
                idxMatch{i}=indMatch;
            end
        end
        binMatchAll{compNo1,compNo2}=binMatch;
        idxMatchAll{compNo1,compNo2}=idxMatch;
    end
end

dirNameMerge={'maheen_mergedComp'};
save(fullfile(outputDir,'nameCells.mat'),'nameCellAll','binMatchAll','idxMatchAll','dirNameMerge');