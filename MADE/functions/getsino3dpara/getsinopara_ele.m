function [ prj ] = getsinopara_ele( I, dir, eigvec)
% getPrj get projection set from image I and a direction dir
%   S : 3D sinogram

prj_length = size(I,1);
ce = (prj_length + 1) / 2;
r = (prj_length - 1) / 2; % sphere radius
    
prj = zeros(prj_length, prj_length); 

phi = dir(1);
theta = dir(2);
psi = dir(3);

cPhi = cos(-phi);
sPhi = sin(-phi);

cTheta = cos(-theta);
sTheta = sin(-theta);

cPsi = cos(-psi);
sPsi = sin(-psi);

R = [cTheta * cPsi,  sPhi * sTheta * cPsi - cPhi * sPsi,  cPhi * sTheta * cPsi + sPhi * sPsi;
     cTheta * sPsi,  sPhi * sTheta * sPsi + cPhi * cPsi,  cPhi * sTheta * sPsi - sPhi * cPsi;
     -sTheta,        sPhi * cTheta,                       cPhi * cTheta];

for k = 1 : prj_length
    for j = 1 : prj_length
        for i = 1 : prj_length

            x = i - ce;
            y = j - ce;
            z = k - ce;

            if x^2 + y^2 + z^2 <= r^2

                temp = eigvec * [x, y, z]';
                p = R * temp;

                xf = floor(p(1));
                xc = ceil(p(1));

                yf = floor(p(2));
                yc = ceil(p(2)); 

                if(xf + ce > 0 && yf + ce > 0 && xc + ce <= prj_length && yc + ce <= prj_length)

                    prj(xf + ce, yf + ce) = (1 - (p(1) - xf)) * (1 - (p(2) - yf)) *  I(i,j,k) + prj(xf + ce, yf + ce);
                    prj(xf + ce, yc + ce) = (1 - (p(1) - xf)) * (p(2) - yf) *  I(i,j,k) + prj(xf + ce, yc + ce);
                    prj(xc + ce, yf + ce) = (p(1) - xf) * (1 - (p(2) - yf)) *  I(i,j,k) + prj(xc + ce, yf + ce);
                    prj(xc + ce, yc + ce) = (p(1) - xf) * (p(2) - yf) *  I(i,j,k) + prj(xc + ce, yc + ce);

                end

            end

        end
    end
end
    

end