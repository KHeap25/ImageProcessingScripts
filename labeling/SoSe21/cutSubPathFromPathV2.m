function [subpath, pixelLabelFolder, filename] = cutSubPathFromPathV2(path)
%cutSubPathFromPath Summary of this function goes here
%This function takes a path and parses it from behind to the authors name.
%If the authors name is detected, the loop breaks and the subpath is
%returned.

splited_path=strsplit(path,'\');
subpath='';
filename = char(splited_path(length(splited_path)));
tempPixFolder='';
pixelLabelFolder = '';
% pixelLabelFolder = strcat('\', char(splited_path(length(splited_path)-1)));
for i=length(splited_path):-1:1
    if strcmp(char(splited_path(i)), 'Marcel') || strcmp(char(splited_path(i)), 'Senay') || strcmp(char(splited_path(i)), 'Yassine') || strcmp(char(splited_path(i)), 'Kai')
        break;
    end
    subpath = strcat(char(splited_path(i)), subpath);
    subpath = strcat('\', subpath);
    
    if i<= (length(splited_path)-1)
        tempPixFolder = char(splited_path(i));
        pixelLabelFolder = strcat('\',tempPixFolder ,pixelLabelFolder);
    end
end
    subpath(1:1) = []; % delete first '\' in subpath
end
