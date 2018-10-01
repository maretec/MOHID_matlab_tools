function [M,variables_names]= ReadBoxTimeSerie(namefile,block_begin,block_end)
% Reads the content of a block from Mohid time series
% namefile= mohid timeseries input file such as salinity.BXF
% block_begin= block begin such as '<BeginTimeSerie>';
% block_begin= block end such as '<EndTimeSerie>';
% Author: Isabella Ascione Kenov
% September 2013
% isabellascione@gmail.com

fid = fopen(namefile);
tline = fgetl(fid);tline2 = tline;k=1;
% the names of the variables are before the line <BeginTimeSerie> :
while ischar(tline)
    if strcmp(tline,'<BeginTimeSerie>')==1
    variables_names=tline2;   
    end
    tline2=tline;
    tline = fgetl(fid);
    
end
fclose(fid);

fid = fopen(namefile);
block=block_begin;
get_data=0;i=1; k=0;
tline = fgetl(fid);search=1;
while ischar(tline) 
    
    

    if strcmp(tline,block_begin)==1
     search=0;
    end

    if strcmp(tline,block_end)==1
     search=1;
    end
    
    if search == 0
       tline = fgetl(fid);
       M(i,:) =str2num(tline);
       i=i+1;
    end
    
    tline = fgetl(fid);

%   if get_data==1
%        M(i,:) =str2num(tline);
%        i=i+1;
%   end
%   
%    tline = fgetl(fid);
%    matches = strfind(tline, block);
%    num = length(matches);
%    if num > 0
%       block=block_end; get_data=get_data+1;tline = fgetl(fid);
%    end 


end
fclose(fid);
