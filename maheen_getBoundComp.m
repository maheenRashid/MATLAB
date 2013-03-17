function [ bPts,bLines ] = maheen_getBoundComp( comp )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
bounds=zeros(2,3);
currCoord=comp(1:2:end);
currCoord=cell2mat(currCoord');
bounds(1,:)=min(currCoord);
bounds(2,:)=max(currCoord);
bounds=bounds(:,1:2);

bounds=bounds';
boundsMin=bounds(:,1:2:end);
boundsMax=bounds(:,2:2:end);

bLines=[[boundsMin(1,:);boundsMin(2,:);boundsMin(1,:);boundsMax(2,:)]...
    [boundsMin(1,:);boundsMax(2,:);boundsMax(1,:);boundsMax(2,:)]...
    [boundsMax(1,:);boundsMax(2,:);boundsMax(1,:);boundsMin(2,:)]...
    [boundsMax(1,:);boundsMin(2,:);boundsMin(1,:);boundsMin(2,:)]];
bPts=[boundsMin,[boundsMin(1,:);boundsMax(2,:)],boundsMax,[boundsMax(1,:);boundsMin(2,:)]];

end

