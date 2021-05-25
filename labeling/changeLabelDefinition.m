%% change Label Definition
% This script converts current labeld data to a new label definition.
% Therefore the TrainIds in the old labeldefinition is mapped with the
% coresponding TrainIds in the new label definition. 
% The Ids in the Label_XX.png files are updated to the new definition.

clear;

gTruth=input('path to the "~/.../gTruth.mat" file from the labeling session: ', 's');
disp(' ');
imageSpace=input('path to the main folder, where the images are stored (z.B. ~/.../Senay/: ', 's');
addpath(genpath(imageSpace));

if exist(strcat(imageSpace, 'changedLabelID'), 'dir') == 0
    mkdir(strcat(imageSpace, 'changedLabelID'));
else
    disp('folder "changedLabelID" already exists ... ')
end

%load gTruth and label Definition.csv 
load(gTruth);
pixelLabelMappingList=importValidationPixelLabelMappingList('validationPixelLabelIdMappingList.csv');

%step trough all PixelLabel Images and chage the invalid labels with the
%valid labes
for i=1:length(gTruth.LabelData.PixelLabelData)
    
    pixelLabelImg = cutSubPathFromPath(gTruth.LabelData.PixelLabelData);
    validPixelLabelImg = iterateAndChangeLabelId(pixelLabelImg, pixelLabelMappingList);

end



