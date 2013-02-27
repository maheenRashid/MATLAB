function dist=maheen_getLineSegDist(line1,line2)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
lines=[line1 line2];
dist=polyxpoly(line1(1:2:end),line1(2:2:end),line2(1:2:end),line2(2:2:end));
if ~isempty(dist)
    dist=0;
    return
end

%get perpendicular proj
pts=[line1(1:2) line1(3:4) line2(1:2) line2(3:4)];
proj=zeros(size(pts,1),size(pts,2),2);
for i=1:size(pts,2)
    for j=1:size(lines,2)
        orthoProj(pts(:,i),lines(:,j))
        proj(:,i,j)=orthoProj(pts(:,i),lines(:,j));
    end
end
%check online
bin=zeros(size(proj,2),size(proj,3));
for i=1:size(proj,2)
    for j=1:size(proj,3)
        if isequal(proj(:,i,j),lines(1:2,j))||isequal(proj(:,i,j),lines(3:4,j))
            continue
        end
        bin(i,j)=isOnline(proj(:,i,j),lines(:,j));
    end
end
%get perpendicular distance
if sum(bin(:))~=0
    dists=inf(1,0);
    for i=1:size(proj,2)
        for j=1:size(proj,3)
            if bin(i,j)~=0
                dists=[dists norm(proj(:,i,j)-pts(:,i))];
            end
        end
    end
%     dists(dists==0)=inf;
else
    dists(1)=norm(pts(:,1)-pts(:,3));
    dists(2)=norm(pts(:,2)-pts(:,3));
    dists(3)=norm(pts(:,1)-pts(:,4));
    dists(4)=norm(pts(:,2)-pts(:,4));
end


dist=min(dists);

end

function bin=isOnline(pt,line)
bin=1;
AB=line(3:4)-line(1:2);
AC=pt(1:2)-line(1:2);
if sum((AB.*AC)>=0)~=size(AC,1)
    bin=0;
    return
end
if norm(AB)<norm(AC)
    bin=0;
    return
end
end

function proj=orthoProj(pt,line)
vLine=line(3:4)-line(1:2);
pt=pt-line(1:2);
proj=((pt'*vLine)/(vLine'*vLine))*vLine;
proj=proj+line(1:2);
end