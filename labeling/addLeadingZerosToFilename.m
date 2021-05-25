function [newFilename] = addLeadingZerosToFilename(filename)
%This function adds leading zeros to the filename of the Label ID Images
    
    firstSplit = strsplit(filename, '.');
    secondSplit = strsplit(char(firstSplit(1)), '_');
    index = str2num(char(secondSplit(2)));
     
    newFilename = strcat(char(secondSplit(1)), '_', num2str(index, '%05d'), '.', char(firstSplit(2)));
    
end