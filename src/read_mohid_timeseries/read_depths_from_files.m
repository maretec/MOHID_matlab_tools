function [file,val,sigma_dp]=read_depths_from_files(pth,ext)
%the depth is extracted from file name, so it is important the files has
%the depth
liste = dir(strcat(pth,'*.txt'));
files = {liste.name};
for k = 1:numel(files)
  file{k} = strcat(pth,files{k});
  [c] = readtable(file{k},'ReadVariableNames',false);
  val(k) = - sscanf(file{k},strcat(pth,ext,'%f'));
  sigma_dp(k,:)=c.Var1;
end

end 