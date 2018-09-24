%% Tity up
clc; clear; close all;
%% Add current path
% Determine where your m-file's folder is.
folder = fileparts(which(mfilename));
% Add that folder plus all subfolders to the path.
addpath(genpath(folder));
%% Import best solution
bestSol = importdata('bestSolution.csv');
%% GA Pams
FitnessFunction = @fitFun;
numberOfVariables = 27;
% lb = [repmat(-10,1,numberOfVariables/2) repmat(0,1,numberOfVariables/2)];
% ub = repmat(10,1,numberOfVariables);
opts = optimoptions(@ga,'PlotFcn',{@gaplotbestf,@gaplotstopping});
opts.PopulationSize = 30;
opts.MaxGenerations = 100;
opts.MaxStallGenerations = 10;
opts.InitialPopulationMatrix = repmat(bestSol,30,1);
%% GA
% Run the |ga| solver.
% rng default % For reproducibility
rng shuffle % For reproducibility
% [x,Fval,exitFlag,Output] = ga(FitnessFunction,numberOfVariables,[],[],...
%     [],[],lb, ub, [], opts);
[x,Fval,exitFlag,Output] = ga(FitnessFunction,numberOfVariables,[],[],...
    [], [], [], [], [], opts);

fprintf('The number of generations was : %d\n', Output.generations);
fprintf('The number of function evaluations was : %d\n', Output.funccount);
fprintf('The best function value found was : %g\n', Fval);
%% Evaluate best solution
vrep();
%% Store resutls
print('Performance', '-dpng');
csvwrite('BestGenotype.csv', x);