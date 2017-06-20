function [ MI ] = getHumoments( ME )
%	calHuMoments function calcule the eight Hu invariant moments
%       ME : essential moment set
%       MI : Hu moment set

MI = zeros(7, size(ME,2));

mmt11 = ME(1,:);
mmt20 = ME(2,:);
mmt02 = ME(3,:);
mmt21 = ME(4,:);
mmt12 = ME(5,:);
mmt30 = ME(6,:);
mmt03 = ME(7,:);

MI(1, :) = mmt20 + mmt02;
MI(2, :) = (mmt20 - mmt02).^2 + 4 * mmt11.^2;
MI(3, :) = (mmt30 - 3 * mmt12).^2 + (3 * mmt21 - mmt03).^2;
MI(4, :) = (mmt30 + mmt12).^2 + (mmt03 + mmt21).^2;
MI(5, :) = (mmt30 - 3 * mmt12) .* (mmt30 + mmt12) .* ((mmt30 + mmt12).^2 - 3 * (mmt21 + mmt03).^2) + (3 * mmt21 - mmt03) .* (mmt21 + mmt03) .* (3 * (mmt30 + mmt12).^2 - (mmt21 + mmt03).^2);
MI(6, :) = (mmt20 - mmt02) .* ((mmt30 + mmt12).^2 - (mmt21 + mmt03).^2) + 4 * mmt11 .* (mmt30 + mmt12) .* (mmt21 + mmt03);
MI(7, :) = (3 * mmt21 - mmt03) .* (mmt30 + mmt12) .* ((mmt30 + mmt12).^2 - 3 * (mmt21 + mmt03).^2) -...
            (mmt30 - 3 * mmt12) .* (mmt21 + mmt03) .* (3 * (mmt30 + mmt12).^2 - (mmt21 + mmt03).^2);
% MI(8, :) = mmt11 .* ((mmt30 + mmt12).^2 - (mmt03 + mmt21).^2) - (mmt20 - mmt02) .* (mmt30 + mmt12) .* (mmt03 + mmt21);

end

