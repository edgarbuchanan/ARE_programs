function coordinates = coordinatesGenerator(Q)
coordinates = [];
for i=2:9
    for j=2:9
        for k=2:9
            if (Q(i,j,k) > 0)
                if(Q(i+1,j,k) > 0 || Q(i-1,j,k) > 0 || ...
                         Q(i,j+1,k) > 0 || Q(i,j-1,k) > 0 || ...
                         Q(i,j,k+1) > 0 || Q(i,j,k-1) > 0)
                        coordinates = [coordinates; [i,j,k]];
                 end
            end
        end
    end
end