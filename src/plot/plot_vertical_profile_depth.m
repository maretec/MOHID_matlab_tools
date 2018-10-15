function plot_vertical_profile_depth(var1,depth,lab_title,var_label,x_lim,cl)
plot(var1,depth,'k')
hold on
plot(meannan(var1,2),depth,cl,'LineWidth',3)
title(lab_title)
ylabel('Depth (m)')
xlabel(var_label)
xlim(x_lim)