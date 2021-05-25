function [nameWithoutExt] = cutExtension(name)
%cutExtension(name) Summary of this function goes here
% This function takes a file name and cuts the extension. The
% extension can be something like "raw.png. It returns te name without
% these suffix.

splited_name=strsplit(name,'_');
nameWithoutExt='';
for i=1:1:(length(splited_name)-1)
    nameWithoutExt = strcat(nameWithoutExt, splited_name(i), '_');
    nameWithoutExt = char(nameWithoutExt);
end

end

