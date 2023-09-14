function n = tsgDMC_pdm(Dq,sigma)
% /* This Source Code Form is subject to the terms of the Mozilla Public
% * License, v. 2.0. If a copy of the MPL was not distributed with this
% * file, You can obtain one at http://mozilla.org/MPL/2.0/.
%
% n = tsgDMC_pdm(Phi1,sigma) computes the perserved size of the state space
% realization n from the singular value decomposition of the data matrix 
% using the power density method.
% 
% Inputs:
%	Phi1: first Hankel Matrix
%   sigma: Ratio of the perserved power density
%
% Outputs:
%   n: perserved size of the state space realization
%%
% Singular value decomposition of the data matrix
[~,b,~] = svd(Dq);
eig_phi1 = diag(b);

% Total energy
W = sum(eig_phi1.^2);
W_trun = 0;

% Find perserved nize n
n = 0;
while W_trun < sigma*W
    n = n+1;
    W_trun = W_trun + eig_phi1(n)^2;
end
end
