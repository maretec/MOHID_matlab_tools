function [var] = hdf5readdatasetsubset(file, group, dataset, start, count, instant)

	fileID=H5F.open(file,'H5F_ACC_RDONLY','H5P_DEFAULT');
    
    if nargin<6;
        datasetname = [group, dataset];
    else
        strinstant = instant2str(instant);
        datasetname = [group, dataset, strinstant];
    end
    
    dset=H5D.open(fileID,datasetname); 
    space=H5D.get_space(dset);

    %start=[120 50 1]; %zero based!
    stride=[1 1 1];
    %count=[1 1 1]; 
    block=[ ];

    H5S.select_hyperslab(space,'H5S_SELECT_SET',fliplr(start-1),... %-1 totake care of 0 based indexing
    fliplr(stride),fliplr(count),fliplr(block)); %fliplrto take care of row/column major reversal (please see the ReadMe.txt in myprevious post
    mem_space = H5S.create_simple(3, fliplr(count), []); %see Readme.txt forexplanation on need for flipping


    var = H5D.read(dset,'H5ML_DEFAULT',mem_space,space,'H5P_DEFAULT');

    H5D.close(dset);
    H5S.close(space);
    H5S.close(mem_space);
    H5F.close(fileID);   

end
