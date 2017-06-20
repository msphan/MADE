function [ noisyProjectionArray, variance ] = addnoise2d( projectionArray, SNR )
%ADDNOISE add noise to projections with a given SNR
%   projectionArray : array of projections
%   SNR : signal to noise ratio (dB)

nProjection = length(projectionArray(1,:));

projectionLength = length(projectionArray(:,1));

noisyProjectionArray = projectionArray;

variance = var(projectionArray(:)) / 10^(SNR / 10);

sigma = sqrt(variance); % deviation

for iProjection = 1 : nProjection,      
  
    noise = 0 + sigma * randn(1, projectionLength);
    
    noisyProjectionArray(:,iProjection) = projectionArray(:,iProjection) + noise';  
    
end

% set negatif values of projections to 0
% noisyProjectionArray(noisyProjectionArray < 0) = 0;


end

