function pendulum_gen_sym(varargin)
% /* This Source Code Form is subject to the terms of the Mozilla Public
% * License, v. 2.0. If a copy of the MPL was not distributed with this
% * file, You can obtain one at http://mozilla.org/MPL/2.0/.
%
% This function generates the simple_pendulum.mat file which includes the
% Markov parameters, reference trajectories and other necessary parameters
% for result visualization for the simple pendulum MDC control example.
%% Generate Markov parameters
dt = 0.01; % Define time step
N = 1000;  % Number of parameters to evaluate
func = @simple_pendulum; % Define black box system
us = ones(N,1);
xs = zeros(2,1);
for i = 1:N % I/O test
    [~,xs_temp] = ode45(func,[0,dt],xs,[],us(i));
    xs = xs_temp(end,:)';
    ys_store(:,i+1) = xs(1);
end

for i = 1:length(ys_store) % Data process
    if i == 1
        H(:,1,i) = ys_store(:,i);
    else
        H(:,1,i) = (ys_store(:,i)-ys_store(:,i-1));
    end
end

M = H;
%% Specify reference tracking trajectory
r = pi/6*ones(1,50);

%% Output data matrix
fullFilePath = mfilename('fullpath');
[currentDir,~,~] = fileparts(fullFilePath);
fullFilePath = fullfile(currentDir, 'simple_pendulum.mat');
save(fullFilePath,'H','M','r','dt')
end
