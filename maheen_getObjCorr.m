function [ resultCorr,corrAll ] = maheen_getObjCorr( imCell1,imCell2 )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    
    resultCorr=zeros(1,size(imCell2,1));
    linIm1=zeros(numel(imCell1{1}(:)),size(imCell1,2));
    for i=1:size(imCell1,2)
        linIm1(:,i)=imCell1{i}(:);
    end
    
    corrAll=zeros(size(imCell2,2),size(imCell2,1));
    
    for rotNo=1:size(imCell2,1)
        imCellCurr=imCell2(rotNo,:);
        linIm2=zeros(numel(imCellCurr{1}(:)),size(imCellCurr,2));
        for i=1:size(imCellCurr,2)
            linIm2(:,i)=imCellCurr{i}(:);
        end
        
%         for i=1:size(linIm1,2)
%             corrCheck=corr(linIm1(:,i),linIm2(:,i))
%         end
%         
%         
        corrCurr=corr(linIm1,linIm2);
        corrCurr=diag(corrCurr);
        corrAll(:,rotNo)=corrCurr;
%         
%         sum(corrCurr)
%         sum(abs(corrCurr))
%         resultCorr(rotNo)=sum(abs(corrCurr));
        
        resultCorr(rotNo)=sum(corrCurr);
%         pause
    end
end

