ccc


dir='D:\ResearchCMU\lustre\jasonli1\code\MATLAB\maheen_findOrientationSolid\minDistWallMethod';
for compNo=1:16
    
    load (fullfile(dir,['predictionClosestWallAll_' num2str(compNo) '.mat']));
%     ,'minDistAllCell','cornerAll');
    
    minDistOnly=zeros(numel(minDistAllCell),1);
    for currComp=1:numel(minDistAllCell)
        
        currDists=minDistAllCell{currComp};
        if sum(currDists<5)==numel(currDists)
            disp('happened!')
        minDistOnly(currComp)=-1;
        else
        minDistOnly(currComp)=minDistAllCell{currComp}(1);
        end
    end
    
    minDistBoth=zeros(numel(minDistAllCell),2);
    for currComp=1:numel(minDistAllCell)
        minDistBoth(currComp,:)=minDistAllCell{currComp}(1:2);
    end
    
    histR=min(minDistOnly):0.5:max(minDistOnly);
    figure;
    hist(minDistOnly,20);
%     histR);
    
    
    maxMinDists=max(minDistBoth,[],2);
    bin=maxMinDists<10;
    
%     
%     bin=minDistOnly<6;
%     
    corner=sum(cornerAll(bin))
    cornerTotal=sum(cornerAll)
    
    
%     dat=minDistBoth;
%     histR=min(minDistBoth(:)):0.5:max(minDistBoth(:));
%     figure;
%     hist3(minDistBoth,{histR,histR});
    
    
%     n = hist3(dat,{[min(dat(:,1)):10:max(dat(:,1))],[min(dat(:,2)):10:max(dat(:,2))]}); % Extract histogram data;
                % default to 10x10 bins
% n1 = n'; 
% n1( size(n,1) + 1 ,size(n,2) + 1 ) = 0; 
% 
% xb = linspace(min(dat(:,1)),max(dat(:,1)),size(n,1)+1);
% yb = linspace(min(dat(:,2)),max(dat(:,2)),size(n,2)+1);
% 
% h = pcolor(xb,yb,n1);
% 
% set(h, 'zdata', ones(size(n1)) * -max(max(n))) 
% % colormap(hot) % heat map 
% title('Seamount:     Data Point Density Histogram and Intensity Map');
% grid on 
% 
% view(3);
%     
%     
    
%     thresh=5;
    
    
end