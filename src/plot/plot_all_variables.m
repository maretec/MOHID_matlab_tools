function plot_all_variables(qX_adcp,qY_adcp,qu_mh,qv_mh,qvel_mh,qu_adcp,qv_adcp,qvel_adcp,lab_title,y_lim,c_lim)
subplot(3,2,1)
plot_vertical_profile_time(qX_adcp,qY_adcp,qvel_mh,y_lim,[0 0.5],{lab_title;'Magnitude'},'Magnitude (m/s)')

subplot(3,2,2)
hidden_arrow = compass(1,0);%I don't care the direction
hidden_arrow.Color = 'none';
hold on
compass(qu_mh,qv_mh)
title('Model')

subplot(3,2,3)
plot_vertical_profile_time(qX_adcp,qY_adcp,qvel_adcp,y_lim,[0 0.5],'ADCP','Magnitude (m/s)')
subplot(3,2,4)
hidden_arrow = compass(1,0);%I don't care the direction
hidden_arrow.Color = 'none';
hold on
compass(qu_adcp,qv_adcp)
title('Obs')

subplot(3,2,5)
plot_vertical_profile_time(qX_adcp,qY_adcp,qvel_adcp-qvel_mh,y_lim,[0 0.5],'BIAS','Magnitude (m/s)')

subplot(3,2,6)
plot(qX_adcp(1,:),median(qvel_adcp),'b','linewidth',2)
hold on
plot(qX_adcp(1,:),median(qvel_mh),'r','linewidth',2)
legend('Obs','Model')
datetick('x')
title('Average in depth')
axis tight