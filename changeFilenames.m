%% This script is used to rename files in a folder
clear;

path=input('path of the folder (path/): ', 's');
exten=input('file extension (.png): ', 's');
exten=strcat('*', exten);
disp(' ');
rename=input('new file name: ', 's');
offset_idx=input('offset for the index in new filename: ');
offset_idx = cast(offset_idx,'uint32');
disp('Raw or annotations img?')
rawOri=input('0: raw, 1: annotations, 2: labelTrainIds : ');

if ((rawOri == 0) || (rawOri == 1)|| (rawOri == 2))== 0
    return;
end

% Get all files in the current folder.
files = dir(strcat(path,exten));

% Loop through each file.
for id = 1:length(files)
    % Get the file name.
    [~, f,ext] = fileparts(files(id).name);
    
        if rawOri == 0 %raw
            if exist(strcat(path, rename, '_', num2str(id, '%05d'), '_', 'raw', ext), 'file')== 0 %does not allready exist
                movefile(strcat(path, files(id).name), strcat(path, rename, '_', num2str(id+offset_idx, '%05d'), '_', 'raw', ext), 'f');
            else %already exists
                disp(strcat(path, files(id).name, ' already exists'));
            end
                
        elseif rawOri == 1 %annotations
            if exist(strcat(path, rename, '_', num2str(id, '%05d'), '_', 'polygons', ext), 'file')== 0 %does not already exist
                movefile(strcat(path, files(id).name), strcat(path, rename, '_', num2str(id+offset_idx, '%05d'), '_', 'polygons', ext), 'f');
            else %already exists
                disp(strcat(path, files(id).name, ' already exists'));
            end
        
        elseif rawOri == 2 %labelTrainIds
            if exist(strcat(path, rename, '_', num2str(id, '%05d'), '_', 'labelTrainIds', ext), 'file')== 0 %does not already exist
                movefile(strcat(path, files(id).name), strcat(path, rename, '_', num2str(id+offset_idx, '%05d'), '_', 'labelTrainIds', ext), 'f');
            else %already exists
                disp(strcat(path, files(id).name, ' already exists'));
            end
        end
end