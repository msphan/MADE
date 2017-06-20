function [ D ] = made3dpara( IM, HM, i, delta, K, mmtmax, n, opt )
%FINDNEIGHBORSPARA Summary of this function goes here
%   Detailed explanation goes here

if (opt.knearest ~= 0) % use k nearest neighbors
        
        [~, temp1] = sort(sqrt(sum((HM - repmat(HM(:,i),[1 n])).^2  ./ repmat(std(HM,0,2), [1 n]).^2)));
        J = temp1(1 : opt.knearest); 
        
else % use adaptive thresholding     

    temp = abs(HM - repmat(HM(:,i),[1 n])) - repmat(delta * K .* mmtmax,[1 n]);
    J = find(sum(temp <= 0) == 7);

end

J = setdiff(J,i);

nJ = length(J);

D = zeros(1, n);

for k = 1 : nJ

    D(J(k)) = angdiff3d(i,J(k),IM) * 180 / pi;

end


end

