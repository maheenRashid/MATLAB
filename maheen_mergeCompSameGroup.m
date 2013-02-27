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
    
mergeLabels=maheen_labelGroups(skpCat,skpGroup);
for indMerge=1:size(mergeLabels,2)
    mergedA=maheen_mergeWithA(mergeLabels{2,indMerge},A);
    return
    %     save(['maheen_mergedComp/' num2str(mergeLabels{1,indMerge}) '/' name '_' num2str(indMerge) '.mat']);
end


end