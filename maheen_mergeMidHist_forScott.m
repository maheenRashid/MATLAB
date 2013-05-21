ccc
outputDir='maheen_statsUsingOrientation';
dirName=fullfile(outputDir,'visualsForScott_2');
load(fullfile(dirName,...
    'statsForScott.mat'),'stats_for_scott');

compNo_str={'bed','couch','cabinet','chair','desk','drawer','dresser'...
    ,'nightstand','table','light','door','window','picture','tv',...
    'closet','bookshelf','misc'};

string_x_y={'x','y'};

dirName_pred='stats_and_vis_2d_';



dirName=fullfile(outputDir,'visualsForScott_3');
if exist(dirName,'dir')~=7
    mkdir(dirName);
end

show=0;



stats_for_scott_12=cell(16,16);
for compNo1=1:16
    for compNo2=1:16
        
        dirName_comp=[dirName_pred num2str(compNo1) '_' num2str(compNo2)];
        if exist(fullfile(dirName,dirName_comp),'dir')~=7
            mkdir(fullfile(dirName,dirName_comp));
        end
        if isempty(stats_for_scott{compNo1,compNo2})
            continue
        end
        
        
        stats_curr=stats_for_scott{compNo1,compNo2};
        
        stringcell={'FB','DH','BF','HD'};
        stats_mids=cell(4,0);
        quadNos=[1,2;2,3;4,3;1,4];
        distTypes=[1,3,1,3];
        for i=1:numel(stringcell)
            stat_FB=maheen_combineMids( stats_curr,quadNos(i,1),quadNos(i,2),distTypes(i));
            if ~isempty(stat_FB)
            stat_FB=[stringcell{i};stat_FB];
            stats_mids=[stats_mids,stat_FB];
            end
        end
        
        
        stringcell2={'GA','GE','EC','EG','CE','CA','AG','AC'};
        quadNos=[1,1,2,2,3,3,4,4];
        distTypes=[2,4,2,4,2,4,2,4];
        for i=1:numel(stringcell2)
         quad1_bin=cell2mat(stats_curr(1,:))==quadNos(i);
        dist1=cell2mat(stats_curr(4,:))==distTypes(i);
            stat_FB=stats_curr([2,3,5],quad1_bin & dist1);
            if ~isempty(stat_FB)
            stat_FB=[stringcell2{i};stat_FB];
            stats_mids=[stats_mids,stat_FB];
            end
        end
        
        
        
        
        stats_curr_all=cell(8,0);
        
        for i=1:size(stats_mids,2)
            dist_curr=stats_mids{4,i};
            mu_both=zeros(2,1);
            std_dev_both=zeros(2,1);
            mode_both=zeros(2,1);
            
            h=figure;
            stringFile=[compNo_str{compNo1} ' ' compNo_str{compNo2} ' ' stats_mids{1,i}];
            for k=1:2
                stringTitle=[compNo_str{compNo1} ' ' compNo_str{compNo2} ' ' stats_mids{1,i} ' ' string_x_y{k}];
                dim_curr=dist_curr(k,:);
                mu=mean(dim_curr);
                std_dev=std(dim_curr);
                binsForHist=numel([min(dim_curr):6:max(dim_curr)]);
                [a,b]=hist(dim_curr,binsForHist);
                if isempty(a)
                    [a,b]=hist(dim_curr);
                end
                [~,max_a_idx]=max(a);
                mode=b(max_a_idx);
                %visualize
                subplot(1,2,k);
                
                if std_dev==0
                    bar(b,a);
                else
                    histfit(dim_curr,binsForHist);
                end
                
                title(stringTitle);
                mu_both(k)=mu;
                std_dev_both(k)=std_dev;
                mode_both(k)=mode;
                %                     keyboard
            end
            
            
            
            saveas(h,fullfile(dirName,dirName_comp,[stringFile '_hist.png']));
            currCell=[stats_mids(:,i);
                mu_both;...
                std_dev_both;...
                mode_both;...
                fullfile(dirName_comp,[stringFile '_hist.png'])];
            stats_curr_all=[stats_curr_all,currCell];
            
            
            if show<1
                set(h,'visible','off');
            else
                keyboard
            end
            close all
            
        end
        
        
        stats_for_scott_12{compNo1,compNo2}=stats_curr_all;
%         keyboard;
    end
end

stats_for_scott=stats_for_scott_12;
save(fullfile(dirName,...
    'statsForScott.mat'),'stats_for_scott');