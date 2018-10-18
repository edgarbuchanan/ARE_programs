%% Clear up environment
clear; clc; close all;
%% GA Pams
FitnessFunction = @fitFun;
numberOfVariables = 27;
%lb = repmat(1,1,numberOfVariables);
%ub = repmat(10,1,numberOfVariables);
opts = optimoptions(@ga,'PlotFcn',{@gaplotbestf,@gaplotstopping});
%opts.PopulationSize = 2;
%opts = optimoptions(@ga,'PlotFcn',{@gaplotbestf,@gaplotstopping} ...
%    ,'MaxGenerations',30,'MaxStallGenerations', 20);
%% GA
% Run the |ga| solver.
rng default % For reproducibility
%[x,Fval,exitFlag,Output] = ga(FitnessFunction,numberOfVariables,[],[],...
%    [],[],lb, ub, [], opts);
[x,Fval,exitFlag,Output] = ga(FitnessFunction,numberOfVariables,[],[],...
    [],[],[], [], [], opts);


fprintf('The number of generations was : %d\n', Output.generations);
fprintf('The number of function evaluations was : %d\n', Output.funccount);
fprintf('The best function value found was : %g\n', Fval);

%%
%% Create matrix
mat = zeros(10,10,10);
%% Assign variable to matrix
mutSize = nthroot(size(x,2),3);
count = 0;
for i = 1:mutSize
    for j = 1:mutSize
        for k = 1:mutSize
            count = count + 1;
            mat(i,j,k) = x(count);
        end
    end
end
%%
invTran = idct(mat,[],3);
invTran = idct(invTran,[],2);
invTran = idct(invTran,[],1);
%%
invTran = abs(invTran)>1;
%% Generate coordinates
coordinates = coordinatesGenerator(invTran);
% Plot
figure; scatter3(coordinates(:,1), coordinates(:,2), coordinates(:,3));
%% Write CSV
csvwrite("Coordinates.csv", coordinates);
csvwrite("bestSolution.csv", x);
