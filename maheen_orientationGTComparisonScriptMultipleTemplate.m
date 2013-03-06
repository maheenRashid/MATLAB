ccc
cellAccuracy=cell(1,8);
for compNo=1:8
dirName='maheen_findOrientationSolid';
outputdirSpec=fullfile(dirName,'groundTruthNew');
load(fullfile(outputdirSpec,['informationCompiled_problemGTRemoved_' num2str(compNo) '.mat']),...
        'direc','gtOrient','allCorrNoSumCell','allCorrRotCell','allCorrRotRefCell','cellPredict','gtCount');

binEmpty=cellfun('isempty',cellPredict);
allCorrRotCell(binEmpty,:)=[];
cellPredict(binEmpty)=[];
direcTemplate=direc;
direcTemplate(binEmpty)=[];
for i=1:size(cellPredict)
    cellPredict{i}=cellPredict{i}';
end
cellPredictMat=cell2mat(cellPredict);
cellPredictMat(:,sum(cellPredictMat)==0)=[];

strCell={'multiMode','multiMax','multiMaxOfMedian'};
accuMat=zeros(3,numel(strCell));
for strNo=1:3
    predict=maheen_getPrediction(allCorrRotCell,strCell{strNo});
    predict=predict';
    predictRep=repmat(predict,1,size(gtOrient,2));
    accu=sum(predictRep==gtOrient,2);
    percent=sum(accu)/numel(accu)*100;
   accuMat(1,strNo)=percent;
   accuMat(2,strNo)=sum(accu);
   accuMat(3,strNo)=numel(accu);
end
cellAccuracy{compNo}=accuMat;
end
save(fullfile(outputdirSpec,['accuracyOtherTypes_' num2str(compNo) '.mat']))
return

ccc

for compNo=1:8
    
    dirName='maheen_findOrientationSolid';
    dirNameCurr=fullfile(dirName,[num2str(compNo) '_projDims_new_3d']);
    outputdirSpec=fullfile(dirName,'groundTruthNew');
    
    load(fullfile(outputdirSpec,['orientation_' num2str(compNo) '.mat']),'orientation','direc');
    load(fullfile(outputdirSpec,['comparison_' num2str(compNo) '_justRot.mat']),'accu','cellComparison','cellGT','cellPredict');
    gtOrient=orientation;
    
    gtCount=gtOrient>0;
    gtCount=sum(gtCount,2);
    templateIdx=find(gtCount==1);
    allCorrRotCell=cell(numel(direc));
    allCorrRotRefCell=cell(numel(direc));
    allCorrNoSumCell=cell(numel(direc));
    for templateNo=templateIdx'
        load(fullfile(outputdirSpec,num2str(compNo),['predictedOrientation_' num2str(compNo) '_' num2str(templateNo) '_justRot.mat']),'orientation','cellCorr');
        for testNo=1:numel(direc)
            corrCurr=cellCorr{testNo};
            if isempty(corrCurr)
                continue;
%                 corrCurr=zeros(5,8);
            end
            sumCorr=sum(corrCurr(~isnan(corrCurr(:,1)),:));
            corrRot=sumCorr(1:4);
            allCorrRotRefCell{templateNo,testNo}=sumCorr;
            allCorrRotCell{templateNo,testNo}=corrRot;
            allCorrNoSumCell{templateNo,testNo}=corrCurr;
        end
%         return
    end
    
    direc=direc(gtCount>0);
    gtOrient=gtOrient(gtCount>0,:);
    allCorrRotRefCell(gtCount==0,:)=[];
    allCorrRotRefCell(:,gtCount==0)=[];
    allCorrRotCell(gtCount==0,:)=[];
    allCorrNoSumCell(gtCount==0,:)=[];
    allCorrRotCell(:,gtCount==0)=[];
    allCorrNoSumCell(:,gtCount==0)=[];
    cellPredict=cellPredict(gtCount>0);
    cellPredict=cellPredict';
    gtCount=gtCount(gtCount>0);
    
    save(fullfile(outputdirSpec,['informationCompiled_problemGTRemoved_' num2str(compNo) '.mat']),...
        'direc','gtOrient','allCorrNoSumCell','allCorrRotCell','allCorrRotRefCell','cellPredict','gtCount');
    
end