
ccc
outputDir='maheen_statsUsingOrientation';
load(fullfile(outputDir,'nameCellsAndDistAndBoundAndDistRefAndCompiledRelStatsNoOrient.mat'),...
    'binMatchAll','idxMatchAll','dirNameMerge','distCellAll',...
    'nameCellAll','boundCellAll','distCellAllNewRef','distCompiledAllCell');

% return
show=0;
% 
% compNo1=1;
% compNo2=8;

for compNo1=1:16
    for compNo2=1:16
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
            
            
            pos=distCompiledAll{5,idx_dist};
            caseNo=distCompiledAll{6,idx_dist};
            [ dists,m1_all,m2_all ] = maheen_getMidtoMidDist( bPts1,bPts2,pos );
            
            distCompiledAll{end-1,idx_dist}=dists;
            
            distCompiledAll{end,idx_dist}={m1_all,m2_all};
            
            
            if show>0
                minX=min([bPts1(1,:) bPts2(1,:)]);
                minY=min([bPts1(2,:) bPts2(2,:)]);
                
                bPts1=bPts1-repmat([minX;minY],1,size(bPts1,2));
                bPts2=bPts2-repmat([minX;minY],1,size(bPts2,2));
                
                bLines1=bLines1-repmat([minX;minY],2,size(bLines1,2));
                bLines2=bLines2-repmat([minX;minY],2,size(bLines2,2));
                m1_all=m1_all-repmat([minX;minY],1,size(m1_all,2));
                m2_all=m2_all-repmat([minX;minY],1,size(m2_all,2));
                h=visualizeBoxes(bPts1,bLines1,bPts2,bLines2);
                
                for i=1:2
                    distCompiledAll{3,idx_dist}{i}
                    
                end
                distCompiledAll{4,idx_dist}
                hold on;
                strCell={'-y','-g';'-b','-m'};
                for i=1:size(m1_all,2)
                    for j=1:size(m2_all,2)
                        plot([m1_all(1,i) m2_all(1,j)],[m1_all(2,i) m2_all(2,j)],strCell{i,j});
                    end
                end
                pause;
            end
            
        end
        distCompiledAllCell{compNo1,compNo2}=distCompiledAll;
    end
end

save(fullfile(outputDir,'nameCellsAndDistAndBoundAndDistRefAndCompiledRelStatsNoOrientAndMidPointDist.mat'),...
    'binMatchAll','idxMatchAll','dirNameMerge','distCellAll',...
    'nameCellAll','boundCellAll','distCellAllNewRef','distCompiledAllCell');

