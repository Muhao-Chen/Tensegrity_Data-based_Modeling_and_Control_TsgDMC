function Hq = tsgDMC_Hq(H,q)
% /* This Source Code Form is subject to the terms of the Mozilla Public
% * License, v. 2.0. If a copy of the MPL was not distributed with this
% * file, You can obtain one at http://mozilla.org/MPL/2.0/.
%
% Hq = tsgDMC_Hq(H,q) computes the Toeplitz matrix Hq for QMC.
%
% Inputs:
%	H: the set of Markov parameters
%   q: Number of Markov and Covariance parameters to match
%
% Outputs:
%	Hq: Toeplitz matrix Hq
%% Get the input and output sizes of the associated system
r = size(H,2);
m = size(H,1);

%% Construct Hq
index_q = 0;
while index_q < q
    for index_q2 = 1:q-index_q
        Hq((index_q2-1)*m+1+index_q*m:index_q2*m+index_q*m,(index_q2-1)*r+1:index_q2*r) = H(:,:,index_q+1);
    end
    index_q = index_q + 1;
end
