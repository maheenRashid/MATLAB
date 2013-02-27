ccc

scale=[50,50];
load('D:\ResearchCMU\lustre\jasonli1\code\MATLAB\maheen_findOrientationSolid\1\1184eac449588ad6bb8e5396b1b4956d_27.mat','imageSpec');
template=imageSpec;

figure;
imagesc(template);title('Original');

templateRS=imresize(template,scale);
folder='maheen_findOrientationSolid';
compNo=4;
direc=dir([folder '\' num2str(compNo)]);
direc=direc(3:end);
% load(fullfile(folder,num2str(compNo),'1b96bd945a54ba3571f01dda08070fe2_5.mat'),'imageSpec');
% template=imageSpec;
% 
% figure;
% imagesc(template);title('Original');
for dirInd=20:30
%     16:numel(direc)
load(fullfile(folder,num2str(compNo),direc(dirInd).name),'imageSpec');
img=imageSpec;
clear imageSpec;

imgCell=maheen_getTforms(img);
corrAll=zeros(size(imgCell));
for i=1:numel(imgCell)
    imCurr=imgCell{i};
    imCurr=imresize(imCurr,scale);
    corrAll(i)=corr(templateRS(:),imCurr(:));
end
[~,maxind]=max(corrAll);
imMax=imgCell{maxind};
figure;imagesc(imMax);title('Best Match');

end

return






template = .2*ones(11); % Make light gray plus on dark gray background
template(6,3:9) = .6;   
template(3:9,6) = .6;
BW = template > 0.5;      % Make white plus on black background
figure, imshow(BW), figure, imshow(template)
% Make new image that offsets the template
offsetTemplate = .2*ones(21); 
offset = [3 5];  % Shift by 3 rows, 5 columns
offsetTemplate( (1:size(template,1))+offset(1),...
                (1:size(template,2))+offset(2) ) = template;
figure, imshow(offsetTemplate)
    
% Cross-correlate BW and offsetTemplate to recover offset  
cc = normxcorr2(BW,offsetTemplate); 
[max_cc, imax] = max(abs(cc(:)));
[ypeak, xpeak] = ind2sub(size(cc),imax(1));
corr_offset = [ (ypeak-size(template,1)) (xpeak-size(template,2)) ];
isequal(corr_offset,offset) % 1 means offset was recovered