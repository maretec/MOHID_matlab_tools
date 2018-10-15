function [PointsMatrix] = GetDataPoints(mohid_xyz,filename)
user_points=ReadFromBlock(mohid_xyz,'<begin_xyz>','<end_xyz>');
user_x=user_points(:,1);
user_y=user_points(:,2);
% Read data from bbox grid 
origin=readkeyword('ORIGIN',filename,':');
XX=ReadFromBlock(filename,'<BeginXX>','<EndXX>');
XX=origin(1)+XX(1:end-1)+(XX(2:end)-XX(1:end-1))/2;

YY=ReadFromBlock(filename,'<BeginYY>','<EndYY>');
YY=origin(2)+YY(1:end-1)+(YY(2:end)-YY(1:end-1))/2;

cols=length(YY);
rows=length(XX);

grd= ReadFromBlock(filename,'<BeginGridData2D>','<EndGridData2D>');
grd=flipud(rot90(reshape(grd,rows,cols)));

[lon,lat]=ndgrid(XX,YY);
lon=lon';
lat=lat';
F=griddedInterpolant(lon',lat',grd');
box2d=round(F(user_x,user_y));
%clean from land points
idx=find(box2d >=0);
user_x=user_x(idx);
user_y=user_y(idx);
box2d=box2d(idx);
PointsMatrix=[user_x user_y box2d];