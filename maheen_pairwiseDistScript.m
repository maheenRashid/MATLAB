% ccc
% outputDir='maheen_statsUsingOrientation';
% load(fullfile(outputDir,'forTestingPairwise.mat'),'file1','file2','comp1','comp2');
% distCell=maheen_getPairwiseDistAllTypes( comp1,comp2,1 );
% return
% %%
ccc
outputDir='maheen_statsUsingOrientation';
load(fullfile(outputDir,'nameCells.mat'),'nameCellAll','binMatchAll','idxMatchAll','dirNameMerge');
compNo1=1;
compNo2=8;

distCellAll=cell(16);
for compNo1=1:16
    for compNo2=compNo1:16


nameSpec1=nameCellAll{2,compNo1};
nameSpec2=nameCellAll{2,compNo2};

binMatchCurr=binMatchAll{compNo1,compNo2};
idxMatchCurr=idxMatchAll{compNo1,compNo2};

hasMatchIdx=find(binMatchCurr);
distCell=cell(1,numel(hasMatchIdx));
for i=1:numel(hasMatchIdx)
%     distCell{end}=hasMatchIdx(i);
    matchesIdx=idxMatchCurr{hasMatchIdx(i)};
    distCellInner=cell(1,numel(matchesIdx)+1);
    distCellInner{end}= hasMatchIdx(i);
        
    for k=1:numel(matchesIdx)
        file1=nameSpec1{hasMatchIdx(i)};
        file2=nameSpec2{matchesIdx(k)};
        load(fullfile(dirNameMerge{1},num2str(compNo1),file1),'mergedA');
        comp1=mergedA;
        load(fullfile(dirNameMerge{1},num2str(compNo2),file2),'mergedA');
        comp2=mergedA;
        distBetweenCurr=maheen_getPairwiseDistAllTypes( comp1,comp2,0 );
        distCellInner{k}=[distBetweenCurr matchesIdx(k)];
    end
    distCell{i}=distCellInner;
end
    distCellAll{compNo1,compNo2}=distCell;
    end
end
save(fullfile(outputDir,'nameCellsAndDist.mat'),'nameCellAll','binMatchAll','idxMatchAll','dirNameMerge','distCellAll');
