function result_table = importResults(filename, dataLines)
%IMPORTFILE1 Import data from a text file
%  ITMOVESINFERENCEEGOTEACHERFP16 = IMPORTFILE1(FILENAME) reads data
%  from text file FILENAME for the default selection.  Returns the data
%  as a table.
%
%  ITMOVESINFERENCEEGOTEACHERFP16 = IMPORTFILE1(FILE, DATALINES) reads
%  data for the specified row interval(s) of text file FILENAME. Specify
%  DATALINES as a positive scalar integer or a N-by-2 array of positive
%  scalar integers for dis-contiguous row intervals.
%
%  Example:
%  itmovesinferenceegoteacherfp16 = importfile1("D:\Dokumente\HS Esslingen\01_Master\03_Forschungsprojekt\ImageProcessingScripts\evaluateResultsOfAGX\itmoves_inference_ego_teacher_fp16.txt", [1, Inf]);
%
%  See also READTABLE.
%
% Auto-generated by MATLAB on 20-Jul-2021 11:23:08

%% Input handling

% If dataLines is not specified, define defaults
if nargin < 2
    dataLines = [1, Inf];
end

%% Setup the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 2);

% Specify range and delimiter
opts.DataLines = dataLines;
opts.Delimiter = ":";

% Specify column names and types
opts.VariableNames = ["layer", "time_ms"];
opts.VariableTypes = ["string", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
opts = setvaropts(opts, "layer", "WhitespaceRule", "preserve");
opts = setvaropts(opts, "layer", "EmptyFieldRule", "auto");
opts = setvaropts(opts, "time_ms", "TrimNonNumeric", true);
opts = setvaropts(opts, "time_ms", "ThousandsSeparator", ",");

% Import the data
result_table = readtable(filename, opts);

end