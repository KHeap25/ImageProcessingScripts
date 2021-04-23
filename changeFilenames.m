%% This script is used to rename files in a folder
clear;

path=input('path of the folder (path/): ', 's');
exten=input('file extension (.png): ', 's');
exten=strcat('*', exten);
disp(' ');
rename=input('new file name: ', 's');
disp('Raw or annotations img?')
rawOri=input('0: raw, 1:annotations: ');

if ((rawOri == 0) || (rawOri == 1))== 0
    return;
end

% Get all files in the current folder.
files = dir(strcat(path,exten));

% Loop through each file.
for id = 1:length(files)
    % Get the file name.
    [~, f,ext] = fileparts(files(id).name);
    
        if rawOri == 0 %raw
            if exist(strcat(path, rename, '_', num2str(id), '_', 'raw', ext), 'file')== 0 %does not allready exist
                movefile(strcat(path, files(id).name), strcat(path, rename, '_', num2str(id), '_', 'raw', ext), 'f');
            else %already exists
                disp(strcat(path, files(id).name, ' already exists'));
            end
                
        else %annotations
            if exist(strcat(path, rename, '_', num2str(id), '_', 'polygons', ext), 'file')== 0 %does not already exist
                movefile(strcat(path, files(id).name), strcat(path, rename, '_', num2str(id), '_', 'polygons', ext), 'f');
            else %already exists
                disp(strcat(path, files(id).name, ' already exists'));
            end
        end
end