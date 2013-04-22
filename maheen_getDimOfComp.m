function [ dims ] = maheen_getDimOfComp( comp )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
allFaces=comp(1:2:end);
allFaces=allFaces';
allFaces=cell2mat(allFaces);
minAllFaces=min(allFaces,[],1);
maxAllFaces=max(allFaces,[],1);
dims=maxAllFaces-minAllFaces;

end

