ccc
load('../../dataStructureForStatistics/bedrooms_livingrooms_2_hotel_withSMALL_BDLR3_with_dist_nametags.mat');
compNo=1;
load(['maheen_stats\category_' num2str(compNo) '_models.mat']);
%     modelNames1=modelNames;
% 
xDiff=zeros(1,0);
yDiff=zeros(1,0);
zmin=zeros(1,0);
zDiff=zeros(1,0);
area=zDiff;
count=0;
thresh=1;
buck=100;
for i=1:size(modelNames,2)        
        currRecord=C{modelNames{2,i}};
        currX=abs(currRecord{3}(1)-currRecord{4}(1));
        currY=abs(currRecord{3}(2)-currRecord{4}(2));
        currZ=abs(currRecord{3}(3)-currRecord{4}(3));
%         if currX<1 ||currY<1              || currZ<1
%             count=count+1;
% %             modelNames{2,i}
%         end
        xDiff=[xDiff currX];
        yDiff=[yDiff currY];
        zDiff=[zDiff currZ];
        zmin=[zmin currRecord{3}(3)];
        area=[area currX*currY*currZ];
%             *(currRecord{3}(3)-currRecord{4}(3)))];
       

        %         
%     for ii=1:numel(comp1ind)
%         for j=1:numel(comp2ind)
% minPixDist=[minPixDist distCornerOrEdge(comp1ind(ii), comp2ind(j), C)];
%         end
%     end
end

%         bin=area>100000 & area<2000000;
%         area=area(bin);
%         xDiff=xDiff(bin);
%         yDiff=yDiff(bin);
%         zDiff=zDiff(bin);
%         zmin=zmin(bin);

figure
[n,xout]=hist(area,buck);
bar(xout,n);


figure
[n,xout]=hist(xDiff,buck);
bar(xout,n);

figure
[n,xout]=hist(yDiff,buck);
bar(xout,n);

figure
[n,xout]=hist(zDiff,buck);
bar(xout,n);

figure
[n,xout]=hist(zmin,buck);
bar(xout,n);



return
ccc

load('../../dataStructureForStatistics/bedrooms_livingrooms_2_hotel_withSMALL_BDLR3_with_dist_nametags.mat');
for compNo1=     1:17
load(['maheen_stats\category_' num2str(compNo1) '_models.mat']);
    modelNames1=modelNames;

    for compNo2=         compNo1+1:17

load(['maheen_stats\category_' num2str(compNo2) '_models.mat']);
    modelNames2=modelNames;


load(['maheen_stats\intersect_' num2str(compNo1) '_' num2str(compNo2) '_models.mat']);
minPixDist=zeros(2,0);
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
minPixDist=[minPixDist distCornerOrEdge(comp1ind(ii), comp2ind(j), C)];
        end
    end
end
figure
[n,xout]=hist(minPixDist(2,:),100);
bar(xout,n);
save(['maheen_stats_pairwise\minPixDist_' num2str(compNo1) '_' num2str(compNo2) '.mat'],'minPixDist');
print(gcf,'-djpeg',['maheen_stats_pairwise\minPixDist_' num2str(compNo1) '_' num2str(compNo2) '.jpg'])
close all
end

end