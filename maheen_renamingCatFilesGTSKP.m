ccc

outputDirParent='maheen_dataForGTModels';
% dirSkp=('maheen_dataForGTModels/skp_problemNew');
dirCat=(fullfile(outputDirParent,'skp_category_new_GT'));
dirCatOut=(fullfile(outputDirParent,'skp_category_new_GT_rename'))
mkdir(dirCatOut);
dirGroup=(fullfile(outputDirParent,'skp_groupings'))



dirGroups=dir(dirGroup);
dirGroups=dirGroups(3:end);
nameGroups=cell(numel(dirGroups),1);
nameGroupsSplitCell=cell(numel(dirGroups),3);
for i=1:numel(nameGroups)
    nameGroups{i}=dirGroups(i).name;
    nameGroupsSplitCell(i,:)=regexp(dirGroups(i).name,'#','split');
end

dirCats=dir(dirCat);
dirCats=dirCats(3:end);

for fileNo=1:numel(dirCats)
   
    
    idx=find(strcmp(dirCats(fileNo).name,nameGroupsSplitCell(:,3)));
    
%     dirCats(fileNo).name
%     nameGroups{idx}
    fileIn=fullfile(dirCat,dirCats(fileNo).name);
    fileOut=fullfile(dirCatOut,nameGroups{idx});
    copyfile(fileIn,fileOut);
    
end



% for i=1:numel(paths)
%     fileIn=fullfile(paths{i}, 'skp.txt');
%     fileOut=fullfile(dirSkp,[dirParent(i).name '.txt']);
%     copyfile(fileIn,fileOut);
%     fileIn=fullfile(paths{i}, 'cat.txt');
%     fileOut=fullfile(dirCat,[dirParent(i).name '.txt']);
%     copyfile(fileIn,fileOut);
% end
% 
