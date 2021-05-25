function labelDefinitions = importLabelDefinitions(filename, dataLines)
%IMPORTFILE Import data from a text file
%  LABELDEFINITIONS = IMPORTFILE(FILENAME) reads data from text file
%  FILENAME for the default selection.  Returns the data as a table.
%
%  LABELDEFINITIONS = IMPORTFILE(FILE, DATALINES) reads data for the
%  specified row interval(s) of text file FILENAME. Specify DATALINES as
%  a positive scalar integer or a N-by-2 array of positive scalar
%  integers for dis-contiguous row intervals.
%
%  Example:
%  labelDefinitions = importfile("D:\Dokumente\HS Esslingen\01_Master\03_Forschungsprojekt\05_Datengenerierung\labelDefinitions.csv", [2, Inf]);
%
%  See also READTABLE.
%
% Auto-generated by MATLAB on 21-May-2021 13:20:36

%% Input handling

% If dataLines is not specified, define defaults
if nargin < 2
    dataLines = [2, Inf];
end

%% Setup the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 10);

% Specify range and delimiter
opts.DataLines = dataLines;
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["name", "id", "trainId", "category", "catId", "hasInstances", "ignoreInEval", "color_r", "color_g", "color_b"];
opts.VariableTypes = ["string", "double", "double", "categorical", "double", "categorical", "categorical", "double", "double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
opts = setvaropts(opts, "name", "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["name", "category", "hasInstances", "ignoreInEval"], "EmptyFieldRule", "auto");

% Import the data
labelDefinitions = readtable(filename, opts);

end