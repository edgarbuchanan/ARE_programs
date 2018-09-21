function f = fitFun(x)

% Generate points
points = GMPointsGenerator(x);
% Get coordinates
coordinates = coordinatesGenerator(points);
% Write CSV 
csvwrite("../V-REP_Software/Coordinates.csv", coordinates);
% Return fitness from simulation
f = vrep();
