%This script takes a folder with pictures, greyscales the pictures and stores 
%the greyscaled pictures in a new folder.
clear;
profile off
profile on -history

% read in the path of the images and the format
path=input('path of the folder (path/): ', 's');
exten=input('file extension (.png): ', 's');
exten=strcat('*', exten);

% Get all files in the current folder.
files = dir(strcat(path,exten));

% Create new folder for the resized images
greyscaled_path=strcat(path,'grey_images');
if exist(greyscaled_path, 'dir')== 0 %does not allready exist
    mkdir(greyscaled_path);
end

%     convert every image to grey scale in the folder
for id = 1:length(files)
    img = imread(strcat(path, files(id).name));
    greyscaled_img = rgb2gray(img);
    imwrite(greyscaled_img, strcat(greyscaled_path, '\', 'grey_', files(id).name));
end

p = profile('info');
profile off;

