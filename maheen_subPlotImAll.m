function [ h,hSubs] = maheen_subPlotImAll( imCell )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

% totalTNo=size(imCellAll,1);
% imCellAll=imCellAll';
% imCellAll=imCellAll(:);
% j=0;

h=figure;
hSubs=zeros(size(imCell));
for tNo=1:size(imCell,1)
    hSubs(tNo,1)=subplot(3,size(imCell,1)*3,2+3*(tNo-1));imagesc(imCell{tNo,1});axis equal;
    hSubs(tNo,4)=subplot(3,size(imCell,1)*3,size(imCell,1)*3+1+3*(tNo-1));imagesc(imCell{tNo,4});axis equal;
    hSubs(tNo,5)=subplot(3,size(imCell,1)*3,size(imCell,1)*3+2+3*(tNo-1));imagesc(imCell{tNo,5});axis equal;
    hSubs(tNo,2)=subplot(3,size(imCell,1)*3,size(imCell,1)*3+3+3*(tNo-1));imagesc(imCell{tNo,2});axis equal;
    hSubs(tNo,3)=subplot(3,size(imCell,1)*3,2*size(imCell,1)*3+2+3*(tNo-1));imagesc(imCell{tNo,3});axis equal;
end


end

