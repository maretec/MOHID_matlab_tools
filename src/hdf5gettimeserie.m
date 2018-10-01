function [values, time] = hdf5gettimeserie(file, group, dataset, i, j, k)

%[values, time] = hdf5gettimeserie(file, group, dataset, i, j, k)
%-------------------------Arguments-----------------------
%
%file         -> path to the hdf5 file                       - string
%group        -> group name   (e.g. '/Results/temperature/') - string
%dataset      -> dataset name (e.g. 'temperature')           - string
%i            -> I location of grid cell                     - integer
%i            -> J location of grid cell                     - integer            
%k            -> K location of grid cell                     - integer
%--------------------------Returns------------------------
%
%var          -> 2D or 3D array
%iub          -> number of grid cells in the YY direction
%jub          -> number of grid cells in the XX direction
%kub          -> number of grid cells in the ZZ direction


    [n] = hdf5getninstants(file);
    values = zeros([1 n]);
    time = zeros([1 n]);
    
    for instant=1:n;
        strinstant = instant2str(instant);
        var = hdf5read(file, [group, dataset, strinstant]);
        if nargin<6;
            values(instant) = var(i,j);
        else
        	values(instant) = var(i,j,k);
        end
        
        date_vec = hdf5read(file, ['/Time/', 'Time', strinstant]);

        year = double(date_vec(1));
        month = double(date_vec(2));
        day = double(date_vec(3));
        hour = double(date_vec(4));
        minute = double(date_vec(5));
        second = double(date_vec(6));
        time(instant) = datenum(year, month, day, hour, minute, second);
       
    end
    
end