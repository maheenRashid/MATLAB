ccc
outputDir='maheen_statsUsingOrientation';
load(fullfile(outputDir,...
    'start_from_scratch.mat'),'stats_sfs');
% {down;left;distVert;distHor;bound1;bound2;bound1_rot;bound2_rot;...
%                 distCompiledAll{1,idx_dist};distCompiledAll{2,idx_dist}};

compNo_str={'bed','couch','cabinet','chair','desk','drawer','dresser'...
    ,'nightstand','table','light','door','window','picture','tv',...
    'closet','bookshelf','misc'};
 stats_type_str={'1','2','3','4'};
        stats_number={'vert mid','vert corner','hor mid','hor corner'};
        stats_x_y={'x','y'};

        dirName_pred='stats_and_vis_2d_';



        dirName=fullfile(outputDir,'visualsForScott_2');
        if exist(dirName,'dir')~=7
            mkdir(dirName);
        end
        
show=0;
        
stats_for_scott=cell(16,16);
for compNo1=1:16
    for compNo2=1:16
        stats_curr_all=cell(9,0);
        
        dirName_comp=[dirName_pred num2str(compNo1) '_' num2str(compNo2)];
        if exist(fullfile(dirName,dirName_comp),'dir')~=7
            mkdir(fullfile(dirName,dirName_comp));
        end
        if isempty(stats_sfs{compNo1,compNo2})
            continue
        end
        stats_curr=stats_sfs{compNo1,compNo2};
        
        t_rec=zeros(8,size(stats_curr,2));
        for t_idx=1:size(stats_curr,2)
            t_rec(:,t_idx)=[stats_curr{4,t_idx}(:);stats_curr{5,t_idx}(:)];
        end
        
        t_bin=abs(t_rec)>(16*12);
        t_bin=sum(t_bin,1);
        t_bin=t_bin<1;
        
        quad_rep_all=cell2mat(stats_curr(1,:));
        stats_cell=cell(1,4);
        percent=zeros(1,4);
        total=ones(1,4)*sum(t_bin);
        for quad_repNo=1:4
            first=stats_curr(4:5,quad_rep_all==quad_repNo & t_bin);
            first=first';
            stats_cell{quad_repNo}=cell2mat(first);
            percent(quad_repNo)=sum(quad_rep_all==quad_repNo & t_bin)/sum(t_bin)*100;
        end
        
        for i=1:numel(stats_cell)
            dist_curr=stats_cell{i};
            for j=1:size(dist_curr,2)
                typeDist_curr=dist_curr(:,j);
                
                mu_both=zeros(2,1);
                std_dev_both=zeros(2,1);
                mode_both=zeros(2,1);
                
                h=figure;
                stringFile=[compNo_str{compNo1} ' ' compNo_str{compNo2} ' ' stats_type_str{i} ' ' stats_number{j}];
                for k=1:2
                    stringTitle=[compNo_str{compNo1} ' ' compNo_str{compNo2} ' ' stats_type_str{i} ' ' stats_number{j} ' ' stats_x_y{k}];
                    dim_curr=typeDist_curr(k:2:end);
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
                    currCell={i,...
                        percent(i),...
                        total(i),...
                        j,...
                        reshape(typeDist_curr,2,[]),...
                        mu_both,...
                        std_dev_both,...
                        mode_both,...
                        fullfile(dirName_comp,[stringFile '_hist.png'])};
                    stats_curr_all=[stats_curr_all,currCell'];
                    
                
                    if show<1
                        set(h,'visible','off');
                    else
                        keyboard
                    end
                    close all
            end
        end
        stats_for_scott{compNo1,compNo2}=stats_curr_all;
    end
end

save(fullfile(dirName,...
    'statsForScott.mat'),'stats_for_scott');

save(fullfile(outputDir,...
    'statsForScott_2_andEverythingelse.mat'));