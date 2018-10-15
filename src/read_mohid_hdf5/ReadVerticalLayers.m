function [stackv]= ReadVerticalLayers(namefile)
% Reads the content of a block from Mohid time series
% namefile= mohid timeseries input file such as file.bxf
% block_begin= block begin such as '<BeginTimeSerie>';
% block_begin= block end such as '<EndTimeSerie>';
% Author: Isabella Ascione Kenov
% September 2013
% isabellascione@gmail.com



fid = fopen(namefile);
block='<beginpolygon>';


block_l_begin='<<beginverticallayer>>';
block_l_end='<<endverticallayer>>';

tline = fgetl(fid);
i=1;k=1;Numstack=0;
while ischar(tline)   
 matches = strfind(tline, block);
   num = length(matches);
   if num > 0
       Numstack=Numstack+1;
      tline = fgetl(fid);
          

      matches_l_begin = strfind(tline, block_l_begin);
      num_l = length(matches_l_begin);
      while num_l ==0
      tline = fgetl(fid);
      matches_l_begin = strfind(tline, block_l_begin);
      num_l = length(matches_l_begin);
      end
      
          
      k=1;
      if num_l > 0
         tline = fgetl(fid);
         matches_l_end = strfind(tline, block_l_end);
         num_l_end = length(matches_l_end);
         while num_l_end ==0 
                
         stackv(Numstack).layers(k,:)=str2num(tline);
         k=k+1;
         
         tline = fgetl(fid);
         matches_l_end = strfind(tline, block_l_end);
         num_l_end = length(matches_l_end);
         end
      
      end
      
      
      
      
      
    
   end 

 tline = fgetl(fid); 
end
fclose(fid);


%       matches_l_begin = strfind(tline, block_l_begin);
%       num_l = length(matches_l_begin);
%       
%         if num_l > 0
%          tline = fgetl(fid);
%          matches_l_end = strfind(tline, block_l_end);
%          num_l_end = length(matches_l_end);
%          while num_l_end ==0 
%                 
%          layers(k,:)=str2num(tline);
%          k=k+1;
%          
%          tline = fgetl(fid);
%          matches_l_end = strfind(tline, block_l_end);
%          num_l_end = length(matches_l_end);
%          end
%       end
