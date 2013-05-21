function [ stat_cell ] = maheen_combineMids( stats_curr,quadNo1,quadNo2,distType)
%quadNo1 must be the min quad (lower x, or lower y).
%   Detailed explanation goes here


quad1_bin=cell2mat(stats_curr(1,:))==quadNo1;
quad2_bin=cell2mat(stats_curr(1,:))==quadNo2;

dist1=cell2mat(stats_curr(4,:))==distType;

if sum(dist1)<1
    stat_cell=[];
    return;
end
if sum(quad1_bin)<1 && sum(quad2_bin)<1
    stat_cell=[];
    return;
elseif sum(quad1_bin)<1
    stat1=[];
    stat2=stats_curr{5,quad2_bin & dist1};
    if distType==1
        stat2(1,:)=-stat2(1,:);
    else
        stat2(2,:)=-stat2(2,:);
    end
    stat_1_2_1=[stat1,stat2];
    percent_1_2_1=stats_curr{2,quad2_bin & dist1};
    total_1_2_1=stats_curr{3,quad2_bin & dist1};
    
elseif sum(quad2_bin)<1
    stat2=[];
    stat1=stats_curr{5,quad1_bin & dist1};
    stat_1_2_1=[stat1,stat2];
    percent_1_2_1=stats_curr{2,quad1_bin & dist1};
    total_1_2_1=stats_curr{3,quad1_bin & dist1};
else
    stat1=stats_curr{5,quad1_bin & dist1};
    stat2=stats_curr{5,quad2_bin & dist1};
    if distType==1
        stat2(1,:)=-stat2(1,:);
    else
        stat2(2,:)=-stat2(2,:);
    end
    stat_1_2_1=[stat1,stat2];
    percent_1_2_1=stats_curr{2,quad1_bin & dist1}+stats_curr{2,quad2_bin & dist1};
    total_1_2_1=stats_curr{3,quad1_bin & dist1};
    
end

stat_cell={percent_1_2_1,total_1_2_1,stat_1_2_1}';

end

