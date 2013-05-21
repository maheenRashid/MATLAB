ccc
outputDir='maheen_statsUsingOrientation';
load(fullfile(outputDir,...
    'nameCellsAndDistAndBoundAndDistRefAndCompiledRelStatsNoOrientAndMidPointDistAndPredsAndFacingAndStatsPrunedByOrientAndMidNorms.mat'),...
    'binMatchAll','idxMatchAll','dirNameMerge','distCellAll',...
    'nameCellAll','boundCellAll','distCellAllNewRef','distCompiledAllCell');




orient_case=[-1,0,1];
orient_str={'back','side','front'};
compNo_str={'bed','couch','cabinet','chair','desk','drawer','dresser'...
    ,'nightstand','table','light','door','window','picture','tv',...
    'closet','bookshelf','misc'};
distType_str={{'hypoBack','hypoFront','midPoints','horizontal'};...
    {'hypo1','hypo2','midPoints','horizontal'}};
dirName_pred='stats_and_vis_';


stats_record={'compToUse','orient_case','percentage','total',...
            'avgAndstd','barsRec','stats_curr','idx_for_record'};
stats_super_cell=cell(16);

for compNo1=1:16
    for compNo2=1:16
        compNo1
        compNo2
        distCompiledAll=distCompiledAllCell{compNo1,compNo2};
        if isempty(distCompiledAll)
            continue;
        end
        
        dirName=[dirName_pred num2str(compNo1) '_' num2str(compNo2)];
        
        if exist(fullfile(outputDir,dirName),'dir')~=7
            mkdir(fullfile(outputDir,dirName));
        end
        
        mat_caseNo_all=cell2mat(distCompiledAll(6,:));
        mat_face_all=cell2mat(distCompiledAll(12:13,:));
        compNo_ids=cell2mat(distCompiledAll(1:2,:));
        
        stats_all=distCompiledAll(14:15,:);
        
        %change sign of -1 case
        idx_case_minusOne=find(mat_caseNo_all==-1);
        for i=idx_case_minusOne
            stats_all{1,i}=-1*stats_all{1,i};
            stats_all{2,i}=-1*stats_all{2,i};
        end
        
        %ignore case 3 and case 4
        idx_case_3and4=mat_caseNo_all==3 | mat_caseNo_all==4;
%         stats_all=stats_all(:,~idx_case_3and4);
%         mat_face_all=mat_face_all(~idx_case_3and4);
%         compNo_ids=compNo_ids(:,~idx_case_3and4);
        
        
        
        
        stats_curr_all=cell(0,8);
        for compToUse=1:2
            for orient_no=1:numel(orient_case)
                idx_curr_orient=mat_face_all(compToUse,:)==orient_case(orient_no);
                stats_curr=stats_all(compToUse,idx_curr_orient & ~idx_case_3and4);
                percentage=sum(idx_curr_orient & ~idx_case_3and4)/sum(~idx_case_3and4)*100;
                total=sum(~idx_case_3and4);
                idx_for_record=find(idx_curr_orient & ~idx_case_3and4);
                stats_curr=cell2mat(stats_curr');
                
                avgAndstd=zeros(2,size(stats_curr,2));
                barsRec=cell(2,size(stats_curr,2));
                for stat_no=1:size(stats_curr,2)
                    stat=stats_curr(:,stat_no);
                    avg=mean(stat);
                    std_dev=std(stat);
                    [nelements,xcentres]=hist(stat,20);
                    
                    barsRec{1,stat_no}=xcentres;
                    barsRec{2,stat_no}=nelements;
                    avgAndstd(1,stat_no)=avg;
                    avgAndstd(2,stat_no)=std_dev;
                    
                    h=figure;
                    set(h,'visible','off');
                    bar(xcentres,nelements);
                    title([compNo_str{compNo1} ' and ' compNo_str{compNo2} ...
                        ' using ' num2str(compToUse) ' Orientation ' ...
                        orient_str{orient_no} ...
                        ' Stat ' distType_str{mod(orient_no,2)+1}{stat_no}]);
                    saveas(h,fullfile(outputDir,dirName,[compNo_str{compNo1} ' and ' compNo_str{compNo2} ...
                        ' using ' num2str(compToUse) ' Orientation ' ...
                        orient_str{orient_no} ...
                        ' Stat ' distType_str{mod(orient_no,2)+1}{stat_no} '.png']));
                    
                end
                
                close all;
                currCell={compToUse,orient_case(orient_no),percentage,total,...
            avgAndstd,barsRec,stats_curr,idx_for_record};
                stats_curr_all=[stats_curr_all;currCell];
            end
        end
        
        stats_super_cell{compNo1,compNo2}=stats_curr_all;
        
    end
end

save(fullfile(outputDir,...
    'everythingAndStatsUsingOrient_Sunday_28_4.mat'));

