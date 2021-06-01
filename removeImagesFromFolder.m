%This script takes a "removelist.txt" with indexes of synthetic images 
%which should be removed.

clear;

path=input('path of the folder (path/): ', 's');
exten=input('file extension (.png): ', 's');
exten=strcat('*', exten);
disp(' ');

path_remove_list = input('path to the remove List (path/list.txt): ', 's');

% read in remove list
file = fopen(path_remove_list,'r');
formatSpec = '%d';
sizeA = [1 Inf];
remove_indexes = fscanf(file, formatSpec, sizeA);
remove_indexes = cast(remove_indexes, 'uint16');
fclose(file);

files = dir(strcat(path,exten));
splited_name = strsplit(files(1).name, '_');

% delete specified files from folder
for i = 1:length(remove_indexes)
  delete(strcat(path,splited_name{1}, '_', splited_name{2}, '_', splited_name{3}, '_', num2str(remove_indexes(i), '%05d'), '_', splited_name{5}));
end
    