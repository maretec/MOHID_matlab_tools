function plot_vertical_1D(depths_toplot,profile_toplot,time_str,axis_limits,property,time_str)
% Functon to plot vertical profile from HDF only one time %
% author:
% isabella ascione
% Instituto Superior Técnico, Universidade de Lisboa
% 22/09/2014
% isabellascione@gmail.com
      plot(depths_toplot,profile_toplot)
      name=cat(2,property, '_',time_str);
      title({property,time_str},'Fontsize',12,'Fontweight','bold')
      xlabel('depth (m)','Fontsize',12,'Fontweight','bold');
      ylabel(unit,'Fontsize',12,'Fontweight','bold')
      set(gcf,'color','white');
      axis([axis_limits]);
      
     legend(str_legend,-1);
       view(90,-90) 
      name=cat(2,name, '_','.bmp');name=regexprep(name, ':', '-');
      saveas(gcf,name,'bmp');
      %print (gcf, '-dbmp', name);
        
        
       