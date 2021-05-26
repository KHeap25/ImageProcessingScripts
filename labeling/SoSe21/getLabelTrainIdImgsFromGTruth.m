%% getLabelTrainIDImgsFromGTruth
% This script takes the ground truth object from the labeling session
% and returns the LabelTrainIds.png images.

%% read in path and files
clear;
profile off
profile on -history

gTruth=input('path to the "~/.../gTruth.mat" file from the labeling session: ', 's');
disp(' ');
imageSpace=input('path to the main folder, where the images are stored (z.B. ~/.../Senay): ', 's');
addpath(genpath(imageSpace));
load(gTruth);
%% create new location
%get pixel label folder
[~, pixelLabelFolder, ~] = cutSubPathFromPath(char(gTruth.LabelData.PixelLabelData(1)));

%create new folder for the results
if exist(strcat(imageSpace, pixelLabelFolder, '\', 'labelTrainIdImgs'), 'dir') == 0
    mkdir(strcat(imageSpace, pixelLabelFolder, '\', 'labelTrainIdImgs'));
else
    disp('folder "labelTrainIdImgs" already exists ... ')
end

%% store PixelLabel Images
%step trough all PixelLabel Images and store it with the right
%corresponding filename.
for i=1:length(gTruth.DataSource.Source)
    
    [~, ~, filename] = cutSubPathFromPath(char(gTruth.DataSource.Source(i)));
    filename = cutExtension(filename);
    [pixelLabelImg, ~, ~] = cutSubPathFromPath(char(gTruth.LabelData.PixelLabelData(i)));
    
    if exist(strcat(imageSpace, pixelLabelFolder, '\', 'labelTrainIdImgs\', filename, 'labelTrainIds.png'), 'file')== 0 %does not allready exist
        copyfile(strcat(imageSpace, '\',pixelLabelImg ), strcat(imageSpace, pixelLabelFolder, '\', 'labelTrainIdImgs\', filename, 'labelTrainIds.png'), 'f');
    else %already exists
        disp(strcat(pixelLabelFolder, '\', 'labelTrainIdImgs\', filename, 'labelTrainIds.png', '  already exists'));
    end
    
end

p = profile('info');
profile off;