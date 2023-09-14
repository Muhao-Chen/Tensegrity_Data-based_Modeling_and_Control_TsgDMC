function [E,stress]=stress_strain(consti_data,index_b,index_s,strain,material)
%calculate young's modulus and stress, given material properties, strain.
%multielastic, plastic, slack of string can be considered
%  Input： consti_date: constitutive data of bar and string 杆、索的应变、应力关系
%           index_b,index_s: number of bar and string索杆标识
%           strain:应变
%           slack: consider material nonlinear(1 for yes,0 for no)  是否考虑材料非线性、索松弛、索破断  (1, 考虑，0，不考虑。默认0）
% Output:  E 弹性模量 young's modulus
%          stress 应力
global Eb Es f_int l_int l0 A
%% extract data of material
data_b1=consti_data.data_b1;%constitutive info of bar & string
data_b2=consti_data.data_b2;
data_s1=consti_data.data_s1;
data_s2=consti_data.data_s2;

%% calculate stress and E
stress=zeros(size(strain)); %initialize stress
E=zeros(size(strain)); %initialize stress

switch material
    case 'linear_elastic';
    %interplot modulus
    E(index_b)=Eb;
    E(index_s)=Es;
    %interplot stress
    stress(index_b)= strain(index_b)*Eb;
    stress(index_s)= strain(index_s)*Es;    
    case 'linear_slack'
      index_slack=find(strain(index_s)<0);
        index_string_slack=index_s(index_slack);       %slack stings'number
        % change youngs mudulus of slack string E_ss=0
        E(index_b)=Eb;
        E(index_s)=Es;
        E(index_string_slack)=0;
        stress=E.*strain;      %reculate force density
    case 'multielastic'    
     %interplot stress
        stress(index_b)= interp1(data_b1(1,:), data_b1(2,:), strain(index_b),'linear','extrap');
         stress(index_s)= strain(index_s)*Es; 
%         stress(index_s)= interp1(data_s1(1,:), data_s1(2,:), strain(index_s),'linear','extrap');
        %interplot modulus
        E(index_b)= interp1(data_b2(1,:), data_b2(2,:), strain(index_b),'previous',data_b2(2,end));
        E(index_s)= interp1(data_s2(1,:), data_s2(2,:), strain(index_s),'previous',data_s2(2,end));
        case 'plastic'   
                %interplot stress of string(multielastic)
    stress(index_s)= interp1(data_s1(1,:), data_s1(2,:), strain(index_s),'linear','extrap');
%     E(index_s)= interp1(data_s2(1,:), data_s2(2,:), strain(index_s),'previous',data_s2(2,end));
        %interplot stress of bar(plastic)
        Et=interp1(data_b2(1,:), data_b2(2,:), data_b2(1,end),'previous',data_b2(2,end));
        Ee=interp1(data_b2(1,:), data_b2(2,:), 0,'previous',data_b2(2,end));     
        strain_int=(l_int-l0)./l0;
        stress_int=f_int./A;        
        stress_b=stress_int(index_b)+Ee*(strain(index_b)-strain_int(index_b));
        
        stress_b=min([stress_b,interp1(data_b1(1,end-1:end), data_b1(2,end-1:end), strain(index_b),'linear','extrap')],[],2);
        stress_b=max([stress_b,interp1(data_b1(1,1:2), data_b1(2,1:2), strain(index_b),'linear','extrap')],[],2);
%         stress_b( find(stress_b>interp1(data_b1(1,end-1:end), data_b1(2,end-1:end), strain(index_b),'linear','extrap')))=...
%             interp1(data_b1(1,end-1:end), data_b1(2,end-1:end), strain(index_b),'linear','extrap');
%         stress_b( find(stress_b<interp1(data_b1(1,1:2), data_b1(2,1:2), strain(index_b),'linear','extrap')))=...
%             interp1(data_b1(1,1:2), data_b1(2,1:2), strain(index_b),'linear','extrap');
            stress(index_b)= stress_b;
end


%     if multielastic==1
%         %interplot stress
%         stress(index_b)= interp1(data_b1(1,:), data_b1(2,:), strain(index_b),'linear','extrap');
%         stress(index_s)= interp1(data_s1(1,:), data_s1(2,:), strain(index_s),'linear','extrap');
%         %interplot modulus
%         E(index_b)= interp1(data_b2(1,:), data_b2(2,:), strain(index_b),'previous',data_b2(2,end));
%         E(index_s)= interp1(data_s2(1,:), data_s2(2,:), strain(index_s),'previous',data_s2(2,end));
% %     else
% %         index_slack=find(strain(index_s)<0);
% %         index_string_slack=index_s(index_slack);       %slack stings'number
% %         % change youngs mudulus of slack string E_ss=0
% %         E(index_b)=Eb;
% %         E(index_s)=Es;
% %         E(index_string_slack)=0;
% %         stress=E.*strain;      %reculate force density
%         
%         %      %interplot stress
%         %     stress(index_b)= interp1([-1,0,1], Eb*[-1,0,1], strain(index_b),'linear','extrap');
%         %     stress(index_s)= interp1([-1,0,1], Es*[0,0,1], strain(index_s),'linear','extrap');
%         %     %interplot modulus
%         %         E(index_b)=Eb;
%         %     E(index_s)= interp1([-1,0], Es*[0,1], strain(index_s),'previous',Es);
%     end
%     
% % end
% % if slack==0
% %     %interplot modulus
% %     E(index_b)=Eb;
% %     E(index_s)=Es;
% %     %interplot stress
% %     stress(index_b)= strain(index_b)*Eb;
% %     stress(index_s)= strain(index_s)*Es;
% % end
% 
% if plastic==1    
%     %interplot stress of string(multielastic)
%     stress(index_s)= interp1(data_s1(1,:), data_s1(2,:), strain(index_s),'linear','extrap');
% %     E(index_s)= interp1(data_s2(1,:), data_s2(2,:), strain(index_s),'previous',data_s2(2,end));
%         %interplot stress of bar(plastic)
%         Et=interp1(data_b2(1,:), data_b2(2,:), 0,'previous',data_b2(2,end));
%         Ee=interp1(data_b2(1,:), data_b2(2,:), data_b2(1,end-1),'previous',data_b2(2,end));     
%         strain_int=(l_int-l0)/l0;
%         stress_int=f_int./A;        
%         stress_b=stress_int(index_b)+Ee*(strain(index_b)-strain_int(index_b));
%         
%         stress_b( find(stress_b>interp1(data_b1(1,end-1:end), data_b1(2,end-1:end), strain(index_b),'linear','extrap')))=...
%             interp1(data_b1(1,end-1:end), data_b1(2,end-1:end), strain(index_b),'linear','extrap');
%         stress_b( find(stress_b<interp1(data_b1(1,1:2), data_b1(2,1:2), strain(index_b),'linear','extrap')))=...
%             interp1(data_b1(1,1:2), data_b1(2,1:2), strain(index_b),'linear','extrap');
%         
%     stress(index_b)= stress_b;
%     
% %     E(index_b)= interp1(data_b2(1,:), data_b2(2,:), strain(index_s),'previous',data_b2(2,end));
% end



end