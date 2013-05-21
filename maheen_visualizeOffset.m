function [ h ] = maheen_visualizeOffset( f,t,box,offset )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

        org_min=box(1:2)'-offset;
            h=figure;
            subplot(1,3,1);
            imagesc(f);
            axis equal;
            subplot(1,3,2);
            imagesc(t);
            axis equal;
            subplot(1,3,3);
            imagesc(f);
            hold on;
            xlim('auto');
            ylim('auto');
            plot(org_min(1),org_min(2),'*r');
            plot(box(1),box(2),'*b');
            hold on;
            rectangle('position',box,'EdgeColor','m','LineWidth',2);
            axis equal;
end

