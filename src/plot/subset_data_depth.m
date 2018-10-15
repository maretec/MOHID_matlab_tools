function [X_adcp,Y_adcp,qu,qv,qvel,qdir]=subset_data_depth(X_adcp,Y_adcp,qu,qv,qvel,qdir,ny)
X_adcp=X_adcp(ny,:);
Y_adcp=Y_adcp(ny,:);
qu=qu(ny,:);
qv=qv(ny,:);
qvel=qvel(ny,:);
qdir=qdir(ny,:);