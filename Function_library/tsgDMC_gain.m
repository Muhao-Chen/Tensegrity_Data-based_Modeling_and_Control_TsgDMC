function K = tsgDMC_gain(k,N,Q,R,H)
% /* This Source Code Form is subject to the terms of the Mozilla Public
% * License, v. 2.0. If a copy of the MPL was not distributed with this
% * file, You can obtain one at http://mozilla.org/MPL/2.0/.
%
% K = tsgDMC_gain(k,N,Q,R,H) computes the Markov data-based optimal
% controller gain at step k which minimizes a cost function consisting of
% accumulation of output errors and inputs, with weight matrices
% Q and R respectively, over the interval [k,N].
%
% Inputs:
%	k: current step
%   N: horizon
%   Q: output weight matrix
%   R: input increment weight matrix
%   H_hat: input augmented Markov parameters
%
% Outputs:
%	K: optimal controller gain at step k
%% Get the input and output sizes of the associated system
size_input = size(H,2);
size_output = size(H,1);

%% Calculate the gain 
H_bar = zeros(size_output*(N-k), size_input*(N-k));
Q_bar = [];
R_bar = [];
for i = 1:N+1-k
        Q_bar = blkdiag(Q_bar,Q);
        R_bar = blkdiag(R_bar,R);
    for j = 1:i
        H_bar(size_output*(i-1)+1:size_output*i,size_input*(j-1)+1:size_input*j) = H(:,:,i-j+1);
    end
end
K = (H_bar'*Q_bar*H_bar+R_bar)\(Q_bar*H_bar)';
end
