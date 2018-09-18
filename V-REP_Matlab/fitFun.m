function f = fitFun(x)

% Generate points
points = GMPointsGenerator(x);
% Coordinates
coordinates = coordinatesGenerator(points);
% Plot
% fig = figure; scatter3(coordinates(:,1),coordinates(:,2),coordinates(:,3));
% Write CSV 
csvwrite("../V-REP_Software/Coordinates.csv", coordinates);
%
f = vrep()
%
% close(fig);



