function Rq = tsgDMC_Rq(R,q)
% /* This Source Code Form is subject to the terms of the Mozilla Public
% * License, v. 2.0. If a copy of the MPL was not distributed with this
% * file, You can obtain one at http://mozilla.org/MPL/2.0/.
%
% Rq = tsgDMC_Rq(R,q) computes the Toeplitz matrix Rq for QMC.
%
% Inputs:
%	R: the set of Covariance parameters
%   q: Number of Markov and Covariance parameters to exactly match
%
% Outputs:
%	Rq: Toeplitz matrix Rq
%%
% Get the output sizes of the associated system
m = size(R,1);

% Construct Rq
index_q = 0;
while index_q < q
    for index_q2 = 1:q-index_q
        Rq((index_q2-1)*m+1:index_q2*m,(index_q2-1)*m+1+index_q*m:index_q2*m+index_q*m) = R(:,:,index_q+1)';
        Rq((index_q2-1)*m+1+index_q*m:index_q2*m+index_q*m,(index_q2-1)*m+1:index_q2*m) = R(:,:,index_q+1);
    end
    index_q = index_q + 1;
end
end
