function R = tsgDMC_genCov(A,B,C,D,N)
% /* This Source Code Form is subject to the terms of the Mozilla Public
% * License, v. 2.0. If a copy of the MPL was not distributed with this
% * file, You can obtain one at http://mozilla.org/MPL/2.0/.
%
% H = tsgDMC_genCov(A,B,C,D,N) generates the first N Covariance parameter 
% sequence of the state space realization {A,B,C,D}.
%
% Inputs:
%	A: state matrix of the state space realization
%	B: input matrix of the state space realization
%	C: output matrix of the state space realization
%	D: feedthrough matrix of the state space realization
%   N: Number of Covariance parameters to generate
%
% Outputs:
%	R: Covariance parameter sequence
%% 
X = dlyap(A,B*B');
for i = 0:N
    if i == 0
        R(:,:,i+1) = C*X*C'+D*D';
    else
        R(:,:,i+1) = C*A^i*X*C'+C*A^(i-1)*B*D';
    end
end
end
