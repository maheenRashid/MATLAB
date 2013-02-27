function [ heightmaps ] = maheen_getMaps( dims,A )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
dim1=dims(1);
dim2=dims(2);
dim3=dims(3);



ob_bounds_min = floor(min(cell2mat(A(1:2:end)')));
ob_bounds_max = ceil(max(cell2mat(A(1:2:end)')));


this_obj_voxels = logical(zeros(ob_bounds_max-ob_bounds_min+1,'uint8'));

for compInd = 2:2:length(A)
    points = A{compInd-1};
    tris = A{compInd};
    for tri_num = 1:size(tris,2)
        this_tri = abs(tris(:,tri_num));
        vertices_coords = points(this_tri,:);
        [tri_voxels vox_minX vox_minY vox_minZ] = triangle_voxelize(vertices_coords(1,:), vertices_coords(2,:), vertices_coords(3,:));
        [vox_x, vox_y, vox_z] = ind2sub(size(tri_voxels), find(tri_voxels));
        vox_x = vox_x+vox_minX-ob_bounds_min(1);
        vox_y = vox_y+vox_minY-ob_bounds_min(2);
        vox_z = vox_z+vox_minZ-ob_bounds_min(3);
        this_obj_voxels(sub2ind(size(this_obj_voxels), vox_x, vox_y, vox_z)) = 1;
    end
end

cellStr={'last','first'};
heights=cell(1,2);
for i=1:numel(cellStr)
    currHeights = zeros(size(this_obj_voxels,dim1), size(this_obj_voxels,dim2));
    for xx = 1:size(currHeights,1)
        for zz = 1:size(currHeights,2)
            if dim1==1 && dim2==2
                indCurr = find(this_obj_voxels(xx,zz,:),1, cellStr{i});
            elseif dim1==1 && dim2==3
                indCurr = find(this_obj_voxels(xx,:,zz),1, cellStr{i});
            elseif dim1==2 && dim2==3
                indCurr = find(this_obj_voxels(:,xx,zz),1, cellStr{i});
            end
            if(length(indCurr)==1)
                currHeights(xx,zz) = indCurr;
            end
        end
    end
    heights{i} = currHeights;
end
bounds= [ob_bounds_min ob_bounds_max];

min_X=bounds(dim1);
max_X=bounds(dim1+3);
indi=dim1;

min_Y=bounds(dim2);
max_Y=bounds(dim2+3);
indj=dim2;

for i=1:numel(heights)
    heightmap = zeros(max_X-min_X+1, max_Y-min_Y+1);
    min_this_X = bounds( indi)-min_X+1;
    min_this_Y = bounds( indj)-min_Y+1;
    max_this_X = bounds( indi+3)-min_X+1;
    max_this_Y = bounds( indj+3)-min_Y+1;
%     region = heightmap(min_this_X:max_this_X, min_this_Y:max_this_Y);
%     max_height = max(region, heights{i}+bounds(dim3));
%     heightmap(min_this_X:max_this_X, min_this_Y:max_this_Y) = max_height;
    heightmaps{i}=heights{i};
%     map; 
end

