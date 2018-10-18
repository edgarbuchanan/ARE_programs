function f = fitFun(x)

%% Generate coordinates
% GMX
% coordinates = GMPointsGenerator(x);
% DCT
coordinates = DCTPointsGenerator(x);
%% Write CSV 
csvwrite("../V-REP_Software/Coordinates.csv", coordinates);
%% Return fitness from simulation
f = vrep();
