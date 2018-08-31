function f = fitFun(x)

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
%%
f = -sum(sum(sum(invTran(3:7,3:7,3:7),3),1))*3+sum(sum(sum(invTran(:,:,:),3),1));
