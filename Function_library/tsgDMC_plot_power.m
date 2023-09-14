function tsgDMC_plot_power(Dq)
% /* This Source Code Form is subject to the terms of the Mozilla Public
% * License, v. 2.0. If a copy of the MPL was not distributed with this
% * file, You can obtain one at http://mozilla.org/MPL/2.0/.
%
% tsgDMC_plot_power(Dq) visualizes the singular values of a data matrix.
%
% Inputs:
%	Dq: Data matrix Dq
%
%% Find singular value decompsion of a data matrix
[~,b,~] = svd(Dq,'econ');
eig_phi1 = diag(b);
eig_horizon = length(eig_phi1);

%% Visualization
figure
semilogy(1:eig_horizon,eig_phi1(1:eig_horizon),'-.*','LineWidth',1)
grid on
xlabel('Index')
xlim([1,eig_horizon])
ylabel('Magnitude')
end
