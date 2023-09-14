function [consti_data,Eb,Es]=material_info2()
%output information of material: strain-stress, strain-modulus
% bar is Q345 steel, string is steel rope

%% input the info of bars
% strain_b1=[0.001267,0.00157,0.02480,0.033,0.06,0.07,0.08];  % strain of bar Q345 
% stress_b1=1e6*[261,273,288.6,313.6,398.5,0,0];              % stress of bar Q345
strain_b1=[1456e-6,23301e-6];  % strain of bar Q345  ˫����
stress_b1=1e6*[300,435];              % stress of bar Q345   ˫����

data_b0=[strain_b1;stress_b1];            %material info for strain>0
data_b1=[-fliplr(data_b0),[0;0],data_b0];         %bar info from strain to stress
stress_b=data_b1(2,:);
strain_b=data_b1(1,:);
data_b_E=diff(stress_b)./diff(strain_b);
data_b_strain=strain_b(1:end-1);
data_b2=[data_b_strain;data_b_E];               %bar info from strain to modulus

%% input the info of strings
strain_s=[-1,0,0.016099,1,1.1];   % strain of string ��˿��
stress_s=1e6*[0,0,1223.5,1650,0];          % stress of string ��˿��
% stress_s=2*1e6*[0,0,790.95,0,0];          % stress of string ��˿��
% strain_s=[1,0,0.001267,0.00157,0.02480,0.033,0.06,0.07,0.08];  % strain of bar Q345 
% stress_s=4*1e6*[0,0,261,273,288.6,313.6,398.5,0,0];              % stress of bar Q345


data_s1=[strain_s;stress_s];                        %string info from strain to stress
data_s_E=diff(stress_s)./diff(strain_s);
data_s_strain=strain_s(1:end-1);
data_s2=[data_s_strain;data_s_E];                    %string info from strain to modulus

%% output info
% data_b.data_b1=data_b1;
% data_b.data_b2=data_b2;
% data_s.data_s1=data_s1;
% data_s.data_s2=data_s2;
consti_data.data_b1=data_b1;
consti_data.data_b2=data_b2;
consti_data.data_s1=data_s1;
consti_data.data_s2=data_s2;
%% plot the stress-strain curve
% stress_strain
% figure
% plot(data_b1(1,:),data_b1(2,:),'k-o','linewidth',1.5)
% grid on; 
% xlabel('Ӧ��','fontsize',14);
% ylabel('Ӧ��/Pa','fontsize',14);title('��');
% saveas(gcf,'1ѹ�˱���.png');
% 
% figure
% plot(data_s1(1,:),data_s1(2,:),'k-o','linewidth',1.5)
% grid on;
% axis([-0.015,0.025,-max(stress_s),max(stress_s)])
% xlabel('Ӧ��','fontsize',14);
% ylabel('Ӧ��/Pa','fontsize',14);
% title('��');
% saveas(gcf,'1��������.png');
%% plot the modulus-strain curve
% E-strain
% figure
% xi = linspace(2*min(data_b_strain),2*max(data_b_strain),1000);
% yi = interp1(data_b_strain, data_b_E, xi,'previous',0);
% plot(data_b_strain, data_b_E,'ko', xi, yi,'linewidth',1.5);
% xlabel('Ӧ��','fontsize',14);
% ylabel('����ģ��/Pa','fontsize',14);title('��');
% saveas(gcf,'1ѹ�˵���ģ��.png');

% figure
% xj = linspace(-1,2*max(data_s_strain),1000);
% yj = interp1(data_s_strain, data_s_E, xj,'previous',0);
% plot(data_s_strain, data_s_E,'ko', xj, yj,'linewidth',1.5);
% % axis([-0.04,0.04,-max(data_s_E),max(data_s_E)])
% xlabel('Ӧ��','fontsize',14);
% ylabel('����ģ��/Pa','fontsize',14);
% title('��');
% saveas(gcf,'1��������ģ��.png');


Eb=interp1(data_b2(1,:), data_b2(2,:), 0,'previous',0);
Es=interp1(data_s2(1,:), data_s2(2,:), 0,'previous',0);

end

