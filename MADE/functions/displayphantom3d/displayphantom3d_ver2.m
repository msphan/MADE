function [] = displayphantom3d_ver2( I, alpha, color, smooth)
%PLOTSURF3D Summary of this function goes here
%   Detailed explanation goes here

if smooth ~= 0
    I = smooth3(I,'box',smooth);
end

n = size(I,3);
[x,y,z] = meshgrid(1:n);
p = patch(isosurface(x,y,z,I,alpha));
isonormals(x,y,z,I,p);
p.FaceColor = color;
p.EdgeColor = 'none';
daspect([1,1,1])
view(3); axis tight
camlight 
lighting gouraud
set(gca,'FontSize',35);
grid on

end

