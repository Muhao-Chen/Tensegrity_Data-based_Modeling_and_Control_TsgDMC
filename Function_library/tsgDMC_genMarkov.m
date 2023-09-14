function H = tsgDMC_genMarkov(A,B,C,D,N)
% /* This Source Code Form is subject to the terms of the Mozilla Public
% * License, v. 2.0. If a copy of the MPL was not distributed with this
% * file, You can obtain one at http://mozilla.org/MPL/2.0/.
%
% H = tsgDMC_genMarkov(A,B,C,D,N) generates the first N Markov parameter 
% sequence of the state space realization {A,B,C,D}
%
% Inputs:
%	A: state matrix of the state space realization
%	B: input matrix of the state space realization
%	C: output matrix of the state space realization
%	D: feedthrough matrix of the state space realization
%   N: Number of Markov parameters to generate
%
% Outputs:
%	H: Markov parameter sequence
%%
for i = 0:N
    if i == 0
        H(:,:,i+1) = D;
    else
        H(:,:,i+1) = C*A^(i-1)*B;
    end
end
end
