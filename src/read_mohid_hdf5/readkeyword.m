function value=readkeyword(keyword,namefile,separator)
fid = fopen(namefile);
tline = fgetl(fid);
while ischar(tline) 
  matches = strfind(tline, keyword);
   num = length(matches);
   if num > 0
       parts = regexp(tline,separator,'split');
    
      value=str2num(char(parts(end)));
   end 
   tline = fgetl(fid);
end
fclose(fid);