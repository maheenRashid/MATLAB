

for compNo=1:17
    load(['maheen_stats_new\category_' num2str(compNo) '_objDim.mat'],'objDim','recordObjDim');
    area=objDim(1,:).*objDim(2,:).*objDim(3,:);
figure
[n,xout]=hist(area,100);
bar(xout,n);
print(gcf,'-djpeg',['maheen_stats_new\category_' num2str(compNo) '_area.jpg'])

save(['maheen_stats_new\category_' num2str(compNo) '_objDim.mat'],'objDim','recordObjDim','area');
    
end


return

% used to record object dimensions
ccc
load('../../dataStructureForStatistics/bedrooms_livingrooms_2_hotel_withSMALL_BDLR3_with_dist_nametags.mat');

for compNo=1:17
    load(['maheen_stats_new\category_' num2str(compNo) '_models.mat']);

% display3DGivenCompIndex(cell2mat(modelNames(2,:)))
compCells=C(1,cell2mat(modelNames(2,:)));
% maxDist=100*ones(1,size(compCells,2));
objDim=zeros(3,size(compCells,2));
recordObjDim=cell(2,size(compCells,2));
j=1;
for i=1:size(compCells,2)
    currCell=compCells{1,i};
    allD=[currCell{1,3};currCell{1,4}];
    if sum(sum(isnan(allD)))==0
%       maxDist(j)=max(allD);   
      diff=abs(allD(1,:)-allD(2,:));
      objDim(:,j)=diff';
      recordObjDim{1,j}=currCell{1,1};
      recordObjDim{2,j}=modelNames{2,i};
        j=j+1;
    end
end

if j==1
    objDim=zeros(3,0);
    recordObjDim=cell(2,0);
else
    objDim=objDim(:,1:j-1);
    recordObjDim=recordObjDim(:,1:j-1);
end

figure
[n,xout]=hist(objDim(1,:),100);
bar(xout,n);
print(gcf,'-djpeg',['maheen_stats_new\category_' num2str(compNo) '_objDimX.jpg'])

figure
[n,xout]=hist(objDim(2,:),100);
bar(xout,n);
print(gcf,'-djpeg',['maheen_stats_new\category_' num2str(compNo) '_objDimY.jpg'])

figure
[n,xout]=hist(objDim(3,:),100);
bar(xout,n);
print(gcf,'-djpeg',['maheen_stats_new\category_' num2str(compNo) '_objDimZ.jpg'])

save(['maheen_stats_new\category_' num2str(compNo) '_objDim.mat'],'objDim','recordObjDim');
% clear modelNames
end


return

ccc
load('../../dataStructureForStatistics/bedrooms_livingrooms_2_hotel_withSMALL_BDLR3_with_dist_nametags.mat');
for compNo1=8:17
load(['maheen_stats_new\category_' num2str(compNo1) '_models.mat']);
    modelNames1=modelNames;

    for compNo2=compNo1+1:17

load(['maheen_stats_new\category_' num2str(compNo2) '_models.mat']);
    modelNames2=modelNames;


load(['maheen_stats_new\intersect_' num2str(compNo1) '_' num2str(compNo2) '_models.mat']);
minPixDist=[];
for i=1:numel(record)        
        currRecord=record{i};
comp1ind=strcmp(modelNames1(1,:),currRecord);
comp2ind=strcmp(modelNames2(1,:),currRecord);
comp1ind=cell2mat(modelNames1(2,comp1ind));
comp2ind=cell2mat(modelNames2(2,comp2ind));
% if numel(comp1ind)>1 ||numel(comp2ind)>1
%     disp('here')
% end

    for ii=1:numel(comp1ind)
        for j=1:numel(comp2ind)
%             minPixDist=[minPixDist distNearestPixels(comp1ind(ii), comp2ind(j), C)];
%                 minPixDist=[minPixDist distCentres(comp1ind(ii), comp2ind(j), C)];
minPixDist=[minPixDist distCornerOrEdge(comp1ind(ii), comp2ind(j), C)];
        end
    end
end
if numel(minPixDist~=0)
    
figure
[n,xout]=hist(minPixDist(2,:),100);
bar(xout,n);

save(['maheen_stats_new\minPixDist_' num2str(compNo1) '_' num2str(compNo2) '.mat'],'minPixDist');
print(gcf,'-djpeg',['maheen_stats_new\minPixDist_' num2str(compNo1) '_' num2str(compNo2) '.jpg'])
end
    end
pause
close all
end


return
%used to record models with combinations
ccc
for compNo1=1:17
load(['maheen_stats_new\category_' num2str(compNo1) '_models.mat']);
    modelNames1=modelNames;
