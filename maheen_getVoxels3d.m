function [ this_obj_voxels ] = maheen_getVoxels3d( A )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
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


end

