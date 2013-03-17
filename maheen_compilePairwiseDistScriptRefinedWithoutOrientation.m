ccc
outputDir='maheen_statsUsingOrientation';
load(fullfile(outputDir,'nameCellsAndDistAndBoundAndDistRefNoOrient.mat'),...
'binMatchAll','idxMatchAll','dirNameMerge','distCellAll',...
'nameCellAll','boundCellAll','distCellAllNewRef');



show=0;
distCompiledAllCell=cell(size(distCellAllNewRef));

% compNo1=1;
% compNo2=8;

for compNo1=1:16
    for compNo2=1:16
        nameSpec1=nameCellAll{2,compNo1};
        nameSpec2=nameCellAll{2,compNo2};
        distCellCurrCombo=distCellAllNewRef{compNo1,compNo2};
        distCompiledCellCurr=cell(7,0);
        for currCompNo1=1:numel(distCellCurrCombo)-1
            distCellCompNo1=distCellCurrCombo{currCompNo1};
            
            for currCompNo2=1:numel(distCellCompNo1)-1
                distCell=distCellCompNo1{currCompNo2};
                bPts1=boundCellAll{compNo1}{distCellCompNo1{end}}{1};
                bLines1=boundCellAll{compNo1}{distCellCompNo1{end}}{2};
                
                bPts2=boundCellAll{compNo2}{distCell{end}}{1};
                bLines2=boundCellAll{compNo2}{distCell{end}}{2};
                
                distPerSide=distCell{1};
                hypos=distCell{2};
                pos=distCell{3};
                
                [stats,caseNo]=maheen_extractRelevantStats( distPerSide,hypos,pos );
                
                cellCurr={distCellCompNo1{end};distCell{end};distPerSide;hypos';pos';caseNo;stats};
                distCompiledCellCurr=[distCompiledCellCurr , cellCurr];
                
                
                
                if show>0
                    minX=min([bPts1(1,:) bPts2(1,:)]);
                    minY=min([bPts1(2,:) bPts2(2,:)]);
                    
                    bPts1=bPts1-repmat([minX;minY],1,size(bPts1,2));
                    bPts2=bPts2-repmat([minX;minY],1,size(bPts2,2));
                    
                    bLines1=bLines1-repmat([minX;minY],2,size(bLines1,2));
                    bLines2=bLines2-repmat([minX;minY],2,size(bLines2,2));
                    stats
                    caseNo
                    currCompNo1
                    currCompNo2
                    visualizeBoxes(bPts1,bLines1,bPts2,bLines2);
                    pause
                end
                
            end
            
        end
        distCompiledAllCell{compNo1,compNo2}=distCompiledCellCurr;
    end
end


save(fullfile(outputDir,'nameCellsAndDistAndBoundAndDistRefAndCompiledRelStatsNoOrient.mat'),...
'binMatchAll','idxMatchAll','dirNameMerge','distCellAll',...
'nameCellAll','boundCellAll','distCellAllNewRef','distCompiledAllCell');
