function [var, iub, jub, kub] = hdf4readdataset(file, group, dataset, instant)

%[var, iub, jub, kub] = hdf5readdataset(file, group, dataset, instant)
%-------------------------Arguments-----------------------
%
%file         -> path to the hdf4 file                       - string
%group        -> group name   (e.g. '/Results/temperature/') - string
%dataset      -> dataset name (e.g. 'temperature')           - string
%instant      -> time instant (e.g. 1) - OPTIONAL            - integer
%
%--------------------------Returns------------------------
%
%var          -> 2D or 3D array
%iub          -> number of grid cells in the YY direction
%jub          -> number of grid cells in the XX direction
%kub          -> number of grid cells in the ZZ direction

    if nargin<4;
        var = hdfread(file, [group, dataset]);
    else
        strinstant = instant2str(instant);
        var = hdfread(file, [group, dataset, strinstant]);
    end
    
    iub = size(var,1);
    jub = size(var,2);
    kub = size(var,3);

end