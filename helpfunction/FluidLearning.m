%% Fluid type classification based on GLCM method
clc;close all;clear all;
%% Preprocessing of the data
PreProcess_background;
k = 1;                                  % The k th image
PreProcess;
RGB = imabsdiff(RGB_original,img_background);
I = rgb2gray(RGB);
%% 


%% 



%% 