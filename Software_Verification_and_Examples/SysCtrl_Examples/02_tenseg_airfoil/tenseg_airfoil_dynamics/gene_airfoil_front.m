function [xU,xL,zU,zL] = gene_airfoil_front(air_str,propotionu,propotionl)
iaf.designation=air_str;
% designation='0008';
iaf.n=400;
iaf.HalfCosineSpacing=1;
iaf.wantFile=1;
iaf.datFilePath='./'; % Current folder
iaf.is_finiteTE=0;

af = naca4gen(iaf);

xU = [];
zU = [];
xL = [];
zL = [];
lenx = length(af.xU);
for i=1:lenx
%     af.xU(i)
    if abs(af.xU(i)) <=propotionu
        xU = [xU af.xU(i)];
        zU =[zU af.zU(i)];
    end
    if abs(af.xL(i)) <=propotionl
        xL =[xL af.xL(i)];
        zL =[zL af.zL(i)];
    end
end
zU = zU';
xU = xU';
xL = xL';
zL = zL';
% save py.mat
% plot(af.xU,af.zU,'bo-','MarkerSize',2)
% axis equal
% hold on
% plot(af.xL,af.zL,'ro-','MarkerSize',2)
% 
% axis equal
end
