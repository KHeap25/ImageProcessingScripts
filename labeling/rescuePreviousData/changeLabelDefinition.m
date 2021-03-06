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
imageSpace=input('path to the main folder, where the images are stored (z.B. ~/.../Senay/): ', 's');
addpath(genpath(imageSpace));

%create new folder for the results
if exist(strcat(imageSpace, 'changedLabelID'), 'dir') == 0
    mkdir(strcat(imageSpace, 'changedLabelID'));
else
    disp('folder "changedLabelID" already exists ... ')
end

%load gTruth and label Definition.csv 
load(gTruth);
pixelLabelMappingList=importValidationPixelLabelMappingList('validationPixelLabelIdMappingList.csv');

%step trough all PixelLabel Images and change the invalid labels with the
%valid labes
for i=1:length(gTruth.LabelData.PixelLabelData)
    
    [pixelLabelImg, filename] = cutSubPathFromPath(char(gTruth.LabelData.PixelLabelData(i)));
    validPixelLabelImg = iterateAndChangeLabelId(imread(pixelLabelImg), pixelLabelMappingList);
    filename = addLeadingZerosToFilename(filename);
    imwrite(validPixelLabelImg,strcat(imageSpace, 'changedLabelID\', filename)); 

end

p = profile('info');
profile off;

