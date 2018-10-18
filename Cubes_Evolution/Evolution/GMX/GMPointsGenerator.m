function points = GMPointsGenerator(x)

%mu = [x(1:3);x(4:6)];
%sigma = cat(4,[x(7:9)],[x(10:12)]);
mu = [x(1:3);x(4:6);x(7:9)];
sigma = cat(4,[x(10:12)],[x(13:15)],[x(16:18)]);
% mu = [x(1:3);x(4:6);x(7:9);x(10:12)];
% sigma = cat(4,x(13:15),x(16:18),x(19:21),x(22:24));
gm = gmdistribution(mu,sigma);
points = random(gm,3000);