function [ M, m, Mt, mt ] = est_extremes( z, s )
%EXTREMEEST Estimate maximum and minimum of second order moment
% z : set of noisy second order moments
% s : std of noise
% M : maximum second order moment
% m : minimum second order moment

fun = @(xt,Mt,mt,st,z) (1 ./ (2 * pi * ((Mt - xt).*(xt - mt)).^(1/2))) .* (1 ./ (sqrt(2 * pi) .* st)) .* exp((-(z - xt).^2)./ (2 .* st.^2));

% idmi = z >= min(z) & z <= ((median(z)+min(z))/2);
% mt = z(idmi);
% idma = z >= ((median(z) + max(z))/2) & z <= max(z);
% Mt = z(idma);

mt = min(z) : 0.04 : (min(z) + (2 * (median(z) - min(z)))/6);
Mt = (median(z) + (4 * (max(z) - median(z))/6)) : 0.04 : max(z);

mr = -inf;
m = 0;
M = 0;

for i = 1 : length(mt)
    for j = 1 : length(Mt)
        
        r = 1;
        
        for k = 1 : length(z)
            
            r = r * integral(@(x)fun(x,Mt(j),mt(i),s,z(k)),mt(i),Mt(j));
            
        end
        
        if(r > mr)
            
            mr = r;
            m = mt(i);
            M = Mt(j);
        
        end
    
    end

end


end

