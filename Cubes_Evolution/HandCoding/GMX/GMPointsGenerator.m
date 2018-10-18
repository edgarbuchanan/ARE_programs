function points = GMPointsGenerator(x)

mu = [x(1:3);x(4:6)];
sigma = cat(4,[x(7:9)],[x(10:12)]);
gm = gmdistribution(mu,sigma);
points = random(gm,2000);