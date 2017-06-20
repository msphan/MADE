% Estimation of angular difference in 2d
% Author : Son Phan

clear;
clc;

%% generate data

display('generating data...');

res = 256; % resolution
i = 10; % image id
I = getimage2d(res, i);

figure, imagesc(I); axis square; colormap gray; % display image

n = 400; % number of angles
angles = -90 + 180 * rand(1, n);

[sino, s] = radon(I, angles); % sinogram of image

figure, imagesc(sino); % display sino

SNR = 15;
nsino = addnoise2d(sino,SNR); % add noise to sino

figure, imagesc(nsino); % display noisy sino

display('==> OK');

%% denoise by Singer-Wu filter

display('denoising sino by Singer-Wu filter...');

dsino = SingerWu_filter2d(nsino); % denoise using Singer-Wu filter

figure, imagesc(dsino); % display denoised sino by Singer-Wu filter

display('==> OK');

%% estimate angular difference using MADE

display('estimating angular difference by MADE...');

opt.knearest = 0; % don't use k nearest neighbors
opt.salzman = 0; % don't use exact formula
opt.jaccard = 0.15; % remove graph shortcuts
opt.global = 1; % apply Dijkstra's algorithm
p = 0.9999; % parameter for each order of moments, depends to noise
alpha = 0.1; % for thresholds a(M), b(M)

ED = made2d(dsino,opt,p,alpha); % estimate angular differences
ED = ED * 180 / pi; % convert to degree

display('==> OK');

%% evaluate error

err = esterror2d(ED, angles) * 100;

display(['==> Estimated error = ', num2str(err), ' %']);


