ccc

 load('D:\ResearchCMU\lustre\jasonli1\code\MATLAB\maheen_dataForGTModels\predAndFileNamesCompiled.mat')

 namesAndOrientAll_org=namesAndOrientAll;
 predAndDirCell_org=predAndDirCell;

 
for probNo=1:2
    if probNo==1
    load('D:\ResearchCMU\lustre\jasonli1\code\MATLAB\maheen_dataForGTModels\predAndFileNamesCompiled_problemCases.mat')
    elseif probNo==2
    load('D:\ResearchCMU\lustre\jasonli1\code\MATLAB\maheen_dataForGTModels\predAndFileNamesCompiled_problemCases_Final.mat')
    end
cell2Add=cell(0,2);
for skpNo=1:size(namesAndOrientAll,1)
   idx=find(strcmp(namesAndOrientAll{skpNo,1},namesAndOrientAll_org(:,1)));
   if numel(idx)>1
       display('error');
       keyboard;
   elseif numel(idx)==0

       display('error 0');

       cell2Add=[cell2Add; namesAndOrientAll(skpNo,:)];
   else
       namesAndOrientAll_org{idx,2}=namesAndOrientAll{skpNo,2};   
   end
end
namesAndOrientAll_org=[namesAndOrientAll_org;cell2Add];   
% return

for compNo=1:16
    cell2Add=cell(2,0);
    currCellNames=predAndDirCell{2,compNo};
    for i=1:numel(currCellNames)
        idx=find(strcmp(currCellNames{i},predAndDirCell_org{2,compNo}));
        if numel(idx)>1
            display('error');
            keyboard;
        elseif numel(idx)==0
            cell2Add=[cell2Add {predAndDirCell{1,compNo}(i);predAndDirCell{2,compNo}{i}}];
        else
            predAndDirCell_org{1,compNo}(idx)=predAndDirCell{1,compNo}(i);
        end
    end
    predAndDirCell_org{1,compNo}=[predAndDirCell_org{1,compNo} cell2mat(cell2Add(1,:))];
    predAndDirCell_org{2,compNo}=[predAndDirCell_org{2,compNo} cell2Add(2,:)];
end
end

namesAndOrientAll=namesAndOrientAll_org;
 predAndDirCell=predAndDirCell_org;

save('D:\ResearchCMU\lustre\jasonli1\code\MATLAB\maheen_dataForGTModels_cleanedUp\predAndFileNamesCompiled.mat','predAndDirCell','namesAndOrientAll');