for compNo2=compNo1+1:17
load(['maheen_stats_new\category_' num2str(compNo2) '_models.mat']);
        record=intersect(modelNames1(1,:),modelNames(1,:));
        save(['maheen_stats_new\intersect_' num2str(compNo1) '_' num2str(compNo2) '_models.mat'],'record');
    end
end



return

% used to record max distance of object to wall
ccc
load('../../dataStructureForStatistics/bedrooms_livingrooms_2_hotel_withSMALL_BDLR3_with_dist_nametags.mat');

for compNo=1:17
    load(['maheen_stats_new\category_' num2str(compNo) '_models.mat']);

% display3DGivenCompIndex(cell2mat(modelNames(2,:)))
compCells=C(1,cell2mat(modelNames(2,:)));
% maxDist=100*ones(1,size(compCells,2));
maxDist=zeros(1,size(compCells,2));
recordMaxDist=cell(2,size(compCells,2));
j=1;
for i=1:size(compCells,2)
    currCell=compCells{1,i};
    allD=currCell{1,6};
    if sum(isnan(allD))==0
      maxDist(j)=max(allD);
      recordMaxDist{1,j}=currCell{1,1};
      recordMaxDist{2,j}=modelNames{2,i};
        j=j+1;
    end
end

if j==1
    maxDist=zeros(0);
else
    maxDist=maxDist(1:j-1);
end

figure
[n,xout]=hist(maxDist,100);
bar(xout,n);

save(['maheen_stats_new\category_' num2str(compNo) '_maxDist2Walls.mat'],'maxDist','recordMaxDist');
print(gcf,'-djpeg',['maheen_stats_new\category_' num2str(compNo) '_maxDist2Walls.jpg'])
% clear modelNames
end
return

% used to record max distance of object to wall
ccc
load('../../dataStructureForStatistics/bedrooms_livingrooms_2_hotel_withSMALL_BDLR3_with_dist_nametags.mat');

for compNo=1:17
    load(['maheen_stats_new\category_' num2str(compNo) '_models.mat']);

% display3DGivenCompIndex(cell2mat(modelNames(2,:)))
compCells=C(1,cell2mat(modelNames(2,:)));
minDist=100*ones(1,size(compCells,2));
recordMinDist=cell(2,size(compCells,2));
j=1;
for i=1:size(compCells,2)
    currCell=compCells{1,i};
    allD=currCell{1,6};
    if sum(isnan(allD))==0
      minDist(j)=min(allD);
      recordMinDist{1,j}=currCell{1,1};
      recordMinDist{2,j}=modelNames{2,i};
        j=j+1;
    end
end

if j==1
    minDist=zeros(0);
else
    minDist=minDist(1:j-1);
end

figure
[n,xout]=hist(minDist,100);
bar(xout,n);

save(['maheen_stats_new\category_' num2str(compNo) '_minDist2Walls.mat'],'minDist','recordMinDist');
print(gcf,'-djpeg',['maheen_stats_new\category_' num2str(compNo) '_minDist2Walls.jpg'])
% clear modelNames
end

return
%used to save modelNames corresponding to categories

ccc
load('../../dataStructureForStatistics/bedrooms_livingrooms_2_hotel_withSMALL_BDLR3_with_dist_nametags.mat');
load('../../dataStructureForStatistics/mapOfCompToVarshaCategory_withSmallBDLR_hotel_BDLR3_newTagged_tableFromCouch_withManualAnnot.mat');

allKeys=keys(mapOfCompToVarshaCategory);
cInd=zeros(0,1);


names=cell(1,size(C,2));
for i=1:size(C,2)
    names{1,i}=C{i}{1};
end

 
for modelNo=1:17
j=1;
modelNames=cell(2,size(C,2));

for i=1:length(allKeys)-1
    sceneValues=mapOfCompToVarshaCategory(allKeys{i});
    x=find(abs(cell2mat(sceneValues(:,2)))==modelNo);
    bin=strcmp(allKeys{i},names);
    indC=find(bin);
%     C(:,bin);
    
    for k=1:numel(indC)
        for xInd=1:numel(x)
        if C{indC(k)}{2}==x(xInd)
        modelNames{1,j}=C{indC(k)}{1};
        modelNames{2,j}=indC(k);
        j=j+1;
        end
        end
    end
    
end
if j==1
    modelNames=cell(2,0);
    display('bad')
    modelNo
else
    modelNames=modelNames(:,1:j-1);
    display('good')
    size(modelNames)
end

save(['maheen_stats_new/category_'  num2str(modelNo) '_models.mat'],'modelNames');

end
