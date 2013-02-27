function [ heightmaps] = maheen_getMaps_new_rot3d( this_obj_voxels,dims )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
dim1=dims(1);
dim2=dims(2);
dim3=dims(3);

cellStr={'last','first'};
heights=cell(1,2);
for i=1:numel(cellStr)
    currHeights = zeros(size(this_obj_voxels,dim1), size(this_obj_voxels,dim2));
    for xx = 1:size(currHeights,1)
        for zz = 1:size(currHeights,2)
            if dim1==1 && dim2==2
                currVec=this_obj_voxels(xx,zz,:);
            elseif dim1==1 && dim2==3
                currVec=this_obj_voxels(xx,:,zz);
            elseif dim1==2 && dim2==3
                currVec=this_obj_voxels(:,xx,zz);
            end
            
            dimVec=size(currVec);
            dimVec=dimVec(dimVec~=1);
            if isempty(dimVec)
                dimVec=1;
            end
            
            indCurr = find(currVec,1, cellStr{i});
            
            if(length(indCurr)==1)
                if i==2
                    indCurr=dimVec+1-indCurr;
                end
                currHeights(xx,zz) = indCurr;
            end
        end
    end
    heights{i} = currHeights;
end

for i=1:numel(heights)
    heightmaps{i}=heights{i};
end


