%% trainIDImages2coloredImages.m
% This script converts trainID images into colored images as specified in
% labelDefinitions.csv

%% read in path and files
clear;

img_path=input('path to the TrainIdImages containing folder "~/.../MyWorkspace" : ', 's');
disp(' ');
labelDefinitions_path=input('path to the main labelDefinitions.csv "~/.../MyWorkspace/labelDefinitions.csv": ', 's');

files = dir(strcat(img_path,'\*.png'));
% Create new folder for the colored images
if exist(strcat(img_path, '\colored_images'), 'dir')== 0 %does not allready exist
    mkdir(strcat(img_path, '\colored_images'));
end

%% read RGB values from labelDefinitions.csv
labelDefinitions = readtable(labelDefinitions_path, 'Delimiter', ',');
trainId  = table2array(labelDefinitions(:,3));
R = table2array(labelDefinitions(:,8));
G = table2array(labelDefinitions(:,9));
B = table2array(labelDefinitions(:,10));

%% create colored images
for d = 1:length(files)
	img = imread(strcat(img_path, '\', files(d).name));
    [height,width,channel] = size(img);
    img_colored = zeros(height, width, 3, 'uint8');
    for y = 1:height
        for x = 1:width
            for i = 2:length(trainId)
                if(img(y,x) == trainId(i))
                    img_colored(y, x, 1) = R(i);
                    img_colored(y, x, 2) = G(i); 
                    img_colored(y, x, 3) = B(i);
                end
            end
        end
    end
    imwrite(img_colored, strcat(img_path,'\colored_images\', 'colored_', files(d).name));
end