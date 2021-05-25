%% change Label Definition
% This script converts current labeld data to a new label definition.
% Therefore the TrainIds in the old labeldefinition is mapped with the
% coresponding TrainIds in the new label definition. 
% The Ids in the Label_XX.png files are updated to the new definition.

clear;
profile off
profile on -history

gTruth=input('path to the "~/.../gTruth.mat" file from the labeling session: ', 's');
disp(' ');
imageSpace=input('path to the main folder, where the images are stored (z.B. ~/.../Senay): ', 's');
addpath(genpath(imageSpace));

%load gTruth and label Definition.csv 
load(gTruth);
pixelLabelMappingList=importValidationPixelLabelMappingList('validationPixelLabelIdMappingList.csv');

%get pixel label folder
[~, pixelLabelFolder, ~] = cutSubPathFromPath(char(gTruth.LabelData.PixelLabelData(1)));

%create new folder for the results
if exist(strcat(imageSpace, pixelLabelFolder, '\', 'changedLabelID'), 'dir') == 0
    mkdir(strcat(imageSpace, pixelLabelFolder, '\', 'changedLabelID'));
else
    disp('folder "changedLabelID" already exists ... ')
end


%step trough all PixelLabel Images and change the invalid labels with the
%valid labes
for i=1:length(gTruth.DataSource.Source)
    
    [~, ~, filename] = cutSubPathFromPath(char(gTruth.DataSource.Source(i)));
    filename = cutExtension(filename);
    
    [pixelLabelImg, ~, ~] = cutSubPathFromPath(char(gTruth.LabelData.PixelLabelData(i)));
    validPixelLabelImg = iterateAndChangeLabelId(imread(pixelLabelImg), pixelLabelMappingList);
    imwrite(validPixelLabelImg,strcat(imageSpace, pixelLabelFolder, '\', 'changedLabelID\', filename, 'labelTrainIds.png')); 

end

p = profile('info');
profile off;

