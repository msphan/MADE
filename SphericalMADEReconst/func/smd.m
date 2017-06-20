function [ anglesest ] = smd( dangest )
%SMD Spherical mutidimensional scaling  

n = size(dangest,1);

r = max(dangest(:) / pi);
dangest = cos(dangest / r) * r^2 ;

% eigen decomposition
[eigve, eigva] = eig(dangest);
eigva = diag(eigva);
[~, sort_id] = sort(eigva, 'descend');
eigve = eigve(:, sort_id);

% get polar coordinate
Q = eigve(:, [1, 2]);

anglesest = ones(1, n) * -1;
for i = 1 : n
    
    q = Q(i,:);
    q = q / norm(q);
    anglesest(i) = 90 - atan(q(1) / q(2)) * 180 / pi;
    
end

end

