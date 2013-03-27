function [pred,minDistances,minEdgeBox,minEdgeWall,shorter,bLines,wLines] = maheen_getPredWallDist( A,mergedA,show,useBounds )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
if nargin<3
    show=0;
end

if nargin<4
    useBounds=1;
end


bounds=getBoundsForComp(mergedA);
bounds=bounds(:,1:2);

walls=A{end}{2};
walls=getWallsOrBound(walls,bounds,A,useBounds);

bounds=bounds';
boundsMin=bounds(:,1:2:end);
boundsMax=bounds(:,2:2:end);

walls=walls';
wallsMin=walls(:,1:2:end);
wallsMax=walls(:,2:2:end);

%make lines
bLines=[[boundsMin(1,:);boundsMin(2,:);boundsMin(1,:);boundsMax(2,:)]...
    [boundsMin(1,:);boundsMax(2,:);boundsMax(1,:);boundsMax(2,:)]...
    [boundsMax(1,:);boundsMax(2,:);boundsMax(1,:);boundsMin(2,:)]...
    [boundsMax(1,:);boundsMin(2,:);boundsMin(1,:);boundsMin(2,:)]];
wLines=[wallsMin(1,:);wallsMin(2,:);wallsMax(1,:);wallsMax(2,:)];
wLines=preprocessWalls(wLines);

%plot lines
if show>0
    h=maheen_plotLines(bLines,'-r');
    maheen_plotLines(wLines,'-k',h);
    axis equal
    pause;
end

%get bin for angle b/w wall and boxes
b1=bLines(:,1:size(boundsMax,2));
b2=bLines(:,size(boundsMax,2)+1:2*size(boundsMax,2));
b3=bLines(:,2*size(boundsMax,2)+1:3*size(boundsMax,2));
b4=bLines(:,3*size(boundsMax,2)+1:4*size(boundsMax,2));
binb1=getBinForAngle(wLines,b1,b2);

%predict
minDistances=zeros(size(b1,2),size(wLines,2))';
minEdgeBox=cell(size(b1,2),size(wLines,2))';
minEdgeWall=minEdgeBox;
pred=minDistances;
shorter=minDistances;
shortBin=norm(diff(reshape(b1(:,1),2,2)'))<norm(diff(reshape(b2(:,1),2,2)'));

for boxNo=1:size(b1,2)
    
    for wallNo=1:size(wLines,2)
        
        if ~binb1(wallNo,boxNo)
            boxLine=[b1(:,boxNo) b3(:,boxNo)];
        else
            boxLine=[b2(:,boxNo) b4(:,boxNo)];
        end
        
        minD=zeros(1,size(boxLine,2));
        for lineNo=1:size(boxLine,2)
            minD(lineNo)=maheen_getLineSegDist(boxLine(:,lineNo),wLines(:,wallNo));
        end
        
        [minDistances(wallNo,boxNo),ind]=min(minD);
        minEdgeBox{wallNo,boxNo}=boxLine(:,ind);
        minEdgeWall{wallNo,boxNo}=wLines(:,wallNo);
        
        if binb1(wallNo,boxNo)
            if ind==1
                %b2
                pred(wallNo,boxNo)=1;
            else
                %b4
                pred(wallNo,boxNo)=3;
            end
            shorter(wallNo,boxNo)=~shortBin;
        else
            if ind==1
                %b1
                pred(wallNo,boxNo)=4;
            else
                %b3
                pred(wallNo,boxNo)=2;
            end
            shorter(wallNo,boxNo)=shortBin;
        end
    end
end

%sort by distance
[minDistances,minInd]=sort(minDistances);
pred=pred(minInd);
minEdgeBox=minEdgeBox(minInd);
minEdgeWall=minEdgeWall(minInd);



end

function bounds=getBoundsForComp(comp)
bounds=zeros(2,3);
currCoord=comp(1:2:end);
currCoord=cell2mat(currCoord');
bounds(1,:)=min(currCoord);
bounds(2,:)=max(currCoord);
end


function wLines=preprocessWalls(wLines)

[~,vWallNorm]=getNormalizedVector(wLines);
bin=vWallNorm>0;

wLines=wLines(:,bin);

bin=ones(size(wLines,2),1);
for i=1:size(wLines,2)
    if bin(i)==0
        continue
    end
    curr=wLines(:,i);
    tmp = wLines - repmat(curr,1,size(wLines,2));
    ind = sum(tmp)==0;
    bin(ind)=0;
    bin(i)=1;
end
wLines=wLines(:,bin>0);

end

function [vWallN,vWallNorm]=getNormalizedVector(wLines)
vWall=[wLines(3,:)-wLines(1,:);wLines(4,:)-wLines(2,:)];
vWallNorm=vWall'*vWall;
vWallNorm=diag(vWallNorm);
vWallNorm=sqrt(vWallNorm');
vWallN=vWall./repmat(vWallNorm,2,1);
end

function binb1=getBinForAngle(wLines,b1,b2)

vWallN=getNormalizedVector(wLines);

vb1N=getNormalizedVector(b1);

vb2N=getNormalizedVector(b2);

dotB1=vWallN'*vb1N;
dotB2=vWallN'*vb2N;

angleb1=acos(abs(dotB1));
angleb2=acos(abs(dotB2));

binb1=angleb1>angleb2;


end


function boundAll=getBoundAllComp(A)
%     bounds(1,:)=min(currCoord);
%     bounds(2,:)=max(currCoord);

minAll=[];
maxAll=[];
for i=1:numel(A)-1
    boundComp=getBoundsForComp(A{i}(1:end-1));
    minAll=[minAll; boundComp(1,:)];
    maxAll=[maxAll; boundComp(2,:)];
end
if size(minAll,1)<2
    boundAll=[minAll; maxAll];
    
else
    boundAll=[min(minAll); max(maxAll)];
end

end

function [walls]=getWallsOrBound(walls,bounds,A,useBounds)
    if ~isempty(walls)
        walls=walls(:,1:2);
        if ~useBounds
            return
        end
        wallsMin=min(walls);
        wallsMax=max(walls);
        
        wallsBounds=[wallsMin;wallsMax];
        boxV=[bounds(1,1) bounds(1,1) bounds(2,1) bounds(2,1);bounds(1,2) bounds(2,2) bounds(2,2) bounds(1,2)];
        wallV=[wallsBounds(1,1) wallsBounds(1,1) wallsBounds(2,1) wallsBounds(2,1);wallsBounds(1,2) wallsBounds(2,2) wallsBounds(2,2) wallsBounds(1,2)];
        
        [in,on]=inpolygon(boxV(1,:),boxV(2,:),wallV(1,:),wallV(2,:));
    else
        in=0;
        on=0;
    end
    
    if sum(in+on)<1
        boundAll=getBoundAllComp(A);
        boundAll=boundAll(:,1:2);
        walls=[boundAll(1,:);...
            [boundAll(1,1) boundAll(2,2)];...
            [boundAll(1,1) boundAll(2,2)];...
            boundAll(2,:);...
            boundAll(2,:);...
            [boundAll(2,1) boundAll(1,2)];...
            [boundAll(2,1) boundAll(1,2)];...
            boundAll(1,:)];
    end
    
    
    
end