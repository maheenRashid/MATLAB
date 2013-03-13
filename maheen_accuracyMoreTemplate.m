%getting accuracy for mindistwallmethod
ccc
gtPerImCell=cell(1,8);
accuCellAll=cell(1,8);
percentageCellAll=cell(1,8);
for compNo=1:8
    dirName='maheen_findOrientationSolid';
    outputdirSpec=fullfile(dirName,'minDistWallMethod');
    
    load(fullfile(outputdirSpec,['predictionClosestWallForAccu_' num2str(compNo) '.mat']),'direcTest','gtOrientVec','nameCell','predAllSmallest','predAllShort','predAllLong');
    %create a mapping
    gtPerIm=-1*zeros(4,numel(direcTest));
    
%     binEmpty=cellfun('isempty',allCorrRotCell);
    
    for imNo=1:numel(direcTest)
        currCol=strcmp(direcTest(imNo).name,nameCell);
        
        currCol=find(currCol);
        for idx=1:numel(currCol)
            gtPerIm(idx,imNo)=gtOrientVec(currCol(idx));
        end
    end
    
%     gtPerIm=gtPerIm(:,1:numel(predAllSmallest));
%     
    predictions={predAllSmallest',predAllShort',predAllLong'};
    
    accuCell=cell(size(predictions));
    percentageCell=cell(size(predictions));
    for predNo=1:numel(predictions)
        predCurr=predictions{predNo};
        %         binTry=predCurr==0;
        accuBin=zeros(size(predCurr));
        percentageCurr=zeros(size(predCurr,1),1);
        for rowNo=1:size(predCurr,1)
            binTry=predCurr(rowNo,:)==0;
            accuCurr=gtPerIm==repmat(predCurr(rowNo,:),4,1);
            accuCurr=sum(accuCurr);
            accuCurr(binTry)=-1;
            accuBin(rowNo,:)=accuCurr;
            right=sum(accuCurr>0);
            all=sum(accuCurr>-1);
            percentageCurr(rowNo)=right/all*100;
        end
        accuCell{predNo}=accuBin;
        percentageCell{predNo}=percentageCurr;
    end
    gtPerImCell{compNo}=gtPerIm;
    accuCellAll{compNo}=accuCell;
    percentCellAll{compNo}=percentageCell;
end
percentAllMat=zeros(compNo,3);
% cell2mat(percentCellAll{1}(2:end))
for i=1:compNo
    percentAllMat(i,:)=cell2mat(percentCellAll{i}(1:end));
end

save(fullfile(outputdirSpec,['resultForAccu_allComp.mat']));
return
%%
%getting accuracy for diff methods using more templates
ccc
gtPerImCell=cell(1,8);
accuCellAll=cell(1,8);
percentageCellAll=cell(1,8);
for compNo=1:8
    dirName='maheen_findOrientationSolid';
    outputdirSpec=fullfile(dirName,'groundTruthMoreTemplate');
    
    load(fullfile(outputdirSpec,['predictions_' num2str(compNo) '.mat']));
    %create a mapping
    gtPerIm=-1*zeros(4,numel(direcTest));
    binEmpty=cellfun('isempty',allCorrRotCell);
    
    for imNo=1:numel(direcTest)
        currCol=binEmpty(:,imNo);
        currCol=find(currCol);
        for idx=1:numel(currCol)
            gtPerIm(idx,imNo)=gtOrientVec(currCol(idx));
        end
    end
    
    
    predMode=[predictions{2};predictions{3};predictions{4}];
    predMode=mode(predMode);
    predictions=[predictions,predMode];
    %     return
    
    accuCell=cell(size(predictions));
    percentageCell=cell(size(predictions));
    for predNo=1:numel(predictions)
        predCurr=predictions{predNo};
        %         binTry=predCurr==0;
        accuBin=zeros(size(predCurr));
        percentageCurr=zeros(size(predCurr,1),1);
        for rowNo=1:size(predCurr,1)
            binTry=predCurr(rowNo,:)==0;
            accuCurr=gtPerIm==repmat(predCurr(rowNo,:),4,1);
            accuCurr=sum(accuCurr);
            accuCurr(binTry)=-1;
            accuBin(rowNo,:)=accuCurr;
            right=sum(accuCurr>0);
            all=sum(accuCurr>-1);
            percentageCurr(rowNo)=right/all*100;
        end
        accuCell{predNo}=accuBin;
        percentageCell{predNo}=percentageCurr;
    end
    gtPerImCell{compNo}=gtPerIm;
    accuCellAll{compNo}=accuCell;
    percentCellAll{compNo}=percentageCell;
end
percentAllMat=zeros(compNo,4);
% cell2mat(percentCellAll{1}(2:end))
for i=1:compNo
    percentAllMat(i,:)=cell2mat(percentCellAll{i}(2:end));
end

save(fullfile(outputdirSpec,['resultMultiTemplate_allComp.mat']));
return
%%
ccc
for compNo=1:8
    dirName='maheen_findOrientationSolid';
    outputdirSpec=fullfile(dirName,'groundTruthMoreTemplate');
    load(fullfile(outputdirSpec,['corrCells_' num2str(compNo) '.mat']));
    
    %first set temp=imNo to empty
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
    save(fullfile(outputdirSpec,['predictions_' num2str(compNo) '.mat']));
    
end