function [mergedA]=maheen_mergeWithA(binA,A)
    Atemp=A(:,1:end-1);
%     binA
    aBin=Atemp(:,binA);
    mergedA=cell(1,0);
    for i=1:length(aBin)
        aCurr=aBin{i};
        mergedA=[mergedA aCurr(:,1:end-1)];
    end
%     mergedA=[mergedA aCurr(:,end)];
end