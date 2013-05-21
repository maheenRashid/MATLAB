ccc

outputDir='maheen_statsUsingOrientation';


load(fullfile(outputDir,...
    'everythingAndStatsUsingOrient_Sunday_28_4_withDistCellNewFormat_distSignedXAndY_compiledStats_new.mat'),'distCompiledAllCell');

show=0;

% compNo1=1;
% compNo2=8;
stats_sfs=cell(16);
for compNo1=1:16
    for compNo2=1:16
distCompiledAll=distCompiledAllCell{compNo1,compNo2};

case_mat=cell2mat(distCompiledAll(6,:));
[x,idx_dist_vec]=unique(case_mat);
stats_all_curr=cell(11,size(distCompiledAll,2));

        for idx_dist=1:size(distCompiledAll,2)
            
            pred1=distCompiledAll{10,idx_dist}
            pred2=distCompiledAll{11,idx_dist}
            
            bound1=distCompiledAll{end-1,idx_dist};
            bound2=distCompiledAll{end,idx_dist};
            
            
            rot90=mod(pred1+4,5)*90;
            bound1_rot=bound1;
            bound2_rot=bound2;
            bound1_rot{1}=[cos(rot90*pi/180) -sin(rot90*pi/180);sin(rot90*pi/180) cos(rot90*pi/180)]*bound1{1};
            bound1_rot{2}=[cos(rot90*pi/180) -sin(rot90*pi/180);sin(rot90*pi/180) cos(rot90*pi/180)]*reshape(bound1{2},2,8);
            bound1_rot{2}=reshape(bound1_rot{2},4,4);
            
            bound2_rot{1}=[cos(rot90*pi/180) -sin(rot90*pi/180);sin(rot90*pi/180) cos(rot90*pi/180)]*bound2{1};
            bound2_rot{2}=[cos(rot90*pi/180) -sin(rot90*pi/180);sin(rot90*pi/180) cos(rot90*pi/180)]*reshape(bound2{2},2,8);
            bound2_rot{2}=reshape(bound2_rot{2},4,4);
            
            
            down=0;
            left=0;
            
            
            corner1=bound1_rot{1};
            corner2=bound2_rot{1};
            
            mid1=(min(corner1,[],2)+max(corner1,[],2))/2;
            mid2=(min(corner2,[],2)+max(corner2,[],2))/2;
            
            down=mid2(2)<mid1(2);
            left=mid2(1)<mid1(1);
            
            
            [ midsBoth2] = maheen_getRelMids_startFromScratch(corner2,down,left);
            
            [ midsBoth1] = maheen_getRelMids_startFromScratch(corner1,~down,~left);
            
            distsMid=midsBoth1-midsBoth2;
            [ distX,distY ] =maheen_projectedDist_startFromScratch(corner1,corner2);
            
            if ~down
                distY=-distY;
                distsMid(2,:)=-distsMid(2,:);
            end
            if ~left
                distX=-distX;
                distsMid(1,:)=-distsMid(1,:);
            end
            
            
            if down
                distVert_corner=[distX(1,1),distX(2,2);distY(1,2),distY(1,2)];
            else
                distVert_corner=[distX(1,1),distX(2,2);distY(2,1),distY(2,1)];
            end
            
            if left
                distHor_corner=[distX(1,2),distX(1,2);distY(1,1),distY(2,2)];
            else
                distHor_corner=[distX(2,1),distX(2,1);distY(1,1),distY(2,2)];
            end
            
            distVert=[distVert_corner(:,1),distsMid(:,1),distVert_corner(:,2)];
            distHor=[distHor_corner(:,1),distsMid(:,2),distHor_corner(:,2)];
            
            
            if down
                distHor=distHor(:,[2,1]);
            else
                distHor=distHor(:,[2,3]);
            end
            
            if left
                distVert=distVert(:,[2,1]);
            else
                distVert=distVert(:,[2,3]);
            end
            
            quad=0;
            if down && left
                quad=1;
            elseif down
                quad=2;
            elseif left
                quad=4;
            else
                quad=3;
            end
            
            %     statsCell_curr={down;left;distVert;distHor;bound1;bound2;bound1_rot;bound2_rot;...
            %         distCompiledAll{1,idx_dist};distCompiledAll{2,idx_dist}};
            
            stats_all_curr(:,idx_dist)={quad;down;left;distVert;distHor;bound1;bound2;bound1_rot;bound2_rot;...
                distCompiledAll{1,idx_dist};distCompiledAll{2,idx_dist}};
            
            if show>0
                bPts1=bound1{1};
                bLines1=bound1{2};
                bPts2=bound2{1};
                bLines2=bound2{2};
                minX=min([bPts1(1,:) bPts2(1,:)]);
                minY=min([bPts1(2,:) bPts2(2,:)]);
                
                bPts1=bPts1-repmat([minX;minY],1,size(bPts1,2));
                bPts2=bPts2-repmat([minX;minY],1,size(bPts2,2));
                
                
                bLines1=bLines1-repmat([minX;minY],2,size(bLines1,2));
                bLines2=bLines2-repmat([minX;minY],2,size(bLines2,2));
                h=visualizeBoxes(bPts1,bLines1,bPts2,bLines2);
            end
            
            if show>0
                bound1=bound1_rot;
                bound2=bound2_rot;
                bPts1=bound1{1};
                bLines1=bound1{2};
                bPts2=bound2{1};
                bLines2=bound2{2};
                minX=min([bPts1(1,:) bPts2(1,:)]);
                minY=min([bPts1(2,:) bPts2(2,:)]);
                
                mid1=mid1-repmat([minX;minY],1,size(mid1,2));
                mid2=mid2-repmat([minX;minY],1,size(mid2,2));
                
                midsBoth1=midsBoth1-repmat([minX;minY],1,size(midsBoth1,2));
                midsBoth2=midsBoth2-repmat([minX;minY],1,size(midsBoth2,2));
                
                
                bPts1=bPts1-repmat([minX;minY],1,size(bPts1,2));
                bPts2=bPts2-repmat([minX;minY],1,size(bPts2,2));
                
                
                bLines1=bLines1-repmat([minX;minY],2,size(bLines1,2));
                bLines2=bLines2-repmat([minX;minY],2,size(bLines2,2));
                h=visualizeBoxes(bPts1,bLines1,bPts2,bLines2);
                hold on;
                plot(mid1(1),mid1(2),'om');
                plot(mid2(1),mid2(2),'ob');
                
                plot(midsBoth1(1,1),midsBoth1(2,1),'ms');
                plot(midsBoth1(1,2),midsBoth1(2,2),'rs');
                plot(midsBoth2(1,1),midsBoth2(2,1),'bs');
                plot(midsBoth2(1,2),midsBoth2(2,2),'ks');
                
                keyboard;
                %                   clc
                %                   close all;
            end
            
        end
        stats_sfs{compNo1,compNo2}=stats_all_curr;
    end
end
save(fullfile(outputDir,...
    'start_from_scratch.mat'));

