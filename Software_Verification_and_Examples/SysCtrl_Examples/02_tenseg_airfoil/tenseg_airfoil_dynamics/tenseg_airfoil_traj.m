%% Cantilever truss dynamics simulation based on FEM
% clc; clear all; close all;
% global N C E_bar fvs ne sigmas sigmab Eb Es rho R p f  C_b C_s t
global l m R p Eb Es
% constitutive law
sigmas=1650e6; sigmab=300e1;
% steel material
[consti_data,Eb,Es]=material_info2();
% Eb=2.06e11;
% Es=76000e6;        %this is from experiment
rho=7870;
t=6e-3; % thickness of hollow bar
c_safe_b=1; % coefficient of safty of bars 0.5
c_safe_s=1; % coefficient of safty of strings 0.3
substep=3;   %�����Ӳ�
% material='linear_elastic';
material='linear_slack';
% material='multielastic';
% material='plastic';
% slack=0; %consider slack of string(1),if not (0)
% multielastic=0; % consider multielastic constitutive law of member(1),if not (0)
% plastic=1; % consider plastic constitutive law of member(1),if not (0)
tf=0.01;         % final time of dynamic simulation
out_dt=1e-4;  % output data interval (approximately, not exatly)
saveimg=0;    % save image or not (1) yes (0)no
savedata=1;   % save data or not (1) yes (0)no
video=0;      %make video(1) or not(0)
% N C of structure
load('member_info.mat'); % this is generated by Main_foil_kinematics.m
C_b = CBT; C_s = CST;
C = [C_b;C_s];
% N=[0 0 0;1 0 0;2 0 0;3 0 0;4 0 0;5 0 0;6 0 0;7 0 0;8 0 0;9 0 0;10 0 0;
%     0 1 0;1 1 0;2 1 0;3 1 0;4 1 0;5 1 0;6 1 0;7 1 0;8 1 0;9 1 0;10 1 0]';   %nodal coordinate
% C_in=[1 2; 2 3;3 4;4 5;5 6;6 7;7 8;8 9;9 10;10 11;
%     1 12;1 13;2 13;2 14;3 14;3 15;4 15;4 16;5 16;5 17;6 17;6 18;7 18;7 19;8 19;8 20;9 20;9 21;10 21;10 22;11 22;
%     12 13;13 14;14 15;15 16;16 17;17 18;18 19;19 20;20 21;21 22];
% C = tenseg_ind2C(C_in,N);
% Plot the structure to make sure it looks right
% tenseg_plot(N,C_b,C_s); % axis off;
%% % ne: No. of element; nn: No. of node
B=N*C'; [ne,nn]=size(C); E_bar = Eb*eye(ne); l=sqrt(sum((N*C').^2))'; %length matrix
ne_b = length(C_b(:,1));
%% Boundary constraints
% %pinned nodes
% I=eye(3*nn); pinned_nodes = [1,7,12]';
% % pinned_nodes = [];
% b=kron(3*pinned_nodes,ones(3,1))-kron(ones(size(pinned_nodes)),[2;1;0]);   %index of pinned nodes
% b=[b;3*[1;7;12]];
% % ;2;3;4;5;6;8;9;10;11;13;14;15;16
% a=setdiff(1:3*nn,b);  %index of free node direction
% Ia=I(:,a);  %free node index
% Ib=I(:,b);  %pinned nod index
pinned_X=([1,7,12])'; pinned_Y=([1,7,12])'; pinned_Z=([1:nn])';
% pinned_Z=([1,7,12])';
[Ia,Ib,a,b]=tenseg_boundary(pinned_X,pinned_Y,pinned_Z,nn);
%% generate group index for tensegrity torus structure
gr=[]; Gp=tenseg_str_gp(gr,C); %generate group matrix
n_g=size(Gp,2); %number of group for elements
%% Cross sectional & young's modulus
A_bar=0.0025*ones(ne_b,1); A_string = 0.0010*ones(ne-ne_b,1);
A = [A_bar;A_string];
E=Eb*ones(ne,1);
%%  members' force & rest length
f=0*ones(ne,1); l0=E.*A.*l./(f+E.*A);
%%  members' force & rest length
l0=E.*A.*l./(t+E.*A);
%% input data for dynamic analysis
% mass matrix
mass=rho*A.*l0; % real mass
M1=0.5*kron(diag(diag(abs(C)'*diag(mass)*abs(C))),eye(3));
M2=1/6*kron((abs(C)'*diag(mass)*abs(C)+diag(diag(abs(C)'*diag(mass)*abs(C)))),eye(3)); 
M=M2; %use M1 or M2
% damping matrix  %damping coefficient
d=0.1; D=d*2*max(sqrt(mass.*E.*A./l0))*eye(3*nn); %critical damping
%% output for anlysis
% ansys_input_mode(N,C,A,f,b,[0],'truss_10seg.txt');
%% mode analysis
K1 = tenseg_stiff_matx2(C,N(:),E,A,l0);
[V_mode1,D1] = eig(Ia'*K1*Ia,Ia'*M*Ia); %calculate buckling mode
d1=diag(D1); d_omega1=real(sqrt(d1))/2/pi; %eigen value, % frequency  in Hz
%% plot the mode
% figure; plot(1:numel(a),d_omega1,'k-o','linewidth',1.5);
% set(gca,'fontsize',18); xlabel('mode order','fontsize',18);
% ylabel('f/Hz','fontsize',18); grid on;
% if saveimg==1; saveas(gcf,'oder_f.png'); end
% plt=1:4;      %plot first 4 mode
% for i=1:numel(plt)
%     f1=figure;
%     title=({['mode ',num2str(plt(i))];['f=',num2str(d_omega1(plt(i)),'%.4f'),'Hz']});
%     %plot buckling mode
%     tenseg_plot(N-5*max(l)*reshape(Ia*V_mode1(:,plt(i)),3,[]),C_b,C_s,f1,[],[],title);
%     tenseg_plot_dash(N,C_b,C_s,f1,[],[],title);
%     axis off; view(2);
%     if saveimg==1; saveas(gcf,['Mode',num2str(plt(i)),'.png']); end
% end
% %%  plot 3 mode in one figure
% f2=figure;
% for i=1:numel(plt)
%     subplot(numel(plt),1,i);
%     title=(['\fontsize{12}mode ',num2str(plt(i)),', f = ',num2str(d_omega1(plt(i)),'%.4f'),' Hz']);
%     tenseg_plot(N-5*max(l)*reshape(Ia*V_mode1(:,plt(i)),3,[]),C,[],f2,[],[],title);
%     xlim([0 11]); ylim([-0.5 1.8]);     axis equal;
%     tenseg_plot_dash(N,C,[],f2,[],[],title);
%     xlim([0 11]); ylim([-0.5 1.8]);     axis equal;
%     set(gca,'fontsize',8); axis off; view(2);
% end
% saveas(gcf,['Mode_first4','.png']);
%% self-stress design
% element length
H=N*C';                     % element's direction matrix
l=sqrt(diag(H'*H));         % elements' length
l_gp=pinv(Gp)*l;            % elements' length in group
[A_1a,A_1ag,A_2a,A_2ag]=tenseg_equilibrium_matrix(H,C,Gp,Ia,l);
%% cross sectional design
% index_b=find(t<0);              % index of bar in compression
index_s= [16:ne];
% setdiff(16:ne,index_b);	% index of strings
% [A_b,A_s,A_gp,A,r_b,r_s,r_gp,radius,E,l0,rho,mass]=tenseg_minimass(t,l,Gp,sigmas,sigmab,Eb,Es,index_b,index_s,c_b,c_s,rho_b,rho_s,thick,hollow_solid);
%% linearized dynaimcs
K_T=tenseg_stiff_matx2(C,N(:),E,A,l0);
K_Taa=Ia'*K_T*Ia; K_Tab=Ia'*K_T*Ib;
D_aa=Ia'*D*Ia; M_aa=Ia'*M*Ia; M_ab=Ia'*M*Ib;
K_l0a=-A_1a*diag(E.*A.*l0.^(-2));     % sensitive matrix of rest length
% K_l0=A_1;                           % sensitive matrix of force density
% linearized model x_dot=Ax+B*u, in which x=[dna;dna_d]; u=[dfa;dl0]; dfa is the force in free nodal coordinates
% A_lin=[zeros(numel(a)),eye(numel(a));-M_aa\K_Taa,-M_aa\D_aa];
% B_lin=[zeros(numel(a),numel(a)+ne);-inv(M_aa),-M_aa\K_l0a];
A_lin=[zeros(numel(a)),eye(numel(a));-inv(M_aa)*K_Taa,-inv(M_aa)*D_aa];
B_lin=[zeros(numel(a),numel(a)+ne);inv(M_aa),-inv(M_aa)*K_l0a];   
% % %%
% time step
dt=pi/(7*max(d_omega1));    % dt is 1/14 of the smallest period
% dt=1e-6;
tspan=0:dt:tf; out_tspan=interp1(tspan,tspan,0:out_dt:tf, 'nearest','extrap');  % output data time span
%consider gravity load
G=-0.5*kron(abs(C)',[0;0;0])*mass;    %gravity force vector
w0=zeros(3*nn,1); 
w0(3*6-1)= -1e4; % external force
% G=-0.5*kron(abs(C)',[0;0*9.8;0])*mass;    %gravity force vector
% w0=zeros(3*nn,1); w0(3*22-1)=-1e5; % external force
% w0=w0+G; %considering gravity
w_t=G*ones(1,numel(tspan))+w0*ones(1,numel(tspan));     %gravity constant, exert force gradually
% forced movement is added in XYZ direction
dnb_t=zeros(numel(b),1)*ones(1,numel(tspan)); %move boundary nodes
dnb_d_t=zeros(numel(b),1)*ones(1,numel(tspan));   %velocity of moved boundary nodes
dnb_dd_t=zeros(numel(b),1)*ones(1,numel(tspan)); %velocity of moved boundary nodes
% input data
%use the equilibrium configuration from static calculation with w
data.N=N; data.C=C; data.ne=ne; data.nn=nn; data.Ia=Ia; data.Ib=Ib;
data.E=E; data.A=A; data.l0=l0; data.index_b=[1:ne_b];
data.index_s=index_s; data.consti_data=consti_data;
% data.slack=slack;
% data.multielastic=multielastic;
% data.plastic=plastic;
data.material=material;
data.w_t=w_t;           % external force
data.dnb_t=dnb_t;       % forced node displacement
data.dnb_d_t=dnb_d_t;    %velocity of forced moved node
data.dnb_dd_t=dnb_dd_t;    %velocity of forced moved node
data.M=M; data.D=D; data.dt=dt; data.tf=tf; data.tspan=tspan;
data.out_dt=out_dt; data.out_tspan=out_tspan;
% %% dynamic analysis
% data_out=dynamic_solver(data);        %solve equilibrium using mNewton method
% % get output data and make video  %nodal coordinate 
% t_t=data_out.t_t; n_t=data_out.n_t; l_t=data_out.l_t;   
% % make video of the dynamic
%%
% if video==0
%     figure(99); name=['cantilever','tf_',num2str(tf),material];
%     set(gcf,'Position',get(0,'ScreenSize'));
%     for n = 1:floor(numel(out_tspan)/10):numel(out_tspan)
%         tenseg_plot(reshape(n_t(:,n),3,[]),C_b,C_s,99,[],[0,90]);hold on
%         xlim([0.8,1]); ylim([-.2,0.2]); % zlim(20*[-1,1.5]);
%         tenseg_savegif_forever(name);  hold off;
%     end
%     close
% end