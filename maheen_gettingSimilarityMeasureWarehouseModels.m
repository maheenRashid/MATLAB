
ccc



writeOutTo='maheen_similarityBetweenComp';
% typeSkp='warehouse';
typeSkp='annotated';

for compNo=1:16

    
load(fullfile(writeOutTo,typeSkp,['simHBl_' typeSkp '_' num2str(compNo) '.mat']),'simMat','dimsAll_temp',...
    'dimsAll','direcSuperA_temp','direcSuperA'...
    ,'predsCurr','predsCurr_temp');


numberCom=5;
for i=1:size(simMat,2)
    [~,idxSort]=sort(simMat(:,i));
    fileName=direcSuperA(i).name;
    
    if strcmp(typeSkp,'warehouse')
    load(fullfile('maheen_findOrientationSolid',[num2str(compNo) '_projDims_new_3d'],fileName),'imCellAllBig');
    else
    load(fullfile('maheen_dataForGTModels_cleanedUp','heightMapsAnd3dVox',num2str(compNo),fileName),'imCellAllBig');
    end
    imCellPred=imCellAllBig(predsCurr(i),:);
    maheen_subPlotIm(imCellPred);
    dimsAll(i,:)
        
    for j=1:numberCom
        fileName=direcSuperA_temp(idxSort(j)).name
        load(fullfile('maheen_findOrientationSolid',[num2str(compNo) '_projDims_new_3d'],fileName),'imCellAllBig');
        imCellPred=imCellAllBig(predsCurr_temp(idxSort(j)),:);
        maheen_subPlotIm(imCellPred);
        simMat(idxSort(j),i)
        dimsAll_temp(idxSort(j),:)
    end
    pause;
    close all;clc;
end

end



return

%%
ccc

outputDir='maheen_rewritingSkpsWithOrient_4_21';

writeOutTo='maheen_similarityBetweenComp';
% typeSkp='warehouse';
typeSkp='annotated';
for compNo=1:16
    compNo
        load(fullfile(outputDir,['matADuplicatesRemovedCornerAlignedOriented_' num2str(compNo)]),'A','direcSuperA','predsCurr');
A_temp=A;
direcSuperA_temp=direcSuperA;
predsCurr_temp=predsCurr;

load(fullfile(writeOutTo,typeSkp,['matAWithDuplicatesCornerAlignedAndOriented' num2str(compNo) '.mat']),'A','direcSuperA','predsCurr');

simMat=zeros(numel(A_temp),numel(A));
dimsAll=zeros(numel(A),3);
dimsAll_temp=zeros(numel(A_temp),3);
for i=1:size(simMat,1)
    i
    dims1=maheen_getDimOfComp(A_temp{i});
    dimsAll_temp(i,:)=dims1;
    for j=1:size(simMat,2)
        dims2=maheen_getDimOfComp(A{j});
        dimsAll(j,:)=dims2;
        simMat(i,j)=norm(dims2-dims1);
    end
end
save(fullfile(writeOutTo,typeSkp,['simHBl_' typeSkp '_' num2str(compNo) '.mat']),'simMat','dimsAll_temp','dimsAll','direcSuperA_temp','direcSuperA','predsCurr','predsCurr_temp');

end





