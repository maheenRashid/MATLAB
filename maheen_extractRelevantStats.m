function [ stats,caseNo ] = maheen_extractRelevantStats( distCell,hypos,pos )
%returns the stats that are relevant per case. the ordering is hypos, and
%then the length common to the calculation of each of the hypotenuse. For example the stats for case 2
%are ordered as [hypos(min,min)  hypos(max,max) hypos(middle one)
%commonLength]. For case 1 the ordering is [hypos(min,min)  hypos(max,max)
%commonLength]
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

