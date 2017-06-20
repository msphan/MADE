function [ noisyProjectionArray, variance ] = addnoise( projectionArray, SNR )
%ADDNOISE add noise to projections with a given SNR
%   projectionArray : array of projections
%   SNR : signal to noise ratio (dB)

nProjection = length(projectionArray(1,:));

noisyProjectionArray = projectionArray;

for iProjection = 1 : nProjection, 
          
    Ps = projectionArray(:,iProjection);
    moy = 0;        % moyenne
    bruit   = randn(size(Ps));
    b       = sum(bruit.^2);
    s       = sum(Ps.^2);      
    sigma   = sqrt(10.^(-SNR/10)*s/b);
    bruit   = moy + sigma*bruit;
    noisyProjectionArray(:,iProjection) = Ps + bruit;
    
    variance = sigma^2;
 
end

end

