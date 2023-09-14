function K_t=tenseg_stiff_matx2(C,n,E,A,l0)
%this function is to calculate stiffness matrix of tensegrity

N=reshape(n,3,[]);
B=N*C';
l=sqrt(sum(B.^2))';
q=E.*A.*(1./l0-1./l);      %force density
ne=size(C,1);
A1=kron(C',eye(3))*diag(kron(C,eye(3))*n)*...
    kron(eye(ne),ones(3,1));  %equilibrium matrix
Ke=A1*diag(E.*A./(l.^3))*A1';
Kg=kron(C'*diag(q)*C,eye(3));
% K_t=Kg+Ke;         % calculate this way may have round off error:K_t not
% symmetric
K_t=Kg+(Ke+Ke')/2;     % this is to guarantee symmetric real matrix
end





 

