%This script creates different Gifs for evaluating the results of a sematic
%segmentation model. 

%Maybe, call a "addpath('D:\Path\to\my\working\directory');" in matlab CMD
%for adding your specific workspace to matlab. So you can use relative path's 
%in the follwing dialog field.%TODO 

clear;
profile off
profile on -history

disp('This script creates a gif or video with the predicted pictures of a semantic segmentation model.');
disp('You can choose from the following modes:');

disp('[1]: Raw | Colored: with transparent colored pictures');
disp('[2]: Raw | Colored: with opaque colored pictures');
disp('[3]: Collored | Colored: with transparent colored pictures');
disp('[4]: Collored | Colored: with opaque colored pictures');
disp('[5]: Raw | Collored overlaying Colored: with transparent colored pictures');
disp('[6]: concatenate pictures without any transparency etc.');
disp('[7]: concatenate pictures with overlaying transparent other pictures');
disp(' ');
mode=input('Please select the mode: ');

disp(' ');
disp('Do you want a gif or a video?');
disp('[0]: gif');
disp('[1]: video');
gif_video=input('gif or video: ');

if gif_video == 0 % Params for gif
    disp(' ');
    delayTime=input('Set the delay time [s]: ');
    disp('Set the file name');
    disp('example: ~\Versuch1_and_2_route_101_250ms.gif');
    filename=input('filename: ', 's');
else %params for video
    disp(' ');
    frameRate=input('Set the frame rate [FPS]: ');
    disp('Set the file name');
    disp('example: ~\Versuch1_and_2_route_101_250ms.avi');
    filename=input('filename: ', 's');
end

if mode==1 || mode == 2
    % Raw | Colored 
    disp(' ');
    disp('Please give the filepath of the raw images.')
    disp('format: ~\original_images\test\*.png')
    filePathRaw=input('Raw filepath: ', 's');
    disp(' ');
    disp('Please give the filepath of the colored images.')
    disp('format: ~\test_1_0\*.viz.png')
    filePathColored=input('Colored filepath: ', 's');
    
    fileListRaw = dir(filePathRaw); 
    fileListColored = dir(filePathColored);
    
    [fileListRaw, fileListColored]=checkLength(fileListRaw, fileListColored);
    
    if mode == 1 %transparent
        if gif_video == 0
            drawImages(filename, fileListRaw, fileListColored, delayTime, 1);
        else
            createVideo(filename, fileListRaw, fileListColored, frameRate, 1);
        end
    elseif mode == 2 %opaque
        if gif_video == 0
            drawImages(filename, fileListRaw, fileListColored, delayTime, 2);
        else
            createVideo(filname, fileListRaw, fileListColored, frameRate, 2);
        end
    end
elseif mode == 3 || mode == 4
    % Colored | Colored
    disp(' ');
    disp('Please give the filepath of the first colored images.')
    disp('format: ~\test_1_0\*.viz.png')
    filePathFirstColored=input('First colored filepath: ', 's');
    disp(' ');
    disp('Please give the filepath of the second colored images.')
    disp('format: ~\test_1_0\*.viz.png')
    filePathSecondColored=input('Second colored filepath: ', 's');
    
    fileListFirstColored = dir(filePathFirstColored); 
    fileListSecondColored = dir(filePathSecondColored);
    
    [fileListFirstColored, fileListSecondColored]=checkLength(fileListFirstColored, fileListSecondColored);
    
    if mode == 3 %transparent
        disp(' ');
        disp('Please give the filepath of the raw images.')
        disp('format: ~\original_images\test\*.png')
        filePathRaw=input('Raw filepath: ', 's');
        fileListRaw = dir(filePathRaw);

        [fileListRaw, fileListFirstColored, fileListSecondColored]=checkLength(fileListRaw, fileListFirstColored, fileListSecondColored);
        
        if gif_video == 0
            drawImages(filename, fileListRaw, fileListFirstColored, delayTime, 3, fileListSecondColored);
        else
            createVideo(filename, fileListRaw, fileListFirstColored, frameRate, 3, fileListSecondColored);
        end
    
    elseif mode == 4 %opaque
        [fileListFirstColored, fileListSecondColored]=checkLength(fileListFirstColored, fileListSecondColored);
        
        if gif_video == 0
            drawImages(filename, fileListFirstColored, fileListSecondColored, delayTime, 2);
        else
            createVideo(filename, fileListFirstColored, file_ListSecondColored, frameRate, 2);
        end
    end
    
elseif mode == 5
    %Raw | Collored overlaying Colored
    disp(' ');
    disp('Please give the filepath of the raw images.')
    disp('format: ~\original_images\test\*.png')
    filePathRaw=input('Raw filepath: ', 's');
    fileListRaw = dir(filePathRaw);

    disp(' ');
    disp('Please give the filepath of the first colored images.')
    disp('format: ~\test_1_0\*.viz.png')
    filePathFirstColored=input('First colored filepath: ', 's');
    disp(' ');
    disp('Please give the filepath of the second colored images.')
    disp('format: ~\test_1_0\*.viz.png')
    filePathSecondColored=input('Second colored filepath: ', 's');
    
    fileListFirstColored = dir(filePathFirstColored); 
    fileListSecondColored = dir(filePathSecondColored);
    
    [fileListRaw, fileListFirstColored, fileListSecondColored]=checkLength(fileListRaw, fileListFirstColored, fileListSecondColored);
    
    
    if gif_video == 0
        drawImages(filename, fileListRaw, fileListFirstColored, delayTime, 5, fileListSecondColored);
    else
        createVideo(filename, fileListRaw, fileListFirstColored, frameRate, 5, file_ListSecondColored);
    end
 
elseif mode == 6
    %concatenate pictures without any transparency etc.
    disp(' ');
    disp('Please give the filepath of the raw images.')
    disp('format: ~\original_images\test\*.png')
    filePathRaw=input('Raw filepath: ', 's');
    fileListRaw = dir(filePathRaw);
    
    if gif_video == 0
        drawImages(filename, fileListRaw, 'NaN', delayTime, 6);
    else
        createVideo(filename, fileListRaw, 'NaN', frameRate, 6);
    end
    
elseif mode == 7
    %concatenate pictures with overlaying transparent other pictures
    disp(' ');
    disp('Please give the filepath of the raw images.')
    disp('format: ~\original_images\test\*.png')
    filePathRaw=input('Raw filepath: ', 's');
    fileListRaw = dir(filePathRaw);
    
    disp(' ');
    disp('Please give the filepath of the colored images.')
    disp('format: ~\test_1_0\*.viz.png')
    filePathColored=input('Colored filepath: ', 's');
    fileListColored = dir(filePathColored);
    
    [fileListRaw, fileListColored]=checkLength(fileListRaw, fileListColored);
    
    
    if gif_video == 0
        drawImages(filename, fileListRaw, fileListColored, delayTime, 7);
    else
        createVideo(filename, fileListRaw, fileListColored, frameRate, 7);
    end
    
else
    disp('No valid mode!');
end

p = profile('info');
profile off;