
ccc
load('D:\ResearchCMU\lustre\jasonli1\results_ALL\616b6258186f2baaeee936b125ae7162.mat');

%walls coordinates

walls=A{end}{2};
walls=walls(:,1:2);

% walls=walls(bin>0,:);

% figure;
% hold on
% for i=1:2:size(walls,1)
% %     plot3(walls(i:i+1,1)',walls(i:i+1,2)',walls(i:i+1,3)','-k');
%     plot(walls(i:i+1,1),walls(i:i+1,2),'-k');
% end


%bounds
bounds=zeros(2*(numel(A)-1),3);
for i=1:numel(A)
    currComp=A{i};
    currCoord=currComp(1:2:end-1);
    currCoord=cell2mat(currCoord');
    bounds(2*i-1,:)=min(currCoord);
    bounds(2*i,:)=max(currCoord);
end
bounds=bounds';
% for i=1
% %     :2:size(bounds,2)
%     box=[bounds(1,i) bounds(2,i);bounds(1,i) bounds(2,i+1);bounds(1,i+1) bounds(2,i+1);bounds(1,i+1) bounds(2,i);bounds(1,i) bounds(2,i)];
%     for j=1:4
%         plot(box(j:j+1,1),box(j:j+1,2),'-r');
%     end
% end


%make lines
boundsMin=bounds(:,1:2:end);
boundsMax=bounds(:,2:2:end);
bLines=[[boundsMin(1,:);boundsMin(2,:);boundsMin(1,:);boundsMax(2,:)]...
    [boundsMin(1,:);boundsMax(2,:);boundsMax(1,:);boundsMax(2,:)]...
    [boundsMax(1,:);boundsMax(2,:);boundsMax(1,:);boundsMin(2,:)]...
    [boundsMax(1,:);boundsMin(2,:);boundsMin(1,:);boundsMin(2,:)]];
    
walls=walls';
wallsMin=walls(:,1:2:end);
wallsMax=walls(:,2:2:end);
wLines=[wallsMin(1,:);wallsMin(2,:);wallsMax(1,:);wallsMax(2,:)];

%plot lines
h=maheen_plotLines(bLines,'-r');    
maheen_plotLines(wLines,'-k',h);

%get angle b/w wall and boxes
vWall=[wLines(3,:)-wLines(1,:);wLines(4,:)-wLines(2,:)];
vWallNorm=vWall'*vWall;
vWallNorm=diag(vWallNorm);
vWallNorm=sqrt(vWallNorm');
bin=vWallNorm>0;
vWallNorm=vWallNorm(bin);
vWall=vWall(:,bin);
vWallN=vWall./repmat(vWallNorm,2,1);

wLines=wLines(:,bin);



bin=ones(size(wLines,2),1);
for i=1:size(wLines,2)
    if bin(i)==0
        continue
    end
    curr=wLines(:,i);
    tmp = wLines - repmat(curr,1,size(wLines,2)); 
    ind = find(sum(tmp)==0);
    bin(ind)=0;
    bin(i)=1;
end

wLines=wLines(:,bin>0);

b1=bLines(:,1:size(boundsMax,2));
b2=bLines(:,size(boundsMax,2)+1:2*size(boundsMax,2));
b3=bLines(:,2*size(boundsMax,2)+1:3*size(boundsMax,2));
b4=bLines(:,3*size(boundsMax,2)+1:4*size(boundsMax,2));

vb1=[b1(3,:)-b1(1,:);b1(4,:)-b1(2,:)];
vb1Norm=vb1'*vb1;
vb1Norm=diag(vb1Norm);
vb1Norm=sqrt(vb1Norm');
vb1N=vb1./repmat(vb1Norm,2,1);

vb2=[b2(3,:)-b2(1,:);b2(4,:)-b2(2,:)];
vb2Norm=vb2'*vb2;
vb2Norm=diag(vb2Norm);
vb2Norm=sqrt(vb2Norm');
vb2N=vb2./repmat(vb2Norm,2,1);

dotB1=vWallN'*vb1N;
dotB2=vWallN'*vb2N;

angleb1=acos(abs(dotB1));
angleb2=acos(abs(dotB2));

binb1=angleb1>angleb2;

%
boxNo=1;
box=[b1(:,boxNo),b2(:,boxNo),b3(:,boxNo),b4(:,boxNo)];

h=maheen_plotLines(box,'-r');
maheen_plotLines(wLines(:,1),'-b',h);

minD=[];
for wallNo=1:1
%     size(wLines,2)
    if ~binb1(wallNo,boxNo)
        boxLine=b1(:,boxNo);
        boxLine=[boxLine b3(:,boxNo)];
    else
        boxLine=b2(:,boxNo);
        boxLine=[boxLine b4(:,boxNo)];
    end
    
    maheen_getLineSegDist(boxLine(:,1),wLines(:,wallNo))
    
    for lineNo=1:size(boxLine,2)
       minD=[minD maheen_getLineSegDist(boxLine(:,lineNo),wLines(:,wallNo))];
    end
end



