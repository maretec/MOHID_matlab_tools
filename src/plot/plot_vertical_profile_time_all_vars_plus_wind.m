function plot_vertical_profile_time_all_vars_plus_wind(X,Y,mod,deg,Dt,Dx,Dy,y_lim,c_lim,title_label)
figure('Position',[10 60 1500 800],'Visible','on'); 
 %figure('Position',[10 60 900 600],'Visible','on');
%figure('Position',[10 60 1800 7000],'Visible','on');
t = linspace(datenum(Dt(1)),datenum(Dt(end)),8);
subplot(5,1,1)
quiver(datenum(Dt)',zeros(size(Dt)),Dx,Dy,'b')
title({'Wind'})
set(gca, 'xlim', [datenum(Dt(1)) datenum(Dt(end))], 'xtick', t)
datetick('x','mmm dd','keepticks', 'keeplimits')

subplot(5,1,[2 3])
plot_vertical_profile_time(datenum(X),Y,mod,y_lim,[0 0.5],{title_label 'Magnitude'},'Magnitude (m/s)')
set(gca, 'xlim', [datenum(Dt(1)) datenum(Dt(end))], 'xtick', t)
xlabel('')
h =colorbar('Position',...
    [0.921481480918549 0.455 0.0296296296296297 0.296666666666667]);
ylabel(h, 'Magnitude (m/s)')
datetick('x','mmm dd','keepticks', 'keeplimits')
subplot(5,1,[4 5])
plot_vertical_profile_time(datenum(X),Y,deg,y_lim,[0 360],{title_label 'Direction'},'Direction º ')
set(gca, 'xlim', [datenum(Dt(1)) datenum(Dt(end))], 'xtick', t)
datetick('x','mmm dd','keepticks', 'keeplimits')
h=colorbar('Position',...
    [0.921481480918549 0.11 0.0296296296296297 0.296666666666667]);
ylabel(h, 'Direction º')