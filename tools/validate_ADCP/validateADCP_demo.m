% Validate ADCP Demo script for comparing ADCP data with Mohid Model
%
% This demo script will provide some examples of how to use the code.

% Author: Mariangel Garcia (mariangel.garcia@tecnico.ulisboa.pt)
% 10/01/2018
% It required to donwload 

% Changes - 
%%
clear; clc
%% IMPUT files:
%ADCP FILE
ADCP_file='./data/SANE_000.000';
%Location ADCP
Points=[-9.4676 38.6702];
% MOHID
MOHID_file='./data/Hydrodynamic_TagusValidation.hdf5';

%% Read ADCP Data 
adcp=rdradcp(ADCP_file); %It create a list with all the variables
[X_adcp, Y_adcp]= meshgrid(adcp.mtime(1:end-1),adcp.config.ranges);
adcp_mod = sqrt(adcp.east_vel(:,1:end-1).^2 + adcp.north_vel(:,1:end-1).^2);
% 
%% Plot ADCP all variables
x_lim=[]; y_lim=[-40 0]; c_lim=[-0.5 0.5];
figure
subplot(2,1,1)
plot_vertical_profile_time(X_adcp,Y_adcp,adcp.east_vel(:,1:end-1),y_lim,c_lim,' ADCP EAST VELOCITY ','east-vel (m/s)')
subplot(2,1,2)
plot_vertical_profile_time(X_adcp,Y_adcp,adcp.north_vel(:,1:end-1),y_lim,c_lim,'ADCP NORTH VELOCITY ','north-vel (m/s)')

%%  Read MOHID Data
%It will stract the profile at such giving point
[time_mohid] = hdf5gettimeinstants(MOHID_file);
[dp,u_mohid]=hdf5getprofile(Points,MOHID_file,'velocity U');
[dp,v_mohid]=hdf5getprofile(Points,MOHID_file,'velocity V');
[dp,mod_mohid]=hdf5getprofile(Points,MOHID_file,'velocity modulus');
[dp,wl_mohid]=hdf5getprofile(Points,MOHID_file,'water level');
[X_mohid,Y_mohid]=meshgrid(time_mohid,dp);

for k=1:length(dp)
mod_mohid_i_time(k,:) = interp1(time_mohid,mod_mohid(k,:),adcp.mtime(1:end-1)); 
end

%Interpolate time Mohid Data into ADCP
[X2_mohid,Y2_mohid]=meshgrid(adcp.mtime(1:end-1),dp);
%Interpolate Depth 

%% Plot MOHID data
figure
subplot(2,1,1)
plot_vertical_profile_time(X_mohid,Y_mohid,u_mohid,y_lim,c_lim,' MOHID U','east-vel (m/s)')
subplot(2,1,2)
plot_vertical_profile_time(X_mohid,Y_mohid,v_mohid,y_lim,c_lim,'MOHID V ','north-vel (m/s)')


%% Visual Comparison MOHID Vs ADCP over time
x_lim=[]; y_lim=[-40 0]; c_lim=[0 0.4];

figure
subplot(5,2,[1 2])
plot(time_mohid,wl_mohid- mean(wl_mohid),'k','linewidth',2)
ylabel('water level (m)')
title('MOHID Water Level')
datetick('x')
%plot ADCP
subplot(5,2,[3 6])
plot_vertical_profile_time(X2_mohid,Y2_mohid,mod_i_time,y_lim,c_lim,'MOHID','Velocity Modulus (m/s)')
%plot ADCP
subplot(5,2,[7 10])
plot_vertical_profile_time(X_adcp,Y_adcp,adcp_mod,y_lim,c_lim,'ADCP','Velocity Modulus (m/s)')

%%
%% Movie evolution in time 
figure
for t=1:length(adcp.mtime(1:end-1))
plot(mod_i_time(:,t),dp)
hold on
plot(adcp_mod(:,t),adcp.config.ranges)

xlim([0 0.5])
ylim([-35 0])
legend('mohid','adcp')
title(datestr(adcp.mtime(t)))
xlabel('Velocity Modulus (m/s)')
ylabel('depths (m)')
    drawnow  
hold off
end
%% Plot 

figure
subplot(2,1,1)
plot(mod_i_time,dp)
xlim([0 0.5])
ylim([-35 0])
subplot(2,1,2)
plot(adcp_mod,adcp.config.ranges)
xlim([0 0.5])
ylim([-35 0])
