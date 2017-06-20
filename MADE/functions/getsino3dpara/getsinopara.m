function [ S ] = getsinopara( I, D, opt )
% getPrj get projection set from image I and direction set D
%   S : 3D sinogram

prj_length = size(I,1);

if(opt == 1)

    c = calCentroid(I); % get centroid of I

    % compute tensor matrix of 3D image
    mmt200 = calImageMoment(I, c, 2, 0, 0);
    mmt110 = calImageMoment(I, c, 1, 1, 0);
    mmt101 = calImageMoment(I, c, 1, 0, 1);
    mmt020 = calImageMoment(I, c, 0, 2, 0);
    mmt011 = calImageMoment(I, c, 0, 1, 1);
    mmt002 = calImageMoment(I, c, 0, 0, 2);

    T = [ mmt200, mmt110, mmt101 ; mmt110, mmt020, mmt011 ; mmt101, mmt011, mmt002 ];

    [eigvec, ~] = eig(T);

    eigvec = eigvec'; % this is rotation matrix back to principal axe
    
end

dir_num = size(D,1);
S = zeros(prj_length, prj_length, dir_num);

parfor dir_i = 1 : dir_num

    S(:, :, dir_i) = getsinopara_ele(I, D(dir_i,:), eigvec);
       
end


end