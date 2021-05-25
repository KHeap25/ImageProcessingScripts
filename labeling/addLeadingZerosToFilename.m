function [newFilename] = addLeadingZerosToFilename(filename)
%This function adds leading zeros to the filename of the Label ID Images
    
    firstSplit = strsplit(filename, '.');
    secondSplit = strsplit(char(firstSplit(1)), '_');
    
    newFilename = strcat(char(secondSplit(1)), '_', '00', char(secondSplit(2)), '.', char(firstSplit(2)));
    
end

