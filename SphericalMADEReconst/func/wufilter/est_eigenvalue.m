function [ estimatedEigenValue] = est_eigenvalue( variance, gamma, noisyEigenValue )
% ESTIMATEEIGENVALUE  Estimate the eigenvalues from noisy eigenvalues
%   estimatedEigenValue = estimateeigenvalue(variance, gamma,
%   noisyEigenValue) estimate the eigenvalues from the noisy eigenvalues
%   with a given variance of noise and gamma = p / n, where n is the number
%   of projection and p is the dimension of projection.

%   This is a part of Singer-Wu method. For more information, please read
%   the Singer's article at page 16. The values of estimated eigenvalues
%   are just the solution of a quadratic equation.

% initialise parameters of quadratic equation
a = 1;
b = variance + gamma * variance - noisyEigenValue;
c = gamma * variance^2;
Delta = b * b - 4 * a * c;

% Solve quadratic equation
if(Delta > 0)
    x1 = (-b - sqrt(Delta)) / (2 * a);
    x2 = (-b + sqrt(Delta)) / (2 * a);
    if(x1 < x2 && x2 > 0) 
        estimatedEigenValue = x2;
    else
        if(x1 > 0)
            estimatedEigenValue = x1;
        end
    end
else
    if(Delta == 0)
        x = -b / (2 * a);
        if(x > 0) 
            estimatedEigenValue = x;
        end
    else
        estimatedEigenValue = noisyEigenValue; % error 
    end
end




end

