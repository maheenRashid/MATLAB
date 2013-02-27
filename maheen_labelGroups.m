function [ mergeLabel] = maheen_labelGroups( skpCat,skpGroup)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
mergeLabel=cell(2,0);
uniqueSkpGroup=unique(skpGroup);
for groupNo=uniqueSkpGroup'
    binGroup=skpGroup==groupNo;
    catCurr=skpCat(binGroup);
    uniqueLab=unique(catCurr);
    uniqueLab(uniqueLab==0)=[];
    if numel(uniqueLab)==1 
        tempCell=cell(2,1);
        tempCell{1}=uniqueLab;
        tempCell{2}=binGroup;
        mergeLabel=[mergeLabel tempCell];
    else
        for i=1:numel(uniqueLab)
            binCat=skpCat==uniqueLab(i);
            binBoth=binCat & binGroup;
            tempCell=cell(2,1);
            tempCell{1}=uniqueLab(i);
            tempCell{2}=binBoth;
            mergeLabel=[mergeLabel tempCell];
        end
    end
end

end