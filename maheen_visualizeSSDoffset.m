ccc

writeOutTo='maheen_similarityBetweenComp';
typeSkp='warehouse';

% load(fullfile(writeOutTo,'templateMatchingTest.mat'),'imCellPred_org','imCellPred_match');

for compNo=2:16
load(fullfile(writeOutTo,typeSkp,[num2str(compNo) '_ssdOffset'],['simHBl_' typeSkp '_' num2str(compNo) '_offset_ssd.mat']),'direcSuperA',...
    'direcSuperA_temp','offset_all','box_all','predsCurr','predsCurr_temp');

modNoArray=randperm(size(offset_all,2),10);
tempNoArray=randperm(size(offset_all,1),100);

fid=fopen(fullfile(writeOutTo,typeSkp,['visualize_' num2str(compNo)],'direc.txt'),'w');
for modNo=1
%     modNoArray
%     1:size(offset_all,2)
    display(sprintf('mod %d of %d',modNo,size(offset_all,2)));
    fileName=direcSuperA(modNo).name;
    if strcmp(typeSkp,'warehouse')
        load(fullfile('maheen_findOrientationSolid',[num2str(compNo) '_projDims_new_3d'],fileName),'imCellAllBig');
    else
        load(fullfile('maheen_dataForGTModels_cleanedUp','heightMapsAnd3dVox',num2str(compNo),fileName),'imCellAllBig');
    end
    imCellPred_org=imCellAllBig(predsCurr(modNo),:);
    f=imCellPred_org{5};
    
    for tempNo=tempNoArray
%         1:size(offset_all,1)
        display(sprintf('temp %d of %d for %d',tempNo,size(offset_all,1),modNo))
        fileName=direcSuperA_temp(tempNo).name;
        load(fullfile('maheen_findOrientationSolid',[num2str(compNo) '_projDims_new_3d'],fileName),'imCellAllBig');
        imCellPred_match=imCellAllBig(predsCurr_temp(tempNo),:);
        
        t=imCellPred_match{5};
        
        offset=offset_all{tempNo,modNo};
        box=box_all{tempNo,modNo};
        [ h ] = maheen_visualizeOffset( f,t,box,offset );
        set(h,'visible','off');
        saveas(h,fullfile(writeOutTo,typeSkp,['visualize_' num2str(compNo)],[num2str(modNo) '_' num2str(tempNo) '.png']));
%         pause;
        fprintf(fid,'%s\n',[num2str(modNo) '_' num2str(tempNo) '.png']);
    end  
end
fclose(fid);
end