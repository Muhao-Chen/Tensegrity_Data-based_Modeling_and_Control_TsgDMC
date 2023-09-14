%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% tsgDMC system identification of a cantilever beam %%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% /* This Source Code Form is subject to the terms of the Mozilla Public
% * License, v. 2.0. If a copy of the MPL was not distributed with this
% * file, You can obtain one at http://mozilla.org/MPL/2.0/.
%
% This script exucutes the system identification for the clamped free beam 
% using QMC. Specific steps include the following:
% Step 1: Generate Markov and Covariance parameters
% Step 2: Construct data matrix
% Step 3: Check existence condition and find QMC solution
% Step 4: Perform simulation
% Step 5: Plot the results

%% Step 1: Generate Markov and Covariance Parameters
clear 
u_force = (0.1:0.1:1)';
y_dis = (0.1:0.1:1)';

size_input = size(u_force,1);
size_output = size(y_dis,1);
N = 6;
[A,B,C,D,omega_set] = clamped_free_beam(u_force,y_dis,N);
dt = 0.001;
T = 10;
[Ad,Bd,Cd,Dd] = tsgDMC_con2dis(A,B,C,D,dt,'zoh');

H = tsgDMC_genMarkov(Ad,Bd,Cd,Dd,100); % Markov parameters
R = tsgDMC_genCov(Ad,Bd,Cd,Dd,100); % Covariance parameters 

savePath=fullfile(fileparts(mfilename('fullpath')),'data_temp'); %Save files in same folder as this code

%% Step 2: Construct data matrix
q = 20;
Hq = tsgDMC_Hq(H,q);
Rq = tsgDMC_Rq(R,q);
Uq = eye(size(Hq,2));
Data_q = tsgDMC_Dq(Hq,Rq,Uq);
existence = tsgDMC_existence(Data_q,-1e-8);

%% Step 3: Check existence condition and find QMC solution
if existence
    n = 12;
    [Aq,Bq,Cq,Dq] = tsgDMC_qmc(H,Hq,Data_q,q,n);
else
    disp('A QMC solution does not exist.')
end


%% Step 4: Perform simulation
sysd = ss(Ad,Bd(:,end),Cd(end,:),Dd(end,end),dt);
sysq = ss(Aq,Bq(:,end),Cq(end,:),Dq(end,end),dt);


ui = zeros(T/dt+1,1);ui(1) = 1;
us = ones(T/dt+1,1);
uw = wgn(T/dt+1,1,pow2db(1));
usin = sin(0:dt:T)';

[yi,~] = lsim(sysd,ui,0:dt:T);
[ys,~] = lsim(sysd,us,0:dt:T);
[yw,~] = lsim(sysd,uw,0:dt:T);
[ysin,~] = lsim(sysd,usin,0:dt:T);

[yri,~] = lsim(sysq,ui,0:dt:T);
[yrs,~] = lsim(sysq,us,0:dt:T);
[yrw,~] = lsim(sysq,uw,0:dt:T);
[yrsin,t] = lsim(sysq,usin,0:dt:T);

%% Step 5: Plot the results
newcolor = colororder;
figure
tiledlayout(4,2, 'Padding', 'none', 'TileSpacing', 'compact');
nexttile
plot(t,yi,'Color',newcolor(2,:),'LineWidth',2)
hold on
plot(t,yri,'--','Color',newcolor(1,:),'LineWidth',2)
hold off
grid on
ylabel('y','Interpreter','latex')
title('Pulse')
nexttile
plot(t,yri-yi,'Color',newcolor(3,:),'LineWidth',2)
hold off
ylabel('$\Delta y$','Interpreter','latex')
title('Pulse')
grid on
nexttile
plot(t,ys,'Color',newcolor(2,:),'LineWidth',2)
hold on
plot(t,yrs,'--','Color',newcolor(1,:),'LineWidth',2)
hold off
grid on
ylabel('y','Interpreter','latex')
title('Step')
nexttile
plot(t,yrs-ys,'Color',newcolor(3,:),'LineWidth',2)
ylabel('$\Delta y$','Interpreter','latex')
title('Step')
grid on
nexttile
plot(t,yw,'Color',newcolor(2,:),'LineWidth',2)
hold on
plot(t,yrw,'--','Color',newcolor(1,:),'LineWidth',2)
hold off
grid on
title('White Noise')
ylabel('y','Interpreter','latex')
nexttile
plot(t,yrw-yw,'Color',newcolor(3,:),'LineWidth',2)
hold off
title('White Noise')
ylabel('$\Delta y$','Interpreter','latex')
grid on
nexttile
plot(t,ysin,'Color',newcolor(2,:),'LineWidth',2)
hold on
plot(t,yrsin,'--','Color',newcolor(1,:),'LineWidth',2)
hold off
grid on
title('Sine')
ylabel('y','Interpreter','latex')
xlabel('Time (s)','Interpreter','latex')
lg  = legend('Beam','QMC','Orientation','Horizontal'); 
lg.Layout.Tile = 'South';
nexttile
plot(t,yrsin-ysin,'Color',newcolor(3,:),'LineWidth',2)
hold off
lg  = legend('Discrepancy','Orientation','Horizontal'); 
lg.Layout.Tile = 'South';
ylabel('$\Delta y$','Interpreter','latex')
xlabel('Time (s)','Interpreter','latex')
title('Sine')
grid on

saveas(gcf,fullfile(savePath,'result.png'));

