function [ gtNo ] = maheen_gTGui( imCell)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
global gtNoGlobal
sSize=get(0,'screensize');
buff=0;
sW=sSize(3)-2*buff;
sH=sSize(4)-2*buff-40;
sOrg=[1+buff 1+buff+40];
fH=sH/2;
fW=sW/2;

hMat=zeros(4,1);

%top left
hMat(1)=figure;set(hMat(1),'outerposition',[sOrg(1) sOrg(2)+fH fW fH]);
%bottom left
hMat(2)=figure;set(hMat(2),'outerposition',[sOrg(1) sOrg(2) fW fH]);
%bottom right
hMat(3)=figure;set(hMat(3),'outerposition',[sOrg(1)+fW sOrg(2) fW fH]);
%top right
hMat(4)=figure;set(hMat(4),'outerposition',[sOrg(1)+fW sOrg(2)+fH fW fH]);

for tNo=1:4
    figCurr=hMat(tNo);
    maheen_subPlotIm(imCell(tNo,:),0,figCurr);
    set(get(figCurr,'Children'),'HitTest','off');
    set(figCurr,'Tag',num2str(tNo));
    set(figCurr, 'ButtonDownFcn', {@figureButtonDown});
end
set(0,'UserData','NotClicked');
waitfor(0,'UserData','Clicked');
gtNo=gtNoGlobal;
clearvars -global gtNoGlobal;
end

function figureButtonDown(h,~)
global gtNoGlobal
selType=get(h,'SelectionType');
cellStr={'normal','alt'};
check=find(strcmpi(selType,cellStr));
if check==1
    gtNoGlobal=[gtNoGlobal str2double(get(h,'tag'))];
else
%     gtNoGlobal=[gtNoGlobal];
    set(0,'UserData','Clicked');
end

end

