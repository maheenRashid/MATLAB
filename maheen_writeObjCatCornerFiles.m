% ccc
% % maheen_nonmerge_cornerPlacement_oriented_specific
% for compNo = 1:16
%     load(['maheen_mergedComp\matA_orientedWidthWays_cornerAligned_' num2str(compNo) '.mat']);
%      A=A(1:10);
%     f=fopen(['maheen_cornerPlacement_oriented\category_orientedWidthWays_test_group_' num2str(compNo) '.txt'],'w');
%     for compsIndex=1:length(A)
% %         length(A);
%         fprintf(f,'%d\n',compsIndex);
%     end
%     fclose(f);
%     A=0;%clear A
% end
% return

ccc

for compNo = 1:16
    load(['maheen_temp\matA_orientedWidthWays_cornerAligned_' num2str(compNo) '.mat']);
%      A=A(1:10);
    nameTextFile='maheen_cornerPlacement_oriented_fixed\category_orientedWidthWays_';
    f=fopen([nameTextFile num2str(compNo) '.txt'],'w');
    fprintf(f,'%d\n',length(A));
    for compsIndex=1:length(A);
        fprintf(f,'%d\n',(length(A{compsIndex}))/2);
        for facesIndex = 1:2:size(A{compsIndex},2)
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
        if compsIndex==length(A)
            fprintf(f,'Z');
        else
            fprintf(f,'Z\n');
        end
    end
    fclose(f);
    
    f=fopen([nameTextFile 'cat_' num2str(compNo) '.txt'],'w');
    for compsIndex=1:length(A)
%         length(A);
        fprintf(f,'%d\n',compNo);
    end
    fclose(f);
    
    f=fopen([nameTextFile 'group_' num2str(compNo) '.txt'],'w');
    for compsIndex=1:length(A)
%         length(A);
        fprintf(f,'%d\n',compsIndex);
    end
    fclose(f);
    
    A=0;%clear A
end