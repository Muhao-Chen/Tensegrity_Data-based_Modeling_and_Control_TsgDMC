function [A,B,C,D,omega_set] = clamped_free_beam(u_force,y_dis,N)
% /* This Source Code Form is subject to the terms of the Mozilla Public
% * License, v. 2.0. If a copy of the MPL was not distributed with this
% * file, You can obtain one at http://mozilla.org/MPL/2.0/.
%
% [A,B,C,D,omega_set] = clamped_free_beam(u_force,y_dis,N) returns a 
% linearized continuous state space realization for a clamed free beam.
% 
% Inputs:
%	u_force: force input locations
%   y_dis: displacement output locations
%   N: number of modes to include
%
% Outputs:
%	A: state matrix of the state space realization
%	B: input matrix of the state space realization
%	C: output matrix of the state space realization
%	D: feedthrough matrix of the state space realization
%   omega_set: natural frequency set of the included modes
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Model Properties
L = 1;
c = 0.1;
% Define the equation cos(βn) * cosh(βn) = -1
fun = @(x) cos(x) .* cosh(x) + 1;

% Find the first N roots of the equation
omega_set = zeros(1,N);
for n = 1:N
    omega_init = (n-0.5)*pi; % initial guess
    omega_set(n) = fzero(fun, omega_init)^2;
end


%% Retrieve Size Information
size_input = size(u_force,1);
size_output = size(y_dis,1);

%% Model Assembly
A = zeros(2*N,2*N);
B = zeros(2*N,size_input);
C = zeros(size_output,N);
D = zeros(size_output,size_input);

for i = 1:N
    omega = omega_set(i);

    A(2*i-1:2*i,2*i-1:2*i) = [0 1;-omega^2 -2*c*omega];

    for j = 1:size_input
        beta = sqrt(omega)/L*u_force(j);
        kr = (cosh(beta*L)+cos(beta*L))/(sinh(beta*L)+sin(beta*L));
        Yr = cosh(beta*u_force(j))-cos(beta*u_force(j))-kr*(sinh(beta*u_force(j))-sin(beta*u_force(j)));
        B(2*i-1:2*i,j) = [0 Yr]';
    end
end

for i = 1:N
    omega = omega_set(i);
    for m = 1:size_output
        beta = sqrt(omega)/L*y_dis(m);
        kr = (cosh(beta*L)+cos(beta*L))/(sinh(beta*L)+sin(beta*L));
        Yr = cosh(beta*y_dis(m))-cos(beta*y_dis(m))-kr*(sinh(beta*y_dis(m))-sin(beta*y_dis(m)));
        C(m,2*i-1:2*i) = [Yr 0];
    end
end
