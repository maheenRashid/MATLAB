% ccc
writeOutTo='maheen_similarityBetweenComp';
typeSkp='annotated';


show=0;
for compNo=1:16
if exist(fullfile(writeOutTo,typeSkp,[num2str(compNo) '_ssdOffset']),'dir')==7
    continue;
else
    mkdir(fullfile(writeOutTo,typeSkp,[num2str(compNo) '_ssdOffset']));
end
load(fullfile(writeOutTo,typeSkp,['simHBl_' typeSkp '_' num2str(compNo) '.mat']),'simMat','dimsAll_temp',...
    'dimsAll','direcSuperA_temp','direcSuperA'...
    ,'predsCurr','predsCurr_temp');

offset_all=cell(size(simMat));
box_all=cell(size(simMat));

for modNo=1:size(simMat,2)
   display(sprintf('mod %d of %d',modNo,size(simMat,2)));
    fileName=direcSuperA(modNo).name;
    if strcmp(typeSkp,'warehouse')
        load(fullfile('maheen_findOrientationSolid',[num2str(compNo) '_projDims_new_3d'],fileName),'imCellAllBig');
    else
        load(fullfile('maheen_dataForGTModels_cleanedUp','heightMapsAnd3dVox',num2str(compNo),fileName),'imCellAllBig');
    end
    imCellPred_org=imCellAllBig(predsCurr(modNo),:);
    f=imCellPred_org{5};
    
    for tempNo=1:size(simMat,1)
        display(sprintf('temp %d of %d for %d',tempNo,size(simMat,1),modNo))
        fileName=direcSuperA_temp(tempNo).name;
        load(fullfile('maheen_findOrientationSolid',[num2str(compNo) '_projDims_new_3d'],fileName),'imCellAllBig');
        imCellPred_match=imCellAllBig(predsCurr_temp(tempNo),:);
        
        t=imCellPred_match{5};
        org_min=[1;1];
        [S,c,r,box] = SSDXCORR(f,t);
                
        offset=[box(1)-org_min(1);box(2)-org_min(2)];
        offset_all{tempNo,modNo}=offset;
        box_all{tempNo,modNo}=box;
        
        if show
            figure;
            imagesc(f);
            figure;
            imagesc(t);
            figure;
            imagesc(f);
            hold on;
            xlim('auto')
            ylim('auto');
            plot(org_min(1),org_min(2),'*r');
            plot(box(1),box(2),'*b');
            rectangle('position',box,'EdgeColor','m','LineWidth',2);
            hold off;
            axis equal;
            pause;
            close all;
        end
    end  
end
save(fullfile(writeOutTo,typeSkp,[num2str(compNo) '_ssdOffset'],['simHBl_' typeSkp '_' num2str(compNo) '_offset_ssd.mat']));

end
