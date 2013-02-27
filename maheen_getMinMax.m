function [ minMax] = maheen_getMinMax(A)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    coord=cell(numel(A)/2,1);
    for i=1:2:numel(A)
        coord{(i+1)/2}=A{i};
    end
    coord=cell2mat(coord);
    mins=min(coord);
    mins=mins(1,:);
    maxs=max(coord);
    maxs=maxs(1,:);
    minMax=[mins(1) maxs(1) mins(2) maxs(2)];

end

