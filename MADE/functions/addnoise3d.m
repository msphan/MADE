function [ noisyS, sigma ] = addnoise3d( S, SNR )
%ADD_NOISE Summary of this function goes here
%   Detailed explanation goes here

nPr = size(S,3);
noisyS = S;

sigma = zeros(1, nPr);

for i = 1 : nPr
   
   Pr = S(:,:,i);
   
   v = var(Pr(:)) / 10^(SNR / 10);

   noisePr = imnoise(Pr,'gaussian',0,v);
   
   noisyS(:,:,i) = noisePr;
   
   sigma(i) = sqrt(v);

end

