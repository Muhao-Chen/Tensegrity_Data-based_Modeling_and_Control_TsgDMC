function exi = tsgDMC_existence(Dq,sigma)
% /* This Source Code Form is subject to the terms of the Mozilla Public
% * License, v. 2.0. If a copy of the MPL was not distributed with this
% * file, You can obtain one at http://mozilla.org/MPL/2.0/.
%
% exi = tsgDMC_existence(Dq,sigma) checks the existence condition of a QMC
% solution for the given data matrix Dq and a specified threshold sigma.
%
% Inputs:
%	Dq: Data matrix Dq
%   sigma: Threshold for determine matrix positiveness
%
% Outputs:
%   exi: existence condition of QMC solution
%% Check if matrix is square
if size(Dq,1) ~= size(Dq,2)
    error('Data Matrix is not square');
end

%% Calculate eigenvalues
eigValues = eig(Dq);

%% Check if all eigenvalues are positive
exi = all(eigValues > sigma);
end
