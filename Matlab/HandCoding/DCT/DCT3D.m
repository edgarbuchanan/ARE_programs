%%
clear; clc; close all;
%% Read image
I = imread('L.jpeg');
%% Apply DCT
J = dct2(I);
%% Filter
J(abs(J) < 10) = 0;
%% Inverse transform
K = idct2(J);
%%
matPrint = zeros(10,10,10);
%%
for i=1:1
    matPrint(:,:,i) = J;
end
%% Mutate
matPrint = matPrint + randn(10,10,10)*5;
%%
T = idct(matPrint,[],3);
O = idct(T,[],2);
P = idct(O,[],1);
%%
Q = abs(P)>10;
%% Generate coordinates
coordinates = coordinatesGenerator(Q);
% Plot
figure; scatter3(coordinates(:,1), coordinates(:,2), coordinates(:,3));
%% Write CSV
csvwrite("Coordinates.csv", coordinates);
