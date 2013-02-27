
ccc
compNo=8;
resume=1;

dirName='maheen_findOrientationSolid';
dirNameCurr=fullfile(dirName,[num2str(compNo) '_projDims_new_3d']);
outputdirSpec=fullfile(dirName,'groundTruthNew');


if resume~=1
    load(fullfile(outputdirSpec,['direc_' num2str(compNo) '.mat']),'direc');
    orientation=zeros(numel(direc),4);
    strt=1;
else
    load(fullfile(outputdirSpec,['orientation_' num2str(compNo) '.mat']),'orientation','imNo','direc');
    strt=imNo;
end


for imNo=strt:numel(direc)
    load(fullfile(dirNameCurr,direc(imNo).name),'imCellAll');
    direc(imNo).name
    imCell=imCellAll(1:4,:);
    gtNo=maheen_gTGui(imCell);
    i=numel(gtNo);
    if i==0
        gtNo=-1;
        i=1;
    end
    orientation(imNo,1:i)=gtNo;
    close all
    
    if mod(imNo,10)==0
        save(fullfile(outputdirSpec,['orientation_' num2str(compNo) '.mat']),'orientation','imNo','direc');
    end
end

save(fullfile(outputdirSpec,['orientation_' num2str(compNo) '.mat']),'orientation','imNo','direc');


% return

% ccc
% % compNo=6;
% for compNo=1:16
% dirName='maheen_findOrientationSolid';
% dirNameCurr=fullfile(dirName,[num2str(compNo) '_projDims_new_3d']);
% outputdirSpec=fullfile(dirName,'groundTruthNew');
%
% direc=dir(dirNameCurr);
% direc=direc(3:end);
% n=min([100,numel(direc)]);
% n=randperm(numel(direc),n);
% direc=direc(n);
% imNo=1;
% compNo
% numel(direc)
% save(fullfile(outputdirSpec,['direc_' num2str(compNo) '.mat']),'direc','imNo');
% end
%
% return

% ccc
% dir=['maheen_findOrientationSolid/testImages'];
% imCell=cell(1,5);
% for i=1:5
%     im=imread(fullfile(dir,[num2str(i) '.png']));
%     im=imresize(im,[50,50]);
%     imCell{i}=rgb2gray(im);
% end
%
% imCell=repmat(imCell,4,1);
% gtNo=maheen_gTGui(imCell)
