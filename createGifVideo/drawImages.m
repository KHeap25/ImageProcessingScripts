function drawImages(varargin)
%drawImages This function draws the images depending on the different modes
%and stores it as a gif.
%Params
%varargin{1}: filename
%varargin{2}: fileListRaw
%varargin{3}: fileListColored
%varargin{4}: delayTime
%varargin{5}: mode
%varargin{6}: fileListSecondColored

h = figure;
set(h, 'color', 'k');


if varargin{5} == 1 % Raw | Colored %transparent
    for i = 1:length(varargin{2})
        imgRaw = imread([varargin{2}(i).folder '\' varargin{2}(i).name]);
        imgColored = imread([varargin{3}(i).folder '\' varargin{3}(i).name]);    
        imgBlend = imfuse(imgColored, imgRaw, 'blend');
        img = imfuse(imgRaw, imgBlend, 'montage');

        imshow(img);
        drawnow;

        % Capture the plot as an image
        frame = getframe(h);
        im = frame2im(frame);
        [imind,cm] = rgb2ind(im,256);

        if i == 1
            % DelayTime 1 = 1s and 0.2 = 200ms
            imwrite(imind, cm, varargin{1}, 'gif', 'DelayTime', varargin{4}, 'Loopcount', inf); 
        else
            imwrite(imind, cm, varargin{1}, 'gif', 'DelayTime', varargin{4}, 'WriteMode','append'); 
        end
    end
    
elseif varargin{5} == 2 % Raw | Colored %opaque
    for i = 1:length(varargin{2})
        imgRaw = imread([varargin{2}(i).folder '\' varargin{2}(i).name]);
        imgColored = imread([varargin{3}(i).folder '\' varargin{3}(i).name]);     

        imshow([imgRaw, imgColored]);
        drawnow;

        % Capture the plot as an image
        frame = getframe(h);
        im = frame2im(frame);
        [imind,cm] = rgb2ind(im,256);

        if i == 1
            % DelayTime 1 = 1s and 0.2 = 200ms
            imwrite(imind, cm, varargin{1}, 'gif', 'DelayTime', varargin{4}, 'Loopcount', inf); 
        else
            imwrite(imind, cm, varargin{1}, 'gif', 'DelayTime', varargin{4}, 'WriteMode','append'); 
        end
    end
elseif varargin{5} == 3 % Colored | Colored %transparent

    for i = 1:length(varargin{2})
        imgRaw = imread([varargin{2}(i).folder '\' varargin{2}(i).name]);
        imgColored = imread([varargin{3}(i).folder '\' varargin{3}(i).name]);
        imgSecondColored = imread([varargin{6}(i).folder '\' varargin{6}(i).name]);
        imgBlend1 = imfuse(imgColored, imgRaw, 'blend');
        imgBlend2 = imfuse(imgSecondColored, imgRaw, 'blend');
        img = imfuse(imgBlend1, imgBlend2, 'montage');

        imshow(img);
        drawnow;

        % Capture the plot as an image
        frame = getframe(h);
        im = frame2im(frame);
        [imind,cm] = rgb2ind(im,256);

        if i == 1
            % DelayTime 1 = 1s and 0.2 = 200ms
            imwrite(imind, cm, varargin{1}, 'gif', 'DelayTime', varargin{4}, 'Loopcount', inf); 
        else
            imwrite(imind, cm, varargin{1}, 'gif', 'DelayTime', varargin{4}, 'WriteMode','append'); 
        end
    end
elseif varargin{5} == 5 % Raw | Collored overlaying Colored
    for i = 1:length(varargin{2})
        imgRaw = imread([varargin{2}(i).folder '\' varargin{2}(i).name]);
        imgColored = imread([varargin{3}(i).folder '\' varargin{3}(i).name]);
        imgSecondColored = imread([varargin{6}(i).folder '\' varargin{6}(i).name]);
        imgBlend = imfuse(imgColored, imgSecondColored, 'blend');
        img = imfuse(imgRaw, imgBlend, 'montage');

        imshow(img);
        drawnow;

        % Capture the plot as an image
        frame = getframe(h);
        im = frame2im(frame);
        [imind,cm] = rgb2ind(im,256);

        if i == 1
            % DelayTime 1 = 1s and 0.2 = 200ms
            imwrite(imind, cm, varargin{1}, 'gif', 'DelayTime', varargin{4}, 'Loopcount', inf); 
        else
            imwrite(imind, cm, varargin{1}, 'gif', 'DelayTime', varargin{4}, 'WriteMode','append'); 
        end
    end
elseif varargin{5} == 6 %concatenate imgs to gif
    for i = 1:length(varargin{2})
        imgRaw = imread([varargin{2}(i).folder '\' varargin{2}(i).name]);
        
        imshow(imgRaw);
        drawnow;

        % Capture the plot as an image
        frame = getframe(h);
        im = frame2im(frame);
        [imind,cm] = rgb2ind(im,256);

        if i == 1
            % DelayTime 1 = 1s and 0.2 = 200ms
            imwrite(imind, cm, varargin{1}, 'gif', 'DelayTime', varargin{4}, 'Loopcount', inf); 
        else
            imwrite(imind, cm, varargin{1}, 'gif', 'DelayTime', varargin{4}, 'WriteMode','append'); 
        end
    end
elseif varargin{5} == 7 %concatenate imgs with overlaying transparent other image to gif 
    for i = 1:length(varargin{2})
        imgRaw = imread([varargin{2}(i).folder '\' varargin{2}(i).name]);
        imgColored = imread([varargin{3}(i).folder '\' varargin{3}(i).name]);
        img = imfuse(imgRaw, imgColored, 'blend');
       
        imshow(img);
        drawnow;

        % Capture the plot as an image
        frame = getframe(h);
        im = frame2im(frame);
        [imind,cm] = rgb2ind(im,256);

        if i == 1
            % DelayTime 1 = 1s and 0.2 = 200ms
            imwrite(imind, cm, varargin{1}, 'gif', 'DelayTime', varargin{4}, 'Loopcount', inf); 
        else
            imwrite(imind, cm, varargin{1}, 'gif', 'DelayTime', varargin{4}, 'WriteMode','append'); 
        end
    end
    
end

close all;
end

