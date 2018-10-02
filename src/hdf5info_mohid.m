info = hdf5info_mohid(file);
nGroups=size(info.GroupHierarchy.Groups,2);

for iGroup=1:nGroups;
    
    if strcmp(info.GroupHierarchy.Groups(iGroup).Name, '/Time')>0;
        n = size(info.GroupHierarchy.Groups(iGroup).Datasets,2);
    end
    
end

