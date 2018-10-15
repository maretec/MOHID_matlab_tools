function [t_win,mag_win,deg_win,u_win,v_win,c]=read_wind(csvFile)
[c] = readtable(csvFile);
date_win=c.EMG_Instante;
for k=1:length(date_win)
t_win(k) = datetime(date_win{k},'InputFormat','dd-MM-yyyy HH:mm');
end
mag_win = c.EMG_VelVento;
deg_win=c.EMG_DirVento;
u_win=cosd(270 -deg_win).*mag_win;
v_win=sind(270 -deg_win).*mag_win;