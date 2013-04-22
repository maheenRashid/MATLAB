ccc

% outputDir='maheen_mergedComp/';
outputDir='maheen_dataForGTModels_cleanedUp/mergedCompAll/';

for compNo=1:17
skpMatFilesDir=[outputDir num2str(compNo)];
d_results = dir(skpMatFilesDir);
A=cell(1,length(3:length(d_results)));
% return
for fileIndex = 3:(length(d_results))
    B=load(fullfile(skpMatFilesDir,d_results(fileIndex).name));
    mergedA=B.mergedA;
%     d_results(fileIndex).name
    A{1,fileIndex-2}=mergedA;
end
direcSuperA=d_results(3:end);
save([outputDir 'matA_' num2str(compNo) '.mat'],'A','direcSuperA');
end