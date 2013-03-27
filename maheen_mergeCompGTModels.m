ccc

outputDirParent='maheen_dataForGTModels';
dirSkp=fullfile(outputDirParent,'skp_problemNew');
dirGroup=fullfile(outputDirParent,'skp_groupings');
dirCat=fullfile(outputDirParent,'skp_category_new_problemNew');
dirCellA=fullfile(outputDirParent,'cellA_problemFinal_correctFormat');
dirMergedA=fullfile(outputDirParent,'mergedCompAll_problemFinal');

mkdir(dirMergedA);
for i=1:16
    mkdir(fullfile(dirMergedA,num2str(i)));
end


direcCat=dir(dirCat);
direcCat=direcCat(3:end);

mergeLabelsAll=cell(2,numel(direcCat));
for indNames=1:numel(direcCat)
    fname=fullfile(dirGroup,['b#bedroom#' direcCat(indNames).name]);
    if exist(fname,'file')~=2
        fname=fullfile(dirGroup,['l#living_room#' direcCat(indNames).name]);
    end
    skpGroup=maheen_getMatFromFile(fname);
    fname=fullfile(dirCat,direcCat(indNames).name);
    skpCat=maheen_getMatFromFile(fname);
    if numel(skpGroup)~=numel(skpCat)
        display('error skpGroup!=skpCat');
        continue
    end
    indNames
    name=regexp(direcCat(indNames).name,'\.','split');
    name=name{1};
    
    load(fullfile(dirCellA,[name '.mat']));
%     for count=1:numel(A)
%         A{count}=[A{count},{[]}];
%     end
%     A=[A,{[]}];
    
    mergeLabels=maheen_labelGroups(skpCat,skpGroup);
    
    for indMerge=1:size(mergeLabels,2)
        mergedA=maheen_mergeWithA(mergeLabels{2,indMerge},A);
        save(fullfile(dirMergedA, num2str(mergeLabels{1,indMerge}),[ name '_' num2str(indMerge) '.mat']),'mergedA');
    end
    mergeLabelsAll{1,indNames}=name;
    mergeLabelsAll{2,indNames}=mergeLabels;
    
end
save(fullfile(outputDirParent,'mergeLabelsAll_problemFinal.mat'),'mergeLabelsAll');


return
%%
%copies the result of theo scripts and renames. nothing special.

ccc

outputDirParent='maheen_dataForGTModels';
dirSkp=('maheen_dataForGTModels/skp_problemNew');
dirCat=('maheen_dataForGTModels/skp_category_new_problemNew');

% pathParent='D:\ResearchCMU\lustre\Image-Modeling\Sketchup\Theo\results\03212013_0721PM_16';
% pathParent='D:\ResearchCMU\lustre\Image-Modeling\Sketchup\Theo\results_new\03252013_0818PM_57';
pathParent='D:\ResearchCMU\lustre\Image-Modeling\Sketchup\Theo\results_check\03262013_0800PM_31';
dirParent=dir(pathParent);
dirParent=dirParent(3:end);
paths=cell(1,numel(dirParent));
for i=1:numel(dirParent)
    paths{i}=fullfile(pathParent,dirParent(i).name);
end

for i=1:numel(paths)
    fileIn=fullfile(paths{i}, 'skp.txt');
    fileOut=fullfile(dirSkp,[dirParent(i).name '.txt']);
    copyfile(fileIn,fileOut);
    fileIn=fullfile(paths{i}, 'cat.txt');
    fileOut=fullfile(dirCat,[dirParent(i).name '.txt']);
    copyfile(fileIn,fileOut);
end

return
