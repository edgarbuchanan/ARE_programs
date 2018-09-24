%% Clear up environment
clear; clc; close all;
%% GA Pams
FitnessFunction = @fitFun;
numberOfVariables = 18;
lb = [repmat(-10,1,numberOfVariables/2) repmat(0,1,numberOfVariables/2)];
ub = repmat(10,1,numberOfVariables);
opts = optimoptions(@ga,'PlotFcn',{@gaplotbestf,@gaplotstopping});
%opts.PopulationSize = 2;
%opts = optimoptions(@ga,'PlotFcn',{@gaplotbestf,@gaplotstopping} ...
%    ,'MaxGenerations',30,'MaxStallGenerations', 20);
%% GA
% Run the |ga| solver.
rng default % For reproducibility
[x,Fval,exitFlag,Output] = ga(FitnessFunction,numberOfVariables,[],[],...
    [],[],lb, ub, [], opts);

fprintf('The number of generations was : %d\n', Output.generations);
fprintf('The number of function evaluations was : %d\n', Output.funccount);
fprintf('The best function value found was : %g\n', Fval);

%% Generate points
points = GMPointsGenerator(x);
%% Plot
figure;
scatter3(points(:,1),points(:,2),points(:,3));
% Coordinates
coordinates = coordinatesGenerator(points);
% Plot
figure; scatter3(coordinates(:,1),coordinates(:,2),coordinates(:,3));
% Write CSV 
csvwrite("Coordinates.csv", coordinates);
csvwrite("bestSolution.csv", x);