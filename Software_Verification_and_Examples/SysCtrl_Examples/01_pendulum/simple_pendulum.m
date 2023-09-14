function xdot = simple_pendulum(~,x,u)
% /* This Source Code Form is subject to the terms of the Mozilla Public
% * License, v. 2.0. If a copy of the MPL was not distributed with this
% * file, You can obtain one at http://mozilla.org/MPL/2.0/.
%
% This function includes the dynamics of a simple pendulum, and generates 
% corresponding responses according to given inputs and initial conditions.
% Inputs:
%   x: state variables
%   u: input signals
%
% Outputs:
%   xdot: derivative of state variables
%
%%
m = 1;
g = 9.8;
L = 1;
c = 0.1;
xdot(1) = x(2);
xdot(2) = -g/L*sin(x(1))-c/m*x(2)+u/(m*L);
xdot = xdot';
end

