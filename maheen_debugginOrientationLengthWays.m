% ccc
load('D:\ResearchCMU\lustre\jasonli1\code\MATLAB\maheen_temp\matA_orientedLengthWays_cornerAligned_1.mat')
extremes=cell(1,0);
for i=1:numel(A)
comp=A{i};
coord=zeros(0,3);
for i=1:2:numel(comp)
    coord=[coord;comp{1,i}];
end
xmin=min(coord(:,1));
xmin=xmin(1);
xmax=max(coord(:,1));
xmax=xmax(1);

ymin=min(coord(:,2));
ymin=ymin(1);
ymax=max(coord(:,2));
ymax=ymax(1);

extremes=[extremes [xmin xmax;ymin ymax]];

end