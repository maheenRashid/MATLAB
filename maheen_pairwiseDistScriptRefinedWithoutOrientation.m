ccc
outputDir='maheen_statsUsingOrientation';
load(fullfile(outputDir,'nameCellsAndDistAndBound.mat'),'nameCellAll','binMatchAll','idxMatchAll','dirNameMerge','distCellAll','boundCellAll');


show=0;
distCellAllNewRef=cell(size(distCellAll));
for compNo1=1:16
    for compNo2=1:16
        nameSpec1=nameCellAll{2,compNo1};
        nameSpec2=nameCellAll{2,compNo2};
        distCellCurrCombo=distCellAll{compNo1,compNo2};
        distCellCurrComboNewRef=cell(size(distCellCurrCombo));
        for currCompNo1=1:numel(distCellCurrCombo)-1
            distCellCompNo1=distCellCurrCombo{currCompNo1};
            distCellNewCompNo1NewRef=distCellCurrCombo{currCompNo1};
            
            for currCompNo2=1:numel(distCellCompNo1)-1
                distCell=distCellCompNo1{currCompNo2};
                bPts1=boundCellAll{compNo1}{distCellCompNo1{end}}{1};
                bLines1=boundCellAll{compNo1}{distCellCompNo1{end}}{2};
                
                bPts2=boundCellAll{compNo2}{distCell{end}}{1};
                bLines2=boundCellAll{compNo2}{distCell{end}}{2};
                
                name2=distCell{end};
                
                distCell=distCell(1:2);
                
                distPerSide=maheen_getDistPerSide(distCell);
                hypos=zeros(numel(distPerSide{1}),numel(distPerSide{2}));
                for r=1:size(hypos,1)
                    for c=1:size(hypos,2)
                        hypos(r,c)=sqrt(distPerSide{1}(r)^2+distPerSide{2}(c)^2);
                    end
                end
                
                [ posX1,posY1,posX2,posY2 ] = maheen_getRelativePos( bPts1,bPts2 );
                posMat=[posX1,posY1,posX2,posY2];
                
                if show>0
                    minX=min([bPts1(1,:) bPts2(1,:)]);
                    minY=min([bPts1(2,:) bPts2(2,:)]);
                    
                    bPts1=bPts1-repmat([minX;minY],1,size(bPts1,2));
                    bPts2=bPts2-repmat([minX;minY],1,size(bPts2,2));
                    
                    bLines1=bLines1-repmat([minX;minY],2,size(bLines1,2));
                    bLines2=bLines2-repmat([minX;minY],2,size(bLines2,2));
                    visualizeBoxes(bPts1,bLines1,bPts2,bLines2);
                    [posX1 posY1]
                    [posX2  posY2]
                    hypos
                    for i=1:numel(distPerSide)
                        distPerSide{i}
                    end
                    pause
                end
                
                distCellNew={distPerSide,hypos,posMat,name2};
                distCellNewCompNo1NewRef{currCompNo2}=distCellNew;
                
            end
            distCellCurrComboNewRef{currCompNo1}=distCellNewCompNo1NewRef;
            
        end
        distCellAllNewRef{compNo1,compNo2}=distCellCurrComboNewRef;
        
    end
end

save(fullfile(outputDir,'nameCellsAndDistAndBoundAndDistRefNoOrient.mat'),...
    'nameCellAll','binMatchAll','idxMatchAll','dirNameMerge','distCellAll',...
    'boundCellAll','distCellAllNewRef');
