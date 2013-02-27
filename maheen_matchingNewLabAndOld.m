ccc


load('../../dataStructureForStatistics/mapOfCompToVarshaCategory_withSmallBDLR_hotel_BDLR3_newTagged_tableFromCouch_withManualAnnot.mat');
d_results = dir('D:\ResearchCMU\lustre\Image-Modeling\OSMesa-Renderer\skp_category');
newBig=0;
oldBig=0;
k=cell(0,0);
for i = 3:(length(d_results))
    
%     d_results(i).name
    [pathstr, name, ext] = fileparts(d_results(i).name);
allKeys=keys(mapOfCompToVarshaCategory);
% % 
% % for i=1:length(allKeys)-1
%     sceneValues=mapOfCompToVarshaCategory(allKeys{i});
%     temp=regexp(allKeys{i},'\.','split');
%     name=temp{1};
fname=(['D:\ResearchCMU\lustre\Image-Modeling\OSMesa-Renderer\skp_category\' name '.txt']);
[fid,message]=fopen(fname);
temp = textscan(fid,'%s','Delimiter','\n');
fclose(fid);
skpCat=temp{1};
fname=(['maheen_newLabels/' name '.txt']);
[fid,message]=fopen(fname);
temp = textscan(fid,'%s','Delimiter','\n');
fclose(fid);
skpCatNew=temp{1};

if numel(skpCatNew)~=numel(skpCat)
    display(name)
    if numel(skpCatNew)>numel(skpCat)
    newBig=newBig+1;
    else
    oldBig=oldBig+1;
    end
end
end

