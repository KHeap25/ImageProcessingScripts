%This script takes a folder which contains original and annotated synthetic 
%images. It picks random 75% of the images (original and annotated) and 
%moves it in the train subfolder and 25% in the val subfolder.

clear;
profile off
profile on -history

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
    return;
end

%% shuffle the files and move it to the train (75%) or val (25%) folder
numFiles = cast(length(filesOriginal), 'uint16');
fileIndexes = 1:1:numFiles;
fileIndexes = cast(fileIndexes, 'uint16');

%shuffle Indexes wit random permutation
fileIndexes = fileIndexes(randperm(numFiles));

%get numbers for train and val
numTrain = cast(0.75 * length(filesOriginal), 'uint16');
numVal = numFiles - numTrain;

%create new sub directories for train and val
mkdir(strcat(path, 'original_images\', 'train'));
mkdir(strcat(path, 'original_images\', 'val'));
mkdir(strcat(path, 'annotations\', 'train'));
mkdir(strcat(path, 'annotations\', 'val'));

% mov the images in the train or val folder depending on the shuffled
% Indexes
for id = 1:numFiles
    %TODO


end


p = profile('info');
profile off;