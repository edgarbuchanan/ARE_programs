%% Tity up
clc; clear; close all;
%% Add current path
% Determine where your m-file's folder is.
folder = fileparts(which(mfilename));
% Add that folder plus all subfolders to the path.
addpath(genpath(folder));
%% Evaluate
fitness = vrep()
