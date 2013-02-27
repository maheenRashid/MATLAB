ccc
    dirHeight='skp_heights';
    outputdirAll='maheen_findOrientationSolid\allModelImages';
for compNo=2:16
    dirName=['maheen_mergedComp/' num2str(compNo)];
    outputdirSpec=['maheen_findOrientationSolid\' num2str(compNo)];
    direc=dir(dirName);
    direc=direc(3:end);
    nameSimple=cell(size(direc));
    nameWithGroupNo=cell(size(direc));
   for fileIndex = 1:(length(direc))
        temp=regexp(direc(fileIndex).name,'\.','split');
        nameWithGroupNo{fileIndex}=temp{1};
        temp=regexp(temp{1},'\_','split');
        nameSimple{fileIndex}=temp{1};
   end
       totalCompInd=50;
   
   if numel(nameSimple)<50
        totalCompInd=numel(nameSimple);
   end
   
   for compInd=1:totalCompInd
        if compInd==1 || ~strcmp(nameSimple{compInd-1},nameSimple{compInd}) 
            height=dlmread(fullfile(dirHeight,strcat(nameSimple{compInd},'.txt')));
            height(2:end,:)=height(2:end,:)+repmat(height(1,:),size(height,1)-1,1);
            height=height+ones(size(height));
            height(1,:)=height(1,:)-ones(size(height(1,:)));
            maxtotal=max(height);
            maxtotal=maxtotal(1,:);
            mintotal=min(height);
            mintotal=mintotal(1,:);
            offset=[mintotal(1:2) 0];
            heightOff=height(2:end,:)-repmat(offset,size(height,1)-1,1);
            totalsize=max(heightOff);
            totalsize=totalsize(1,1:2);
            image=zeros(totalsize);
            inds=sub2ind(size(image),heightOff(1:end,1),heightOff(1:end,2));
            image(inds)=heightOff(1:end,3);
%             h = figure('visible','off');
%             imagesc(image);
%             axis equal;
%             saveas(h,fullfile(outputdirAll,strcat(nameSimple{compInd},'.png')));
        end
        load(fullfile(dirName,direc(compInd).name),'mergedA');
        minMax=maheen_getMinMax(mergedA);
        minMax=floor(minMax);
        minMax=minMax+ones(size(minMax));
        minMaxOff=minMax-[offset(1) offset(1) offset(2) offset(2)];
        minMaxOff(minMaxOff<=0)=1;
        imageSpec=image(minMaxOff(1):minMaxOff(2),minMaxOff(3):minMaxOff(4));
%         h = figure('visible','off');
%         imagesc(imageSpec);
%         axis equal;
%         saveas(h,fullfile(outputdirSpec,strcat(nameWithGroupNo{compInd},'.png')));
        save(fullfile(outputdirSpec,strcat(nameWithGroupNo{compInd},'.mat')));
   end
end