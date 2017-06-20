function [ mmt ] = compute_mmt( sino, d )
%COMPUTE_MMT Compute projection moments of order d

prjD = size(sino, 1);
x = (1 : prjD) - (prjD + 1)/2;
mmt = (x.^d) * sino;

% mmt = zscore(mmt);

end

