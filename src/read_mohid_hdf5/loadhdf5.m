
file = 'G:\Work\modis\modis20090223_1325.hdf5';
[sst, IUB, JUB] = hdf5readdataset(file, '/Results/sst/', 'sst', 1);
[lat, IUB, JUB] = hdf5readdataset(file, '/Grid/Latitude/', 'Latitude', 1);
[lon, IUB, JUB] = hdf5readdataset(file, '/Grid/Longitude/', 'Longitude', 1);
[lonc, latc] = lonlat2center(lon, lat);

%hdf5write('E:\Chla\Final\MODIS\A2007031133500.L2_LAC.hdf5', '/Grid/Latitude/LatitudeC_00001', latc, 'WriteMode', 'append');
%hdf5write('E:\Chla\Final\MODIS\A2007031133500.L2_LAC.hdf5', '/Grid/Longitude/LongitudeC_00001', lonc, 'WriteMode', 'append');





