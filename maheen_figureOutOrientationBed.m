ccc
% load('D:\ResearchCMU\lustre\jasonli1\code\MATLAB\maheen_nonmergedComp\1\109f55cffe4fec1adfe9e247c5ea6187_1.mat')
% load('D:\ResearchCMU\lustre\jasonli1\code\MATLAB\maheen_nonmergedComp\1\109f55cffe4fec1adfe9e247c5ea6187_2.mat')
% load('D:\ResearchCMU\lustre\jasonli1\code\MATLAB\maheen_nonmergedComp\1\1175baf1849eb7c14e4975e87c20ce53_2.mat')
% load('D:\ResearchCMU\lustre\jasonli1\code\MATLAB\maheen_nonmergedComp\1\1184eac449588ad6bb8e5396b1b4956d_27.mat')
% load('D:\ResearchCMU\lustre\jasonli1\code\MATLAB\maheen_nonmergedComp\1\1184eac449588ad6bb8e5396b1b4956d_28.mat')
% load('D:\ResearchCMU\lustre\jasonli1\code\MATLAB\maheen_nonmergedComp\1\1184eac449588ad6bb8e5396b1b4956d_29.mat')
% load('D:\ResearchCMU\lustre\jasonli1\code\MATLAB\maheen_nonmergedComp\1\11cd99ef11926dceefe5f291bc2f5fd0_1.mat')
% load('D:\ResearchCMU\lustre\jasonli1\code\MATLAB\maheen_nonmergedComp\1\11cd99ef11926dceefe5f291bc2f5fd0_2.mat')


for compNo=1:16
skpMatFilesDir=['maheen_nonmergedComp/' num2str(compNo)];
d_results = dir(skpMatFilesDir);
A=cell(1,length(3:length(d_results)));

for fileIndex = 3:(length(d_results))
    B=load(fullfile(skpMatFilesDir,d_results(fileIndex).name));
    mergedA=B.mergedA;
    roomBound=B.roomBound;

    allCoord=mergedA(1:2:end);
    allCoord=reshape(allCoord,size(allCoord,2),1);
    allCoord=cell2mat(allCoord);
    minAll=min(allCoord);
    minAll=minAll(1,:);
    maxAll=max(allCoord);
    maxAll=maxAll(1,:);

    
minroom=roomBound{1}(1:2:end);
maxroom=roomBound{1}(2:2:end);

% figure; 
% hold on
% rectangle('Position',[minroom(1:2) maxroom(1:2)-minroom(1:2)]);
% rectangle('Position',[minAll(1:2) maxAll(1:2)-minAll(1:2)]);



rot0=[1 0;0 1];
rot90=[0 -1;1 0];
rot180=[-1 0;0 -1];
rot270=[0 1;-1 0];


dims=maxAll-minAll;
if dims(1)>dims(2)
    xshort=0;
else
    xshort=1;
end
dirVec=zeros(1);
if xshort==1
    diffabove=maxroom(2)-maxAll(2);
    diffbelow=minAll(2)-minroom(2);
    if diffabove>diffbelow
%         dirVec=[(maxAll(1)+minAll(1))/2 maxAll(2) (maxAll(1)+minAll(1))/2 maxroom(2)];
%         plot(dirVec(1:2:end),dirVec(2:2:end),'-r');
        rot=rot0;
    else
%         dirVec=[(maxAll(1)+minAll(1))/2 minAll(2) (maxAll(1)+minAll(1))/2 minroom(2)];
% plot(dirVec(1:2:end),dirVec(2:2:end),'-g');
rot=rot180;
    end
else
    diffright=maxroom(1)-maxAll(1);
    diffleft=minAll(1)-minroom(1);
    if diffright>diffleft
%         dirVec=[maxAll(1) (maxAll(2)+minAll(2))/2 maxroom(1) (maxAll(2)+minAll(2))/2];
% plot(dirVec(1:2:end),dirVec(2:2:end),'-b');
        rot=rot90;
    else
%         dirVec=[minAll(1) (maxAll(2)+minAll(2))/2 minroom(1) (maxAll(2)+minAll(2))/2]
% plot(dirVec(1:2:end),dirVec(2:2:end),'-m');
        rot=rot270;
    end
end
% 
% axis equal
% 
% figure;
% hold on
% minAll=minAll';
% maxAll=maxAll';
% minAll(1:2)=rot*minAll(1:2);
% maxAll(1:2)=rot*maxAll(1:2);
% minAll=minAll';
% maxAll=maxAll';
% vecTemp=[dirVec(1:2:end); dirVec(2:2:end)];
% vecTemp=rot*vecTemp;
% rectangle('Position',[minroom(1:2) maxroom(1:2)-minroom(1:2)]);
% % ,'LineStyle','b');
% % rectangle('Position',[maxAll(1:2) abs(minAll(1:2)-maxAll(1:2))]);
% plot([minAll(1) minAll(1) maxAll(1) maxAll(1) minAll(1)],[minAll(2) maxAll(2) maxAll(2) minAll(2) minAll(2)],'-r');
% plot(vecTemp(1,:),vecTemp(2,:),'-c');
% axis equal






compNew= mergedA;
for i=1:2:numel(mergedA)
    compCurr=mergedA{1,i};
    compCurr=compCurr';
    compCurr(1:2,:)=rot*compCurr(1:2,:);
    compNew{1,i}=compCurr';
end



% pause;
A{1,fileIndex-2}=compNew;
end
save(['maheen_nonmergedComp/matA_rot_' num2str(compNo) '.mat'],'A');
end
