function [uqq_mh,vqq_mh,modqq_mh,dirqq_mh,wlqq_mh]=interp_mohid2adcp(depth_mh,ts_mh,u_mh,v_mh,mod_mh,dir_mh,wl,ts_adcp,depth_adcp)
                                                           
for i=1:length(ts_mh)
uq_mh(:,i) = interp1(depth_mh(:,i),u_mh(:,i),depth_adcp);
vq_mh(:,i) = interp1(depth_mh(:,i),v_mh(:,i),depth_adcp);
modq_mh(:,i) = interp1(depth_mh(:,i),mod_mh(:,i),depth_adcp);
dirq_mh(:,i) = interp1(depth_mh(:,i),dir_mh(:,i),depth_adcp);
end
 
%Interpolate Over time
for i=1:length(depth_adcp)
uqq_mh(i,:) = interp1(ts_mh,uq_mh(i,:),ts_adcp);
vqq_mh(i,:) = interp1(ts_mh,vq_mh(i,:),ts_adcp);
modqq_mh(i,:) = interp1(ts_mh,modq_mh(i,:),ts_adcp);
dirqq_mh(i,:) = interp1(ts_mh,dirq_mh(i,:),ts_adcp);
end
wlqq_mh = interp1(ts_mh,wl,ts_adcp);

end