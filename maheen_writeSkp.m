ccc
name='79080b386fea4304d4bc66ad7dfc4c3_corner';
 load('maheen_cornerPlacement/testMatrixA.mat');
% load('../../results_All/79080b386fea4304d4bc66ad7dfc4c3.mat');
f=fopen(fullfile('maheen_cornerPlacement',strcat(name,'.txt')),'w');% dump file to be read into opengl cpp

    fprintf(f,'%d\n',length(A)-1);
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
