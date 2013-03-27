ccc

pathParent='D:\ResearchCMU\lustre\Image-Modeling\Sketchup\Theo\results\03212013_0721PM_16';
pathParentModels='D:\ResearchCMU\lustre\Image-Modeling\Sketchup\Theo\models_to_export';

% pathParent='D:\ResearchCMU\lustre\Image-Modeling\Sketchup\Theo\results_new\03252013_0818PM_57';
% pathParentModels='D:\ResearchCMU\lustre\Image-Modeling\Sketchup\Theo\models_to_export_new';

dirParent=dir(pathParent);
dirParent=dirParent(3:end);
dirParentModels=dir(pathParentModels);
dirParentModels=dirParentModels(3:end);
paths=cell(1,numel(dirParent));
pathsModels=paths;
for i=1:numel(dirParent)
   paths{i}=fullfile(pathParent,dirParent(i).name);
   pathsModels{i}=fullfile(pathParentModels,dirParentModels(i).name);
end

bin=zeros(2,numel(paths));
for i=1:numel(paths)
    dirCurr=dir(paths{i});
    bin(1,i)=dirCurr(5).bytes;
    bin(2,i)=dirCurr(4).bytes;
%     if dirCurr(5).bytes==0
%         bin(i)=1;
%         paths{i}
%     end
end

    inds=find(bin(1,:)==bin(2,:));
    for i=1:numel(inds)
    system(['start ' pathsModels{inds(i)}]);
    end

%load 'D:\ResearchCMU\lustre\Image-Modeling\Sketchup\Theo\SU_exportNew.rb'