%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% tsgDMC system identification of tensegrity airfoil %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% /* This Source Code Form is subject to the terms of the Mozilla Public
% * License, v. 2.0. If a copy of the MPL was not distributed with this
% * file, You can obtain one at http://mozilla.org/MPL/2.0/.
%
% This script exucutes the system identification for the tensegrity 
% airfoil. Specific steps include the following:
% 1. Generate Markov parameters
% 2. Construct Hankel matrices
% 3. Determine model complexity
% 4. Simulation
% 5. Result visualization
%% Step 1: Generate Markov parameters
clear; clc; close all
T = 10;
dt = 0.1;
MadCtrl_data = load("airfoil.mat");
H = MadCtrl_data.Hi;
[size_output, size_input] = size(H,1,2);
savePath=fullfile(fileparts(mfilename('fullpath')),'data_temp'); %Save files in same folder as this code

%% Step 2: Construct Hankel matrices
a = 10;
b = 10;
[Phi1,Phi2] = tsgDMC_Hankel(H,a,b);

%% Step 3: Determine model complexity
n = 52;
[A,B,C,D] = tsgDMC_era(Phi1,Phi2,H,n);
sys = ss(A,B,C,D,dt);

%% Simulation
newcolor = colororder;

ui = zeros(T/dt+1,size_input); ui(1,10) = 1;
us = zeros(T/dt+1,size_input); us(:,10) = ones(T/dt+1,1);
uw = zeros(T/dt+1,size_input); uw(:,10) = wgn(T/dt+1,1,pow2db(1));
usin = zeros(T/dt+1,size_input); usin(:,10) = sin((0:dt:T))';

[yi,~] = lsim(sys,ui,(0:dt:T));
[ys,~] = lsim(sys,us,(0:dt:T));
[yw,~] = lsim(sys,uw,(0:dt:T));
[ysin,t] = lsim(sys,usin,(0:dt:T));

xi = zeros(52,1);
xs = zeros(52,1);
xw = zeros(52,1);
xsin = zeros(52,1);

for i = 1:T/dt
    [xi,yi_temp] = discrete_airfoil(ui(i,:)',xi);
    [xs,ys_temp] = discrete_airfoil(us(i,:)',xs);
    [xw,yw_temp] = discrete_airfoil(uw(i,:)',xw);
    [xsin,ysin_temp] = discrete_airfoil(usin(i,:)',xsin);
    yi_store(i+1,:) = yi_temp;
    ys_store(i+1,:) = ys_temp;
    yw_store(i+1,:) = yw_temp;
    ysin_store(i+1,:) = ysin_temp;
end

%% Step 5: Result visualization
figure
tiledlayout(4,2, 'Padding', 'none', 'TileSpacing', 'compact');
nexttile
plot(t,yi_store(:,10),'Color',newcolor(2,:),'LineWidth',2)
hold on
plot(t,yi(:,10),'--','Color',newcolor(1,:),'LineWidth',2)
hold off
grid on
ylabel('$\theta$','Interpreter','latex')
xlabel('Pulse Response','Interpreter','latex')
lg  = legend('Pendulum','ERA','Orientation','Horizontal'); 
lg.Layout.Tile = 'South';
nexttile
plot(t,yi_store(:,10)-yi(:,10),'Color',newcolor(3,:),'LineWidth',2)
ylabel('$\Delta \theta$','Interpreter','latex')
xlabel('Pulse Response Discrepancies','Interpreter','latex')
grid on
lg  = legend('Discrepancy','Orientation','Horizontal'); 
lg.Layout.Tile = 'South';
nexttile
plot(t,ys_store(:,10),'Color',newcolor(2,:),'LineWidth',2)
hold on
plot(t,ys(:,10),'--','Color',newcolor(1,:),'LineWidth',2)
hold off
grid on
ylabel('$\theta$','Interpreter','latex')
xlabel('Step Response','Interpreter','latex')
nexttile
plot(t,ys_store(:,10)-ys(:,10),'Color',newcolor(3,:),'LineWidth',2)
ylabel('$\Delta \theta$','Interpreter','latex')
xlabel('Step Response Discrepancies','Interpreter','latex')
grid on
nexttile
plot(t,yw_store(:,10),'Color',newcolor(2,:),'LineWidth',2)
hold on
plot(t,yw(:,10),'--','Color',newcolor(1,:),'LineWidth',2)
hold off
grid on
ylabel('$\theta$','Interpreter','latex')
xlabel('White Noise Response','Interpreter','latex')
nexttile
plot(t,yw_store(:,10)-yw(:,10),'Color',newcolor(3,:),'LineWidth',2)
ylabel('$\Delta \theta$','Interpreter','latex')
xlabel('White Noise Response Discrepancies','Interpreter','latex')
grid on
nexttile
plot(t,ysin_store(:,10),'Color',newcolor(2,:),'LineWidth',2)
hold on
plot(t,ysin(:,10),'--','Color',newcolor(1,:),'LineWidth',2)
hold on
grid on
ylabel('$\theta$','Interpreter','latex')
xlabel('Sine Response','Interpreter','latex')
nexttile
plot(t,ysin_store(:,10)-ysin(:,10),'Color',newcolor(3,:),'LineWidth',2)
ylabel('$\Delta \theta$','Interpreter','latex')
xlabel('Sine Response Discrepancies','Interpreter','latex')
grid on

saveas(gcf,fullfile(savePath,'result.png'));

