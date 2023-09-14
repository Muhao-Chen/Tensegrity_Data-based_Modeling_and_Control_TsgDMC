function [Phi1,Phi2] = tsgDMC_Hankel(H,a,b)
% /* This Source Code Form is subject to the terms of the Mozilla Public
% * License, v. 2.0. If a copy of the MPL was not distributed with this
% * file, You can obtain one at http://mozilla.org/MPL/2.0/.
%
% [Phi1,Phi2] = tsgDMC_Hankel(H,a,b) computes two consecutive Hankel 
% matrices for ERA.
%
% Inputs:
%	H: the set of Markov parameters
%   a: the number of Markov parameters in the column of the Hankel matrix
%   b: the number of Markov parameters in the row of the Hankel matrix
%
% Outputs:
%	Phi1: first Hankel Matrix
%   Phi2: second Hankel Matrix
%%
% Get the input and output sizes of the associated system
r = size(H,2);
m = size(H,1);


for i = 1:a+1
    for j = 1:b+1
        Phi1((i-1)*m+1:i*m,(j-1)*r+1:j*r) = H(:,:,i+j);
        Phi2((i-1)*m+1:i*m,(j-1)*r+1:j*r) = H(:,:,i+j+1);
    end
end
end
