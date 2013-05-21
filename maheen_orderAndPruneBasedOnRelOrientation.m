function [ stats ] = maheen_orderAndPruneBasedOnRelOrientation( hypos,horizontal,facing,pred,mids )
%ordering based on facing. if object is facing or has its back to the other
%object then the ordering is [hypos corner matches with ordering min to
%max, the mid point to midpoint dist, the horizontal distance];
%ordering for side is hypo from the back of the object, hypo from the front
%corner, mid point to midpoint dist with vert,vert dist is side is vert
%(same for horizontal, the horizontal distance];
%   Detailed explanation goes here
if abs(facing)==1 
    if numel(mids)>1
        if pred==1 ||pred==3
            mids=mids(end);
        else
            mids=mids(1);
        end
    end
    stats=[hypos(1),hypos(end),mids,horizontal];
else
    if pred==1 || pred==2
        hyposPrune=[hypos(end),hypos(1)];
    else
        hyposPrune=[hypos(1) hypos(end)];
    end
    if pred==3 ||pred==1
        if numel(mids)>1
            mids=mids(1);
        end
    else
        if numel(mids)>1
            mids=mids(end);
        end
    end
    stats=[hyposPrune mids horizontal];
end


end

