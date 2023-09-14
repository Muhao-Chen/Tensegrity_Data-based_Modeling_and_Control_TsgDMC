function Gp=tenseg_str_gp(gr,C_s)
% generate group matrix for strings
% input£º gr-group inedx
        %C_s connectivity matrix of the structure
%output:  Gp-group matrix

Gp=eye(size(C_s,1));
E=eye(size(C_s,1));
Gp1=[];

num=[];      %give index for grooup string number
for i=1:size(gr,1)
    num=[num,gr{i}];
end

if ~isempty(gr)
for i=1:size(gr,1)
    s=sum(E(:,gr{i}),2);
    Gp1=[Gp1,s];
end
Gp(:,num)=[];
Gp=[Gp1,Gp];
end
