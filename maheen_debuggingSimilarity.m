ccc
writeToDir='maheen_rewritingSkpsWithOrient_4_21';
% mkdir(writeToDir);
% outputDir='maheen_rewritingSkpsWithOrient';
% for compNo=1:16
% load(fullfile(outputDir,['matAWithDuplicates_' num2str(compNo) '.mat']),'A','direcSuperA');
%     
%  
%  
%  sizes=cell(1,size(A,2));
%  for i=1:size(A,2)
%     sizes{i}=cell2mat(A{i}(2:2:end));
%  end
%     [uniqueSizes,ind,indSizes]=uniquecell(sizes);
%     A=A(:,ind);
%     direcSuperA=direcSuperA(ind);
compNo=1
% load(fullfile(writeToDir,['matADuplicatesRemoved_' num2str(compNo) '.mat']),'A','direcSuperA');
% end
%    return

check=1
% randperm(10,1);
 for i=1:3
 
%      numel(checkAll)
load(fullfile(writeToDir,['matADuplicatesRemovedCornerAlignedOriented_rot' num2str(i) '_' num2str(compNo)]),'A','direcSuperA','predsCurr');

 
%      check=checkAll(i);
 fileName=direcSuperA(check).name
 maheen_getDimOfComp( A{check} )
 comp=A{check};
 maheen_patchComp(comp);
 
        load(fullfile('maheen_findOrientationSolid',[num2str(compNo) '_projDims_new_3d'],fileName),'imCellAllBig');
        imCellPred=imCellAllBig(predsCurr(check),:);
        maheen_subPlotIm(imCellPred);
        pause;
 
 end
 