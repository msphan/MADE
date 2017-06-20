function [x, y, z ] = getsphere( A )
% calSphere calculate direction points from direction set A on sphere
% x, y, z : 3d coordinates 

phi = A(:,1);
theta = A(:,2);
x = sin(theta);
y = -sin(phi) .* cos(theta);
z = cos(phi) .* cos(theta);

end

