function [ fullpath ] = getpath( imageSize, imageName )
%GETPATH get full path of image from input folder
%   imageSize : size of image
%   imageName : image's name
%
%   fullpath : output path

root = 'Data/Images/';
fullpath = strcat(root,strcat(imageSize,strcat(num2str(imageName),'.pgm'))); 

end

