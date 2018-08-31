%%
clear; clc; close all;
%% Read image
I = imread('L.jpeg');
%% Apply DCT
J = dct2(I);
%% Draw heatmap before filter
figure
imshow(log(abs(J)),[])
colormap(gca,jet(64))
colorbar
%% Filter
J(abs(J) < 10) = 0;
%% Draw hearmap before filter
figure
imshow(log(abs(J)),[])
colormap(gca,jet(64))
colorbar
%% Inverse transform
K = idct2(J);
%% Plot
figure
imshowpair(I,K,'montage')
title('Original Grayscale Image (Left) and Processed Image (Right)');