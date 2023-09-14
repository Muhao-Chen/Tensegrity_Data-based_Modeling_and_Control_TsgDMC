function [y_store,u_store] = pendulum_simulation(Q,R,H,M,t,dt,N,size_input,size_output,r)
% /* This Source Code Form is subject to the terms of the Mozilla Public
% * License, v. 2.0. If a copy of the MPL was not distributed with this
% * file, You can obtain one at http://mozilla.org/MPL/2.0/.
%
% [y_store,u_store] = pendulum_simulation(Q,R,H,M,t,dt,N,size_input,
% size_output,r) generates the dymanic simulation results for simple 
% pendulum.
%
% Inputs:
%   Q: output weight matrix
%   R: input increment weight matrix
%	H: input Markov parameters
%   M: input disturbance Markov parameters
%   t: simulation time span
%   N: horizon
%   size_input: size of the input signals
%   size_output: size of the output signals
%   r: reference trajectory for the desired horizon
%
% Outputs:
%   y_store: output signals for the simulation
%   u_store: input signals for the simulation

%% Initialize
func = @simple_pendulum;

W = 1e-6*eye(size_input);
V = 1e-6*eye(size_output);
[H_hat,M_hat] = tsgMDC_markov_transform(H,M);

%% Guess initial output estimate
y_est = zeros((N+1)*size_output,1);

%% Calculate optimal controller gain, update output estimate, and compute input sequence
% Simulation initial condition
y = 0;
y_store(:,1) = y;
u_store(:,1) = 0;
x0 = [0 0]';

% Simulation over horizon
for k = 0:N
    if k == 0
        K = tsgMDC_gain(k,N,Q,R,H_hat);
        u = tsgMDC_control(K,y_est,r);
    elseif k == 1
        K = tsgMDC_gain(k,N,Q,R,H_hat);
        y_est = tsgMDC_estimate(k,N,y_est,y,u(1:size_input),H_hat,M_hat,W,V);
        [~,x_temp] = ode45(func,[t,t+dt],x0',[],u(1:size_input));
        x0 = x_temp(end,:)';
        y = x_temp(end,1);
        y_store(:,k+1) = y;
        u_last = u(1:size_input);
        u_store(k+1) = u_last;
        r = r(:,2:end);
        u = tsgMDC_control(K,y_est,r);
    else
        K = tsgMDC_gain(k,N,Q,R,H_hat);
        y_est = tsgMDC_estimate(k,N,y_est,y,u(1:size_input),H_hat,M_hat,W,V);
        [~,x_temp] = ode45(func,[t,t+dt],x0',[],u(1:size_input)+u_last);
        x0 = x_temp(end,:)';
        y = x_temp(end,1);
        y_store(:,k+1) = y;
        u_last = u_last + u(1:size_input);
        u_store(k+1) = u_last;
        r = r(:,2:end);
        u = tsgMDC_control(K,y_est,r);
    end
end
end