file = 'G:\Temp\PCOMS\BackUp\Portugal\Results_HDF\2009-02-23_2009-02-26\WaterProperties_Surface.hdf5';


[lat, IUB, JUB] = hdf5readdataset(file, '/Grid/', 'Latitude');
[lon, IUB, JUB] = hdf5readdataset(file, '/Grid/', 'Longitude');
[sst, IUB, JUB] = hdf5readdataset(file, '/Results/temperature/', 'temperature', 14);
[lonc, latc] = lonlat2center(lon, lat);
 
for i=1:1:IUB;
    for j=1:1:JUB;
        if sst(i,j) < -1000;
            sst(i,j) = NaN;
        end
   end
end
