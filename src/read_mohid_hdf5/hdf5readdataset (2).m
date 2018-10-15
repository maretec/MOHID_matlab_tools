function [var] = hdf5readdataset(file, group, dataset, instant)

%[var, iub, jub, kub] = hdf5readdataset(file, group, dataset, instant)
%-------------------------Arguments-----------------------
%
%file         -> path to the hdf5 file                       - string
%group        -> group name   (e.g. '/Results/temperature/') - string
%dataset      -> dataset name (e.g. 'temperature')           - string
%instant      -> time instant (e.g. 1) - OPTIONAL            - integer
%
%--------------------------Returns------------------------
%
%var          -> 2D or 3D array

    if nargin<4;
        var = hdf5read(file, [group, dataset]);
    else
        strinstant = instant2str(instant);
        var = hdf5read(file, [group, dataset, strinstant]);
    end

end