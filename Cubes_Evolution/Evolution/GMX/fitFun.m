function f = fitFun(x)

% Generate points
points = GMPointsGenerator(x);
%% Cube-ish
% f = -sum(points(:,1)>2 & points(:,1)<4 & points(:,2)>2 & points(:,2)<4 ...
%     & points(:,3)>2 & points(:,3)<4);
%% Two cube-ishs
% fa = -sum(points(:,1)>2 & points(:,1)<4 & points(:,2)>2 & points(:,2)<4 ...
%     & points(:,3)>2 & points(:,3)<4);
% fb = -sum(points(:,1)>3 & points(:,1)<5 & points(:,2)>3 & points(:,2)<5 ...
%     & points(:,3)>3 & points(:,3)<5);
% f = fa + fb;
%% Cylinder
% f = -sum(hypot(points(:,1),points(:,2))<2 & points(:,3)>3 & points(:,3)<5); 
%% Cylinder + density
% % Granularity
% gran = 0.25;
% % Thershold or number of neighbours
% threshold = 1;
% % Limits
% rangelim = [ceil(max(points)); floor(min(points))];
% f = 0;
% % Generate list of coordinates
% for a = rangelim(2,1):gran:rangelim(1,1)
%     for b = rangelim(2,2):gran:rangelim(1,2)
%         for c = rangelim(2,3):gran:rangelim(1,3)
%             if(hypot(a,b)<2 & c>-2 & c<2)
%                 f = f + 2;
%                 pointsNeg = sum(points(:,1)>(a-gran/2) & points(:,1)<(a+gran/2) & ...
%                     (points(:,2)>(b-gran/2) & points(:,2)<(b+gran/2)) & (points(:,3)>(c-gran/2) & points(:,3)<(c+gran/2)));
%                 if(pointsNeg > threshold)
%                    f = f + 4; 
%                 else
%                    f = f - 1; 
%                 end
%             else
%                 f = f - 1;
%             end
%         end
%     end
% end
% f = -f;
%% Cube + density
gran = 0.5;
% Thershold or number of neighbours
threshold = 0;
% Limits
rangelim = [ceil(max(points)); floor(min(points))];
f = 0;
% Generate list of coordinates
for a = rangelim(2,1)+gran:gran*2:rangelim(1,1)-gran
    for b = rangelim(2,2)+gran:gran*2:rangelim(1,2)-gran
        for c = rangelim(2,3)+gran:gran*2:rangelim(1,3)-gran
            % Sum points within interval
            pointsNeg = sum(points(:,1)>(a-gran) & points(:,1)<(a+gran) & ...
                    (points(:,2)>(b-gran) & points(:,2)<(b+gran)) & (points(:,3)>(c-gran) & points(:,3)<(c+gran)));
            % Rewards if points are within interval    
            if(a>=3 && a<7 && b>=3 && b<7 && c>=3 && c<7)
                %f = f + 2;        
                if(pointsNeg > threshold)
                   f = f + 1;  
                end
            % Penalize if points are out of interval
            else
                if(pointsNeg > threshold)
                    f = f - pointsNeg; % Prevent points accumulation
                end
            end
        end
    end
end
f = -f;
%sum(points(:,1)>(3-gran) & points(:,1)<(3+gran) & points(:,2)>(3-gran) & points(:,2)<(3+gran) & points(:,3)>(3-gran) & points(:,3)<(3+gran));


