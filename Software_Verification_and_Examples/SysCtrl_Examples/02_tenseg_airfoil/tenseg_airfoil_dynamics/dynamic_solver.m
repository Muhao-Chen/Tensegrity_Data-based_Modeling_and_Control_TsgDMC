function data_out=dynamic_solver(data_in)
%solve dynamic equations using Runge_Kuta method

%% input data

Ia=data_in.Ia;
n0=data_in.N(:);
tspan=data_in.tspan;
%% dynamic iteration
% time step 
% tspan=0:dt:tf;
% initial value
n0a=Ia'*n0;
n0a_d=zeros(size(n0a));
Y0a=[n0a;n0a_d];
% Perform simulation
data_out = ode4_truss(@tenseg_dyn_x_xdot,tspan,Y0a,data_in);




















