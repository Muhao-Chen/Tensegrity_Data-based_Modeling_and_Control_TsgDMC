function P_left = rotanew_point_axis(P,A_nor,theta)
%% P_left = rotanew_point_axis(P,A_nor,theta) gives vector P rotates 
% about axis A_nor with angle theta.

% Inputs:
%	P: vector P is a row vector
%   A_nor: row vector A_nor is the axis
%   theta: angle in radius
% Outputs:
%   d: P_left is the new row vector

A_nor = A_nor/(sqrt(A_nor*A_nor'));
Ax = A_nor(1);Px = P(1);
Ay = A_nor(2);Py = P(2);
Az = A_nor(3);Pz = P(3);
% theta = pi*120/180;
% theta_2 = theta*2;
axp = [Ay*Pz - Az*Py,Az*Px - Ax*Pz,Ax*Py - Ay*Px];
P_left= P*cos(theta) + (axp)*sin(theta) + A_nor*(A_nor*P')*(1 - cos(theta));
% P_right = vpa(P*cos(theta_2) + (axp)*sin(theta_2) + A*(A*P')*(1 - cos(theta_2)),10);
end