ccc

outputDir='maheen_statsUsingOrientation';
load(fullfile(outputDir,...
    'everythingAndStatsUsingOrient_Sunday_28_4_withDistCellNewFormat.mat'));


show=0;



for compNo1=1:16
    for compNo2=1:16
        distCompiledAll=distCompiledAllCell{compNo1,compNo2};
        distCompiledAll=[distCompiledAll;cell(8,size(distCompiledAll,2))];
        case_mat=cell2mat(distCompiledAll(6,:));
        [x,idx_dist_vec]=unique(case_mat);
                
        for idx_dist=1:size(distCompiledAll,2)
        
            
            
            
%             idx_dist_vec(end-1:end)
%             :size(distCompiledAll,2)

%             idx_dist_vec
%             1:size(distCompiledAll,2)
%             idx_dist_vec
            
            
            bound1=boundCellAll{compNo1}{distCompiledAll{1,idx_dist}};
            bound2=boundCellAll{compNo2}{distCompiledAll{2,idx_dist}};

            pos=distCompiledAll{5,idx_dist};           
            distCell_curr=distCompiledAll{18,idx_dist};
            [distX,distY] = maheen_getSignedCornerDist( pos,distCell_curr );
            distsXAndY={distX,distY};
            distsMid=maheen_getMidDistance(distCompiledAll{9,idx_dist}{1}...
                ,distCompiledAll{9,idx_dist}{2},distsXAndY);
            
            pred=distCompiledAll{10,idx_dist}
            face1=distCompiledAll{12,idx_dist}
            [lump,lumpSorted,midDistRel,midDistRelSorted,midFlag]=maheen_lumpUsingPred(pred,distX,distY,...
                distsMid,face1)
            
            pred2=distCompiledAll{11,idx_dist}
            distsMidTemp=distsMid;
            if size(distsMid,2)>1
                distsMidTemp=distsMid(:,[1,3,2,4]);
            end
            face2=distCompiledAll{13,idx_dist}
            if numel(distX)>2
                distX=-distX;
            end
            if numel(distY)>2
                distY=-distY;
            end
            
            [lump2,lumpSorted2,midDistRel2,midDistRelSorted2,midFlag2]=maheen_lumpUsingPred(pred2,distX,distY,...
                distsMidTemp,face2)
            midFlag2=midFlag2([2,1])
            
            
            
            distCompiledAll{19,idx_dist}=lumpSorted;
            distCompiledAll{20,idx_dist}=lumpSorted2;
            distCompiledAll{21,idx_dist}=midDistRelSorted;
            distCompiledAll{22,idx_dist}=midDistRelSorted2;
            distCompiledAll{23,idx_dist}=midFlag;
            distCompiledAll{24,idx_dist}=midFlag2;
            distCompiledAll{25,idx_dist}=bound1;
            distCompiledAll{26,idx_dist}=bound2;
            
            if show>0
            
            bPts1=bound1{1};
            bLines1=bound1{2};
            bPts2=bound2{1};
            bLines2=bound2{2};
            mids1=[distCompiledAll{9,idx_dist}{1}(:,midFlag(1)),distCompiledAll{9,idx_dist}{2}(:,midFlag(2))];
            mids2=[distCompiledAll{9,idx_dist}{1}(:,midFlag2(1)),distCompiledAll{9,idx_dist}{2}(:,midFlag2(2))];
            
                minX=min([bPts1(1,:) bPts2(1,:)]);
                minY=min([bPts1(2,:) bPts2(2,:)]);
                
                bPts1=bPts1-repmat([minX;minY],1,size(bPts1,2));
                bPts2=bPts2-repmat([minX;minY],1,size(bPts2,2));
                mids1=mids1-repmat([minX;minY],1,size(mids1,2));
                mids2=mids2-repmat([minX;minY],1,size(mids2,2));
                
                bLines1=bLines1-repmat([minX;minY],2,size(bLines1,2));
                bLines2=bLines2-repmat([minX;minY],2,size(bLines2,2));
                h=visualizeBoxes(bPts1,bLines1,bPts2,bLines2);
                hold on;
                plot(mids1(1,:),mids1(2,:),'-m');
                
                plot(mids2(1,:),mids2(2,:),'-c');
%             pause;
                  keyboard;
            clc
          end 
        end
        distCompiledAllCell{compNo1,compNo2}=distCompiledAll;
    end
end

% outputDir='maheen_statsUsingOrientation';
save(fullfile(outputDir,...
    'everythingAndStatsUsingOrient_Sunday_28_4_withDistCellNewFormat_distSignedXAndY.mat'));