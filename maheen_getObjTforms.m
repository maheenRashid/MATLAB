function [ imCellNew ] = maheen_getObjTforms( imCell )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

imCellRot=cell(8,5);
for i=1:size(imCellRot,2)
    imCellRot(:,i)=maheen_getTforms(imCell{i});
end

imCellRotNew=cell(4,5);

for rotNo=1:size(imCellRotNew,1);
imCellRotNew{rotNo,5}=imCellRot{rotNo,5};
ind=1:4;
ind=ind+rotNo;
ind=mod(ind,4);
ind(ind==0)=4;
imCellRotNew(rotNo,1:4)=imCellRot(rotNo,ind);
% h=maheen_subPlotIm(imCellRotNew(rotNo,:),1);
end

imCellRef([4 1 2 3 5])=imCellRot(end,:);
temp=imCellRef{1};
imCellRef{1}=imCellRef{3};
imCellRef{3}=temp;

imCellRotRef=cell(8,5);
for i=1:size(imCellRotRef,2)
    imCellRotRef(:,i)=maheen_getTforms(imCellRef{i});
end

imCellRotRefNew=cell(4,5);

for rotNo=1:size(imCellRotRefNew,1);
imCellRotRefNew{rotNo,5}=imCellRotRef{rotNo,5};
ind=1:4;
ind=ind+rotNo;
ind=mod(ind,4);
ind(ind==0)=4;
imCellRotRefNew(rotNo,1:4)=imCellRotRef(rotNo,ind);
% h=maheen_subPlotIm(imCellRotRefNew(rotNo,:),1);
end

imCellNew=[imCellRotNew;imCellRotRefNew];



end

