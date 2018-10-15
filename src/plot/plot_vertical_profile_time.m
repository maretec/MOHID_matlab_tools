function plot_vertical_profile_time(X2,Y2,VAR,y_lim,c_lim,source,var_name)
pcolor(X2,Y2,VAR)
shading interp
datetick('x')
ylim(y_lim)
%xlim(x_lim)
caxis(c_lim)
title([source ])
ylabel('depth (m)')
xlabel('date')
h=colorbar;
ylabel(h, var_name)
colormap jet
axis tight