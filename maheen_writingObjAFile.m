ccc
% compNo=1;
for compNo=2:17
skpMatFilesDir=['maheen_mergedComp/' num2str(compNo)];
d_results = dir(skpMatFilesDir);
A=cell(1,length(3:length(d_results)));
% return
for fileIndex = 3:(length(d_results))
    B=load(fullfile(skpMatFilesDir,d_results(fileIndex).name));
    mergedA=B.mergedA;
%     d_results(fileIndex).name
    A{1,fileIndex-2}=mergedA;
end
save(['maheen_mergedComp/matA_' num2str(compNo) '.mat'],'A');
end