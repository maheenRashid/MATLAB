function [ skpGroup] = maheen_getMatFromFile( fname )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
[fid,message]=fopen(fname);
temp = textscan(fid,'%s','Delimiter','\n');
fclose(fid);
skpGroup=temp{1};
for i=1:numel(skpGroup)
    skpGroup{i}=str2num(skpGroup{i});
end
skpGroup=cell2mat(skpGroup);


end

