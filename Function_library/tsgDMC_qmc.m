function [A,B,C,D] = tsgDMC_qmc(H,Hq,Dq,q,n)
% /* This Source Code Form is subject to the terms of the Mozilla Public
% * License, v. 2.0. If a copy of the MPL was not distributed with this
% * file, You can obtain one at http://mozilla.org/MPL/2.0/.
%
% [A,B,C,D] = tsgDMC_qmc(H,Hq,Dq,q,n) computes a state space realization of
% order n that exactly matches q Markov and Covariance parameters using QMC.
%
% Inputs:
%   H: Markov parameter sequence
%   Hq: Markov parameter toeplitz matrix
%	Dq: data matrix Dq
%   q: number of exactly matched Markov and Covariance parameters
%   n: desired size of the state space realization
%
% Outputs:
%	A: state matrix of the state space realization
%	B: input matrix of the state space realization
%	C: output matrix of the state space realization
%	D: feedthrough matrix of the state space realization
%
%% Get the input and output sizes of the associated system
r = size(H,2);
m = size(H,1);

%% Compute qmc solution
[temp_U,temp_E,~] = svd(Dq);
i = (1:n)';
temp = diag(temp_E);
Oq=(temp_U(:,i)*diag(sqrt(temp(i))));

Oq_1 = [eye(m*(q-1)) zeros(m*(q-1),m)]*Oq;
Kq_1 = [zeros(m*(q-1),m) eye(m*(q-1))]*Hq(:,1:r);
Jq_1 = [zeros(m*(q-1),m) eye(m*(q-1))]*Oq;

soln_mat = Oq_1\[Kq_1 Jq_1];

D = Hq(1:m,1:r);
C = Oq(1:m,1:end);
B = soln_mat(1:end,1:r);
A = soln_mat(1:end,r+1:end);
end