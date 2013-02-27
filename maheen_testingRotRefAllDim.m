ccc

compNo=7;
dirName='maheen_findOrientationSolid';
dirNameCurr=fullfile(dirName,[num2str(compNo) '_projDims_new_3d']);
outputdirSpec=[dirNameCurr '_result']; 
direc=dir(dirNameCurr);
direc=direc(3:end);
orientation=zeros(numel(direc),1);

% for templateNo=1:20
load(fullfile(dirNameCurr,direc(templateNo).name));

% imCell1=allmaps(2,[6 3 5 4 1]);
imCell1=imCellAll(4,:);

orientation(templateNo)=4;
h=maheen_subPlotIm(imCell1);

temp=regexp(direc(templateNo).name,'\.','split');
temp=temp{1};

saveas(h,fullfile(outputdirSpec,[temp '_template.png']));
% end
% return
% delete(h);
% imCellResult=maheen_getObjTforms(imCell1);

% for i=1:size(imCellResult,1)
% h=maheen_subPlotIm(imCellResult(i,:));
% end
for j=1:20
    if j==templateNo
        continue
    end
load(fullfile(dirNameCurr,direc(j).name));

% imCell2=allmaps(2,[6 3 5 4 1]);
% h=maheen_subPlotIm(imCell2);
% 
% imCellResult=maheen_getObjTforms_new(imCell2);

imCellResult=imCellAll;
% for i=1:size(imCellResult,1)
% h=maheen_subPlotIm(imCellResult(i,:));
% end

corrs=maheen_getObjCorr(imCell1,imCellResult);
[~,maxInd]=max(corrs);

h1=maheen_subPlotIm(imCellResult(4,:));
set(h1,'visible','off');
h2=maheen_subPlotIm(imCellResult(maxInd,:));
set(h2,'visible','off');

temp=regexp(direc(j).name,'\.','split');
temp=temp{1};

saveas(h1,fullfile(outputdirSpec,[temp '_nRect.png']));


temp=regexp(direc(j).name,'\.','split');
temp=temp{1};

saveas(h2,fullfile(outputdirSpec,[temp '_rect.png']));
delete(h1);
delete(h2);
orientation(j)=maxInd;
end

save(fullfile(outputdirSpec,'orientation.mat'),'orientation');
    

return

imCell=cell(1,5);
scale=[50,50];
for i=1:5
    imCurr=imread(['maheen_findOrientationSolid\testImages\' num2str(i) '.png']);
    imCurr=rgb2gray(imCurr);
    imCurr=imCurr<255;
    imCurr=imresize(imCurr,scale,'nearest');
    imCell{i}=imCurr;
end

imCellResult=maheen_getObjTforms(imCell);

for i=1:size(imCellResult,1)
h=maheen_subPlotIm(imCellResult(i,:),1);
end
