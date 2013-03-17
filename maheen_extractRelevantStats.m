function [ stats,caseNo ] = maheen_extractRelevantStats( distCell,hypos,pos )
%UNTITLED11 Summary of this function goes here
%   Detailed explanation goes here

if max(size(hypos))==3
    caseNo=2;
    stats=[hypos(1) hypos(end) hypos(2) distCell{size(hypos)==1}]';
    return
elseif max(size(hypos))==2
    caseNo=1;
    if sum(pos==1)~=0
        caseNo=-1;
    end
    stats=[hypos(1) hypos(2) distCell{size(hypos)==1}]';
    return
elseif hypos(1)==0
    caseNo=4;
    stats=0;
    return
else
    caseNo=3;
    stats=hypos;
    return
end





end

