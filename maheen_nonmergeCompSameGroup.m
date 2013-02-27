ccc

skpMatFilesDir='D:\ResearchCMU\lustre\Image-Modeling\OSMesa-Renderer\skp_groupings\';
d_results = dir(skpMatFilesDir);
names=cell(length(d_results)-2,1);
for fileIndex = 3:(length(d_results))
    temp=regexp(d_results(fileIndex).name,'\.','split');
    names{fileIndex-2}=temp{1};
end

for indNames=1:numel(names)
name=names{indNames};
fname=(['D:\ResearchCMU\lustre\Image-Modeling\OSMesa-Renderer\skp_groupings\' name '.txt']);
skpGroup=maheen_getMatFromFile(fname);
fname=(['maheen_newLabels\' name '.txt']);
skpCat=maheen_getMatFromFile(fname);
if numel(skpGroup)~=numel(skpCat)
    continue
end
load(['../../results_All/' name '.mat']);
    
% mergeLabels=maheen_labelGroups(skpCat,skpGroup);
for indCat=1:numel(skpCat)
    catCurr=skpCat(indCat);
    if catCurr==0 || catCurr==17
        continue
    end
    mergedA=A{1,indCat}(1:end-1);
    roomBound=A{1,end};
    save(['maheen_nonmergedComp/' num2str(catCurr) '/' name '_' num2str(indCat) '.mat'],'mergedA','roomBound');
end
% 
% return
% for indMerge=1:size(mergeLabels,2)
%      mergedA=maheen_mergeWithA(mergeLabels{2,indMerge},A);
% %     save(['maheen_nonmergedComp/' num2str(mergeLabels{1,indMerge}) '/' name '_' num2str(indMerge) '.mat']);
% end


end