function [ output ] = esterror2d( ED, angles )
%VMR compute variance to mean ratio - the dispersion of "target" with
%respect to "origin"

n = length(angles);

D = zeros(n, n); % true angular difference
for i = 1 : n
 for j = i + 1 : n
     D(i,j) = abs(angles(i) - angles(j));
     D(j,i) = D(i,j);
 end
end

% convert to array
DArr = zeros(1, n * n);
EDArr = zeros(1, n * n);
ite = 1;
for i = 1 : n
    for j = i + 1 : n
        
        if(ED(i,j)~=Inf)
            EDArr(ite) = ED(i,j);
            DArr(ite) = D(i,j);
            ite = ite + 1;
        end
        
    end
end

DArr(ite : end) = [];
EDArr(ite : end) = [];

target = EDArr;
origin = DArr;
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


n = length(origin);
output = sqrt(sum((target - origin).^2) / n) / (max(origin) - min(origin));

end
