ccc
outputDir='maheen_statsUsingOrientation';

load(fullfile(outputDir,...
    'everythingAndStatsUsingOrient_Sunday_28_4_withDistCellNewFormat_distSignedXAndY.mat'));


show=0;



orient_case=[-1,0,1];
orient_str={'back','side','front'};
compNo_str={'bed','couch','cabinet','chair','desk','drawer','dresser'...
    ,'nightstand','table','light','door','window','picture','tv',...
    'closet','bookshelf','misc'};
% distType_str={{'hypoBack','hypoFront','midPoints','horizontal'};...
%     {'hypo1','hypo2','midPoints','horizontal'}};
distType_str={'corners' 'mids'};

dirName_pred='stats_and_vis_2d_';


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
        
        mat_face_all=cell2mat(distCompiledAll(12:13,:));
        compNo_ids=cell2mat(distCompiledAll(1:2,:));
        
        
        lumpSortedBoth=distCompiledAll(19:20,:);
        midSortedBoth=distCompiledAll(21:22,:);
        
        distsBothType={lumpSortedBoth,midSortedBoth};
        stats_curr_all=cell(12,0);
        for compToUse=1:2
            for orient_no=1:numel(orient_case)
                for distType_no=1:numel(distsBothType)
                    stringTitle=[compNo_str{compNo1} ' and ' compNo_str{compNo2} ...
                        ' using ' num2str(compToUse) ' Orientation ' ...
                        orient_str{orient_no} ...
                        ' Stat ' distType_str{distType_no}];
                    
                    idx_curr_orient=mat_face_all(compToUse,:)==orient_case(orient_no);
                    
                    lumpDist_cell=distsBothType{distType_no}(compToUse,idx_curr_orient);
                    
                    %do no consider object pairs that are more than 12 feet
                    %apart.
                    bin_thresh=ones(1,numel(lumpDist_cell));
                    for i=1:numel(lumpDist_cell)
                        curr=lumpDist_cell{i};
                        curr=curr(:);
                        if sum(abs(curr)>144)>0
                            bin_thresh(i)=0;
                        end
                    end
                    idx_for_record=find(idx_curr_orient);
                    idx_for_record=idx_for_record(bin_thresh>0);
                    lumpDist=cell2mat(distsBothType{distType_no}(compToUse,idx_for_record));
                    
                    if numel(lumpDist)==0
                         continue
                    end
                    
                    percentage=sum(idx_curr_orient)/size(mat_face_all,2)*100;
                    total=size(mat_face_all,2);
                    idx_for_record_pruned=idx_for_record;
                    idx_for_record=find(idx_curr_orient);
                    
                    mu_lump=zeros(2,1);
                    h1=figure;
                    std_lump=0.1*ones(2,1);
                    mode_lump=zeros(2,1);
                    std_mode_lump=0.1*ones(2,1);
                    for i=1:2
                        dimcurr=lumpDist(i,:);
  
                        %calculate the std dev with mean set to the mode
                        %with accu ~6''.
                        
                        binsForHist=[min(dimcurr):6:max(dimcurr)];
                        if numel(binsForHist)==1
                            binsForHist=1;
                        end
                        [a,b]=hist(dimcurr,binsForHist);
                        if isempty(a)
                        [a,b]=hist(dimcurr);
                        end
                        [~,max_a_idx]=max(a);
                        muhat=b(max_a_idx)
                        nMinus1=numel(dimcurr)-1;
                        if nMinus1==0
                            nMinus1=1;
                        end
                        stdhat=sqrt(sum((dimcurr-repmat(muhat,1,numel(dimcurr))).^2)/(nMinus1))
                        

                        %calculate the real mean and std
                        muhat_2=mean(dimcurr)
                        stdhat_2=std(dimcurr)
                        
                        %just to avoid errors
                        if stdhat_2==0
                            stdhat_2=0.1;
                        end
                        
                        %visualize
                        a=a/sum(a);
                        subplot(1,2,i);
                        bar(b,a);
                        ix=linspace(muhat-3*stdhat,muhat+3*stdhat,100);
                        iy=pdf('normal',ix,muhat,stdhat);
                        hold on;
                        plot(ix,iy,'-r');
                        mu_lump(i)=muhat_2
                        std_lump(i)=stdhat_2
                        mode_lump(i)=muhat
                        std_mode_lump(i)=stdhat
                    end
                    set(gcf,'NextPlot','add');
                    axes;
                    title_temp = title(stringTitle);
                    set(gca,'Visible','off');
                    set(title_temp,'Visible','on');
%                            keyboard
                    
                    %visualize this info as a 2d gauss
                    std_steady=std_lump(1);
                    std_unsteady=std_lump(2);
                    
                    h=maheen_visualize2dGauss(std_lump(1),std_lump(2),mu_lump);
                    title(stringTitle);
                    
                    if show<1
                        set(h,'visible','off');
                        set(h1,'visible','off');
                    else
                        keyboard
                    end
                    
                    saveas(h1,fullfile(outputDir,dirName,[stringTitle '_hist.png']));
                    
                    saveas(h,fullfile(outputDir,dirName,[stringTitle '.png']));
                    currCell={compToUse,orient_case(orient_no),percentage,...
                        total,...
                        idx_for_record,...
                        idx_for_record_pruned,...
                        lumpDist,...
                        mu_lump,...
                        std_lump,...
                        mode_lump,...
                        std_mode_lump,...
                        fullfile(outputDir,dirName,stringTitle)};
                    stats_curr_all=[stats_curr_all,currCell'];
                    close all
%                     keyboard
                end
            end
        end
        
        stats_super_cell{compNo1,compNo2}=stats_curr_all;
        
    end
end







save(fullfile(outputDir,...
    'everythingAndStatsUsingOrient_Sunday_28_4_withDistCellNewFormat_distSignedXAndY_compiledStats_new.mat'));

