%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% tsgDMC system identification of a Simple Pendulum %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% /* This Source Code Form is subject to the terms of the Mozilla Public
% * License, v. 2.0. If a copy of the MPL was not distributed with this
% * file, You can obtain one at http://mozilla.org/MPL/2.0/.
%
% This script exucutes the system identification for the simple pendulum. 
% Specific steps include the following:
% 1. Generate Markov parameters
% 2. Construct Hankel matrices
% 3. Determine model complexity
% 4. Simulation
% 5. Result visualization
%% Step 1: Import Markov parameters
T = 10;
func = @simple_pendulum;
simple_pendulum = load('simple_pendulum.mat');
H = simple_pendulum.H;
dt = simple_pendulum.dt;
[size_output, size_input] = size(H,1,2);
savePath=fullfile(fileparts(mfilename('fullpath')),'data_temp'); %Save files in same folder as this code

%% Step 2: Construct Hankel matrices

a = 400; % Specify number of Markov parameters in the row
b = 400; % Specify number of Markov parameters in the column
[Phi1,Phi2] = tsgDMC_Hankel(H,a,b);

%% Step 3: Determine model complexity
sigma = 0.999999;
n = tsgDMC_pdm(Phi1,sigma);
[A,B,C,D] = tsgDMC_era(Phi1,Phi2,H,n);
sys = ss(A,B,C,D,dt);

%% Step 4: Simulation
newcolor = colororder;

ui = zeros(T/dt+1,1);ui(1) = 1;
us = ones(T/dt+1,1);
uw = wgn(T/dt+1,1,pow2db(1));
usin = sin((0:dt:T))';

[yi,~] = lsim(sys,ui,0:dt:T);
[ys,~] = lsim(sys,us,0:dt:T);
[yw,~] = lsim(sys,uw,0:dt:T);
[ysin,t] = lsim(sys,usin,0:dt:T);

xi = zeros(2,1);
xs = zeros(2,1);
xw = zeros(2,1);
xsin = zeros(2,1);

yi_store = zeros(T/dt+1,1);
ys_store = zeros(T/dt+1,1); 
yw_store = zeros(T/dt+1,1); 
ysin_store = zeros(T/dt+1,1); 

for i = 1:T/dt
    [~,xi_temp] = ode45(func,[0,dt],xi,[],ui(i));
    [~,xs_temp] = ode45(func,[0,dt],xs,[],us(i));
    [~,xw_temp] = ode45(func,[0,dt],xw,[],uw(i));
    [t_temp,xsin_temp] = ode45(func,[0,dt],xsin,[],usin(i));
    xi = xi_temp(end,:)';
    xs = xs_temp(end,:)';
    xw = xw_temp(end,:)';
    xsin = xsin_temp(end,:)';
    yi_store(i+1,:) = xi_temp(end,1);
    ys_store(i+1,:) = xs_temp(end,1);
    yw_store(i+1,:) = xw_temp(end,1);
    ysin_store(i+1,:) = xsin_temp(end,1);
end
%% Step 5: Result visualization
figure
tiledlayout(4,2, 'Padding', 'none', 'TileSpacing', 'compact');
nexttile
plot(t,yi_store,'Color',newcolor(2,:),'LineWidth',2)
hold on
plot(t,yi,'--','Color',newcolor(1,:),'LineWidth',2)
grid on
hold off
ylabel('$\theta$','Interpreter','latex')
xlabel('Pulse Response','Interpreter','latex')
lg  = legend('Pendulum','ERA','Orientation','Horizontal'); 
lg.Layout.Tile = 'South';
nexttile
plot(t,yi_store-yi,'Color',newcolor(3,:),'LineWidth',2)
ylabel('$\Delta \theta$','Interpreter','latex')
xlabel('Pulse Response Discrepancies','Interpreter','latex')
grid on
lg  = legend('Discrepancy','Orientation','Horizontal'); 
lg.Layout.Tile = 'South';
nexttile
plot(t,ys_store,'Color',newcolor(2,:),'LineWidth',2)
hold on
plot(t,ys,'--','Color',newcolor(1,:),'LineWidth',2)
hold off
grid on
ylabel('$\theta$','Interpreter','latex')
xlabel('Step Response','Interpreter','latex')
nexttile
plot(t,ys_store-ys,'Color',newcolor(3,:),'LineWidth',2)
ylabel('$\Delta \theta$','Interpreter','latex')
xlabel('Step Response Discrepancies','Interpreter','latex')
grid on
nexttile
plot(t,yw_store,'Color',newcolor(2,:),'LineWidth',2)
hold on
plot(t,yw,'--','Color',newcolor(1,:),'LineWidth',2)
hold off
grid on
ylabel('$\theta$','Interpreter','latex')
xlabel('White Noise Response','Interpreter','latex')
nexttile
plot(t,yw_store-yw,'Color',newcolor(3,:),'LineWidth',2)
ylabel('$\Delta \theta$','Interpreter','latex')
xlabel('White Noise Response Discrepancies','Interpreter','latex')
grid on
nexttile
plot(t,ysin_store,'Color',newcolor(2,:),'LineWidth',2)
hold on
plot(t,ysin,'--','Color',newcolor(1,:),'LineWidth',2)
hold on
grid on
ylabel('$\theta$','Interpreter','latex')
xlabel('Sine Response','Interpreter','latex')
nexttile
plot(t,ysin_store-ysin,'Color',newcolor(3,:),'LineWidth',2)
ylabel('$\Delta \theta$','Interpreter','latex')
xlabel('Sine Response Discrepancies','Interpreter','latex')
grid on

saveas(gcf,fullfile(savePath,'result.png'));
