function [ x, y, z ] = getspherepoint( A, i )
% calSpherePoint calculate 3d coordinate from a given direction
%   input : 
%       A : input direction set
%       i : projection id
%   output :
%       x, y, z : coordinate

phi_iPr = A(i,1);
theta_iPr = A(i,2);
x = sin(theta_iPr);
y = -sin(phi_iPr) .* cos(theta_iPr);
z = cos(phi_iPr) .* cos(theta_iPr);

end

