function plot_compare_variableSTAT(qX,qY,model,obs,lab_title,var_label,y_lim,c_lim)
[bias,RMSE, R,yfit,x]=stats_profile_depth(obs,model);
figure('Position',[10 60 900 600],'Visible','on');
set(gca, 'nextplot', 'replacechildren','FontSize',12)
subplot(3,2,1)
plot_vertical_profile_time(qX,qY,model,y_lim,c_lim,{lab_title ; 'Model'},var_label)
xlabel('')
subplot(3,2,2)
plot(qX(1,:),mean(obs),'b','linewidth',2)
hold on
plot(qX(1,:),mean(model),'r','linewidth',2)
datetick('x')
axis tight
legend('Obs','Model')
legend boxoff
title(['Average in depth ' '[' num2str(-min(qY(:))) ' - ' num2str(-max(qY(:))) ' m ]' ] )
ylim(c_lim)

subplot(3,2,3)
plot_vertical_profile_time(qX,qY,obs,y_lim,c_lim,'Observations',var_label)
xlabel('')
subplot(3,2,4)
plot(qX(1,:),bias,'k--','linewidth',1)
hold on
plot(qX(1,:),RMSE,'k','linewidth',2)
datetick('x')
%yyaxis right
legend({'bias','rms'})
legend boxoff
title('Model - Obs')
axis tight


subplot(3,2,5)
plot_vertical_profile_time(qX,qY,obs-model,y_lim,c_lim,'Bias',var_label)

subplot(3,2,6)
plot(obs(:),model(:),'.k')
hold on
plot(x,yfit,'r-');
title(['Correlation Coeff ' num2str(nanmean(R))])
xlabel('Obs')
ylabel('Model')
axis equal
ylim(c_lim)
xlim(c_lim)
hold off


