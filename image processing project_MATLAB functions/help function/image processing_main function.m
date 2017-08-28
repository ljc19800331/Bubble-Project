function []=bubble_video()
%write the video from the pictures

for i=1:37
filename=[num2str(i+10),'.jpg'];
images{i}=imread(filename,'jpg');  
end

% create the video writer with 1 fps
writerObj = VideoWriter('myVideo.avi');
writerObj.FrameRate = 37;
% set the seconds per image
secsPerImage = [0.1];
% open the video writer
open(writerObj);

% write the frames to the video
for u=1:length(images)
    % convert the image to a movie frame
    frame = im2frame(images{u});
    %for v=0.1:0.1:0.2
    writeVideo(writerObj, frame);
    %end
end
%movie(M,N,FPS)  
%close the writer object
close(writerObj);



