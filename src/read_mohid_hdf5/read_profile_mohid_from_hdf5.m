function [serial_time,depth,u,v,mod,deg,wl]=read_profile_mohid_from_hdf5(MOHID_file,coord)
[serial_time] = hdf5gettimeinstants(MOHID_file);
disp('Loading from MOHID hdf5 output file')
disp('Reading Grid')
[lats] = hdf5readdataset(MOHID_file, '/Grid/', 'Latitude');
[lons] = hdf5readdataset(MOHID_file, '/Grid/', 'Longitude');
disp('Extracting U')
[u,depth]=hdf5getprofile(coord,lats,lons,serial_time,MOHID_file,'velocity U');
disp('Extracting V')
[v]=hdf5getprofile(coord,lats,lons,serial_time,MOHID_file,'velocity V');
disp('Extracting WL')
[wl]=hdf5getprofile(coord,lats,lons,serial_time,MOHID_file,'water level');
mod= sqrt(u.^2 + v.^2);
deg =atan2d(v,u)+180;
[depth,u,v,mod,deg] =remove_nans(depth,u,v,mod,deg);
disp('Done reading')