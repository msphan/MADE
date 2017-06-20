function [ angleArray ] = gen_anglearray(number)
%GENERATEANGLEARRAY auto-generate angle array
%   angleArray = generateanglearray(number) auto-generate an angle array with a given
%   number between 0 and 180 degree. The objectif is to advoid generating
%   an angle array in which the angular difference between two adjacent 
%   angles is too small or too large.

%   There is a function rand() of MATLAB which help us to randomly generate
%   the angle array but the angular difference between two adjacent angles
%   may be too small or too large. This is not good in practice since the
%   pre-processing process will average all projections in which the
%   difference is very small. In addition, if the number of angle is
%   sufficient large, the angular difference between two adjacent angles is
%   therefore not too large.

%   Principe : 
%       - randomly generate a very large number of angles
%       - sort angles by asc
%       - travel all angles step by step and mark the angle in which the
%         angular difference between this angle and the previous angle
%         is larger than a given criterion.
%       - remove all angles which are not marked
%       - permulate result angles

maxNumber = 100000; % initialise the maximum possible number of angles
angleArray = 180 .* rand(1,maxNumber); % generate randomly an angle array 
                                       % with a maxNumber given

TRUE = 1;

% set an average sample step
% ex : if we want 100 projections on [0, 180[, the average step is : 1.8
% degree. 
sampleStep = 180 / number; 

% set an array of sampleStep in which each element value is random on 
% [sampleStep / 4 ; sampleStep + 3 * sampleStep / 4].
% This is just a criterion for which the sampleStep is not very small and
% very large.
sampleStepArray = (sampleStep / 4) + (sampleStep + sampleStep / 4)...
                                                    .* rand(1, maxNumber);

% sort the angle array by ascending                                               
angleArray = sort(angleArray,'ascend');

% an array are used to mark the best fit 
% We first suppose all elements in angle array is good
isGoodArray = ones(1,maxNumber); % TRUE

% start at the first element in angle array
i = 1;

while i <= (maxNumber - 1)
    criterion = sampleStepArray(i); % get the criterion
    j = i + 1;
    while j <= maxNumber % find j that best fits the criterion       
        if angleArray(j) - angleArray(i) < criterion
            isGoodArray(j) = 0; % FALSE
            j = j + 1;            
        else
            i = j;
            break;
        end       
    end
    
    if(j > maxNumber), i = i + 1; end
end

% modify angle array by only keep the best ones
angleArray = angleArray(isGoodArray == TRUE);

% get new number 
nAngleArray = length(angleArray);

% permulate
angleArray = angleArray(randperm(nAngleArray));

% verify if the new number > number
if nAngleArray > number
angleArray = angleArray(1 : number);

end

