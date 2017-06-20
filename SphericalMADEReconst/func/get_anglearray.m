function [ angleArray ] = get_anglearray( number, type)
%GETANGLEARRAY get an array of random angles 
%   angleArray = getanglearray(number, type) get an array of random angles
%   with a given number. There are two types for getting the angle array.
%   type = 0 (default) : auto-generate the angle array by using the
%   function generateanglearray(number).
%   type = 1 : import the angle array from Data/Angles folder.
%   ex : 
%       - getAngleArray(100) : auto-generate 100 random projections 
%       - getAngleArray(100,1) : import an array with 100 projections from
%       Data/Angles folder.

% verify the number of input
switch nargin
    case 1
        type = 0;
end

if type == 0    % call generateanglearray function
    angleArray = generateanglearray(number);   
else    % import from Data folder
    path = 'Data/Angles/angleArray_';
    path = strcat(strcat(path,num2str(number)),'.mat');
    angleArray = importdata(path);
end

end

