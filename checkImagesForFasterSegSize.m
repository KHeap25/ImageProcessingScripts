%This script takes a folder with pictures and checks if 
%width mod 64 = 0 and hight mod 64 = 0.
clear;

% read in the path of the images and the format
path=input('path of the folder (path/): ', 's');
exten=input('file extension (.png): ', 's');
exten=strcat('*', exten);

% Get all files in the current folder.
files = dir(strcat(path,exten));
    
% Open text file to store the results
if exist(strcat(path, 'checkSizeResult.txt'), 'file') ~= 0 %does allready exist
    delete(strcat(path, 'checkSizeResult.txt'));
end
result = fopen(strcat(path, 'checkSizeResult.txt'), 'wt' );

%check every image train ID that has to be <=13
%Train ID's > 13 are invalid
isInvalid = false;

for id = 1:length(files)
    img = imread(strcat(path, files(id).name));
    [height,width,channel] = size(img);
    
    if mod(height, 64) ~= 0
        %invalid height detected
        isInvalid = true;
        fprintf(result, '%s\n', strcat('invalid height: ', files(id).name));
    end
    
    if mod(width, 64) ~= 0
        %invalid width detected
        isInvalid = true;
        fprintf(result, '%s\n', strcat('invalid width: ', files(id).name));
    end
end

if isInvalid == false
    fprintf(result, '%s\n', 'no invalid hight or width detected');
    disp('no invalid hight or width detected');
else
    disp('Invalid hight or width was detected. See checkSizeResult.txt');
end

fclose(result);