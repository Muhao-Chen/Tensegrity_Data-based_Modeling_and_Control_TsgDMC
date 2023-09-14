function y_est = tsgDMC_estimate(k,N,y_est_pre,y_pre,u_pre,H,M,W,V)
% /* This Source Code Form is subject to the terms of the Mozilla Public
% * License, v. 2.0. If a copy of the MPL was not distributed with this
% * file, You can obtain one at http://mozilla.org/MPL/2.0/.
%
% y_est = tsgDMC_estimate(k,N,y_est_pre,y_pre,u_pre,H,M,W,V) computes the
% Markov data-based output estimate for interval [k,N].
%
% Inputs:
%	k: current step
%   N: horizon
%   y_est_pre: previous Markov-databased output estimate
%   R: input increment weight matrix
%   y_pre: previous output
%   u_pre: previous input
%   H: input Markov parameters
%   M: input disturbance Markov parameters
%   W: input disturbance variance
%   V: output sensor variance
%
% Outputs:
%	y_est: Markov-databased output estimate for interval [k,N]
%% Get the input and output sizes of the associated system
size_input = size(H,2);
size_output = size(H,1);

%% Formulate estimator parameters
Wk1 = [];
Vk1 = [];

Bk = [];
for i = 0:N-k
    Bk = [Bk;H(:,:,i+2)];
end

Nk = [];

Tk1 = zeros(size_output*k, size_input*k);
for m = 1:k
    Nk = [Nk M(:,:,m+1)];
    Wk1 = blkdiag(Wk1,W);
    Vk1 = blkdiag(Vk1,V);
    for n = m:k
        Tk1((m-1)*size_output+1:m*size_output, (n-1)*size_input+1:n*size_input) = M(:,:,n-m+1);
    end
end
Pk = eye(size(Wk1))/(eye(size(Wk1))/Wk1 + Tk1'*(eye(size(Vk1))/Vk1)*Tk1);

Hk = zeros(size_output*(N-k+1), size_input*k);
for m = 2:N-k+2
    for n = 2:k+1
        Hk((m-2)*size_output+1:(m-1)*size_output, (n-2)*size_input+1:(n-1)*size_input) = M(:,:,m+n-2);
    end
end
Fk = Hk*Pk*Nk'*(eye(size(V))/(V+Nk*Pk*Nk'));
Ak = [-Fk eye((N-k+1)*size_output)];

y_est = Ak*y_est_pre + Bk*u_pre + Fk*y_pre;

%% Reshape for output
y_est = reshape(y_est, numel(y_est),1);
end