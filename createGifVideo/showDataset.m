clear;
close all force;

src_raw_path = input('Enter the absolute path of the folder with raw images: \n', 's');
if ~exist(src_raw_path, 'dir')
     return;
end
img_raw_list = dir(fullfile(src_raw_path, '*.png'));

src_id_path = input('Enter the absolute path of the folder with trainId images: \n', 's');
if ~exist(src_id_path, 'dir')
     return;
end
img_trainId_list = dir(fullfile(src_id_path, '*.png'));

label_def_path = input('Enter the absolute path of the folder within the label definitions: \n', 's');
labelDefinitions = readtable(strcat(label_def_path, '\labelDefinitions.csv'), 'Delimiter', ',');


trainId  = table2array(labelDefinitions(:,3));
R = table2array(labelDefinitions(:,8));
G = table2array(labelDefinitions(:,9));
B = table2array(labelDefinitions(:,10));

writerObject = VideoWriter("evaluationVideo.avi");
writerObject.FrameRate = 20;
open(writerObject);

h = figure;
tiledlayout(2,2, 'Padding', 'none', 'TileSpacing', 'compact');

% if you want to use a range e.g. from 10.000 to 20.000
% adapt the parfor loop head and use a additional counter variable 
% to store the frames. (see line 65: frames{i} = frame; i = i+1;) 

% frames=cell(100);
frames=cell(length(img_raw_list));


parfor d = 1:length(img_raw_list)
	image_path = strcat(img_raw_list(d).folder, '\', img_raw_list(d).name);
    img_raw = imread(image_path);  
    [height,width,channel] = size(img_raw);
    
    image_path = strcat(img_trainId_list(d).folder, '\', img_trainId_list(d).name);
    img_trainId = imread(image_path);   
    
    img_colored = zeros(height, width, 3, 'uint8');
    
    for y = 1:height
        for x = 1:width
            for i = 2:length(trainId)
                if(img_trainId(y,x) == trainId(i))
                    img_colored(y, x, 1) = R(i);
                    img_colored(y, x, 2) = G(i); 
                    img_colored(y, x, 3) = B(i);
                end
            end
        end
    end
    
    subplot(2,2,1); imshow(img_raw); title(strcat('Original Image: ', num2str(d-1))); set(gca,'xtick',[],'ytick',[]);
    subplot(2,2,2); imshow(img_colored); title('Labeled Image'); set(gca,'xtick',[],'ytick',[]);
    subplot(2,2,[3,4]); imshow(imfuse(img_raw, img_colored, 'blend')); set(gca,'xtick',[],'ytick',[]);
    ha=get(gcf,'children');
    set(ha(1),'position',[.25 .1 .5 .4]);
    set(ha(3),'position',[.05 .5 .5 .4]);
    set(ha(2),'position',[.45 .5 .5 .4]);
    frame = getframe(h);
    frames{d} = frame; 
end


for i=1:length(frames)
    writeVideo(writerObject, frames{i});
end

close(writerObject);
close all force;