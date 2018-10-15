function plot_compare_vertical_profile_time(obs,model,depth,MaxIdx,MinIdx,lab_title,var_label,x_lim)
subplot(2,2,1)
plot_vertical_profile_depth(model(:,MaxIdx),depth(:,MaxIdx),{lab_title ; 'High Tide'},var_label,x_lim,'r')
subplot(2,2,2)
plot_vertical_profile_depth(model(:,MinIdx),depth(:,MinIdx),{lab_title ; 'Low Tide'} ,var_label,x_lim,'r')
subplot(2,2,3)
plot_vertical_profile_depth(obs(:,MaxIdx),depth(:,MaxIdx),{'Observation' ; 'High Tide'},var_label,x_lim,'b')
subplot(2,2,4)
plot_vertical_profile_depth(obs(:,MinIdx),depth(:,MinIdx),{'Observation' ; 'Low Tide'},var_label,x_lim,'b')