function [serial_time] = hdf5gettimeinstants(file)
%[nInstants] = hdf5getninstants(file)
%-------------------------Arguments-----------------------
%
%file         -> path to the hdf5 file - string
%
%--------------------------Returns------------------------
%
%n            -> number of time instants
%

    [n] = hdf5getninstants(file);
    serial_time = zeros([1 n]);
    
    for instant=1:n;
        strinstant = instant2str(instant);

        date_vec = hdf5read(file, ['/Time/', 'Time', strinstant]);

        year = double(date_vec(1));
        month = double(date_vec(2));
        day = double(date_vec(3));
        hour = double(date_vec(4));
        minute = double(date_vec(5));
        second = double(date_vec(6));
        serial_time(instant) = datenum(year, month, day, hour, minute, second);
       
    end
end