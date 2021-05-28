%This script takes a folder with pictures, cuts the pictures and stores 
%the cut pictures in a new folder. This is nessecary to get width mod 64 =
%0 and hight mod 64 = 0

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

for id = 1:length(files)
    img = imread(strcat(path, files(id).name));
    [height,width,channel] = size(img);
    
    diff_hight = mod(height, 64);
    diff_width = mod(width, 64);
    
    if channel <=3 %more than one channel
        %remove the first rows (at upper edge of the image) 
        img(1:diff_hight,:, :) = [];
        %remove left and rigth side
        if mod(diff_width, 2) == 0 % even number
            img(:,1:diff_width/2, :) = []; %leftside
            img(:,width - diff_width/2 - diff_width/2 +1 : width - diff_width/2, :) = []; %rightside
        else % odd number
            img(:,1:fix(diff_width/2)+1, :) = []; %leftside
            img(:, width - (fix(diff_width/2)+1) - fix(diff_width/2) + 1 : width - (fix(diff_width/2)+1), :) = []; %rightside
        end
    else
        disp('only tested for not more than three channels');
    end
     
    imwrite(img, strcat(resized_path, '\', files(id).name));
end    

p = profile('info');
profile off;
    