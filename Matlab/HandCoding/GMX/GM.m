%% Clear environment
clear; clc; close all;
%% Define coefficiantes for two gaussian distributions
x = [0 3 0 0 2.5 0 1 0.1 0.25 0.01 0.25 0.25];
%% Create gaussian distribution and create points
points = GMPointsGenerator(x);
% Plot points
figure; scatter3(points(:,1),points(:,2),points(:,3));
%% Generate coordiantes
coordinates = coordinatesGenerator(points);
% Plot points
figure; scatter3(coordinates(:,1),coordinates(:,2),coordinates(:,3));
%% Write CSV 
csvwrite("Coordinates.csv", coordinates);
