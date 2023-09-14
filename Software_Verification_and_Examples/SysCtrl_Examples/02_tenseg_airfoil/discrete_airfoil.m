function [x,y] = discrete_airfoil(u,x)
% /* This Source Code Form is subject to the terms of the Mozilla Public
% * License, v. 2.0. If a copy of the MPL was not distributed with this
% * file, You can obtain one at http://mozilla.org/MPL/2.0/.
%
% This function includes the state space model of the discrete airfoil
% model, and generates corresponding responses according to given input
% signals and initial conditions.
% Inputs:
%   x: state variables
%   u: input signals
%
% Outputs:
%   x: updated state variables
%   y: output signals
%%
discrete_airfoil_dynamics = load('Airfoil.mat');
A = discrete_airfoil_dynamics.Ad;
B = discrete_airfoil_dynamics.Bd;
C = discrete_airfoil_dynamics.Cd;
D = discrete_airfoil_dynamics.Dd;

x = A*x + B*u;
y = C*x + D*u;
end