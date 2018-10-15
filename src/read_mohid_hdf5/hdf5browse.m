function [nInstants, IUB, JUB] = hdf5browse(file, showall)
%[nInstants, IUB, JUB] = hdf5browse(file, showall)
%-------------------------Arguments-----------------------
%
%file         -> path to the hdf5 file              - string
%showall      -> lists all the datasets in the file - boolean
%
%--------------------------Returns------------------------
%
%nInstants    -> number of time instants
%IUB          -> number of grid cells in the YY direction
%JUB          -> number of grid cells in the XX direction
%

disp('-------------------------------------------------------------------------');
disp(['Browsing                 : ', file]);
disp('File Tree');

if nargin < 2;
    showall=false;
end

info = hdf5info(file);
nGroups=size(info.GroupHierarchy.Groups,2);

for iGroup=1:nGroups;
    
    disp(['Group                    : ',info.GroupHierarchy.Groups(iGroup).Name]);
    
    nDataSets = size(info.GroupHierarchy.Groups(iGroup).Datasets,2);
    
    for iDataSet=1:nDataSets;
        
        if showall;
            disp(['Dataset                  : ',info.GroupHierarchy.Groups(iGroup).Datasets(iDataSet).Name]);
        end
        
        if strcmp(info.GroupHierarchy.Groups(iGroup).Datasets(iDataSet).Name, '/Grid/Bathymetry')>0;
            refmatrix = hdf5read(info.GroupHierarchy.Groups(iGroup).Datasets(iDataSet));
            IUB = size(refmatrix,1);
            JUB = size(refmatrix,2);
        end
        
    end

    if strcmp(info.GroupHierarchy.Groups(iGroup).Name, '/Time')>0;
        nInstants = size(info.GroupHierarchy.Groups(iGroup).Datasets,2);
    end
    
    if size(info.GroupHierarchy.Groups(iGroup).Groups,2) > 0;
        
        nL2Groups = size(info.GroupHierarchy.Groups(iGroup).Groups,2);

        for iL2Group=1:nL2Groups;
            
            disp(['Group                    : ',info.GroupHierarchy.Groups(iGroup).Groups(iL2Group).Name]);
            nDataSets = size(info.GroupHierarchy.Groups(iGroup).Groups(iL2Group).Datasets,2);
            
            if showall;
                for iDataSet=1:nDataSets;
                    disp(['Dataset                  : ',info.GroupHierarchy.Groups(iGroup).Groups(iL2Group).Datasets(iDataSet).Name]);
                end
            end
            
        end
              
    end

end

disp(['Dimensions               : ',num2str(IUB),'x',num2str(JUB)]);
disp(['Number of time instants  : ', num2str(nInstants)]);
disp('-------------------------------------------------------------------------');

end