ccc
% compNo=1;
% catNo=1;
for catNo=1:16
    load(['maheen_mergedComp\matA_cornerAligned_duplicatesRemoved_' num2str(catNo)],'A');
    
    newAVert=cell(1,0);
    
    for compNo=1:numel(A)
        comp=A{1,compNo};
        % load(['maheen_mergedComp\comp' num2str(compNo)],'comp');
        coord=zeros(0,3);
        for i=1:2:numel(comp)
            coord=[coord;comp{1,i}];
        end
        xmin=min(coord(:,1));
        xmin=xmin(1);
        xmax=max(coord(:,1));
        xmax=xmax(1);
        
        ymin=min(coord(:,2));
        ymin=ymin(1);
        ymax=max(coord(:,2));
        ymax=ymax(1);
        rot90=[0 -1 ;1 0];
        rot180=[-1 0;0 -1];
        rot270=[0 1 ;-1 0];
        rot0=[1 0;0 1];
        
        if ymax>xmax
            %     rotate 180, reorient and save
            cellTransform={rot0, rot180};
        elseif xmax>ymax
            %     rotate 90, save, reorient, save
            cellTransform={rot90, rot270};
        else
            %     rotate 90, 180, -90, -180, save
            cellTransform={rot0,rot90,rot180,rot270};
        end
        
        
        compNew= cell(numel(cellTransform),numel(comp));
        for i=1:2:numel(comp)
            compCurr=comp{1,i};
            compCurr=compCurr';
            temp=compCurr;
            %     compCurr=compCurr(1:2,:);
            for j=1:numel(cellTransform)
                temp(1:2,:)=cellTransform{1,j}*compCurr(1:2,:);
                compNew{j,i}=temp';
                compNew{j,i+1}=comp{1,i+1};
            end
        end
        
        %     compCurr=compNew;
        for i=1:size(compNew,1)
            compCurr=compNew(i,:);
            allCoord=compCurr(1:2:end);
            allCoord=reshape(allCoord,size(allCoord,2),1);
            minAll=min(cell2mat(allCoord));
            minAll=minAll(1,:);
            for j=1:2:size(compCurr,2)
                tempFace=compCurr{j};
                tempFace=tempFace-repmat(minAll,size(tempFace,1),1);
                compCurr{j}=tempFace;
            end
            compNew(i,:)=compCurr;
        end
        
%         return
        for i=1:size(compNew,1)
            newAVert=[newAVert {compNew(i,:)}];
        end
        
    end
    
    A=newAVert;
    save(['maheen_temp\matA_orientedLengthWays_cornerAligned_' num2str(catNo)],'A');
newAHori=A;
    
for compInd=1:numel(A)
    compCurr=A{1,compInd};
    rot90=[0 -1;1 0];
    for i=1:2:numel(compCurr)
        currFace=compCurr{1,i};
        currFace=currFace';
        currFace(1:2,:)=rot90*currFace(1:2,:);
        compCurr{1,i}=currFace';
    end
    
    allCoord=compCurr(1:2:end);
    allCoord=reshape(allCoord,size(allCoord,2),1);
    minAll=min(cell2mat(allCoord));
    minAll=minAll(1,:);
    for j=1:2:size(compCurr,2)
        tempFace=compCurr{j};
        tempFace=tempFace-repmat(minAll,size(tempFace,1),1);
        compCurr{j}=tempFace;
    end
    
    
    newAHori{1,compInd}=compCurr;
end
A=newAHori;
save(['maheen_temp\matA_orientedWidthWays_cornerAligned_' num2str(catNo)],'A');

    
    
    
end
% corners=[xmin xmax xmax xmin xmin;ymin ymin ymax ymax ymin];
%
% rot90pts=rot90*corners;
% rot270pts=rot270*corners;
% rot180pts=rot180*corners;
% figure
% plot(corners(1,:),corners(2,:),'-k');
% hold on
% plot(corners(1,1),corners(2,1),'*r');
% plot(corners(1,2),corners(2,2),'*g');
% plot(corners(1,3),corners(2,3),'*b');
% plot(corners(1,4),corners(2,4),'*m');
% hold off;axis equal
% figure
% plot(rot90pts(1,:),rot90pts(2,:),'-k');
% hold on
% plot(rot90pts(1,1),rot90pts(2,1),'*r');
% plot(rot90pts(1,2),rot90pts(2,2),'*g');
% plot(rot90pts(1,3),rot90pts(2,3),'*b');
% plot(rot90pts(1,4),rot90pts(2,4),'*m');
% hold off;axis equal
% figure
% plot(rot180pts(1,:),rot180pts(2,:),'-k');
% hold on
% plot(rot180pts(1,1),rot180pts(2,1),'*r');
% plot(rot180pts(1,2),rot180pts(2,2),'*g');
% plot(rot180pts(1,3),rot180pts(2,3),'*b');
% plot(rot180pts(1,4),rot180pts(2,4),'*m');
% hold off;axis equal
% figure
% plot(rot270pts(1,:),rot270pts(2,:),'-k');
% hold on
% plot(rot270pts(1,1),rot270pts(2,1),'*r');
% plot(rot270pts(1,2),rot270pts(2,2),'*g');
% plot(rot270pts(1,3),rot270pts(2,3),'*b');
% plot(rot270pts(1,4),rot270pts(2,4),'*m');
% hold off;axis equal

