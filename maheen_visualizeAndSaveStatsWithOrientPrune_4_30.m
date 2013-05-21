ccc

outputDir='maheen_statsUsingOrientation';
load(fullfile(outputDir,...
    'everythingAndStatsUsingOrient_Sunday_28_4.mat'));
stats_record={'compToUse','orient_case','percentage','total',...
            'avgAndstd','barsRec','stats_curr','idx_for_record'};
        
        
        f=fopen(fullfile(outputDir,'visuForPHP.txt'),'w');
        
for compNo1=1:16
    for compNo2=1:16
        dirName=[dirName_pred num2str(compNo1) '_' num2str(compNo2)];
        
        distCompiledAll=distCompiledAllCell{compNo1,compNo2};
        if isempty(distCompiledAll)
            continue
        end
        statsAll=stats_super_cell{compNo1,compNo2};
        percent_mat=cell2mat(statsAll(:,3));
        [~,idx_max_percent]=max(percent_mat);
        stats_to_use=statsAll(idx_max_percent,:);
        compToUse=stats_to_use{1};
        orient_case=stats_to_use{2};
        orient_no=orient_case+2;
        percentage=stats_to_use{3};
        total=stats_to_use{4};
        avgAndstd=stats_to_use{5};
        barsRec=stats_to_use{6};
        stats_curr=stats_to_use{7};
        idx_for_record=stats_to_use{8};
        for stat_no=1:size(barsRec,2)
            avg=avgAndstd(1,stat_no)
            std=avgAndstd(2,stat_no)
            xcentres=barsRec{1,stat_no};
            nelements=barsRec{2,stat_no};
            
            
            
            
                     
            
%         h=figure;
% %                     set(h,'visible','off');
%                     bar(xcentres,nelements);
%                     title([compNo_str{compNo1} ' and ' compNo_str{compNo2} ...
%                         ' using ' num2str(compToUse) ' Orientation ' ...
%                         orient_str{orient_no} ...
%                         ' Stat ' distType_str{mod(orient_no,2)+1}{stat_no}]);
                   histName=fullfile(outputDir,dirName,[compNo_str{compNo1} ' and ' compNo_str{compNo2} ...
                        ' using ' num2str(compToUse) ' Orientation ' ...
                        orient_str{orient_no} ...
                        ' Stat ' distType_str{mod(orient_no,2)+1}{stat_no} '.png']); 
             fprintf(f,'%s\n',histName);
                   
            [~,idx_max_nelements]=max(nelements);
            r=xcentres(2)-xcentres(1);
            r=r/2;
            max_val=xcentres(idx_max_nelements);
            idx_to_show=stats_curr(:,stat_no)>(max_val-r) & stats_curr(:,stat_no)<(max_val+r);
            idx_to_show=idx_for_record(idx_to_show);
            if numel(idx_to_show)>4
                idx_dist_vec=randperm(numel(idx_to_show),4);
            else
                idx_dist_vec=1:numel(idx_to_show);
            end
            for i=idx_dist_vec
                idx_dist=idx_to_show(i);
            bound1=boundCellAll{compNo1}{distCompiledAll{1,idx_dist}};
            bound2=boundCellAll{compNo2}{distCompiledAll{2,idx_dist}};
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
                   
                   title([compNo_str{compNo1} ' and ' compNo_str{compNo2} ...
                        ' using ' num2str(compToUse) ' Orientation ' ...
                        orient_str{orient_no} ...
                        ' Stat ' distType_str{mod(orient_no,2)+1}{stat_no} ' typical ' num2str(find(i==idx_dist_vec))]);
                    set(h,'visible','off');
                                       saveas(h,fullfile(outputDir,dirName,[compNo_str{compNo1} ' and ' compNo_str{compNo2} ...
                        ' using ' num2str(compToUse) ' Orientation ' ...
                        orient_str{orient_no} ...
                        ' Stat ' distType_str{mod(orient_no,2)+1}{stat_no} ' typical ' num2str(find(i==idx_dist_vec)) '.png']));
                   
                   imName=fullfile(outputDir,dirName,[compNo_str{compNo1} ' and ' compNo_str{compNo2} ...
                        ' using ' num2str(compToUse) ' Orientation ' ...
                        orient_str{orient_no} ...
                        ' Stat ' distType_str{mod(orient_no,2)+1}{stat_no} ' typical ' num2str(find(i==idx_dist_vec)) '.png']);
                   fprintf(f,'%s\n',imName);
                   close(gcf)
            end
            
%             pause
        end

        
    end
end
fclose(f);
