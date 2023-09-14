function airfoil_animation(x_store,ref)
% /* This Source Code Form is subject to the terms of the Mozilla Public
% * License, v. 2.0. If a copy of the MPL was not distributed with this
% * file, You can obtain one at http://mozilla.org/MPL/2.0/.
%
% This function generates the gif animation of the control process for the
% tensegrity airfoil.
% Inputs:
%   x: controlled trajectory
%   u: reference trajectory
%
%%
load("Airfoil.mat")
h=figure(); name='airfoil_animation';
foil_str = '2412'; propu = min(N_struc0(1,2:end)); propl = 1;
for i=1:length(N_struc0(1,:))
    if N_struc0(2,i)<0
        propl = min(propl,N_struc0(1,i));
    end
end
[xU,xL,zU,zL] = gene_airfoil_front(foil_str,propu,propl);
x_front = [xU;xL]; z_front =[zU;zL];
plot(x_front,z_front,'linewidth',2); hold on;
fill(x_front,z_front,[25/255 25/255 112/255]); hold on;


N_lin = size(N_struc0);
N_struc = N_struc0;
N_fin = N_struc0;
N_process = [];
N_target = [];
Node_error_x = [];     Node_error_y = [];
Node_error_z = [];


S_error = []; B_error = [];
N = N_struc0;
S_len = []; S_0 = N*CST'; S_len0 = [];
for ss = 1:length(CST(:,1))
    S_len0 = [S_len0;norm(S_0(:,ss),2)];
end
B_len = []; B_0 = N*CBT'; B_len0 = [];
for bb = 1:length(CBT(:,1))
    B_len0 = [B_len0;norm(B_0(:,bb),2)];
end

x_state = [zeros(52,1)+x_ori x_store(1:52,:)+x_ori];
yy = x_state';
r_store = ref;
r_temp = reshape(r_store(:,end)+x_ori(1:26),2,13);
r_temp = [r_temp;zeros(1,13)];
r_fin = [N_fin(:,1) r_temp(:,1:5) N_fin(:,7) r_temp(:,6:9) N_fin(:,12) r_temp(:,10:13)];
for n = 1:1:size(yy,1) % change 10 to change the animation speed

    foil_str = '2412'; propu = min(N_struc0(1,2:end)); propl = 1;
    for i=1:length(N_struc0(1,:))
        if N_struc0(2,i)<0
            propl = min(propl,N_struc0(1,i));
        end
    end
    [xU,xL,zU,zL] = gene_airfoil_front(foil_str,propu,propl);
    x_front = [xU;xL]; z_front =[zU;zL];
    plot(x_front,z_front,'linewidth',2); hold on;
    fill(x_front,z_front,[25/255 25/255 112/255]); hold on;


    %         N_lin = reshape(yy(n,1:40),2,[]); % 2X20
    N_lin = reshape(yy(n,1:52/2),2,[]); % 2X20

    %         N_final2d = reshape(yy(end,1:40),2,[]); % 2X20
    N_final2d = reshape(yy(end,1:52/2),2,[]); % 2X20

    %         N_lin = [N_lin;zeros(1,20)]; % 3X20
    %         N_final3d = [N_final2d;zeros(1,20)]; % 2X20
    N_lin = [N_lin;zeros(1,13)]; % 3X20
    N_final3d = [N_final2d;zeros(1,13)]; % 2X20

    %         N_struc(:,2:11) = N_lin(:,1:10); N_struc(:,13:end) = N_lin(:,11:end);
    N_struc(:,2:6) = N_lin(:,1:5);  N_struc(:,8:11) = N_lin(:,6:9);
    N_struc(:,13:end) = N_lin(:,10:end);

    % for plot target
    %         N_fin(:,2:11) = N_final3d(:,1:10); N_fin(:,13:end) = N_final3d(:,11:end);
    N_fin(:,2:6) = N_final3d(:,1:5); N_fin(:,8:11) = N_final3d(:,6:9);
    N_fin(:,13:end) = N_final3d(:,10:end);


    tenseg_plot_lin(N_struc,CBT,CST,3,[],[0,90]);hold on;
    tenseg_plot_lin_tar(N_fin,CBT,CST,3,[1:1:16],[0,90]);hold on;
    %     text(0.42,0.11,strcat('T = ',num2str((n-1)/100),'s'),'fontsize',14);
    xlim([0 1]);ylim([-0.15 0.15]);
    xlabel('Chord X (m)','Interpreter','latex')
    ylabel('Y (m)','Interpreter','latex')
    set(gca,'fontsize', 12,'linewidth',1.15);
    set(gca,'ticklength',1.2*get(gca,'ticklength'));
    tenseg_savegif_forever(name);  hold off;

    N_new = N_struc;
    S_len = []; B_len = []; S = N_new*CST';
    for ss = 1: length(S(1,:))
        S_len = [S_len;norm(S(:,ss),2)];
    end
    S_len_error = abs(S_len - S_len0);

    Node_error_x = [Node_error_x (N_new(1,:) - r_fin(1,:))'];
    Node_error_y = [Node_error_y (N_new(2,:) - r_fin(2,:))'];
    Node_error_z = [Node_error_z (N_new(3,:) - r_fin(3,:))'];


end
end