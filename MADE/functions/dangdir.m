function [ dang ] = dangdir( D1, D2 )
%GETDANGFRDIR compute angular difference between two directions.
%D1 and D2 are a set of three angles phi, theta and psi

phi = D1(1); theta = D1(2); 
dr1 = [sin(theta), -sin(phi) * cos(theta), cos(phi) * cos(theta)];

phi = D2(1); theta = D2(2); 
dr2 = [sin(theta), -sin(phi) * cos(theta), cos(phi) * cos(theta)];

dang = acos(sum(dr1 .* dr2)) * 180 / pi;
% if dang > 180 - dang, dang = 180 - dang; end

end

