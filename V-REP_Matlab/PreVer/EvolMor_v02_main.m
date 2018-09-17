%% Tity up
clc; clear; close all;

%% Add current path
% Determine where your m-file's folder is.
folder = fileparts(which(mfilename));
% Add that folder plus all subfolders to the path.
addpath(genpath(folder));
%% Terminal commands
% command = './Script.sh';
% status = system(command)
%%
% command = 'openscad -o Render.stl Render.scad';
% status = system(command)
% %%
% command = 'gnome-terminal -e "openscad -o Render.stl Render.scad"';
% status = system(command)
% pause(2)
% %%
% command = 'gnome-terminal -- bash -c "openscad && bash"';
% status = system(command)
%% Evaluate
fitness = vrep();