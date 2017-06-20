function [ estimatedProjection ] = est_projection( mean, variance, evaArray, eveArray, gamma, noisyProjection)
% ESTIMATEPROJECTION estimate projection from noisy projection and
% parameters used in Singer-Wu method.
%   estimatedProjection = estimateprojection(mean, variance, evaArray,
%   eveArray, gamma, noisyProjection) estimate projection from noisy 
%   projection and parameters used in Singer-Wu method.
%       - mean : mean of projection
%       - variance : variance of noise
%       - evaArray, eveArray : first K eigenvalues and eigenvectors from
%         covariance matrix of noisy projection data

%   For more detail, please read the Singer's article, page 16. This is
%   just the implementation of equation (4.30).

meanShiftNoisyProjection = noisyProjection - mean;
K = length(evaArray);
sum = mean;
for iK = 1 : K

    dotProduct = dot(meanShiftNoisyProjection, eveArray(:,iK));
    SNRk = evaArray(iK) / variance;
    temp = 1 / ( 1 + (1 / ( (SNRk * SNRk - gamma)/(SNRk + gamma) ) ) );
    sum = sum + temp * dotProduct * eveArray(:,iK);  

end

estimatedProjection = sum;