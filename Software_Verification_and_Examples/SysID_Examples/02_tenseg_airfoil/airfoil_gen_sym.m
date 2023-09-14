function airfoil_gen_sym(varargin)
% /* This Source Code Form is subject to the terms of the Mozilla Public
% * License, v. 2.0. If a copy of the MPL was not distributed with this
% * file, You can obtain one at http://mozilla.org/MPL/2.0/.
%
% This function generates generates the airfoil.mat file which includes the
% Markov parameters, reference trajectories and other necessary parameters
% for result visualization for the tensegrity airfoil MDC control example.
%% Load tensegrity airfoil dynamics
dyn_airfoil;
dt = 0.01;

%% Linearized airfoil dynamics in state space form
A = A_lin;
B = B_lin(:,13*2+15+1:13*2+15+26);
C = [eye(26) zeros(26)];
D = zeros(26);
[Ad,Bd,Cd,Dd] = tsgDMC_con2dis(A,B,C,D,dt,'zoh');
%% Generate reference tracking trajectory
tenseg_airfoil_traj;
[N_target,~,~,~] = Main_foil_bend(); % kinematics, morphing targets
traj = [];
for i = 1:length(N_target(:,:,:))
    N_tem = [];
    N_tem = cell2mat(N_target(:,i));
    traj = [traj N_tem(:)];
end
N_struc0 = N; C_struct = C;
N_0 = [N(1:2,2:6) N(1:2,8:11) N(1:2,13:16)];  % free nodes, nodes 1 7 12 are fixed
N = zeros(size(N_0));
dN = zeros(size(N));
N = [N dN]; % initial condition
x_ori = reshape([N_0 dN],numel(N),1);
ref = zeros(size(traj,2),size(Cd,1));
for i = 1:size(traj,2)
    N_target = reshape(traj(:,i),3,[]);
    %     N_target = reshape(traj(:,end),3,[]);
    %     n_target = [N_target(1:2,2:11) N_target(1:2,13:end)];
    n_target = [N_target(1:2,2:6) N_target(1:2,8:11) N_target(1:2,13:16)];
    ref(i,:) = reshape(n_target,numel(n_target),1);
end
ref = ref';
ref = ref - x_ori(1:52/2);
ref = [ref ref(:,end)];
%% Generate Markov parameters
Hi = zeros(26,26,102);
Hi = tsgDMC_genMarkov(Ad,Bd,Cd,Dd,100);
%% Output data matrix
fullFilePath = mfilename('fullpath');
[currentDir,~,~] = fileparts(fullFilePath);
fullFilePath = fullfile(currentDir, 'Airfoil.mat');
save(fullFilePath)
end