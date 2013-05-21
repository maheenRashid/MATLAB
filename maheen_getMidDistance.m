function distsMid=maheen_getMidDistance(mids1,mids2,distsXAndY)
distsMid=zeros(2,0);
for mid1=1:size(mids1,2)
    for mid2=1:size(mids2,2)
        midCurrA=mids1(:,mid1);
        midCurrB=mids2(:,mid2);
        distsMid=[distsMid,midCurrA-midCurrB];
    end
end
for i=1:size(distsMid,2)
    for j=1:size(distsMid,1)
%         keyboard
        com_idx=find(abs(distsMid(j,i))==abs(distsXAndY{j}));
%         keyboard
        
        if isempty(com_idx)
            continue
        end
        distsMid(j,i)=distsXAndY{j}(com_idx(1));
        
    end
end
end