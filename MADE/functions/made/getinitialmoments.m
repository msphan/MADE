function [ M ] = getinitialmoments( S, opt )
%	calEssentialMoments function calcule the essential moments of
%	2D projection set
%       S : 3D sinogram
%       M : essential moment set

prjLength = size(S,1);

ndir = size(S,3);

M = zeros(7, ndir);

for idir = 1 : ndir
    
    c = calCentroid(S(:, :, idir)); % need to verify in case of white noise
    M00 = 0;
    
    for j = 1 : prjLength
        for i = 1 : prjLength
            
            x = (i - c(1));
            y = (j - c(2));
            
            M(1, idir) = M(1, idir) + x * y * S(i, j, idir);
            M(2, idir) = M(2, idir) + x^2 * S(i, j, idir);
            M(3, idir) = M(3, idir) + y^2 * S(i, j, idir);
            M(4, idir) = M(4, idir) + x^2 * y * S(i, j, idir);
            M(5, idir) = M(5, idir) + x * y^2 * S(i, j, idir);
            M(6, idir) = M(6, idir) + x^3 * S(i, j, idir);
            M(7, idir) = M(7, idir) + y^3 * S(i, j, idir);
            
            M00 = M00 + S(i,j,idir);
                    
        end
    end
    
    if opt == 1
    
        M(1, idir) = M(1, idir) / (M00^2);
        M(2, idir) = M(2, idir) / (M00^2);
        M(3, idir) = M(3, idir) / (M00^2);
        M(4, idir) = M(4, idir) / (M00^2.5);
        M(5, idir) = M(5, idir) / (M00^2.5);
        M(6, idir) = M(6, idir) / (M00^2.5);
        M(7, idir) = M(7, idir) / (M00^2.5);
        
    end
    
end


end

