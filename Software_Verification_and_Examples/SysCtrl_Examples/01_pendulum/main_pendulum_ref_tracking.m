%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% TsgMDC reference tracking of a Simple Pendulum %%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% /* This Source Code Form is subject to the terms of the Mozilla Public
% * License, v. 2.0. If a copy of the MPL was not distributed with this
% * file, You can obtain one at http://mozilla.org/MPL/2.0/.
%
% This script exucutes the reference tracking control for the simple 
% pendulum. Specific steps include the following:
% 1. Generate the reference tracking trajectory and Markov parameters
% 2. Initialize output and input weight matrices, and simulation
% 3. Results of the control
% 4. Generate gif to visually verify control efforts

%% Step 1: Import reference tracking trajectory and Markov parameters
clear
t = 0;
func = @simple_pendulum;
Simple_Pendulum = load('simple_pendulum.mat');
r = Simple_Pendulum.r;
H = Simple_Pendulum.H;
M = Simple_Pendulum.M;
dt = Simple_Pendulum.dt;
[size_output, size_input] = size(H,1,2);
N = size(r,2)-1;
savePath=fullfile(fileparts(mfilename('fullpath')),'data_temp'); %Save files in same folder as this code

%% Step 2: Initialize output and input weight matrices and perform simulation

for i = 1:3 % test three combinations of Q and R
    if i == 1
        Q = 1e0*eye(size_output);
        R = 1e0*eye(size_input);
        [y_temp,u_temp] = pendulum_simulation(Q,R,H,M,t,dt,N,size_input,size_output,r);
        y_store(:,i) = y_temp';
        u_store(:,i) = u_temp';
    elseif i == 2
        Q = 1e3*eye(size_output);
        R = 1e0*eye(size_input); 
        [y_temp,u_temp] = pendulum_simulation(Q,R,H,M,t,dt,N,size_input,size_output,r);
        y_store(:,i) = y_temp';
        u_store(:,i) = u_temp';
    else
        Q = 1e6*eye(size_output);
        R = 1e0*eye(size_input); 
        [y_temp,u_temp] = pendulum_simulation(Q,R,H,M,t,dt,N,size_input,size_output,r);
        y_store(:,i) = y_temp';
        u_store(:,i) = u_temp';
    end
end


%% Step 3: Results of the control
newcolor = colororder;

figure
tiledlayout(3,2, 'Padding', 'none', 'TileSpacing', 'compact');
nexttile
plot((1:N+1)*dt,r'-y_store(:,1),'-','Color',newcolor(1,:),'linewidth',2)
ylabel('Tracking error (rad)','Interpreter','latex')
title('Tracking errors at different weights')
lg  = legend('Q = 1, R = 1','Orientation','Horizontal');
lg.Layout.Tile = 'South';
grid on
nexttile
plot((1:N+1)*dt,u_store(:,1),'-','Color',newcolor(1,:),'linewidth',2)
ylabel('Inputs increment (N)','Interpreter','latex')
title('Inputs at different weights')
grid on
nexttile
plot((1:N+1)*dt,r'-y_store(:,2),'-','Color',newcolor(2,:),'linewidth',2)
ylabel('Tracking error (rad)','Interpreter','latex')
lg  = legend('Q = 1E3, R = 1','Orientation','Horizontal');
lg.Layout.Tile = 'South';
grid on
nexttile
plot((1:N+1)*dt,u_store(:,2),'-','Color',newcolor(2,:),'linewidth',2)
ylabel('Inputs increment (N)','Interpreter','latex')
grid on
nexttile
plot((1:N+1)*dt,r'-y_store(:,3),'-','Color',newcolor(3,:),'linewidth',2)
ylabel('Tracking error (rad)','Interpreter','latex')
lg  = legend('Q = 1E6, R = 1','Orientation','Horizontal');
lg.Layout.Tile = 'South';xlabel('Time(s)','Interpreter','latex')
grid on
nexttile
plot((1:N+1)*dt,u_store(:,3),'-','Color',newcolor(3,:),'linewidth',2)
ylabel('Inputs increment (N)','Interpreter','latex')
xlabel('Time(s)','Interpreter','latex')
grid on

saveas(gcf,fullfile(savePath,'result.png'));


%% Step 4: Generate GIF for Pendulum Animation with Different Values of Q and R
L = 1;

QR = [1,1;1E3,1;1E6,1];
for i = 1:3
    h(i) = pendulum_animation(N,L,y_store(:,i),i);hold on;
    title(['(Q,R) = ','(',num2str(QR(i,1)),',', num2str(QR(i,2)),')']);hold off
end

saveas(gcf,fullfile(savePath,'result.png'));

