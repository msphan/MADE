function [ da ] = angdiff3d( i, j, EM )
%DANG3D Estimate dang3D between two vertices in graph

mmt11 = EM(1,:);
mmt20 = EM(2,:);
mmt02 = EM(3,:);

mmt20_pr = abs((mmt20 + mmt02) / 2 + (((mmt20 - mmt02).^2 + 4 * mmt11.^2).^(1/2) / 2));
mmt02_pr = abs((mmt20 + mmt02) / 2 - (((mmt20 - mmt02).^2 + 4 * mmt11.^2).^(1/2) / 2));

mmt_max = max(max(mmt20_pr, mmt02_pr));
mmt_med = min(min(mmt20_pr, mmt02_pr));
mmt_min = max(min(mmt20_pr, mmt02_pr));

mmt200 = mmt20_pr(i);
mmt020 = mmt02_pr(i);
mmt110 = 0;
mmt002 = mmt_max + mmt_med + mmt_min - mmt200 - mmt020;
mmt101 = sqrt(abs((-(mmt200 - mmt_max) * (mmt200 - mmt_med) * (mmt200 - mmt_min)) / (mmt200 - mmt020)));
mmt011 = sqrt(abs(((mmt020 - mmt_max) * (mmt020 - mmt_med) * (mmt020 - mmt_min)) / (mmt200 - mmt020)));
T = [mmt200, mmt110, mmt101 ; mmt110, mmt020, mmt011 ; mmt101, mmt011, mmt002];
[eige, ~] = eig(T);
di = abs(eige(3,:));

mmt200 = mmt20_pr(j);
mmt020 = mmt02_pr(j);
mmt110 = 0;
mmt002 = mmt_max + mmt_med + mmt_min - mmt200 - mmt020;
mmt101 = sqrt(abs((-(mmt200 - mmt_max) * (mmt200 - mmt_med) * (mmt200 - mmt_min)) / (mmt200 - mmt020)));
mmt011 = sqrt(abs(((mmt020 - mmt_max) * (mmt020 - mmt_med) * (mmt020 - mmt_min)) / (mmt200 - mmt020)));
T = [mmt200, mmt110, mmt101 ; mmt110, mmt020, mmt011 ; mmt101, mmt011, mmt002];
[eige, ~] = eig(T);
dj = abs(eige(3,:));

da = abs(acos(di * dj'));

end

