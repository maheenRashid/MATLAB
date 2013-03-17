ccc
for compNo=7:16
    dirName='maheen_findOrientationSolid';
    inputdirSpec=fullfile(dirName,'groundTruthMoreTemplate');
    dirNameCurr=fullfile(dirName,[num2str(compNo) '_projDims_new_3d']);
    outputdirSpec=fullfile(dirName,'minDistWallMethod');
    dirForMergeA=['maheen_mergedComp/' num2str(compNo)];
    dirForA='D:\ResearchCMU\lustre\jasonli1\results_ALL';
%     load(fullfile(inputdirSpec,['templatesAndGT_' num2str(compNo) '.mat']),'gtOrient','direc','gtOrientVec','map');
    forAccu=0;
    
    
    if forAccu==1
    nameCell=cell(numel(direc),1);
    for i=1:numel(direc)
        nameCell{i}=direc(i).name;
    end
    [uniqueNameCell,ind1,ind2]=unique(nameCell);
    direcTest=direc(ind1);
    nameOutputMat='predictionClosestWallForAccu_';
    else
        direcTest=dir(dirNameCurr);
        direcTest=direcTest(3:end);
        nameOutputMat='predictionClosestWallAll_';
    end
    
    
    
    
    numberTest=numel(direcTest);
    
    predAllCell=cell(numberTest,1);
    minDistAllCell=predAllCell;
    minEdgeBoxAllCell=predAllCell;
    minEdgeWallCell=predAllCell;
    bLinesCell=predAllCell;
    wLinesCell=predAllCell;
    predAllSmallest=zeros(numberTest,1);
    predAllShort=zeros(numberTest,1);
    predAllLong=zeros(numberTest,1);
    cornerAll=zeros(numberTest,1);
    
    for testNo=1:numberTest
        
        load(fullfile(dirForMergeA,direcTest(testNo).name),'mergedA');
        nameOfFile=regexp(direcTest(testNo).name,'_','split');
        nameOfFile=nameOfFile{1};
        load(fullfile(dirForA,[nameOfFile '.mat']),'A');
        
        [pred,minDistances,minEdgeBox,minEdgeWall,shorter,bLines,wLines]=maheen_getPredWallDist(A,mergedA,0);
        [predUnique,indDist]=unique(pred,'stable');
        corner=0;
        if numel(predUnique)>1
        if mod(predUnique(1),2)~=mod(predUnique(2),2)
            d1=minDistances(indDist(1));
            d2=minDistances(indDist(2));
            if abs(d1-d2)<5
                corner=1;
            end
        end
        end
        prediction=pred(1);
        predictionShort=prediction;
        predictionLong=prediction;
        
        if corner==1 && ~shorter(1)
            predictionShort=predUnique(2);
        end
        
        if corner==1 && shorter(1)
            predictionLong=predUnique(2);
        end
        
        predAllCell{testNo}=pred;
        minDistAllCell{testNo}=minDistances;
        minEdgeBoxAllCell{testNo}=minEdgeBox;
        minEdgeWallCell{testNo}=minEdgeWall;
        bLinesCell{testNo}=bLines;
        wLinesCell{testNo}=wLines;
        predAllSmallest(testNo)=prediction;
        predAllShort(testNo)=predictionShort;
        predAllLong(testNo)=predictionLong;
        cornerAll(testNo)=corner;
        if mod(testNo,10)==0
            disp(num2str(testNo))
        end
    end
%     return
    save(fullfile(outputdirSpec,[nameOutputMat num2str(compNo) '.mat']));
    disp(['done with ' num2str(compNo) '!'])
end