ccc

for compNo=1:16
    outputDir='maheen_rewritingSkpsWithOrient_4_21';
    load(fullfile(outputDir,['matADuplicatesRemovedCornerAlignedOriented_' num2str(compNo)]),'A','direcSuperA','predsCurr');
    AOrg=A;
for rotNo=1:3
            angles=rotNo*ones(1,numel(A));
            [ A ] = maheen_cornerAlignAndOrientByPred( A,angles );
    
    save(fullfile(outputDir,['matADuplicatesRemovedCornerAlignedOriented_rot' num2str(rotNo) '_' num2str(compNo)]),'A','direcSuperA','predsCurr');
    A=AOrg;
end
end



return
ccc


for compNo=1:16
    outputDir='maheen_rewritingSkpsWithOrient_4_21';
    load(fullfile(outputDir,['matADuplicatesRemoved_' num2str(compNo)]),'A','direcSuperA');
    
    if compNo>8
        inputDirPred=fullfile('maheen_findOrientationSolid','minDistWallMethod');
    load(fullfile(inputDirPred,['predictionClosestWallAll_' num2str(compNo) '.mat']),'direcTest','predAllLong');
    predsCurr=predAllLong';

    else
    inputDirPred=fullfile('maheen_findOrientationSolid','groundTruthMoreTemplate');
    load(fullfile(inputDirPred,['predictionsAll_tempEqualImRemoved_' num2str(compNo) '.mat']),'direcTest','predMat');
    predsCurr=predMat(4,:);
        
    end
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
    
    predsCurr=predsCurr(inds);
    [ A ] = maheen_cornerAlignAndOrientByPred( A,predsCurr );
    save(fullfile(outputDir,['matADuplicatesRemovedCornerAlignedOriented_' num2str(compNo)]),'A','direcSuperA','predsCurr');
end