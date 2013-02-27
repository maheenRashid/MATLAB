



ccc
load('../../dataStructureForStatistics/bedrooms_livingrooms_2_hotel_withSMALL_BDLR3_with_dist_nametags.mat');
load('../../dataStructureForStatistics/mapOfCompToVarshaCategory_withSmallBDLR_hotel_BDLR3_newTagged_tableFromCouch_withManualAnnot.mat');


% checkArray={'bryce','susan','sandra','sang','nancy','2d man','2d_man','2d woman','2d_woman','3d man','3d_man','3d woman','3d_woman','gothic_woman'}  ;

allKeys=keys(mapOfCompToVarshaCategory);
cInd=zeros(0,1);
j=0;
for i=1:length(allKeys)-1
    sceneValues=mapOfCompToVarshaCategory(allKeys{i});
    temp=regexp(allKeys{i},'\.','split');
    name=temp{1};
%     peopleInd=zeros(size(sceneValues,1),1);
%     for indCheck=1:numel(checkArray)
%         temp=regexpi(sceneValues(:,1),checkArray{indCheck});
%         temp=~cellfun(@isempty,temp);
%         peopleInd=peopleInd+temp;
%     end
%     if sum(peopleInd)~=0
%         display(name)
% %         return
%         j=j+1;
%     end
    ourLabels=abs(cell2mat(sceneValues(:,2)));
    f=fopen(fullfile('maheen_newLabels',strcat(name,'.txt')),'w');
    for labInd=1:numel(ourLabels)
        if isnan(ourLabels(labInd))
            fprintf(f,'%d\n',0);
        else
            fprintf(f,'%d\n',ourLabels(labInd));
        end
    end
    fclose(f);
end