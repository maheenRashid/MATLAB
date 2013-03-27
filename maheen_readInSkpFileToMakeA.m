% ccc
% % pathParent='D:\ResearchCMU\lustre\Image-Modeling\Sketchup\Theo\resultsWalls\03242013_1122PM_04';
% pathParent='D:\ResearchCMU\lustre\Image-Modeling\Sketchup\Theo\resultsWalls_new\03252013_0822PM_06';
% 
% dirParent=dir(pathParent);
% dirParent=dirParent(3:end);
% paths=cell(1,numel(dirParent));
% mkdir('maheen_dataForGTModels/cellWalls_new');
% outputPath='maheen_dataForGTModels/cellWalls_new';
% for i=1:numel(dirParent)
%     paths{i}=fullfile(pathParent,dirParent(i).name);
% end
% 
% for fileNo=1:numel(paths)
%     fileName=fullfile(paths{fileNo}, 'wall.txt');
%     fid=fopen(fileName);
%     numComp=fscanf(fid,'%f',1);
%     walls=cell(1,numComp);
%     for compNo=1:numComp
%         points = fscanf(fid, '%f %f %f %f %f %f', [3 ,inf]);
%         fscanf(fid, '%[C]', 1); 
%         walls{compNo}=points';
%     end
%     fclose(fid);
%     save(fullfile(outputPath,[dirParent(fileNo).name '.mat']),'walls');
%     walls=0;
% end
% 
% 
% return
%%
ccc
% pathParent='D:\ResearchCMU\lustre\Image-Modeling\Sketchup\Theo\results\03212013_0721PM_16';
% pathParent='D:\ResearchCMU\lustre\Image-Modeling\Sketchup\Theo\resultsLeftOvers';
% pathParent='D:\ResearchCMU\lustre\Image-Modeling\Sketchup\Theo\results_new\03252013_0818PM_57';
pathParent='D:\ResearchCMU\lustre\Image-Modeling\Sketchup\Theo\results_check\03262013_0800PM_31';

dirParent=dir(pathParent);
dirParent=dirParent(3:end);
paths=cell(1,numel(dirParent));
outputPath='maheen_dataForGTModels/cellA_problemFinal';
mkdir('maheen_dataForGTModels/cellA_problemFinal');
for i=1:numel(dirParent)
    paths{i}=fullfile(pathParent,dirParent(i).name);
end

for fileNo=1:numel(paths)
    fileName=fullfile(paths{fileNo}, 'skp.txt');
    fid=fopen(fileName);
    numComp=fscanf(fid,'%f',1);
    A=cell(1,numComp);
    for compNo=1:numComp
        numFace=fscanf(fid,'%f',1);
        compCell=cell(1,numFace*2);
        for faceNo=1:numFace
            numVert=fscanf(fid,'%f',1);
            points = fscanf(fid, '%f %f %f %f %f %f', [3 ,inf]);
            %size(points)
            %numVert
            fscanf(fid, '%[C]', 1);
            numPoly=fscanf(fid, '%f', 1);
            polygons = fscanf(fid, '%f %f %f %f %f %f', [3 ,inf]);
            %size(polygons)
            %numPoly
            fscanf(fid, '%[C]', 1);
            compCell{2*faceNo-1} = points';
            compCell{2*faceNo} = polygons;
        end
        A{compNo}=compCell;
        fscanf(fid, '%[Z]', 1);
    end
    fclose(fid);
    save(fullfile(outputPath,[dirParent(fileNo).name '.mat']),'A');
    A=0;
end