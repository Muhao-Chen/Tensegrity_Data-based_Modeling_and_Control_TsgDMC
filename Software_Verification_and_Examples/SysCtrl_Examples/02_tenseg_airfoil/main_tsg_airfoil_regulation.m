%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%% tsgDMC Regulation of a tensegrity airfoil %%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% /* This Source Code Form is subject to the terms of the Mozilla Public
% * License, v. 2.0. If a copy of the MPL was not distributed with this
% * file, You can obtain one at http://mozilla.org/MPL/2.0/.
%
% This script exucutes the Markov data-based regulation control for the
% tensegrity airfoil. Steps of Markov data-based regulation control
% include the following:
% 1. Import reference tracking trajectory and Markov parameters
% 2. Initialize output and input weight matrices and noise variances
% 3. Guess initial output estimate
% 4. Calculate optimal controller gain, update output estimate, and compute
% input sequence
% 5. Visualize Control Process
%% Step 1: Import reference tracking trajectory and Markov parameters
clear
MadCtrl_data = load("airfoil.mat");
r = MadCtrl_data.ref;
H = MadCtrl_data.Hi;
M = H;
savePath=fullfile(fileparts(mfilename('fullpath')),'data_temp'); %Save files in same folder as this code

%% Step 2: Initialize output and input weight matrices and noise variances
[size_output, size_input] = size(H,1,2);
N = 20;
Q = 1e0*eye(size_output);
R = 1e3*eye(size_input);
W = 1e-4*eye(size_input);
V = 1e-4*eye(size_output);

%% Step 3: Guess initial output estimate
y_est = zeros((N+1)*size_output,1);

%% Step 4: Calculate optimal controller gain, update output estimate, and compute input sequence
% Simulation initial condition
x = [r(:,end);zeros(26,1)];
y = r(:,end);
y_store(:,1) = y;

% Simulation over horizon
for k = 0:N
    %     k
    if k == 0
        K = tsgDMC_gain(k,N,Q,R,H);
        u = tsgDMC_control(K,y_est);
    elseif k == 1
        K = tsgDMC_gain(k,N,Q,R,H);
        y_est = tsgDMC_estimate(k,N,y_est,y,u(1:size_input),H,M,W,V);
        [x,y] = discrete_airfoil(u(1:size_input),x);
        y_store(:,k+1) = y;
        %         u_last = u(1:size_input);
        u = tsgDMC_control(K,y_est);
    else
        K = tsgDMC_gain(k,N,Q,R,H);
        y_est = tsgDMC_estimate(k,N,y_est,y,u(1:size_input),H,M,W,V);
        [x,y] = discrete_airfoil(u(1:size_input),x);
        y_store(:,k+1) = y;
        u = tsgDMC_control(K,y_est);
    end
end

%% Visualize Control Process
dt = 0.01;
for  i = 1:size(y_store,1)/2
    legend_str{i} = ['Node ' num2str(i)];
end
figure
plot(0:dt:N*dt,y_store(1:2:end,1:N+1),'LineWidth',2)
grid on
ylabel('Node Error in X Coordinate (m)','Interpreter','latex')
xlabel('Time (s)','Interpreter','latex')
legend(legend_str,'Location','southeast','NumColumns',2)
saveas(gcf,fullfile(savePath,'result_regulate1.png'));

figure
plot(0:dt:N*dt,y_store(2:2:end,1:N+1),'LineWidth',2)
grid on
ylabel('Node Error in Y Coordinate (m)','Interpreter','latex')
xlabel('Time (s)','Interpreter','latex')
legend(legend_str,'Location','southeast','NumColumns',2)
saveas(gcf,fullfile(savePath,'result_regulate2.png'));

