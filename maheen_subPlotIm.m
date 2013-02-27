function [ h ,hSubs] = maheen_subPlotIm( imCell,flag,h)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
if nargin<2
    flag=0;
end

if nargin<3
    h=figure;
else
    figure(h);
end

hSubs=zeros(5,1);
if flag==0
    hSubs(1)=subplot(3,3,2);imagesc(imCell{1});axis equal;
    hSubs(4)=subplot(3,3,4);imagesc(imCell{4});axis equal;
    hSubs(5)=subplot(3,3,5);imagesc(imCell{5});axis equal;
    hSubs(2)=subplot(3,3,6);imagesc(imCell{2});axis equal;
    hSubs(3)=subplot(3,3,8);imagesc(imCell{3});axis equal;
else
    hSubs(1)=subplot(3,3,2);imshow(imCell{1});axis equal;
    hSubs(4)=subplot(3,3,4);imshow(imCell{4});axis equal;
    hSubs(5)=subplot(3,3,5);imshow(imCell{5});axis equal;
    hSubs(2)=subplot(3,3,6);imshow(imCell{2});axis equal;
    hSubs(3)=subplot(3,3,8);imshow(imCell{3});axis equal;  
end
end

