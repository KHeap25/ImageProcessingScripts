%This script is used to find methods to generate gifs
%with images of different size.

clear;
close all;

disp(' ');
delayTime=input('Set the delay time [s]: ');
disp('Set the file name');
disp('example: ~\Versuch1_and_2_route_101_250ms.gif');
filename=input('filename: ', 's');

disp(' ');
disp('Please give the filepath of the raw images.')
disp('format: ~\original_images\test\*.png')
filePathRaw=input('Raw filepath: ', 's');
fileListRaw = dir(filePathRaw);

disp('[1]: Concat Images');
disp('[2]: Raw | Colored: with transparent colored pictures');
mode=input('Please select the mode: ');

if mode == 2
    disp(' ');
    disp('Please give the filepath of the predicted images.')
    disp('format: ~\predicted_images\test\*.png')
    filePathPred=input('Prediction filepath: ', 's');
    fileListPred = dir(filePathPred);
    [fileListRaw, fileListPred]=checkLength(fileListRaw, fileListPred);
end

h = figure;
set(h, 'color', 'k');

destHeight = 0;
destWidth = 0;

% search highest heigth and widest width of the images
for i = 1:length(fileListRaw)
    info = imfinfo([fileListRaw(i).folder '\' fileListRaw(i).name]);
    if info.Height > destHeight
        destHeight = info.Height;
    end
    if info.Width > destWidth
        destWidth = info.Width;
    end
end

for i = 1:length(fileListRaw)
    if mode == 1
        imgRaw = zeros(destHeight, destWidth, 3, 'uint8');
        imgTmp = imread([fileListRaw(i).folder '\' fileListRaw(i).name]);
        [height,width,~] = size(imgTmp);  
        r1 = (destHeight / 2) - (height / 2);
        r2 = (destHeight / 2) + (height / 2);
        c1 = (destWidth / 2) - (width / 2);
        c2 = (destWidth / 2) + (width / 2);
        imgRaw(r1 + 1:r2, c1 + 1:c2, :) = imgTmp;

        imshow(imgRaw);
        drawnow;      

        % Capture the plot as an image
        frame = getframe(h);
        im = frame2im(frame);
        [imind,cm] = rgb2ind(im,256);

        if i == 1
            % DelayTime 1 = 1s and 0.2 = 200ms
            imwrite(imind, cm, filename, 'gif', 'DelayTime', delayTime, 'Loopcount', inf); 
        else
            imwrite(imind, cm, filename, 'gif', 'DelayTime', delayTime, 'WriteMode','append'); 
        end

    elseif mode == 2 % Raw | Colored %transparent
            imgRaw = imread([fileListRaw(i).folder '\' fileListRaw(i).name]);
            imgPred = imread([fileListPred(i).folder '\' fileListPred(i).name]);    
            imgBlend = imfuse(imgPred, imgRaw, 'blend');
%             img = imfuse(imgRaw, imgBlend, 'montage');
            
            imgRaw = zeros(destHeight, 2*destWidth, 3, 'uint8');
            imgTmp = imread([fileListRaw(i).folder '\' fileListRaw(i).name]);
            [height,width,~] = size(imgTmp);  
            r1 = (destHeight / 2) - (height / 2);
            r2 = (destHeight / 2) + (height / 2);
            c1 = (destWidth / 2) - (width / 2);
            c2 = (destWidth / 2) + (width / 2);
            imgRaw(r1 + 1:r2, c1 + 1:c2, :) = imgTmp;
            
            [height,width,~] = size(imgBlend);  
            r1 = (destHeight / 2) - (height / 2);
            r2 = (destHeight / 2) + (height / 2);
            c1 = ((3*destWidth) /2) - (width / 2);
            c2 = ((3*destWidth) /2) + (width / 2);
            imgRaw(r1 + 1:r2, c1 + 1:c2, :) = imgBlend;
    
            imshow(imgRaw);
            drawnow;      

            % Capture the plot as an image
            frame = getframe(h);
            im = frame2im(frame);
            [imind,cm] = rgb2ind(im,256);

            if i == 1
                % DelayTime 1 = 1s and 0.2 = 200ms
                imwrite(imind, cm, filename, 'gif', 'DelayTime', delayTime, 'Loopcount', inf); 
            else
                imwrite(imind, cm, filename, 'gif', 'DelayTime', delayTime, 'WriteMode','append'); 
            end
    end
end

close;