function P_left_n = trans_space_to_rota_V2(N,P1,P2,theta)
%% This function is to rotate one matrix with axis which given by two points
% Inputs:
%       P1,P2:1*3
%       N:n*3
n = length(N(:,1));
P_left_n = zeros(size(N));
for i =1:n
    A = N(i,:);
    T = [1 0 0 -P1(1);0 1 0 -P1(2);0 0 1 -P1(3);0 0 0 1];
    T_r = [1 0 0 P1(1);0 1 0 P1(2);0 0 1 P1(3);0 0 0 1];
    A_t = T*[A 1]';
    P1_t = T*[P1 1]';
    P2_t = T*[P2 1]';
    A_nor = P2_t (1:3)'- P1_t(1:3)';
    A_nor = A_nor/(sqrt(A_nor*A_nor'));
    P = A_t(1:3)';
    P_left = rotanew_point_axis(P,A_nor,theta);
    P_left = T_r*[P_left';1];
    P_left = vpa(P_left(1:3));
    P_left_n(i,:) = P_left;
end

