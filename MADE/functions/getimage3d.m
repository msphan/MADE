function [ I ] = getimage3d( file )
%GET_IMAGE3D read image from file and convert to 3D matrix.
%   - file : path of file  
%   -   the organisation of file is a matrix nZ * nY rows and nX columns.
%       nZ : number of z-coordinate (resp. nY and nX).
%   - I : 3D squared matrix

A = load(file);

% get length of 3D matrix
l = size(A, 2);

% 3D matrix
I = zeros(l, l, l);

% assign A values to I matrix
% suppose that I(i,j,k) corresponds to (x,y,z) coordinates
for i = 1 : l
    
    I(:, :, i) = A((i-1) * l + 1 : i * l, :);
    
end

I(I < 0) = 0; % make sure positive values

end



