function [dp,var_out]=hdf5getprofile(coord,hdffile,property)

% Functon to draw vertical profile from HDF%
% author:
% isabella ascione
% Instituto Superior Técnico, Universidade de Lisboa
% 22/09/2014
% isabellascione@gmail.com
%--------------------------
% Modified: Mariangel Garcia 
% Email: mariangel.garcia@tecnico.ulisboa.pt 
% Date :27/09/2018
%--------------------------
Xin=coord(:,1);
Yin=coord(:,2);

n_points=length(Xin);
disp('Loading from MOHID hdf5 output file')
file=hdffile;

[serial_time] = hdf5gettimeinstants(file);
[lats] = hdf5readdataset(file, '/Grid/', 'Latitude');
[lons] = hdf5readdataset(file, '/Grid/', 'Longitude');
[lon, lat] = lonlat2center(lons, lats);  
  
 for i=1:length(serial_time)
 
 for k=1:n_points
     
 idx=findnearest(Xin(k),lon(1,:));
 idy=findnearest(Yin(k),lat(:,1));
 
 time_str=datestr(serial_time(i),'dd-mm-yyyy-HH-MM-SS') ;
 [var] = hdf5readdataset(file, ['/Results/',property,'/'], property, i);

   [varZ] = hdf5readdataset(file, ['/Grid/VerticalZ/'], 'Vertical', 1); %FIXME-AG: Grid does change in times here needs to be i
        vertical_profile(1,:)=var(idy,idx,:);
        nanloc=vertical_profile <-1e10;vertical_profile(nanloc)=NaN;
        profile_toplot(:,k)=vertical_profile';
        
        depths(1,:)=varZ(idy,idx,:);
        nanloc=depths <-1e10;depths(nanloc)=NaN;
        depths_centre=(depths(2:end)+depths(1:end-1))/2;
        depths_toplot(:,k)=depths_centre';
     
       str_legend{k}=cat(2,'LON= ',num2str(Xin(k)),' LAT= ',num2str(Yin(k)));
       i
 end
      dp =-depths_toplot;
      var_out(:,i,k) =profile_toplot;


 end
 
 disp('finishing reading mohid profile!')


    
 