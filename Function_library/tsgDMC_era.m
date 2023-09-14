function [A,B,C,D] = tsgDMC_era(Phi1,Phi2,H,n)
% /* This Source Code Form is subject to the terms of the Mozilla Public
% * License, v. 2.0. If a copy of the MPL was not distributed with this
% * file, You can obtain one at http://mozilla.org/MPL/2.0/.
%
% [A,B,C,D] = tsgDMC_era(Phi1,Phi2) computes a state space realization of
% order n using the Eigensystem Realization Algorith (ERA), where Phi1 and Phi2 
% represent the two consecutive Hankel matrices, and n represents the 
% desired size of the state space realization.
%
% Inputs:
%	Phi1: first Hankel Matrix
%   Phi2: second Hankel Matrix
%   n: desired size of the state space realization
%
% Outputs:
%	A: state matrix of the state space realization
%	B: input matrix of the state space realization
%	C: output matrix of the state space realization
%	D: feedthrough matrix of the state space realization
%% Get the input and output sizes of the associated system
r = size(H,2);
m = size(H,1);

%% Calculate the state space realization using ERA
[Ue,Ee,Ve] = svd(Phi1,'econ');
Un = Ue(:,1:n); En = Ee(1:n,1:n); Vn = Ve(:,1:n);
A = En^-0.5*Un'*Phi2*Vn*En^-0.5;
B_temp = En^0.5*Vn';
C_temp = Un*En^0.5;
B = B_temp(:,1:r);
C = C_temp(1:m,:);
D = H(:,:,1);
end