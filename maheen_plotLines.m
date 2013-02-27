function [ fig ] = maheen_plotLines( lines,colStr,fig )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
if nargin<2
    colStr='-r';
end
if nargin<3
    fig=figure;
else
    figure(fig);
end

hold on;
nan=NaN*ones(1,size(lines,2));
pLX=[lines(1:2:end,:);nan];
pLY=[lines(2:2:end,:);nan];
plot(pLX(:),pLY(:),colStr);

end

