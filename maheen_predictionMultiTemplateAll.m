ccc
for compNo=1:8
    dirName='maheen_findOrientationSolid';
    outputdirSpec=fullfile(dirName,'groundTruthMoreTemplate');
    load(fullfile(outputdirSpec,['corrCellsAll_' num2str(compNo) '.mat']));
    
%     first set temp=imNo to empty
    nameTempCell=cell(numel(direc),1);
    for i=1:numel(direc)
        nameTempCell{i}=direc(i).name;
    end
    
    for imNo=1:numel(direcTest)
        binEqual=strcmp(direcTest(imNo).name,nameTempCell);
        inds=find(binEqual);
        for indCurr=inds'
            allCorrRotCell{indCurr,imNo}=[];
        end
    end
    
    strCell={'single','multiMode','multiMax','multiMaxOfMedian'};
    predictions=cell(1,numel(strCell));
    for strNo=1:numel(strCell)
        predictions{strNo}=maheen_getPrediction(allCorrRotCell,strCell{strNo});
    end
    
    
    predMat=[predictions{2};predictions{3};predictions{4}];
    modePredMat=mode(predMat);
    predMat=[predMat;modePredMat];
    numel(direcTest)
    size(predMat)
    save(fullfile(outputdirSpec,['predictionsAll_tempEqualImRemoved_' num2str(compNo) '.mat']));
    
end