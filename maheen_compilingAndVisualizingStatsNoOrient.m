ccc

outputDir='maheen_statsUsingOrientation';
load(fullfile(outputDir,'nameCellsAndDistAndBoundAndDistRefAndCompiledRelStatsNoOrient.mat'),...
'nameCellAll','distCompiledAllCell');
% 'binMatchAll','idxMatchAll','dirNameMerge','distCellAll',...
% 'boundCellAll','distCellAllNewRef',);

compNo1=2;
compNo2=9;

distCellCurr=distCompiledAllCell{compNo1,compNo2};
noPairs=size(distCellCurr,2);
compNo1Count=numel(unique(cell2mat(distCellCurr(1,:))));
compNo2Count=numel(unique(cell2mat(distCellCurr(1,:))));

caseNos=cell2mat(distCellCurr(6,:));

caseNo1=abs(caseNos)==1;
caseNo1Neg=caseNos==-1;
caseNo2=caseNos==2;
caseNo3=caseNos==3;
caseNo4=caseNos==4;

caseNoCount=[sum(caseNo1) sum(caseNo2) sum(caseNo3) sum(caseNo4) sum(caseNo1Neg)];

statsPerCase=cell(1,3);
caseNo1Stats=cell2mat(distCellCurr(end,caseNo1&~caseNo1Neg));
caseNo1Stats=[caseNo1Stats cell2mat(distCellCurr(end,caseNo1Neg))*-1];
statsPerCase{1}=caseNo1Stats;
caseNo2Stats=cell2mat(distCellCurr(end,caseNo2));
caseNo3Stats=cell2mat(distCellCurr(end,caseNo3));
statsPerCase{2}=caseNo2Stats;
statsPerCase{3}=caseNo3Stats;

minCase1=min(abs(caseNo1Stats(1:2,:)),[],1);
minCase1(sum(caseNo1)+1:end)=-1*minCase1(sum(caseNo1)+1:end);
minCase2=min(caseNo2Stats(1:2,:),[],1);
horzCase1=caseNo1Stats(end,:);
horzCase2=caseNo2Stats(end,:);

ratioCase1=min(abs(caseNo1Stats(1:2,:)),[],1)-max(abs(caseNo1Stats(1:2,:)),[],1);
ratioCase2=min(abs(caseNo2Stats(1:2,:)),[],1)-max(abs(caseNo2Stats(1:2,:)),[],1);
midCase2=caseNo2Stats(3,:);
case3=caseNo3Stats;


cellStats={minCase1,minCase2,horzCase1,horzCase2,ratioCase1,ratioCase2,midCase2,case3};
cellStatsStrings={'minCase1','minCase2','horzCase1','horzCase2','ratioCase1','ratioCase2','midCase2','case3'};
meanAndStdDev=zeros(2,size(cellStats,2));
for i=1:size(cellStats,2)
    x=min(cellStats{i}):5:max(cellStats{i});
    no=numel(cellStats{i});
    figure;
    hist(cellStats{i},x);
    title([cellStatsStrings{i} '\_' num2str(no)]);
end

