function [ output ] = esterror3d( ED, O )
%ESTERROR3D Summary of this function goes here
%   Detailed explanation goes here

n = size(O,1); % number of projections

D = zeros(n, n); % true angular difference
for i = 1 : n
    for j = i + 1 : n
        D(i,j) = dangdir(O(i,:), O(j,:));
        D(j,i) = D(i,j);
    end
end

id = find(ED > 0 & ED ~= Inf);
target = ED(id);
origin = D(id);

norm = 1;

if(norm == 1)
      
    minco = 0;
    maxco = 90;
    minan = min(origin);
    maxan = max(origin);
    origin = minco * (1 - (origin - minan) ./ (maxan - minan)) + ...
                             maxco * ((origin - minan) ./ (maxan - minan));

    minco = min(origin);
    maxco = max(origin);
    minan = min(target);
    maxan = max(target);
    target = minco * (1 - (target - minan) ./ (maxan - minan)) + ...
                             maxco * ((target - minan) ./ (maxan - minan));
end


no = length(origin);
output = sqrt(sum((target - origin).^2) / no) / (max(origin) - min(origin));


end

