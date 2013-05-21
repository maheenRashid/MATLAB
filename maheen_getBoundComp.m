function [ bPts,bLines ] = maheen_getBoundComp( comp )
%returns component bounding points and lines. points arranged in clockwise
%order starting from min,min. blines are 4by4 with each column with the
%endpoints of the line.bPts is 2by4.comp is the comp from mergedcomp. or
%any comp from the A matrix with the string name etc cell from its end
%removed.
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

