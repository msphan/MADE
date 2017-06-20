function [ output ] = rmsd( target, origin, nr )
%VMR compute variance to mean ratio - the dispersion of "target" with
%respect to "origin"

if(nr == 1)
      
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
