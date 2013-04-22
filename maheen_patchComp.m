function maheen_patchComp(comp)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
figure;
for facesIndex = 1:2:size(comp,2)
            pointsTrans = comp{facesIndex};
            polygons = comp{facesIndex+1};
            patch('vertices', (pointsTrans), 'faces', abs(polygons'));
        
        end
end

