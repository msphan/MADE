function [ mmts ] = compute_mmts( sino, d )
%COMPUTE_MMTS Compute projection moments of all orders <= d

prjD = size(sino, 1);
x = (1 : prjD) - (prjD + 1)/2;
orders = (1 : d)';
nOrder = length(orders);
base = repmat(x,[nOrder 1]).^(repmat(orders,[1 prjD]));
mmts = base * sino;
% mmts = zscore(mmts,0,2);

end

