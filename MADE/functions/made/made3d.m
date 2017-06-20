function [ D ] = made3d( sino, p, opt )
%MADE3D Summary of this function goes here
%   Detailed explanation goes here

n = size(sino,3);

norm = 0; % normalized moments
IM = getinitialmoments(sino,norm); % initial moments

HM = getHumoments(IM); % Hu moments

% miHM = repmat(min(HM,[],2),[1, n]);
% maHM = repmat(max(HM,[],2),[1, n]);
% HM = (HM - miHM) ./ (maHM - miHM); % normalize Hu moments

D = zeros(n, n);

pscaled = p / 1000;
delta = 2 * pi/2 * (1 - (1 - pscaled).^(1 / (n - 1)))^(1/3);
K = [2,4,6,6,12,8,12]';
mmtmax = max(HM,[],2);

parfor i = 1: n
    
    D(i,:) = made3dpara(IM, HM,i,delta,K,mmtmax,n,opt);
    
%     if (opt.knearest ~= 0) % use k nearest neighbors
%         
%         [~, temp1] = sort(sqrt(sum((HM - repmat(HM(:,i),[1 n])).^2  ./ repmat(std(HM,0,2), [1 n]).^2)));
%         J = temp1(1 : opt.knearest); 
%         
%     else % use adaptive thresholding     
% 
%         temp = abs(HM - repmat(HM(:,i),[1 n])) - repmat(delta * K .* mmtmax,[1 n]);
%         J = find(sum(temp <= 0) == 7);
%         
% %         J = 1 : n;
% %         for j = 1 : 7 % seven H moments
% %             
% %             temp = delta * K(j) * mmtmax(j);
% %             temp1 = find(abs(HM(j,:) - HM(j,i)) <= temp);
% %             J = intersect(J, temp1);
% %          
% %         end
%     
%     end
%       
%     J = setdiff(J,i);
%     
%     nJ = length(J);
%     
%     for k = 1 : nJ
%         
%         D(i,J(k)) = angdiff3d(i,J(k),IM) * 180 / pi;
%         
%     end
    
end

D = min(D,D');

if(opt.jaccard ~= 0)
    
    D = remove_graphshorcuts(D, opt.jaccard);
    
end

if(opt.global == 1)
    
    n_par = 50; % calculate only first 100 projections to reduce executed time
    A = D > 0; % neighborhood matrix
    D(1:n_par, 1:n) = dijkstra3d(A, D, 1:n_par,1:n);
    
end
    
end

