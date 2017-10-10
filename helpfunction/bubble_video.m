function []=bubble_video(firstimage,lastimage,fps)
%remember, if with a new document, set path for the new document file path

%write the video from the pictures
%clc
%clear all
%close all
%firstimage=11
%lastimage=99
%fps=24;
delta=lastimage-firstimage+1;
for i=1:delta
filename=[num2str(firstimage+i-1),'.jpg'];
images{i}=imread(filename,'jpg');
end
% create the video writer with 1 fps
writerObj = VideoWriter('Video_second.avi');
writerObj.FrameRate = fps;
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
