function [M]= ReadFromBlock(namefile,block_begin,block_end)
% Reads the content of a block from Mohid time series
% namefile= mohid timeseries input file such as file.bxf
% block_begin= block begin such as '<BeginTimeSerie>';
% block_begin= block end such as '<EndTimeSerie>';
% Author: Isabella Ascione Kenov
% September 2013
% isabellascione@gmail.com



fid = fopen(namefile);
block=block_begin;
get_data=0;i=1; k=0;
tline = fgetl(fid);

while ischar(tline)   

   matches = strfind(tline, block);
   num = length(matches);
   if num > 0
      block=block_end; get_data=get_data+1;tline = fgetl(fid);
   end 
  if get_data==1
       M(i,:) =str2num(tline);
       i=i+1;
  end
  
   tline = fgetl(fid);
   


end
fclose(fid);
