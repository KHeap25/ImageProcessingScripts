function createVideo(varargin)
%createVideo: This function creates a video of the frames depending on the 
%different modes.
%Params
%varargin{1}: filename
%varargin{2}: fileListRaw
%varargin{3}: fileListColored
%varargin{4}: frameRate
%varargin{5}: mode
%varargin{6}: fileListSecondColored

% open video handler
video_handler = VideoWriter(varargin{1});
video_handler.FrameRate = varargin{4}; %43%24;%5.2;
open(video_handler);

fig = figure;
set(fig, 'color', 'k');

if varargin{5} == 1 % Raw | Colored %transparent
    for i = 1:length(varargin{2})      
        imgRaw = imread([varargin{2}(i).folder '\' varargin{2}(i).name]);
        imgColored = imread([varargin{3}(i).folder '\' varargin{3}(i).name]);    
        imgBlend = imfuse(imgColored, imgRaw, 'blend');
        img = imfuse(imgRaw, imgBlend, 'montage');
        imshow(img);
        frame = getframe(gcf);
        writeVideo(video_handler, frame);
        
    end
    
elseif varargin{5} == 2 % Raw | Colored %opaque
    for i = 1:length(varargin{2})
        imgRaw = imread([varargin{2}(i).folder '\' varargin{2}(i).name]);
        imgColored = imread([varargin{3}(i).folder '\' varargin{3}(i).name]);     
        imshow([imgRaw, imgColored]);
        frame = getframe(gcf);
        writeVideo(video_handler, frame);
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
        frame = getframe(gcf);
        writeVideo(video_handler, frame);
     
     end
    
elseif varargin{5} == 5 % Raw | Collored overlaying Colored
    
    for i = 1:length(varargin{2})
        imgRaw = imread([varargin{2}(i).folder '\' varargin{2}(i).name]);
        imgColored = imread([varargin{3}(i).folder '\' varargin{3}(i).name]);
        imgSecondColored = imread([varargin{6}(i).folder '\' varargin{6}(i).name]);
        imgBlend = imfuse(imgColored, imgSecondColored, 'blend');
        img = imfuse(imgRaw, imgBlend, 'montage');
        imshow(img);
        frame = getframe(gcf);
        writeVideo(video_handler, frame);
    end
        
elseif varargin{5} == 6 % concatenate pictures without transparency etc.
   for i = 1:length(varargin{2})       
        imgRaw = imread([varargin{2}(i).folder '\' varargin{2}(i).name]);
        imshow(imgRaw);
        frame = getframe(gcf);
        writeVideo(video_handler, frame);
   end

elseif varargin{5} == 7 %concatenate pictures with overlaying transparent other pictures
     for i = 1:length(varargin{2})
        imgRaw = imread([varargin{2}(i).folder '\' varargin{2}(i).name]);
        imgColored = imread([varargin{3}(i).folder '\' varargin{3}(i).name]);
        img = imfuse(imgColored, imgRaw, 'blend');
        imshow(img);
        frame = getframe(gcf);
        writeVideo(video_handler, frame);
     end 
end

%close video handler
close(video_handler);
close(fig);
end

