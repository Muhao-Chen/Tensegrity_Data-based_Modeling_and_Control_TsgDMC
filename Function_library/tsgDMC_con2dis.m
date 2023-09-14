function [Ad,Bd,Cd,Dd] = tsgDMC_con2dis(Ac,Bc,Cc,Dc,sample_time,method)
% /* This Source Code Form is subject to the terms of the Mozilla Public
% * License, v. 2.0. If a copy of the MPL was not distributed with this
% * file, You can obtain one at http://mozilla.org/MPL/2.0/.
%
% [Ad,Bd,Cd,Dd] = tsgDMC_con2dis(Ac,Bc,Cc,Dc,sample_time,method) discretizes
% the continuous state space realization {A,B,C,D} into the discretized
% state space realization {Ad,Bd,Cd,Cd} using the specified method with the
% specified sample time.
%
% Inputs:
%	Ac: continuous state matrix of the state space realization
%	Bc: continuous input matrix of the state space realization
%	Cc: continuous output matrix of the state space realization
%	Dc: continuous feedthrough matrix of the state space realization
%   sample time: Sampling time of the discretization
%   method: the specified discretization method, ex., 'zoh','foh','impulse'
%
% Outputs:
%	Ad: discrete state matrix of the state space realization
%	Bd: discrete input matrix of the state space realization
%	Cd: discrete output matrix of the state space realization
%	Dd: discrete feedthrough matrix of the state space realization
%%
sysc = ss(Ac,Bc,Cc,Dc);
sysd = c2d(sysc,sample_time,method);
Ad = sysd.a;
Bd = sysd.b;
Cd = sysd.c;
Dd = sysd.d;
end
