function points = GMPointsGenerator(x)

%% Generate points
mu = [x(1:3);x(4:6);x(7:9)];
sigma = cat(4,[x(10:12)],[x(13:15)],[x(16:18)]);
gm = gmdistribution(mu,sigma);
points = random(gm,3000);
%% Measuring density
% Granularity
gran = 0.5;
% Thershold or number of neighbours
threshold = 2;
% Limits
rangelim = [ceil(max(points)); floor(min(points))];
% Generate matrix. Overestimate
matPrint = zeros(abs(diff(rangelim(:,1)))/gran+3, ...
    abs(diff(rangelim(:,2)))/gran+3, abs(diff(rangelim(:,3)))/gran+3);
%% Generate list of coordinates
coordinates = [];
i = 2;
j = 2;
k = 2;
for a = rangelim(2,1):gran:rangelim(1,1)
    for b = rangelim(2,2):gran:rangelim(1,2)
        for c = rangelim(2,3):gran:rangelim(1,3)
            % Count number of neighbours
            matPrint(i,j,k) = sum(points(:,1)>(a-gran/2) & points(:,1)<(a+gran/2) & ...
                (points(:,2)>(b-gran/2) & points(:,2)<(b+gran/2)) & (points(:,3)>(c-gran/2) & points(:,3)<(c+gran/2)));
            % If the number of neighbours is greater than ... then
            % register coordinates
            if (matPrint(i,j,k)>threshold)
                % Prevent isoleted cubes
                if(matPrint(i+1,j,k) > threshold || matPrint(i-1,j,k) > threshold || ...
                        matPrint(i,j+1,k) > threshold || matPrint(i,j-1,k) > threshold || ...
                        matPrint(i,j,k+1) > threshold || matPrint(i,j,k-1) > threshold)
                    
                        coordinates = [coordinates; [i j k]];
                end
            end
            k = k + 1;
        end
        k = 2;
        j = j+ 1;
    end
    j = 2;
    i = i +1;
end