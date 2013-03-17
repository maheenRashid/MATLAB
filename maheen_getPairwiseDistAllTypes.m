function [ distCell ] = maheen_getPairwiseDistAllTypes( comp1,comp2,show )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

if nargin<3
    show=0;
end

[ bPts1,bLines1 ] = maheen_getBoundComp( comp1 );
[ bPts2,bLines2 ] = maheen_getBoundComp( comp2 );
    
    if show>0
    h=maheen_plotLines(bLines1,'-r');
    maheen_plotLines(bLines2,'-k',h);
    axis equal
    
    minMax1=[bPts1(:,1) bPts1(:,3)];
    minMax2=[bPts2(:,1) bPts2(:,3)];
        
    figure(h);
    hold on
    plot(minMax1(1,:),repmat(min([minMax1(2,:) minMax2(2,:)]),1,size(minMax1,2)),'*m');
    plot(minMax2(1,:),repmat(min([minMax1(2,:) minMax2(2,:)]),1,size(minMax2,2)),'*b');
    plot(repmat(min([minMax1(1,:) minMax2(1,:)]),1,size(minMax1,2)),minMax1(2,:),'*m');
    plot(repmat(min([minMax1(1,:) minMax2(1,:)]),1,size(minMax2,2)),minMax2(2,:),'*b');
    end
    
    
    projX1=bPts1(1,[1 3]);
    projX2=bPts2(1,[1 3]);
    
    projY1=bPts1(2,[1 3]);
    projY2=bPts2(2,[1 3]);

    distY=zeros(2);
    for i=1:2
        for j=1:2
            distY(i,j)=projY1(i)-projY2(j);
        end
    end
    
    distX=zeros(2);
    for i=1:2
        for j=1:2
            distX(i,j)=projX1(i)-projX2(j);
        end
    end
    
    
    cornerDist=zeros(size(bPts1,2));
    
    for i=1:size(cornerDist,1)
        for j=1:size(cornerDist,2)
            cornerDist(i,j)=norm(bPts1(:,i)-bPts2(:,j));
        end
    end
    
    distCell={distX,distY,cornerDist};

end

