function [ I ] = getimage(size, name )
%GETIMAGE Get image with a given size and name.
%   I = getimage(size, name) get image with a given size and name. All 
%   images are in Data folder. The input parameters are numbers.
%   Example : I = getImage(64,1) get the image with name 1 and size
%   64 x 64 pixels from Data folder.

path = 'phantoms/'; % root image's path

% concat size to path
switch size
    case 32
        path = strcat(path,'Im2_'); 
    case 64
        path = strcat(path,'Im3_');
    case 128
        path = strcat(path,'Im4_');
    case 256
        path = strcat(path,'Im5_');
end

% concat name to path
path = strcat(strcat(path,num2str(name)),'.pgm');

% get image from full path
I = imread(path);

end

