%% showInferenceResultForSIngleSourec.m
% This script reads the result.txt file from the NVIDIA Jetson AGX Xavier embedded board
% and calculates the elapsed inference time.

%% read data
clear;

result_file = input('path to the result.txt (path/): ', 's');
num_testimgs = input('number of test images: ');

%% calc
result_table = importResults(result_file);
elapsed_time = sum(result_table.time_ms(:));
time_per_img = (elapsed_time / 1000) / num_testimgs;
frame_rate = 1 / time_per_img;

%% output
disp(strcat('time per image [s]: ', num2str(time_per_img)));
disp(strcat('frame rate [Hz]: ', num2str(frame_rate)));