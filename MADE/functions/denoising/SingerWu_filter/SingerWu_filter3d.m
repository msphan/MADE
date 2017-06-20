function [outPrj] = SingerWu_filter3d( inPrj)
%	WuSingerFilter function denoise projection set using Wu-Singer method in 3D
%       inPrj : input noisy projections
%       outPrj : output denoised projections

prjSize = size(inPrj,1);
nPrj = size(inPrj,3);
dPrj = prjSize * prjSize;

% convert inPrj to 2D matrix in which each column is a projection
convertInPrj = reshape(inPrj,dPrj, nPrj);

% perfom PCA
[eve, ~, eva] = pca(convertInPrj');

% estimate K, sigma^2
beta = 1; % default parameter
alpha = 0.5; % default parameter, must be study !
[K, sigma2] = KN_rankEst(eva, nPrj, beta, alpha);

% estimate top K eigenvalues
evaEst = zeros(K,1);
gamma = 2 * prjSize / nPrj; % default parameter (theorically, should be prjSize * prjSize / nPrj)
for iK = 1 : K
    evaEst(iK) = esteigenvalue(sigma2, gamma, eva(iK));
end

% denoise using equation (4.30)
convertOutPrj = convertInPrj;
meanDimension = mean(convertInPrj,2);
for iN = 1 : nPrj

    denoisedPrj = estprojection(meanDimension, sigma2, evaEst, eve, gamma, convertInPrj(:,iN));
    
    convertOutPrj(:,iN) = denoisedPrj;
    
end

% restore denoised projections using only first K components
% feve = eve(:, 1 : K); % only get first K components
% mfeve = feve * feve';
% reducedConvOutPrj = mfeve * convertOutPrj;

% reconvert output projections
outPrj = reshape(convertOutPrj,prjSize, prjSize, nPrj);

end

