function [ D ] = pointpicking( sample )
%GEN_PRJ_DIRECTION generate a set of projection direction

u = rand(1, sample);
v = rand(1, sample);

phi = pi * u - pi/2;
theta = asin(2 * v - 1);

psi = 0 + pi * rand(1, sample);

D = [phi;theta;psi]';

end

