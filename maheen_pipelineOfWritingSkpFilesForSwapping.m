ccc
for compNo=8:16
    inputDirPred=fullfile('maheen_findOrientationSolid','groundTruthMoreTemplate');
    outputDir='maheen_rewritingSkpsWithOrient';
%     load(fullfile(outputDir,['matADuplicatesRemovedCornerAlignedOriented_tempEqualImRemoved_' num2str(compNo)]),'A','direcSuperA');
load(fullfile(outputDir,['matADuplicatesRemovedCornerAlignedOrientedMinDistWall_' num2str(compNo)]),'A','direcSuperA');
    AOrg=A;
for rotNo=1:3
    newA=A;
    for compInd=1:numel(A)
        compCurr=A{1,compInd};
        angle=rotNo*pi/2;
        rot90=[cos(angle) -sin(angle);sin(angle) cos(angle)];
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
        
        
        newA{1,compInd}=compCurr;
    end
    A=newA;
    save(fullfile(outputDir,['matADuplicatesRemovedCornerAlignedOrientedMinDistWall_rot' num2str(rotNo) '_' num2str(compNo)]),'A','direcSuperA');
    A=AOrg;
end
end


return
%%
%rotates according to pred and corner aligns for mindistwallpred.
ccc

for compNo=8:16
    inputDirPred=fullfile('maheen_findOrientationSolid','minDistWallMethod');
    outputDir='maheen_rewritingSkpsWithOrient';
    load(fullfile(outputDir,['matADuplicatesRemoved_' num2str(compNo)]),'A','direcSuperA');
    load(fullfile(inputDirPred,['predictionClosestWallAll_' num2str(compNo) '.mat']),'direcTest','predAllSmallest','predAllShort','predAllLong');
    
    nameCell=cell(1,numel(direcTest));
    for i=1:numel(direcTest)
        nameCell{i}=direcTest(i).name;
    end
    
    inds=zeros(1,numel(direcSuperA));
    for i=1:numel(direcSuperA)
        bin=strcmp(direcSuperA(i).name,nameCell);
        if sum(bin)~=1
            disp('error')
            direcSuperA(i).name
            return
        end
        inds(i)=find(bin);
        
    end
    
    predsCurr=predAllLong';
%     (4,:);
    predsCurr=predsCurr(inds);
    
    newA=A;
    for compInd=1:numel(A)
        compCurr=A{1,compInd};
        angle=predsCurr(compInd)*pi/2;
        rot90=[cos(angle) -sin(angle);sin(angle) cos(angle)];
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
        
        
        newA{1,compInd}=compCurr;
    end
    A=newA;
    save(fullfile(outputDir,['matADuplicatesRemovedCornerAlignedOrientedMinDistWall_' num2str(compNo)]),'A','direcSuperA');
end

return
%%
%rotates according to pred and corner aligns.
ccc

for compNo=1:8
    inputDirPred=fullfile('maheen_findOrientationSolid','groundTruthMoreTemplate');
    outputDir='maheen_rewritingSkpsWithOrient';
    load(fullfile(outputDir,['matADuplicatesRemoved_' num2str(compNo)]),'A','direcSuperA');
    load(fullfile(inputDirPred,['predictionsAll_tempEqualImRemoved_' num2str(compNo) '.mat']),'direcTest','predMat');
    nameCell=cell(1,numel(direcTest));
    for i=1:numel(direcTest)
        nameCell{i}=direcTest(i).name;
    end
    
    inds=zeros(1,numel(direcSuperA));
    for i=1:numel(direcSuperA)
        bin=strcmp(direcSuperA(i).name,nameCell);
        if sum(bin)~=1
            disp('error')
            direcSuperA(i).name
            return
        end
        inds(i)=find(bin);
        
    end
    
    predsCurr=predMat(4,:);
    predsCurr=predsCurr(inds);
    
    newA=A;
    for compInd=1:numel(A)
        compCurr=A{1,compInd};
        angle=predsCurr(compInd)*pi/2;
        rot90=[cos(angle) -sin(angle);sin(angle) cos(angle)];
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
        
        
        newA{1,compInd}=compCurr;
    end
    A=newA;
    save(fullfile(outputDir,['matADuplicatesRemovedCornerAlignedOriented_tempEqualImRemoved_' num2str(compNo)]),'A','direcSuperA');
end
return
%%
ccc
for compNo=1:16
    skpMatFilesDir=['maheen_mergedComp/' num2str(compNo)];
    d_results = dir(skpMatFilesDir);
    outputDir='maheen_rewritingSkpsWithOrient';
    load(['maheen_mergedComp/matA_' num2str(compNo) '.mat'],'A');
    direcSuperA=d_results(3:end);
    save(fullfile(outputDir,['matAWithDuplicates_' num2str(compNo) '.mat']),'A','direcSuperA');
    
    sizes=zeros(1,size(A,2));
    
    for numCat=1:numel(sizes)
        sizes(1,numCat)=size(A{1,numCat},2);
    end
    
    [uniqueSizes,ind,indSizes]=unique(sizes);
    newA=cell(1,0);
    for i=1:numel(ind)
        bin=uniqueSizes(i)==sizes;
        currCats=A(:,bin);
        newA=[newA currCats(1,1)];
    end
    A=newA;
    direcSuperA=direcSuperA(ind);
    save(fullfile(outputDir,['matADuplicatesRemoved_' num2str(compNo)]),'A','direcSuperA');
    
end