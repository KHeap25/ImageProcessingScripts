%This script takes a folder which contains original and annotated synthetic 
%images. It picks random 75% of the images (original and annotated) and 
%moves it in the train subfolder and 25% in the val subfolder.

clear;

%% read in the path of the images and the format
path=input('path of the folder which contains the synthetic images (path/): ', 's');
exten=input('file extension (.png): ', 's');
exten=strcat('*', exten);

%% Get all original and annotated files
filesOriginal = dir(strcat(path, 'original_images\',exten));
filesAnnotated = dir(strcat(path, 'annotations\',exten));

%% quit if number is not equal
if length(filesOriginal) ~= length(filesAnnotated)
    disp('number of original images and annotations is not equal!');
    profile off;
    return;
elseif (length(filesOriginal) == 0) || (length(filesAnnotated) == 0)
    disp('no original images or annotations in selected folder!');
    profile off;
    return;
end

%% shuffle the files and move it to the train (75%) or val (25%) folder
numFiles = cast(length(filesOriginal), 'uint16');
fileIndexes = 1:1:numFiles;
fileIndexes = cast(fileIndexes, 'uint16');

%shuffle Indexes wit random permutation
rng(0,'v5uniform'); %adjust rng to get always the same permutation
fileIndexes = fileIndexes(randperm(numFiles));

%get numbers for train and val
numTrain = cast(0.75 * length(filesOriginal), 'uint16');
numVal = numFiles - numTrain;

disp(strcat('number of train images: ', num2str(numTrain)));
disp(strcat('number of val images: ', num2str(numVal)));
%create new sub directories for train and val

if exist(strcat(path, 'original_images\', 'train'), 'dir')== 0 %does not allready exist
    mkdir(strcat(path, 'original_images\', 'train'));
end
if exist(strcat(path, 'original_images\', 'val'), 'dir')== 0 %does not allready exist
    mkdir(strcat(path, 'original_images\', 'val'));
end
if exist(strcat(path, 'annotations\', 'train'), 'dir')== 0 %does not allready exist
    mkdir(strcat(path, 'annotations\', 'train'));
end
if exist(strcat(path, 'annotations\', 'val'), 'dir')== 0 %does not allready exist
    mkdir(strcat(path, 'annotations\', 'val'));
end

% move the images in the train or val folder depending on the shuffled
% Indexes
for id = 1:numFiles
    
    if id <= numTrain 
      %train images
        %original images
        if exist(strcat(path, 'original_images\', 'train\', filesOriginal(fileIndexes(id)).name), 'file')== 0 
            %does not allready exist    
            movefile(strcat(path, 'original_images\', filesOriginal(fileIndexes(id)).name), strcat(path, 'original_images\', 'train\', filesOriginal(fileIndexes(id)).name) , 'f');
        else
            %already exists
            disp(strcat(path, 'original_images\', 'train\', filesOriginal(fileIndexes(id)).name, ' already exists'));
        end
        %annotations 
        if exist(strcat(path, 'annotations\', 'train\', filesAnnotated(fileIndexes(id)).name), 'file')== 0 
            %does not allready exist    
            movefile(strcat(path, 'annotations\', filesAnnotated(fileIndexes(id)).name), strcat(path, 'annotations\', 'train\', filesAnnotated(fileIndexes(id)).name) , 'f');
        else
            %already exists
            disp(strcat(path, 'annotations\', 'train\', filesAnnotated(fileIndexes(id)).name, ' already exists'));
        end  
    else
      %val images
        %original images
        if exist(strcat(path, 'original_images\', 'val\', filesOriginal(fileIndexes(id)).name), 'file')== 0 
            %does not allready exist    
            movefile(strcat(path, 'original_images\', filesOriginal(fileIndexes(id)).name), strcat(path, 'original_images\', 'val\', filesOriginal(fileIndexes(id)).name) , 'f');
        else
            %already exists
            disp(strcat(path, 'original_images\', 'val\', filesOriginal(fileIndexes(id)).name, ' already exists'));
        end
        %annotations 
        if exist(strcat(path, 'annotations\', 'val\', filesAnnotated(fileIndexes(id)).name), 'file')== 0
            %does not allready exist    
            movefile(strcat(path, 'annotations\', filesAnnotated(fileIndexes(id)).name), strcat(path, 'annotations\', 'val\', filesAnnotated(fileIndexes(id)).name) , 'f');
        else
            %already exists
            disp(strcat(path, 'annotations\', 'val\', filesAnnotated(fileIndexes(id)).name, ' already exists'));
        end          
    end
end
