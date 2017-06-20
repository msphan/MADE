% Image reconstruction using MADE measure and Spherical Multidimensional
% Scaling
% author : Phan Minh-Son

clear;
clc;

%% Generate data
res = 128; % image resolution
i = 15; % image id
I = getimage(res, i);
n = 50; % number of projections
angles = linspace(1,180,n);
rid = randperm(n);
angles = angles(rid);
[sino, s] = radon(I, angles); % gen sinogram

%% Reconstruction by MADE
opt.knearest = 3 ; opt.measure = 0; opt.global = 1; opt.jaccard = 0;
p = 0.7;
alpha = 0.03;
dangest = made2d(sino,opt,p,alpha); % build distance matrix
anglesest = smd(dangest); % estimate angles by spherical mutidimensional scaling
[anglesest, sid] = sort(anglesest); 
sinoest = sino(:, sid);
Iest1 = iradon(sinoest, anglesest); % reconstruct image

%% Reconstruction by Euclidian distance
opt.measure = 2; % use Euclidian distance
p = 0.7;
alpha = 0.03;
dangest = made2d(sino,opt,p,alpha);
anglesest = smd(dangest);
[anglesest, sid] = sort(anglesest);
sinoest = sino(:, sid);
Iest2 = iradon(sinoest, anglesest);

%% Display result
figure
subplot(1,3,1), imagesc(I); axis square; xlabel('Original image'); set(gca,'FontSize',30);
subplot(1,3,2), imagesc(Iest2); axis square; xlabel('Euclidian distance'); set(gca,'FontSize',30);
subplot(1,3,3), imagesc(Iest1); axis square; xlabel('MADE'); set(gca,'FontSize',30);
colormap gray






