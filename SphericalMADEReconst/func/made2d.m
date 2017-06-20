function [ D, mmt ] = made2d( sino, opt, p, alpha )
%DANG2D compute the angular difference between tomographic projections in 2D
%   input :
%       sino : sinogram in which columns are projections
%       p    : probability 0 <= p <= 1
%       alpha: threshold for distinguishing the three angular difference estimation formulae
%       opt  : option structure
%               - opt.knearest = 0 : using threshold to find
%                 projection neighbors
%               - opt.measure = 0 : compute dang between
%                 neighbors using approximation of Salzman method
%               - opt.measure = 1 : use Salzman formulation
%               - opt.measure = 2 : use Euclidian distance
%               - opt.global = 0 : don't use dijkstra's algo
%               - opt.jaccard ~= 0 : using jaccard index to denoise
%                 neighborhood graph
%   output :
%       D    : distance matrix (in radian), where D(i,j) = angular difference bt prj i and prj j

%% check input parameters and set defult parameters
switch nargin

    case 1
        opt = struct('global',0,'knearest',0,'measure',0);
        p = [0.95, 0.95, 0.8, 0.8, 0.8];
        alpha = 0.02;  
    case 2
        p = [0.95, 0.95, 0.8, 0.8, 0.8];
        alpha = 0.02;
    case 3
        alpha = 0.02;     
end

%% compute projection moments

[prjD, nPrj] = size(sino);
x = (1 : prjD) - (prjD + 1)/2;
orders = (1 : 5)';
nOrder = length(orders);
base = repmat(x,[nOrder 1]).^(repmat(orders,[1 prjD]));
mmt = base * sino;

stdmmt = repmat(std(mmt,[],2),[1 nPrj]);
mmt = mmt ./ stdmmt;
mmt(isnan(mmt)) = 0;
% mmt = zscore(mmt,0,2);

%% find neighbors of each prj and compute their angular differences
delta = 2 * pi/2 * (1 - (1 - p).^(1 / (nPrj - 1)));
mmtmax = max(abs(mmt),[],2);
mmtmin = min(abs(mmt),[],2);
D = zeros(nPrj, nPrj);
for i = 1 : nPrj
    
    % find neighbors of each prj
    J = 1 : nPrj;
    if(opt.knearest == 0)
       for j = 1 : nOrder

            temp = delta * j * mmtmax(j);
            temp1 = find(abs(mmt(j,:) - mmt(j,i)) <= temp);
            J = intersect(J, temp1);
        
       end
    else
        [~, temp1] = sort(sqrt(sum((mmt - repmat(mmt(:,i),[1 nPrj])).^2  ./ repmat(std(mmt,0,2), [1 nPrj]).^2)));
        J = temp1(1 : opt.knearest);
    end
    
    J = setdiff(J,i);
    
    % compute their angular differences
    nJ = length(J);

    
    if (opt.measure == 0) % use approximation of Salzman method

       for k = 1 : nJ
          
          if((mmtmax(2) - mmt(2,i) <= alpha * (mmtmax(2) - mmtmin(2))) && (mmtmax(2) - mmt(2,J(k)) <= alpha * (mmtmax(2) - mmtmin(2))))
               nume = abs(sqrt(mmtmax(2) - mmt(2,i)) - sqrt(mmtmax(2) - mmt(2,J(k))));
               deno = sqrt(mmtmax(2) - mmtmin(2));
               D(i,J(k)) = nume / deno;
          elseif((mmt(2,i) - mmtmin(2) <= alpha * (mmtmax(2) - mmtmin(2))) && (mmt(2,J(k)) - mmtmin(2) <= alpha * (mmtmax(2) - mmtmin(2))))
               nume = abs(sqrt(mmt(2,i) - mmtmin(2)) - sqrt(mmt(2,J(k)) - mmtmin(2)));
               deno = sqrt(mmtmax(2) - mmtmin(2));
               D(i,J(k)) = nume / deno;
          else
               nume = abs(mmt(2,i) - mmt(2,J(k)));
               deno = 2 * sqrt((mmtmax(2) - mmt(2,i)) * (mmt(2,i) - mmtmin(2)));
               D(i,J(k)) = nume / deno;
          end
          
       end
       
    elseif (opt.measure==1) % use Salzman method
       
       for k = 1 : nJ
          
          a = asin( sqrt( (mmtmax(2) - mmt(2,i)) / (mmtmax(2) - mmtmin(2)) ) );
          b = asin( sqrt( (mmtmax(2) - mmt(2,J(k))) / (mmtmax(2) - mmtmin(2)) ) );
          D(i,J(k)) = abs(a - b);
          
       end
       
    else % use Euclidian distance
        
       for k = 1 : nJ
          
         D(i,J(k)) = sqrt( sum((sino(:,i) - sino(:,J(k))).^2) );
          
       end
    
    end

end

% make symetry
D = min(D, D');


%% remove shorcut edges of neighborhood graph
if(opt.jaccard ~= 0)
    
    D = remove_shorcut_graph(D,opt.jaccard);
      
end

%% compute angular difference bt any two prjs using Dijkstra's Algo if opt.global = 1
if(opt.global == 1)
    
    D = dijkstra(D);
    
end

end

