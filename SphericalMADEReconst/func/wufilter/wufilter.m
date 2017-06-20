function [ outPrj, K ] = wufilter(inPrj)
% DENOISE Denoise the noisy projection array by using the Singer-Wu method
%   denoisePrjArray = denoise(noisyPrjArray) denoise projection array from
%   noisy projection array by using Singer-Wu method.

nPrj = size(inPrj,2);
prjD = size(inPrj,1);

% perfom PCA
[eve, ~, eva] = pca(inPrj');

% estimate K, sigma^2
beta = 1; % default parameter
alpha = 0.5; % default parameter, must be study !
[K, sigma2] = KN_rankEst(eva, nPrj, beta, alpha);

if K > 0 
    
    % estimate top K eigenvalues
    evaEst = zeros(K,1);
    gamma = prjD / nPrj; % default parameter (theorically, should be prjSize * prjSize / nPrj)
    for iK = 1 : K
        evaEst(iK) = est_eigenvalue(sigma2, gamma, eva(iK));
    end

    % denoise using equation (4.30)
    outPrj = inPrj;
    meanDimension = mean(inPrj,2);
    for iN = 1 : nPrj

        denoisedPrj = est_projection(meanDimension, sigma2, evaEst, eve, gamma, inPrj(:,iN));

        outPrj(:,iN) = denoisedPrj;

    end
     
else
    
    outPrj = inPrj; % faire rien
    
end



end

