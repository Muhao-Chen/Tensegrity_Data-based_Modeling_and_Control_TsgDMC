function Dq = tsgDMC_Dq(Hq,Rq,Uq)
% /* This Source Code Form is subject to the terms of the Mozilla Public
% * License, v. 2.0. If a copy of the MPL was not distributed with this
% * file, You can obtain one at http://mozilla.org/MPL/2.0/.
%
% Dq = tsgDMC_Dq(Hq,Rq) computes the data matrix Dq for the q-Markov 
% Covariance equivalent realization (QMC).
%
% Inputs:
%	Hq: the Toeplitz matrix Hq
%   Rq: the Toeplitz matrix Rq
%   Uq: Input Covariance 

% Outputs:
%	Dq: Data matrix Dq
%% Compute the data matrix
Dq = Rq - Hq*Uq*Hq';
end
