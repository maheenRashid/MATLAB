ccc
outputDir='maheen_statsUsingOrientation';

load(fullfile(outputDir,'nameCellsAndDistAndBoundAndDistRefAndCompiledRelStatsNoOrientAndMidPointDistAndPredsAndFacing.mat'),...
    'binMatchAll','idxMatchAll','dirNameMerge','distCellAll',...
    'nameCellAll','boundCellAll','distCellAllNewRef','distCompiledAllCell');
show=0;

for compNo1=1:16
    for compNo2=1:16
        
        distCompiledAll=distCompiledAllCell{compNo1,compNo2};
        distCompiledAll=[distCompiledAll;cell(4,size(distCompiledAll,2))];
        case_mat=cell2mat(distCompiledAll(6,:));
        [x,idx_dist_vec]=unique(case_mat);
        
        
        for idx_dist=1:size(distCompiledAll,2)
            bound1=boundCellAll{compNo1}{distCompiledAll{1,idx_dist}};
            bound2=boundCellAll{compNo2}{distCompiledAll{2,idx_dist}};
            nameComp1=nameCellAll{2,compNo1}{distCompiledAll{1,idx_dist}};
            nameComp2=nameCellAll{2,compNo2}{distCompiledAll{2,idx_dist}};
            bPts1=bound1{1};
            bLines1=bound1{2};
            bPts2=bound2{1};
            bLines2=bound2{2};
            
            predCurr1=distCompiledAll{10,idx_dist};
            predCurr2=distCompiledAll{11,idx_dist};
            pos=distCompiledAll{5,idx_dist};
            
            face1=distCompiledAll{12,idx_dist};
            face2=distCompiledAll{13,idx_dist};
            
            hypos=distCompiledAll{4,idx_dist};
            horizontal=distCompiledAll{3,idx_dist}{size(hypos')==1};
            mids=distCompiledAll{8,idx_dist};
            [ stats1 ] = maheen_orderAndPruneBasedOnRelOrientation( hypos,horizontal,face1,predCurr1,mids );
            [ stats2 ] = maheen_orderAndPruneBasedOnRelOrientation( hypos,horizontal,face2,predCurr2,mids );
            
            
            distCompiledAll{end-3,idx_dist}=stats1;
            distCompiledAll{end-2,idx_dist}=stats2;
            
            
                minX=min([bPts1(1,:) bPts2(1,:)]);
                minY=min([bPts1(2,:) bPts2(2,:)]);
                
                bPts1=bPts1-repmat([minX;minY],1,size(bPts1,2));
                bPts2=bPts2-repmat([minX;minY],1,size(bPts2,2));
                
                bLines1=bLines1-repmat([minX;minY],2,size(bLines1,2));
                bLines2=bLines2-repmat([minX;minY],2,size(bLines2,2));
                
                mid_norm_1=(min(bPts1,[],2)+max(bPts1,[],2))/2;
                mid_norm_2=(min(bPts2,[],2)+max(bPts2,[],2))/2;
                distCompiledAll{end-1,idx_dist}=mid_norm_1;
            distCompiledAll{end,idx_dist}=mid_norm_2;
            if show>0
                h=visualizeBoxes(bPts1,bLines1,bPts2,bLines2);
                
                hold on;
                plot(mid_norm_1(1),mid_norm_1(2),'*k');
                plot(mid_norm_2(1),mid_norm_2(2),'*k');
                distCompiledAll(:,idx_dist)
                keyboard;
            end
            
            
            
            
        end
        
        distCompiledAllCell{compNo1,compNo2}=distCompiledAll;
    end
end

save(fullfile(outputDir,'nameCellsAndDistAndBoundAndDistRefAndCompiledRelStatsNoOrientAndMidPointDistAndPredsAndFacingAndStatsPrunedByOrientAndMidNorms.mat'),...
    'binMatchAll','idxMatchAll','dirNameMerge','distCellAll',...
    'nameCellAll','boundCellAll','distCellAllNewRef','distCompiledAllCell');

return
%%
ccc
outputDir='maheen_statsUsingOrientation';

load(fullfile(outputDir,'nameCellsAndDistAndBoundAndDistRefAndCompiledRelStatsNoOrientAndMidPointDistAndPreds.mat'),...
    'binMatchAll','idxMatchAll','dirNameMerge','distCellAll',...
    'nameCellAll','boundCellAll','distCellAllNewRef','distCompiledAllCell');
show=0;

for compNo1=1:16
    for compNo2=1:16
        
        distCompiledAll=distCompiledAllCell{compNo1,compNo2};
        distCompiledAll=[distCompiledAll;cell(2,size(distCompiledAll,2))];
        case_mat=cell2mat(distCompiledAll(6,:));
        [x,idx_dist_vec]=unique(case_mat);
        
        
        for idx_dist=1:size(distCompiledAll,2)
            bound1=boundCellAll{compNo1}{distCompiledAll{1,idx_dist}};
            bound2=boundCellAll{compNo2}{distCompiledAll{2,idx_dist}};
%             nameComp1=nameCellAll{2,compNo1}{distCompiledAll{1,idx_dist}}
%             nameComp2=nameCellAll{2,compNo2}{distCompiledAll{2,idx_dist}}
            bPts1=bound1{1};
            bLines1=bound1{2};
            bPts2=bound2{1};
            bLines2=bound2{2};
            
            predCurr1=distCompiledAll{end-3,idx_dist};
            predCurr2=distCompiledAll{end-2,idx_dist};
            pos=distCompiledAll{5,idx_dist};
            
            face1=maheen_getFacingBin(pos(1:2),predCurr1);
            face2=maheen_getFacingBin(pos(3:4),predCurr2);
            
            distCompiledAll{end-1,idx_dist}=face1;
            distCompiledAll{end,idx_dist}=face2;
            
            if show>0
                minX=min([bPts1(1,:) bPts2(1,:)]);
                minY=min([bPts1(2,:) bPts2(2,:)]);
                
                bPts1=bPts1-repmat([minX;minY],1,size(bPts1,2));
                bPts2=bPts2-repmat([minX;minY],1,size(bPts2,2));
                
                bLines1=bLines1-repmat([minX;minY],2,size(bLines1,2));
                bLines2=bLines2-repmat([minX;minY],2,size(bLines2,2));
                h=visualizeBoxes(bPts1,bLines1,bPts2,bLines2);
                distCompiledAll(:,idx_dist)
                keyboard;
            end
            
            
            
            
        end
        
        distCompiledAllCell{compNo1,compNo2}=distCompiledAll;
    end
end

save(fullfile(outputDir,'nameCellsAndDistAndBoundAndDistRefAndCompiledRelStatsNoOrientAndMidPointDistAndPredsAndFacing.mat'),...
    'binMatchAll','idxMatchAll','dirNameMerge','distCellAll',...
    'nameCellAll','boundCellAll','distCellAllNewRef','distCompiledAllCell');


return
%%
ccc

outputDir='maheen_statsUsingOrientation';

load(fullfile(outputDir,'nameCellsAndDistAndBoundAndDistRefAndCompiledRelStatsNoOrientAndMidPointDist.mat'),...
    'binMatchAll','idxMatchAll','dirNameMerge','distCellAll',...
    'nameCellAll','boundCellAll','distCellAllNewRef','distCompiledAllCell');

show=0;
% compNo1=1;
% compNo2=8;
for compNo1=1:16
    for compNo2=1:16
        
        load(['maheen_similarityBetweenComp\warehouse\simHBl_withPreds_warehouse_' num2str(compNo1) '.mat'],...
            'direcSuperA','predsCurr');
        names1=cell(1,numel(direcSuperA));
        for i=1:numel(direcSuperA)
            names1{i}=direcSuperA(i).name;
        end
        preds1=predsCurr;
        load(['maheen_similarityBetweenComp\warehouse\simHBl_withPreds_warehouse_' num2str(compNo2) '.mat'],...
            'direcSuperA','predsCurr');
        names2=cell(1,numel(direcSuperA));
        for i=1:numel(direcSuperA)
            names2{i}=direcSuperA(i).name;
        end
        preds2=predsCurr;
        
        distCompiledAll=distCompiledAllCell{compNo1,compNo2};
        distCompiledAll=[distCompiledAll;cell(2,size(distCompiledAll,2))];
        case_mat=cell2mat(distCompiledAll(6,:));
        [x,idx_dist_vec]=unique(case_mat);
        
        
        
        for idx_dist=1:size(distCompiledAll,2)
            bound1=boundCellAll{compNo1}{distCompiledAll{1,idx_dist}};
            bound2=boundCellAll{compNo2}{distCompiledAll{2,idx_dist}};
            
            bPts1=bound1{1};
            bLines1=bound1{2};
            bPts2=bound2{1};
            bLines2=bound2{2};
            
            
            
            nameComp1=nameCellAll{2,compNo1}{distCompiledAll{1,idx_dist}};
            nameComp2=nameCellAll{2,compNo2}{distCompiledAll{2,idx_dist}};
            
            idx_pred1=find(strcmp(nameComp1,names1));
            idx_pred2=find(strcmp(nameComp2,names2));
            if numel(idx_pred1)~=1 || numel(idx_pred2)~=1
                display('error')
                keyboard
            end
            
            predCurr1=preds1(idx_pred1);
            predCurr2=preds2(idx_pred2);
            
            distCompiledAll{end-1,idx_dist}=predCurr1;
            distCompiledAll{end,idx_dist}=predCurr2;
            
            
            
            if show>0
                minX=min([bPts1(1,:) bPts2(1,:)]);
                minY=min([bPts1(2,:) bPts2(2,:)]);
                
                bPts1=bPts1-repmat([minX;minY],1,size(bPts1,2));
                bPts2=bPts2-repmat([minX;minY],1,size(bPts2,2));
                
                bLines1=bLines1-repmat([minX;minY],2,size(bLines1,2));
                bLines2=bLines2-repmat([minX;minY],2,size(bLines2,2));
                h=visualizeBoxes(bPts1,bLines1,bPts2,bLines2);
                distCompiledAll(:,idx_dist)
                keyboard;
            end
            
            
            
            
        end
        
        distCompiledAllCell{compNo1,compNo2}=distCompiledAll;
    end
end


save(fullfile(outputDir,'nameCellsAndDistAndBoundAndDistRefAndCompiledRelStatsNoOrientAndMidPointDistAndPreds.mat'),...
    'binMatchAll','idxMatchAll','dirNameMerge','distCellAll',...
    'nameCellAll','boundCellAll','distCellAllNewRef','distCompiledAllCell');
