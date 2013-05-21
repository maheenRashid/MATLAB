function [ h] = maheen_visualize2dGauss(stdX,stdY,mu_lump)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
% 
%                     x1 = linspace(min(lumpDist(1,:)),max(lumpDist(1,:)),20);
%                     x2 = linspace(min(lumpDist(2,:)),max(lumpDist(2,:)),20);
%                     
%                          stdX=std(lumpDist(1,:))
%                 stdY=std(lumpDist(2,:))
           
                    
                    x1 = linspace(mu_lump(1)-3*stdX,mu_lump(1)+3*stdX,30);
                    x2 = linspace(mu_lump(2)-3*stdY,mu_lump(2)+3*stdY,30);
                    
                    
[X1,X2] = meshgrid(x1,x2);
F = mvnpdf([X1(:) X2(:)],mu_lump',[stdX^2,stdY^2]);
F = reshape(F,length(x2),length(x1));
h=figure;
caxis([min(F(:))-.5*range(F(:)),max(F(:))]);

surf(x1,x2,F);

caxis([min(F(:))-.5*range(F(:)),max(F(:))]);

% xlim('auto');
% ylim('auto');
% zlim('auto');
axis([min(x1),max(x1),min(x2),max(x2) min(F(:)) max(F(:))])
xlabel('x1'); ylabel('x2'); zlabel('Probability Density');


az = 0;
el = 90;
view(az, el);    
% axis equal;
                    

end

