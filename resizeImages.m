%This script takes a folder with pictures, resizes the pictures and stores 
%the resized pictures in a new folder.
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
resized_path=strcat(path,'resized_images');
if exist(resized_path, 'dir')== 0 %does not allready exist
    mkdir(resized_path);
end

% select the mode
disp(' ');
disp('select the mode, scale factor or specific high and width.');
disp('0 for scaling factor');
disp('1 specific high and width');
disp(' ');
while 1
  mode=input('mode: ');
  if (mode == 0) || (mode == 1)
      break;
  end
  disp('0 for scaling factor');
  disp('1 specific high and width');
  disp(' ');
end
disp(' ');

if mode == 0    %scaling factor
    while 1
      scale=input('scale factor [0...1]:');

      if (scale >= 0) && (scale <= 1)
          break;
      end
      disp('0<= scale factor <=1 !');
      disp(' ');
    end
    
%     resize every image in the folder with scale factor
    for id = 1:length(files)
        img = imread(strcat(path, files(id).name));
        resized_img = imresize(img,scale);
        imwrite(resized_img, strcat(resized_path, '\', files(id).name));
    end
else    %specifig high and width
    % read in a specific image size which has to be smaller than the
    % current one
    img_size = size(imread(strcat(path, files(1).name))); 
    disp('size of the first selected image is')
    disp(strcat('high: ', num2str(img_size(1)), ' px'));
    disp(strcat('width: ', num2str(img_size(2)), ' px'));
    disp(' ');
    disp('please select smaller values for the specific downscaling');
    while 1
        new_high=input('high [px]: ');
        new_width=input('width [px]: ');
        if (new_high < img_size(1)) && (new_width < img_size(2))
            break;
        end
        disp(' ');
        disp('PLEASE select SMALLER values for the specific downscaling');
    end
    
    %     resize every image in the folder with specific high and width
    for id = 1:length(files)
        img = imread(strcat(path, files(id).name));
        resized_img = imresize(img,[new_high new_width]);
        imwrite(resized_img, strcat(resized_path, '\', files(id).name));
    end      
end

p = profile('info');
profile off;

