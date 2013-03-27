ccc

outputDirParent='maheen_dataForGTModels';
dirGroup=fullfile(outputDirParent,'skp_groupings');
dirCat=fullfile(outputDirParent,'skp_category_new_GT');
dirOrient=fullfile(outputDirParent,'perModelOrientFiles_GT');

direcGroup=dir(dirGroup);
direcGroup=direcGroup(3:end);
namesGroups=cell(1,numel(direcGroup));
for i=1:numel(namesGroups)
    namesGroups{i}=direcGroup(i).name;
end

nameAllSplit=cell(numel(namesGroups),3);
for i=1:numel(namesGroups)
    nameCurr=namesGroups{i};
    nameCurr=regexp(nameCurr,'#','split');
    nameAllSplit(i,:)=nameCurr;
end

direcCat=dir(dirCat);
direcCat=direcCat(3:end);
namesCats=cell(1,numel(direcCat));
for i=1:numel(namesCats)
    namesCats{i}=direcCat(i).name;
end
errorLog=cell(1,0);
for i=1:numel(namesCats)
   idx=find(strcmp(namesCats{i},nameAllSplit(:,3)));
   fname=fullfile(dirGroup,namesGroups{idx});
   skpGroup=maheen_getMatFromFile(fname);
   fname=fullfile(dirCat,namesCats{i});
   skpCat=maheen_getMatFromFile(fname);
   fname=fullfile(dirOrient,namesGroups{idx});
   skpOrient=maheen_getMatFromFile(fname);
   check=[skpCat skpOrient skpGroup];
   size(check)
   if numel(skpGroup)~=numel(skpCat) || numel(skpGroup)~=numel(skpOrient)
        display('error skpGroup!=skpCat');
        errorLog=[errorLog namesCats{i}];
   end
end

% inds=find(bin(1,:)==bin(2,:));
% pathsModel= 'D:\ResearchCMU\lustre\Image-Modeling\Sketchup\Theo\models_to_export\';
% pathsModelAlt='D:\ResearchCMU\lustre\Image-Modeling\Sketchup\Theo\models_to_export_new\';
%     for i=1:numel(errorLog)
%         temp=regexp(errorLog{i},'\.','split');
%     temp=temp{1};
%     if exist([pathsModel temp '.skp'],'file')==2
%     system(['start ' pathsModel temp '.skp']);
%     elseif exist([pathsModelAlt temp '.skp'],'file')==2
%     system(['start ' pathsModelAlt temp '.skp']);
%     else
%         temp
%     end
%     
%     end



% fid=fopen('maheen_dataForGTModels\skpGroupNotEqualskpCat.txt','w');
% for i=1:numel(errorLog)
%     temp=regexp(errorLog{i},'\.','split');
%     temp=temp{1};
%     fprintf(fid,'%s\r\n',temp);
% end
% fclose(fid);