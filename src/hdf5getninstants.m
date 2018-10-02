function [n] = hdf5getninstants(file)
%[nInstants] = hdf5getninstants(file)
%-------------------------Arguments-----------------------
%
%file         -> path to the hdf5 file - string
%
%--------------------------Returns------------------------
%
%n            -> number of time instants
%

info = hdf5info(file);
nGroups=size(info.GroupHierarchy.Groups,2);

for iGroup=1:nGroups;
    
    if strcmp(info.GroupHierarchy.Groups(iGroup).Name, '/Time')>0;
        n = size(info.GroupHierarchy.Groups(iGroup).Datasets,2);
    end
    
end

end