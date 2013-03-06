function [ prediction ] = maheen_getPrediction( cellCorr,flag )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
flagStrCell={'single','multiMode','multiMax','multiMaxOfMedian'};
flag=find(strcmpi(flag,flagStrCell));

if isempty(flag)
    prediction=0;
    disp('flag str not valid')
    return;
end
if flag==1
        prediction=zeros(size(cellCorr));
        for tempNo=1:size(cellCorr,1)
            currTemp=cellCorr(tempNo,:);
            binEmpty=cellfun('isempty',currTemp);
            currTemp(binEmpty)=[];
            currTemp=currTemp';
            currTemp=cell2mat(currTemp);
            [~,currPred]=max(currTemp,[],2);
            prediction(tempNo,~binEmpty)=currPred;
        end    
else
    prediction=zeros(1,size(cellCorr,2));
        for imNo=1:size(cellCorr,2)
            currIm=cellCorr(:,imNo);
            binEmpty=cellfun('isempty',currIm);
            currIm(binEmpty)=[];
            currIm=cell2mat(currIm);
        
            if flag==2
            [~,currPred]=max(currIm,[],2);
            prediction(1,imNo)=mode(currPred);
    
            elseif flag==3
                    [maxCurrIm,idxMaxCurrIm]=max(currIm,[],2);
            [~,idxMaxMax]=max(maxCurrIm);
            prediction(1,imNo)=mode(idxMaxCurrIm(idxMaxMax));
    
            elseif flag==4
                medianCurrIm=median(currIm);
                [~,currPred]=max(medianCurrIm);
                prediction(1,imNo)=currPred;
            end
        end
end

end

