% ccc
% load('maheen_findOrientationSolid\temp.mat');
% scale=[50,50]
% grads=cell(1,size(allmaps,2));
% for i=3:size(allmaps,2)
%     imcurr=allmaps{1,i};
%     bin=imcurr>0;
%     minim=min(imcurr(bin));
%     minim=minim-1;
%     minus=zeros(size(imcurr));
%     minus(bin)=minim;
%     newimcurr=imcurr-minus;
%     newimcurr=imcurr;
% %     newimcurr1=newimcurr;
% %     bin2=newimcurr==mode(newimcurr(bin));
% %     newimcurr1(bin2)=0;
%     newimcurr=imresize(newimcurr,scale,'nearest');
% %     min(newimcurr(bin));
% %     newimcurr1=newimcurr1/max(newimcurr1(:));
%
%     [FX,FY] = gradient(newimcurr);
%     gradcurr=FX+FY;
%     gradbin=abs(gradcurr)>0;
%     gradcurr=edge(gradbin,'canny');
% %     figure;imagesc(imcurr);axis equal;
%     figure;imagesc(newimcurr);axis equal;
%
%     figure;imagesc(gradcurr);axis equal;
% %     figure;imagesc(gradbin);axis equal;
% %     sum(gradbin(:))
% %     figure;imagesc(imresize(gradbin,scale));axis equal;
%     %     imshow(gradcurr,[min(gradcurr(:)) max(gradcurr(:))]);
%     grads{i}=gradcurr;
%     sum(abs(gradcurr(:)))
%     %     figure;plot(1:numel(imcurr),imcurr(:),'-b');
%
% end
%
%
%
%
%
% return



ccc
scale=[50,50];

for compNo=1:2
    dirName=['maheen_mergedComp/' num2str(compNo)];
    outputdirSpec=['maheen_findOrientationSolid\' num2str(compNo) '_projDims_new'];
    direc=dir(dirName);
    direc=direc(3:end);
    
    for compInd=1: 10
        %     numel(direc)
        load(fullfile(dirName,direc(compInd).name),'mergedA');
        
        dims=[1 2 3;1 3 2;2 3 1];
        corrs=zeros(2*size(dims,1));
        allmaps=cell(2,6);
        
        for dimNo=1:size(dims,1)
            heightmaps=        maheen_getMaps_new(dims(dimNo,:),mergedA);
            allmaps(1,2*dimNo-1:2*dimNo)=heightmaps(:);
            for i=1:numel(heightmaps)
                imcurr=imresize(heightmaps{i},scale,'nearest');
                allmaps{2,2*dimNo+i-2}=imcurr;
            end
            
        end
        
%         imCell1=allmaps(2,[6 3 5 4 1]);
% h=maheen_subPlotIm(imCell1);

        
        save(fullfile(outputdirSpec,direc(compInd).name),'allmaps');
    end
end