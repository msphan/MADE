% Estimation of angular difference in 3d
% Author : Son Phan

clear;
clc;

%% generate data

display('generating data...');

n = 1000;
O = pointpicking(n); % get random orientations using point picking algorithm

figure, displaysphere(O); % display orientation distribution on sphere

I = getimage3d('Im3_5.txt'); % load 3d phantom

alpha = 0.2; % thresholding percentage
color = 'magenta'; 
smooth = 5; % number of neighborhood pixels for smoothing
figure, displayphantom3d_ver2(I,alpha,color,smooth);

centered = 1; % centerized flag
sino = getsinopara(I,O,centered); % get sino using parallel toolbox
sino = (sino - min(sino(:))) / (max(sino(:)) - min(sino(:))); % normalize sino before adding noise

ipr = 15; % projection id
figure, imagesc(sino(:,:,ipr)); axis square; % display projection

SNR = 15;
nsino = addnoise3d(sino, SNR); % addnoise

figure, imagesc(nsino(:,:,ipr)); axis square; % display noisy projection

display('==> OK');

%% denoise by Singer-Wu filter

display('denoising sino by Singer-Wu filter...');

dsino = SingerWu_filter3d(nsino); % denoise using Singer-Wu filter

figure, imagesc(dsino(:,:,ipr)); axis square; % display denoised projection

display('==> OK');

%% estimate angular difference using MADE

display('estimating angular difference by MADE...');

opt.knearest = 0; % don't use k nearest neighbors
opt.jaccard = 0.3; % remove neighborhood graph by jaccard index
opt.global = 1; % use dijkstra's algorithm
p = 0.9; % probability
D = made3d(dsino, p, opt); % estimate angular difference

display('==> OK');

%% evaluate error

err = esterror3d(D,O) * 100;

display(['estimated error = ', num2str(err), ' %']);



