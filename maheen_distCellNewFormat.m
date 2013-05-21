ccc

outputDir='maheen_statsUsingOrientation';
load(fullfile(outputDir,...
    'everythingAndStatsUsingOrient_Sunday_28_4.mat'));
stats_record={'compToUse','orient_case','percentage','total',...
    'avgAndstd','barsRec','stats_curr','idx_for_record'};
show=0;

distCellAll_newFormat=cell(size(distCellAll));
for compNo1=1:16
    for compNo2=1:16
        distCompiledAll=distCompiledAllCell{compNo1,compNo2};
        distCompiledAll=[distCompiledAll;cell(1,size(distCompiledAll,2))];
        case_mat=cell2mat(distCompiledAll(6,:));
        [x,idx_dist_vec]=unique(case_mat);
        
        
        distCellCurrCombo=distCellAll{compNo1,compNo2};
        distCell_newFormat=cell(3,0);
        
        for currCompNo1=1:numel(distCellCurrCombo)
            distCellCompNo1=distCellCurrCombo{currCompNo1};
            for currCompNo2=1:numel(distCellCompNo1)-1
                distCell=distCellCompNo1{currCompNo2};
                name1=distCellCompNo1{end};
                name2=distCell{end};
                relStats=distCell(1:2);
                distCell_newFormat=[distCell_newFormat,{name1;name2;relStats}];
            end
        end
        
        
        
        
        
        for idx_dist=1:size(distCompiledAll,2)
%             idx_dist_vec
            bound1=boundCellAll{compNo1}{distCompiledAll{1,idx_dist}};
            bound2=boundCellAll{compNo2}{distCompiledAll{2,idx_dist}};
            bPts1=bound1{1};
            bLines1=bound1{2};
            bPts2=bound2{1};
            bLines2=bound2{2};
            pos=distCompiledAll{5,idx_dist};
            
            a_bin=cell2mat(distCell_newFormat(1,:))==distCompiledAll{1,idx_dist};
            b_bin=cell2mat(distCell_newFormat(2,:))==distCompiledAll{2,idx_dist};
            
            tot_bin=[a_bin;b_bin];
            tot_bin=sum(tot_bin,1);
            idx_rel=find(tot_bin==2);
            if isempty(idx_rel)
                display('wtf')
                keyboard;
            end
            
            distCompiledAll{end,idx_dist}=distCell_newFormat{end,idx_rel};
            
            if show>0
                minX=min([bPts1(1,:) bPts2(1,:)]);
                minY=min([bPts1(2,:) bPts2(2,:)]);
                
                bPts1=bPts1-repmat([minX;minY],1,size(bPts1,2));
                bPts2=bPts2-repmat([minX;minY],1,size(bPts2,2));
                
                bLines1=bLines1-repmat([minX;minY],2,size(bLines1,2));
                bLines2=bLines2-repmat([minX;minY],2,size(bLines2,2));
                h=visualizeBoxes(bPts1,bLines1,bPts2,bLines2);
                distCompiledAll{5,idx_dist}
                for i=1:numel(distCompiledAll{end,idx_dist})
                    distCompiledAll{end,idx_dist}{i}
                end
                keyboard;
            end 
        end
        distCompiledAllCell{compNo1,compNo2}=distCompiledAll;
    end
end



save(fullfile(outputDir,...
    'everythingAndStatsUsingOrient_Sunday_28_4_withDistCellNewFormat.mat'));

% save(fullfile(outputDir,'nameCellsAndDistAndBoundAndDistRefNoOrient.mat'),...
%     'nameCellAll','binMatchAll','idxMatchAll','dirNameMerge','distCellAll',...
%     'boundCellAll','distCellAllNewRef');
