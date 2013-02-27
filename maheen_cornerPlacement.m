ccc
name='79080b386fea4304d4bc66ad7dfc4c3_test';
%  load('maheen_cornerPlacement/testMatrixA.mat');
load('../../results_All/79080b386fea4304d4bc66ad7dfc4c3.mat');
f=fopen(fullfile('maheen_cornerPlacement',strcat(name,'.txt')),'w');% dump file to be read into opengl cpp

    
    for compsIndex=1:length(A)-1;
        fprintf(f,'%d\n',(length(A{compsIndex})-1)/2);
        for facesIndex = 1:2:size(A{compsIndex},2)-1
            pointsTrans = A{compsIndex}{facesIndex};
            polygons = abs(A{compsIndex}{facesIndex+1})';
            fprintf(f,'%d\n',size(pointsTrans,1)*3);
            for i=1:size(pointsTrans,1)
                fprintf(f,'%4.5f\n',pointsTrans(i,1));
                fprintf(f,'%4.5f\n',pointsTrans(i,2));
                fprintf(f,'%4.5f\n',pointsTrans(i,3));
            end
            fprintf(f,'C\n');
            fprintf(f,'%d\n',size(polygons,1)*3);
            for i=1:size(polygons,1)
                fprintf(f,'%d\n',polygons(i,:));
            end
            fprintf(f,'C\n');
        end
        fseek(f,-1,0);
        if compsIndex==length(A)-1
            fprintf(f,'Z');
        else
            fprintf(f,'Z\n');
        end
    end
    fclose(f);






return

% ccc
% load('../../dataStructureForStatistics/bedrooms_livingrooms_2_hotel_withSMALL_BDLR3_with_dist_nametags.mat');
% load('../../results_All/1a1f06d240dc574d71b28eda1373ea91.mat');
% load('../../results_All/79080b386fea4304d4bc66ad7dfc4c3.mat');
% return

ccc
load('maheen_cornerPlacement/onlyNames.mat');

% load('../../results_All/1a1f06d240dc574d71b28eda1373ea91.mat');
load('../../results_All/79080b386fea4304d4bc66ad7dfc4c3.mat');
% 
% fname=('D:\ResearchCMU\lustre\Image-Modeling\OSMesa-Renderer\skp\1a1f06d240dc574d71b28eda1373ea91.txt');
% 
% [fid,message]=fopen(fname);
% temp = textscan(fid,'%s','Delimiter','\n');
% fclose(fid);
% skp=temp{1};
% bin=strcmp(temp,'CZ');
% 
% fname=('D:\ResearchCMU\lustre\Image-Modeling\OSMesa-Renderer\skp_category\1a1f06d240dc574d71b28eda1373ea91.txt');
% 
% [fid,message]=fopen(fname);
% temp = textscan(fid,'%s','Delimiter','\n');
% fclose(fid);
% skpCat=temp{1};

% fname=('D:\ResearchCMU\lustre\Image-Modeling\OSMesa-Renderer\skp_groupings\1a1f06d240dc574d71b28eda1373ea91.txt');
fname=('D:\ResearchCMU\lustre\Image-Modeling\OSMesa-Renderer\skp_groupings\79080b386fea4304d4bc66ad7dfc4c3.txt');

[fid,message]=fopen(fname);
temp = textscan(fid,'%s','Delimiter','\n');
fclose(fid);
skpGroup=temp{1};

for i=1:numel(skpGroup)
    skpGroup{i}=str2num(skpGroup{i});
end
skpGroup=cell2mat(skpGroup);
uniqueId=unique(skpGroup);
minMax=zeros(numel(uniqueId),4);
    
    minComp=zeros(length(A)-1,3);
    maxComp=zeros(length(A)-1,3);
    for indA=1:length(A)-1
        currComp=A{indA};
        mins=zeros(0,3);
        maxs=zeros(0,3);
        for indComp=1:2:length(currComp)-1
            mins=[mins;min(currComp{indComp},[],1)];
            maxs=[maxs;max(currComp{indComp},[],1)];
        end
        minComp(indA,:)=min(mins);
        maxComp(indA,:)=max(maxs);
    end
    
    for i=1:numel(uniqueId)
        minCurr=min(minComp(skpGroup==uniqueId(i),:),[],1);
        maxCurr=max(maxComp(skpGroup==uniqueId(i),:),[],1);
        minMax(i,[1 3])=minCurr(1,1:2);
        minMax(i,[2 4])=maxCurr(1,1:2);
    end
    
    newA=A;
    for indA=1:length(newA)-1
        currComp=newA{indA};
        minMaxCurr=minMax(skpGroup(indA)==uniqueId,[1,3]);
        minMaxCurr=[minMaxCurr,zeros(1,size(minMaxCurr,1))];
        for indComp=1:2:length(currComp)-1
            corrCurr=currComp{indComp}
            corrCurr=corrCurr-repmat(minMaxCurr,size(corrCurr,1),1)
            newA{indA}{indComp}=corrCurr;
        end
        pause
    end

    A=newA;
%     save('maheen_cornerPlacement/testMatrixA.mat','A');
    
return
load('../../dataStructureForStatistics/bedrooms_livingrooms_2_hotel_withSMALL_BDLR3_with_dist_nametags.mat');
B=cell(1,size(C,2));
 for i=1:size(C,2)
     B{1,i}=C{1,i}{1};
 end
B=unique(B);
save('maheen_cornerPlacement/onlyNames.mat','B');
