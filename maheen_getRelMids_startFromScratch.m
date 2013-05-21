function [ midsBoth] = maheen_getRelMids_startFromScratch( corner2,down,left )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

midVert=zeros(2,1);
                midHor=zeros(2,1);
                
                mins=min(corner2,[],2);
                maxs=max(corner2,[],2);
                
                if down
                    midVert=([mins(1);maxs(2)]+[maxs(1);maxs(2)])/2;
                else
                    midVert=([mins(1);mins(2)]+[maxs(1);mins(2)])/2;
                end
                if left
                    midHor=([maxs(1);mins(2)]+[maxs(1);maxs(2)])/2;
                else
                    midHor=([mins(1);mins(2)]+[mins(1);maxs(2)])/2;
                end
            midsBoth=[midVert,midHor];
end

