function [depth,u,v,mod,dir] =remove_nans(depth,u,v,mod,deg)
  temp = find(~isnan(depth(:,1)));
  depth = depth(temp,:);
   u = u(temp,:);
   v = v(temp,:);
   mod=mod(temp,:);
   dir = deg(temp,:);