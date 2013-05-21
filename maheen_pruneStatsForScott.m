ccc
outputDir='maheen_statsUsingOrientation';


load(fullfile(outputDir,...
    'everythingAndStatsUsingOrient_Sunday_28_4_withDistCellNewFormat_distSignedXAndY_compiledStats_new.mat'),'distCompiledAllCell','stats_super_cell');


dirName_pred='stats_and_vis_2d_';



        dirName=fullfile(outputDir,'visualsForScott');
        if exist(dirName,'dir')~=7
            mkdir(dirName);
        end
        

stats_for_scott=cell(16,16);
for compNo1=1:16
    for compNo2=1:16
        
        dirName_comp=[dirName_pred num2str(compNo1) '_' num2str(compNo2)];
        if exist(fullfile(dirName,dirName_comp),'dir')~=7
            mkdir(fullfile(dirName,dirName_comp));
        end
        if isempty(stats_super_cell{compNo1,compNo2})
            continue
        end
        
        
        stats_curr=stats_super_cell{compNo1,compNo2};
        rec=cell2mat(stats_curr(1:2,:));
        rec_firstComp=rec(1,:)==1;
        stats_curr=stats_curr(:,rec_firstComp);
        rec_typePlacement=cell2mat(stats_curr(2,:));
        stats_rel=cell(8,0);
        for i=[-1,0,1]
            idx=find(rec_typePlacement==i);
            if numel(idx)==0
                continue
            end
%             display('here')
            
            if abs(i)==1
%                 display('here')
%                 stats_curr(:,max(idx))
                stats_rel=[stats_rel, stats_curr([2,3,4,7,8,9,10,12],max(idx))];
            else
%                 display('here')
%                 stats_curr(:,idx)
                stats_rel=[stats_rel, stats_curr([2,3,4,7,8,9,10,12],idx)];
            end
            
            
            
            end
%         keyboard
        for i=1:size(stats_rel,2)
                im1_name=[stats_rel{end,i} '.png'];
                im2_name=[stats_rel{end,i} '_hist.png'];
                
                justName= regexp(stats_rel{end,i},'\','split');
                justName=justName{1,end};
                justName_1=[justName '.png'];
                justName_2=[justName '_hist.png'];
                
                filenames={fullfile(dirName_comp,justName_1),...
                    fullfile(dirName_comp,justName_2)};
                copyfile(im1_name,fullfile(dirName...
                    ,dirName_comp,justName_1));
                copyfile(im2_name,fullfile(dirName...
                    ,dirName_comp,justName_2));
                
                stats_rel{end,i}=filenames;
        end
%             keyboard
    stats_for_scott{compNo1,compNo2}=stats_rel;
    end
end

save(fullfile(dirName,...
    'statsForScott.mat'),'stats_for_scott');
