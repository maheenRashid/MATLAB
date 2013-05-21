function  h=visualizeBoxes( bPts1,bLines1,bPts2,bLines2,h )
%bPts1 is in red, and bPts2 is in black. magenta points are x,y projections
%of the point. magenta for the red component, and blue for the black.
%   Detailed explanation goes here
if nargin<5
    h=figure;
else
    figure(h);
end
%     if show>0
    maheen_plotLines(bLines1,'-r',h);
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
%         end
    
end

