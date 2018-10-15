function [t,depth,u,v,mod,gr,wl]=read_profile_mohid_from_timeseries(pth,ext)
%the depth is extracted from file name, so it is important the files has
%the depth
liste = dir(strcat(pth,'*.dat'));
files = {liste.name};
for k = 1:numel(files)
  file{k} = strcat(pth,files{k});
  depth(k) = - sscanf(file{k},strcat(pth,ext,'%f'))+ 2.08;
  [M]= ReadBoxTimeSerie(file{k},'<BeginTimeSerie>','<EndTimeSerie>');
  t(:,1)=datenum(datetime(M(:,2),M(:,3),M(:,4),M(:,5),M(:,6),M(:,7)));
  u(k,:)= M(:,8);
  v(k,:)= M(:,9);
  mod(k,:)= M(:,11);
  gr(k,:)= M(:,12);
  wl(k,:)= M(:,13);
  k
end
