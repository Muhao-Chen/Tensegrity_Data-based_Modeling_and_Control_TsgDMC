function [H_hat, M_hat] = tsgDMC_markov_transform(H,M)
% /* This Source Code Form is subject to the terms of the Mozilla Public
% * License, v. 2.0. If a copy of the MPL was not distributed with this
% * file, You can obtain one at http://mozilla.org/MPL/2.0/.
%
% [H_hat, M_hat] = tsgDMC_markov_transform(H,M) computes the augmented input 
% Markov parameters and augmented input disturbance Markov parameters, from 
% input Markov parameters and input disturbance Markov parameters. The 
% augmented Markov parametersare used for reference tracking applications.
%
% Inputs:
%	H: input Markov parameters
%   M: input disturbance Markov parameters
%
% Outputs:
%	H_hat: augmented input Markov parameters
%   M_hat: augmented input disturbance Markov parameters
%%
H_hat = zeros(size(H));
for i = 0:size(H_hat,3)-1
    if i == 0
        H_hat(:,:,i+1) = H(:,:,1);
    else
        H_hat(:,:,i+1) = H_hat(:,:,i) + H(:,:,i+1);
    end
end

M_hat = M;
end