ccc
load('D:\ResearchCMU\lustre\jasonli1\code\MATLAB\maheen_dataForGTModels\predAndFileNamesCompiled.mat')
path='D:\ResearchCMU\lustre\jasonli1\code\MATLAB\maheen_dataForGTModels\heightMapsAnd3dVox\1\';
% load('D:\ResearchCMU\git\Image-Modeling\Pipeline\cellInputAllNew1.mat');

pred=predAndDirCell{1,1};
dir=predAndDirCell{2,1};

% strRoom='sun_agxpdpyuzjnmnaxt'
% strRoom='sun_alutrfqttmaobwdy'
% strRoom='sun_akendlqecdqfkkku'
strRoom='sun_agzmicvybezxcsfn'
% bin=cellfun(@isempty,cellInputAll);
% cellInputAll=cellInputAll(~bin)';
% matches=cell(numel(cellInputAll),1);
% for i=1:numel(cellInputAll)
%     matches(i)=cellInputAll{i}{4};
% end

% cutUp=cell(size(matches,1),3);
% for i=1:size(matches,1)
%     cutUp(i,:)=regexp(matches{i},'[#\.]','split');  
% end
% cutUp=cutUp(:,3);

% for i=1:numel(cutUp)
%     if(isempty(pred))
%         break;
%     end
    k = strfind(dir,strRoom);
    check=find(~cellfun(@isempty,k)); 
    for j=1:numel(check)
        dir{check(j)}
        load([path dir{check(j)}]);
        imCellPred=imCellAll(pred(check(j)),:);
        h=maheen_subPlotIm(imCellPred);
        valDone=pred(check(j))
        pause
    end
%     if valDone~=2
%     bin=(pred~=valDone);
%     end
%     pred=pred(bin);
%     dir=dir(bin);
%     pause;
% end


return
ccc
load('D:\ResearchCMU\lustre\jasonli1\code\MATLAB\maheen_dataForGTModels\predAndFileNamesCompiled.mat')
path='D:\ResearchCMU\lustre\jasonli1\code\MATLAB\maheen_dataForGTModels\heightMapsAnd3dVox\1\';
load('D:\ResearchCMU\git\Image-Modeling\Pipeline\cellInputAllNew1.mat');

pred=predAndDirCell{1,1};
dir=predAndDirCell{2,1};


bin=cellfun(@isempty,cellInputAll);
cellInputAll=cellInputAll(~bin)';
matches=cell(numel(cellInputAll),1);
for i=1:numel(cellInputAll)
    matches(i)=cellInputAll{i}{4};
end

cutUp=cell(size(matches,1),3);
for i=1:size(matches,1)
    cutUp(i,:)=regexp(matches{i},'[#\.]','split');  
end
cutUp=cutUp(:,3);
for i=1:numel(cutUp)
    if(isempty(pred))
        break;
    end
    k = strfind(dir,cutUp{i});
    check=find(~cellfun(@isempty,k)); 
    for j=1:numel(check)
        i
        cellInputAll{i}{1}
        cellInputAll{i}{4}
        cutUp{i}
        dir{check(j)}
        load([path dir{check(j)}]);
        imCellPred=imCellAll(pred(check(j)),:);
        h=maheen_subPlotIm(imCellPred);
        valDone=pred(check(j))
    end
    if valDone~=2
    bin=(pred~=valDone);
    end
    pred=pred(bin);
    dir=dir(bin);
    pause;
end


% b#bedroom#sun_agxpdpyuzjnmnaxt
% for i=1:10
% %     size(pred,2)
%     load([path dir{i}]);
%     imCellPred=imCellAll(pred(i),:);
%     h=maheen_subPlotIm(imCellPred);
%     title(dir{i});
%     dir{i}
% end
