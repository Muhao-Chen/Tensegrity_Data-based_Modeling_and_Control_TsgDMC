function [A_1a,A_1ag,A_2a,A_2ag]=tenseg_equilibrium_matrix(H,C,Gp,Ia,l)
% /* This Source Code Form is subject to the terms of the Mozilla Public
% * License, v. 2.0. If a copy of the MPL was not distributed with this
% * file, You can obtain one at http://mozilla.org/MPL/2.0/.
%
% This function gives the equilibrium matrix of tensegrity structures
%
% Inputs:
%   H: members' direction matrix
%	C: members' length
%   Gp: group matrix of members
%   Ia: Tranform matrix to get free nodal coordinate: na=Ia'*n
%   l: members' length vector
%
% Outputs:
%	A_1a: equilibrium matrix with constraints, force density as variable
%	A_1ag: Equilirium matrix with boundary, group constraints, force
%	density as variable.
%	A_2a: equilibrium matrix with constraints, force as variable
%	A_1ag: Equilirium matrix with boundary, group constraints, force
%	as variable.

Cell_H=mat2cell(H,3,ones(1,size(H,2)));          % transfer matrix H into a cell: Cell_H

A_1a=Ia'*kron(C',eye(3))*blkdiag(Cell_H{:});     % equilibrium matrix
A_1ag=A_1a*Gp;                                   % equilibrium matrix in group constraints

A_2a=A_1a*diag(l.^-1);                           % equilibrium matrix
A_2ag=A_2a*Gp;                                   % equilibrium matrix in group constraints

end

