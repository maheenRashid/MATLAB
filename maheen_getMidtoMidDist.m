function [ dists,m1_all,m2_all ] = maheen_getMidtoMidDist( bPts1,bPts2,pos )
%This function gets the relevant sides' midpoint to midpoint distance. For
%case 3 and 4, the rel side becomes the sides that are closest. In that
%case four mid points are returned, with ordering [vert,vert
%vert,hor;hor,vert hor,hor];
%   Detailed explanation goes here
len_1=getRelLengths(bPts1,pos(1:2));
len_2=getRelLengths(bPts2,pos(3:4));
dists=zeros(size(len_1,1)/2);
m1_all=zeros(2,size(len_1,1)/2);
m2_all=zeros(2,size(len_2,1)/2);
for i=1:2:size(len_1,1)
    m1=sum(len_1(i:i+1,:),2)/2;
    m1_all(:,(i+1)/2)=m1;
    for j=1:2:size(len_2,1)
        m2=sum(len_2(j:j+1,:),2)/2;
        dists((i+1)/2,(j+1)/2)=norm(m1-m2);
        m2_all(:,(j+1)/2)=m2;
    end
end
    

end

function [lengths]=getRelLengths(bPts,pos)
    pos_abs=abs(pos);
    lengths=zeros(0,2);
    if pos_abs(1)>=pos_abs(2)
        if pos(1)<0
            x1=max(bPts(1,:));
        else
             x1=min(bPts(1,:));
        end
            x2=x1;
            y1=min(bPts(2,:));
            y2=max(bPts(2,:));
            lengths=[lengths;[x1,x2;y1,y2]];
    end
    if pos_abs(1)<=pos_abs(2)
        if pos(2)<0
            y1=max(bPts(2,:));
        else
             y1=min(bPts(2,:));
        end
            y2=y1;
            x1=min(bPts(1,:));
            x2=max(bPts(1,:));
            lengths=[lengths;[x1,x2;y1,y2]];        
    end
end

