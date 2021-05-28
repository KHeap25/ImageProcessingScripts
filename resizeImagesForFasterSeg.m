%This script takes a folder with pictures, resizes the pictures and stores 
%the resized pictures in a new folder.
clear;
profile off
profile on -history

% read in the path of the images and the format
path=input('path of the folder: ', 's');
exten=input('file extension (.png): ', 's');
exten=strcat('*', exten);
path = strcat(path, '\');

% Get all files in the current folder.
files = dir(strcat(path, exten));

% Create new folder for the resized images
resized_path=strcat(path,'resized_images');
if exist(resized_path, 'dir')== 0 %does not allready exist
    mkdir(resized_path);
end
    
% resize every image in the folder with scale factor
for id = 1:length(files)
    img = imread(strcat(path, files(id).name));
    [height,width,channel] = size(img);
    
    diff = mod(height, 64);
    new_height = height - diff;
    scale = (new_height / height);  
%     interpolation method: 'nearest' or 'bilinear' to stay in range
    resized_img = imresize(img,scale, 'bilinear');
    
    [height,width,channel] = size(resized_img);    
    diff = mod(width, 64);
    new_width = width - diff;
    if (mod(diff, 2) == 0)
        x_start = diff / 2;   
    else
        x_start = (diff - 1) / 2;   
    end    
    resized_img = imcrop(resized_img,[(x_start + 1) 0 (new_width - 1) height]); 

    imwrite(resized_img, strcat(resized_path, '\', files(id).name));
end    

p = profile('info');
profile off;