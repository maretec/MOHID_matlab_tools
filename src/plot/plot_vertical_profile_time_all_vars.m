function plot_vertical_profile_time_all_vars(X,Y,u,v,mod,dir,y_lim,c_lim,title_label)
 figure('Position',[10 60 900 600],'Visible','on');

subplot(4,1,1)
plot_vertical_profile_time(X,Y,u,y_lim,c_lim,{title_label;'East-vel' },'east-vel (m/s)')
subplot(4,1,2)
plot_vertical_profile_time(X,Y,v,y_lim,c_lim,'North-vel','North-vel (m/s)')
subplot(4,1,3)
plot_vertical_profile_time(X,Y,mod,y_lim,[0 0.5],'Magnitude','Magnitude (m/s)')
subplot(4,1,4)
plot_vertical_profile_time(X,Y,dir,y_lim,[0 360],'Direction','Direction º ')