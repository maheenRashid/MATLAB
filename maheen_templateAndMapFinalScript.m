%%this part makes the corrCells
ccc

forAccu=0;
gtModelCase=1;
for compNo=1:8
    dirName='maheen_findOrientationSolid';
    inputdirSpec=fullfile(dirName,'groundTruthMoreTemplate');
    outputdirSpec=inputdirSpec;
    if gtModelCase
        outputdirParent='maheen_dataForGTModels';
        outputdirSpec=fullfile(outputdirParent,'corrCellsAll_problemFinal');
    end
    resume=0;
    if resume~=1
        dirNameCurr=fullfile(dirName,[num2str(compNo) '_projDims_new_3d']);
        dirTest=dirNameCurr;
        load(fullfile(inputdirSpec,['templatesAndGT_' num2str(compNo) '.mat']),'gtOrient','direc','gtOrientVec','map');
        
        if gtModelCase
            dirTest=fullfile(outputdirParent,'heightMapsAnd3dVox_problemFinal',num2str(compNo));
        end
        if forAccu==1
            nameCell=cell(numel(direc),1);
            for i=1:numel(direc)
                nameCell{i}=direc(i).name;
            end
            [uniqueNameCell,ind1,ind2]=unique(nameCell);
            direcTest=direc(ind1);
            nameOutputMat='corrCells_';
        else
            direcTest=dir(dirTest);
            direcTest=direcTest(3:end);
            nameOutputMat='corrCellsAll_';
        end
        allCorrRotCell=cell(numel(direc),numel(direcTest));
        allCorrNoSumCell=cell(numel(direc),numel(direcTest));
        allCorrRotRefCell=cell(numel(direc),numel(direcTest));
    else
        load(fullfile(outputdirSpec,[nameOutputMat num2str(compNo) '.mat']));
    end
    
    for tempNo=1:numel(direc)
        load(fullfile(dirNameCurr,direc(tempNo).name));
        imCellTemp=imCellAll(gtOrientVec(tempNo,1),:);
        %     h=maheen_subPlotIm(imCell1);
        for testNo=1:numel(direcTest)
            load(fullfile(dirTest,direcTest(testNo).name));
            imCellTest=imCellAll;
            [corrs,allCorrs]=maheen_getObjCorr(imCellTemp,imCellTest);
            allCorrRotCell{tempNo,testNo}=corrs(1:4);
            allCorrNoSumCell{tempNo,testNo}=allCorrs;
            allCorrRotRefCell{tempNo,testNo}=corrs;
            %             if mod(testNo,10)==0
            %                 save(fullfile(outputdirSpec,[nameOutputMat num2str(compNo) '.mat']));
            %             end
        end
        %         save(fullfile(outputdirSpec,[nameOutputMat num2str(compNo) '.mat']));
    end
    save(fullfile(outputdirSpec,[nameOutputMat num2str(compNo) '.mat']));
    disp(['done with ' num2str(compNo) '!'])
end
return
%%
%%this part gets rid of templates that have no ground truth, and splits up
%%multiple orientations to be separate templates.
for compNo=1:8
    
    dirName='maheen_findOrientationSolid';
    dirNameCurr=fullfile(dirName,[num2str(compNo) '_projDims_new_3d']);
    inputdirSpec=fullfile(dirName,'groundTruthNew');
    outputdirSpec=fullfile(dirName,'groundTruthMoreTemplate');
    
    load(fullfile(inputdirSpec,['orientation_' num2str(compNo) '_withMoreTemp.mat']),'orientation','direc','orientationSingleVec','map');
    
    
    binValidTemp=orientationSingleVec>0;
    gtOrient=orientation;
    gtOrientVec=orientationSingleVec(binValidTemp);
    direc=direc(binValidTemp);
    map=map(binValidTemp);
    
    
    save(fullfile(outputdirSpec,['templatesAndGT_' num2str(compNo) '.mat']),'gtOrient','direc','gtOrientVec','map');
end
