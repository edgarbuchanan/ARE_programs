function coordinates = DCTPointsGenerator(x)
%% Create matrix
mat = zeros(20,20,20);
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
points = idct(mat,[],3);
points = idct(points,[],2);
points = idct(points,[],1);
%%
points = abs(points)>1;
%% Coordinates
coordinates = [];
for i=2:19
    for j=2:19
        for k=2:19
            if (points(i,j,k) > 0)
                if(points(i+1,j,k) > 0 || points(i-1,j,k) > 0 || ...
                         points(i,j+1,k) > 0 || points(i,j-1,k) > 0 || ...
                         points(i,j,k+1) > 0 || points(i,j,k-1) > 0)
                        coordinates = [coordinates; [i,j,k]];
                 end
            end
        end
    end
end