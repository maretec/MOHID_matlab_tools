function [iub, jub, kub] = hdf5getdatasetsize(var)

%[iub, jub, kub] = hdf5getdatasetsize(instant)
%-------------------------Arguments-----------------------
%
%dataset      -> variable              - 1D, 2D, 3D array
%
%--------------------------Returns------------------------
%
%iub, jub, kub


    
iub = size(var,1);
jub = size(var,2);
kub = size(var,3);

end