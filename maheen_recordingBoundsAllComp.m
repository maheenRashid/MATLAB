ccc

outputDir='maheen_statsUsingOrientation';
load(fullfile(outputDir,'nameCellsAndDist.mat'),'nameCellAll','binMatchAll','idxMatchAll','dirNameMerge','distCellAll','boundCellAll');
boundCellAll=cell(1,size(nameCellAll,2));
for compNo=1:numel(boundCellAll)
    nameSpec=nameCellAll{2,compNo};
    boundCurrComp=cell(1,numel(nameSpec));
    for currComp=1:numel(boundCurrComp)
        file=nameSpec{currComp};
        load(fullfile(dirNameMerge{1},num2str(compNo),file),'mergedA');
        [ bPts,bLines ] = maheen_getBoundComp( mergedA );
        boundCurrComp{currComp}={bPts,bLines};
    end
    boundCellAll{compNo}=boundCurrComp;
end
save(fullfile(outputDir,'nameCellsAndDistAndBound.mat'),'nameCellAll','binMatchAll','idxMatchAll','dirNameMerge','distCellAll','boundCellAll');
