ccc
load('D:\ResearchCMU\lustre\jasonli1\code\MATLAB\maheen_cornerPlacement\recordDiffCompLabels.mat')
recordNew=cell(0,1);
count=0;

for i = 1:(length(record))

    name=record{i};
fname=(['D:\ResearchCMU\lustre\Image-Modeling\OSMesa-Renderer\skp_category\' name '.txt']);
[fid,message]=fopen(fname);
temp = textscan(fid,'%s','Delimiter','\n');
fclose(fid);
skpCat=temp{1};
fname=(['D:\ResearchCMU\lustre\Image-Modeling\OSMesa-Renderer\skp\' name '.txt']);
[fid,message]=fopen(fname);
temp = textscan(fid,'%s','Delimiter','\n');
fclose(fid);
skp=temp{1};


        temp=regexpi(skp,'z');
        temp=~cellfun(@isempty,temp);
        compNo=sum(temp);
if numel(skpCat)~=compNo
    count=count+1;
    recordNew=[recordNew;name];
%     name
end
return
end

return
ccc
d_results = dir('D:\ResearchCMU\lustre\Image-Modeling\OSMesa-Renderer\skp_category');
record=cell(0,1);
count=0;
for i = 3:(length(d_results))

    [pathstr, name, ext] = fileparts(d_results(i).name);
fname=(['D:\ResearchCMU\lustre\Image-Modeling\OSMesa-Renderer\skp_category\' name '.txt']);
[fid,message]=fopen(fname);
temp = textscan(fid,'%s','Delimiter','\n');
fclose(fid);
skpCat=temp{1};
load(['../../results_ALL/' name '.mat']);
if numel(skpCat)~=length(A)-1
    count=count+1;
    record=[record;name];
%     name
end

% return
end


return
ccc
load ('maheen_cornerPlacement\varK.mat','k');
load('../../dataStructureForStatistics/mapOfCompToVarshaCategory_withSmallBDLR_hotel_BDLR3_newTagged_tableFromCouch_withManualAnnot.mat');

for i=1:length(k)
    sceneValues=mapOfCompToVarshaCategory(k{i});
    temp=regexp(k{i},'\.','split');
    name=temp{1};
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
return
end

return
ccc

load ('maheen_cornerPlacement\varK.mat','k');
load('../../dataStructureForStatistics/mapOfCompToVarshaCategory_withSmallBDLR_hotel_BDLR3_newTagged_tableFromCouch_withManualAnnot.mat');
checkArray={'bryce','susan','sandra','sang','nancy','2d man','2d_man','2d woman','2d_woman','3d man','3d_man','3d woman','3d_woman','gothic_woman'}  ;


for i=1:length(k)
    sceneValues=mapOfCompToVarshaCategory(k{i});
    temp=regexp(k{i},'\.','split');
    name=temp{1};
    peopleInd=zeros(size(sceneValues,1),1);
    for indCheck=1:numel(checkArray)
        checkArray{indCheck};
        sceneValues(:,1);
        temp=regexpi(sceneValues(:,1),checkArray{indCheck});
        temp=~cellfun(@isempty,temp);
        peopleInd=peopleInd+temp;
%         pause;
    end
     ourLabels=abs(cell2mat(sceneValues(:,2)));
    for labInd=1:numel(ourLabels)
        labInd
        if ~isnan(ourLabels(labInd)) && peopleInd(labInd)==0
        else
            display('pass')
        end
    end
    return
end