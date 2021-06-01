%This script takes a folder with labelTrainIds pictures and checks if 
%the train ID's are valid. (0 <= train ID <= 13)

clear;

% read in the path of the images and the format
path=input('path of the folder (path/): ', 's');
exten=input('file extension (.png): ', 's');
exten=strcat('*', exten);

% Get all files in the current folder.
files = dir(strcat(path,exten));
    
% Open text file to store the results
if exist(strcat(path, 'checkInvalidAnnotationsResult.txt'), 'file') ~= 0 %does allready exist
    delete(strcat(path, 'checkInvalidAnnotationsResult.txt'));
end
result = fopen(strcat(path, 'checkInvalidAnnotationsResult.txt'), 'wt' );

%check every image train ID that has to be <=13
%Train ID's > 13 are invalid
isInvalid = false;

for id = 1:length(files)
    img = imread(strcat(path, files(id).name));
    [i,k]=find(img>13);
    
    if (isempty(i)== 0) || (isempty(k)==0)
        %invalid ids are detected
        isInvalid = true;
        fprintf(result, '%s\n', files(id).name);
    end
end

if isInvalid == false
    fprintf(result, '%s\n', 'no invalid train IDs were detected');
    disp('no invalid train IDs were detected');
else
    disp('Invalid train IDs were detected. See checkInvalidAnnotationsResult.txt');
end

fclose(result);