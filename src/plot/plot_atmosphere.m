function plot_atmosphere(c_wind,t_win,u_win,v_win)
t = linspace(datenum(t_win(1)),datenum(t_win(end)),7);
subplot(4,1,1)
plot(datenum(t_win),c_wind.EMG_Temperatura)
title('Temperature')
set(gca, 'xlim', [datenum(t_win(1)) datenum(t_win(end))], 'xtick', t)
datetick('x','mmm dd','keepticks', 'keeplimits')
axis tight

subplot(4,1,2)
plot(datenum(t_win),c_wind.EMG_Humidade)
title('Humidity')
axis tight
set(gca, 'xlim', [datenum(t_win(1)) datenum(t_win(end))], 'xtick', t)
datetick('x','mmm dd','keepticks', 'keeplimits')

subplot(4,1,3)
plot(datenum(t_win),c_wind.EMG_PressaoAtm)
title('Atmospheric Peessure')
axis tight
set(gca, 'xlim', [datenum(t_win(1)) datenum(t_win(end))], 'xtick', t)
datetick('x','mmm dd','keepticks', 'keeplimits')

subplot(4,1,4)
quiver(datenum(t_win)',zeros(size(u_win)),u_win,v_win,'b')
title('Wind Direction')
xlabel('Dates')
%t = linspace(datenum(t_win(1)),datenum(t_win(end)),7);
set(gca, 'xlim', [datenum(t_win(1)) datenum(t_win(end))], 'xtick', t)
datetick('x','mmm dd','keepticks', 'keeplimits')
