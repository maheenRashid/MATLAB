ccc

scale=[50,50]
outputDirParent='maheen_dataForGTModels';
dirMergedA=fullfile(outputDirParent,'mergedCompAll_problemFinal');
dirVoxAndMap=fullfile(outputDirParent,'heightMapsAnd3dVox_problemFinal');
errorLog=cell(1,0);
for compNo=1:16
%     dirName=['maheen_mergedComp/' num2str(compNo)];
%     outputdirSpec=['maheen_findOrientationSolid\' num2str(compNo) '_projDims_new_3d'];
    dirName=fullfile(dirMergedA,num2str(compNo));
    outputdirSpec=fullfile(dirVoxAndMap,num2str(compNo));
    
    direc=dir(dirName);
    direc=direc(3:end);
    
    for compInd=1:numel(direc)
        load(fullfile(dirName,direc(compInd).name),'mergedA');
        if  isempty(mergedA)
            errorLog=[errorLog fullfile(dirName,direc(compInd).name)];
            continue
        end
        dims=[1 2 3;1 3 2;2 3 1];
        corrs=zeros(2*size(dims,1));
        allmaps=cell(2,6);
        voxOrg=maheen_getVoxels3d(mergedA);
        vox=voxOrg;
        imCellAll=cell(8,5);
        imCellAllBig=cell(8,5);
        for rotNo=1:8
            if rotNo==5
                vox=permute(voxOrg,[2 1 3]);
            end
            voxNew=zeros([size(vox,2),size(vox,1),size(vox,3)]);
            for hNo=1:size(vox,3)
                voxNew(:,:,hNo)=imrotate(vox(:,:,hNo),90);
            end
            
            vox=voxNew;
            
            for dimNo=1:size(dims,1)
                heightmaps=maheen_getMaps_new_rot3d(vox,dims(dimNo,:));
                allmaps(1,2*dimNo-1:2*dimNo)=heightmaps(:);
                for i=1:numel(heightmaps)
                    imcurr=imresize(heightmaps{i},scale,'nearest');
                    allmaps{2,2*dimNo+i-2}=imcurr;
                end 
            end
            imCell1=allmaps(2,[6 3 5 4 1]);
%             h=maheen_subPlotIm(imCell1);
            imCellAll(rotNo,:)=imCell1;
            imCell1=allmaps(1,[6 3 5 4 1]);
%             h=maheen_subPlotIm(imCell1);
            imCellAllBig(rotNo,:)=imCell1;

        end
        compInd
        save(fullfile(outputdirSpec,direc(compInd).name),'imCellAll','voxOrg','imCellAllBig');
    end
end