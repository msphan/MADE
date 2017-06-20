function [] = displayphantom3d_ver1( I )
%SHOW_IMAGE3D display image from 3D matrix voxel by voxel
%   - I : 3D image matrix

I(I==0)=NaN;
cmap=colormap(parula);

patch3Darray(0.9 * I, cmap, 'col')

axis([1 size(I,1) 1 size(I,2) 1 size(I,3)])  
xlabel('X');               
ylabel('Y'); 
zlabel('Z');

box on,                                                 
camproj perspective                                                                       
camlight
lighting phong
colorbar

view(40 + 90, 25)
whitebg('white')

end

