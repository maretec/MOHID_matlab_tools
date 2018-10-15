function Box=BoxConstruction(HDFfile,GridFile,VericalLayersFile,PointsMatrix)
% Construct the Box structure from MOHID files
% - HDFfile          :  MOHID HDF file from model run output 
%                      (Hydrodynamics or Waterproperties HDF file)
% - Gridfile         : the file containing the 2D Boxes Grid (from MOHID outputs)
% - VericalLayersFile: MOHID file with Boxes Vertical structure 
%                      (used in MOHID to input in the model the
%                      vertical structure of the Boxes)
% - PointsMatrix     : a table with reference points to be used for box0

block_begin='<BeginGridData2D>';
block_end='<EndGridData2D>';
grd= ReadFromBlock(GridFile,block_begin,block_end);


[OpenPoint] = hdf5readdataset(HDFfile, ['/Grid/OpenPoints/'], 'OpenPoints',1);
[VerticalZ] = hdf5readdataset(HDFfile, ['/Grid/VerticalZ/'], 'Vertical', 1);
[lats] = hdf5readdataset(HDFfile, '/Grid/', 'Latitude');
[lons] = hdf5readdataset(HDFfile, '/Grid/', 'Longitude');
[lon, lat] = lonlat2center(lons, lats);
XX=lons(1,:);
YY=lats(:,1);
[rows,cols, zlevs]=size(VerticalZ);

ZZ=1:zlevs;

XXCenter= XX(1:end-1) + (XX(2:end)-XX(1:end-1))/2;
YYCenter= YY(1:end-1) + (YY(2:end)-YY(1:end-1))/2;
ZZCenter=1:zlevs-1;


grd=flipud(rot90(reshape(grd,cols,rows)));

stack=ReadVerticalLayers(VericalLayersFile);
[rs,cs]=size(stack);
[rg,cg]=size(grd);
Boxesmatrix.Value=-1*ones(rows,cols,zlevs-1);


[serial_time] = hdf5gettimeinstants(HDFfile);
instant=1;
[VerticalZ] = hdf5readdataset(HDFfile, ['/Grid/VerticalZ/'], 'Vertical', instant);
mini=min(min(min(VerticalZ)));
for i=1:rows
for j=1:cols
for k=1:zlevs
if VerticalZ(i,j,k)==mini;
VerticalZ(i,j,k)=NaN;
end
end
end
end

VerticalVertices=ones(rows+1,cols+1,zlevs);


for k=1:zlevs
    VerticalVertices(:,:,k)=interp2(lon,lat,-VerticalZ(:,:,k),lons,lats);
    
end
VerticalVertices(1,:,:)=VerticalVertices(2,:,:);
VerticalVertices(end,:,:)=VerticalVertices(end-1,:,:);
VerticalVertices(:,1,:)=VerticalVertices(:,2,:);
VerticalVertices(:,end,:)=VerticalVertices(:,end-1,:);



% remaining boxes
Boxnum=0;
% cs is the number of the 2D boxes
for s= 1: cs
    [nlayers,lim]=size(stack(1,s).layers);
    for l=1:nlayers
        Boxnum=Boxnum+1;
      
        for i=1:rows
            for j=1:cols
            if grd(i,j)==s
               
                zlev=stack(1,s).layers(l,:);zlev=sort(zlev);
                Boxesmatrix.Value(i,j, zlev(1):zlev(2))=Boxnum;
                
            end
            
            end
        end
    end
end

%Points for Box 0:

% construct Box0 and  openpoints
 for i=1:rg
            for j=1:cg
                for k=1:zlevs-1;
                    
                     if grd(i,j)==0
                
                         Boxesmatrix.Value(i,j, k)=0;
                          Boxesmatrix.ValueAus(i,j, k)=0;
                     end
                  if OpenPoint(i,j,k)==0
                        Boxesmatrix.ValueAus(i,j, k)=-1;
                    end
                end
            end
 end


[Boxesmatrix.XXC,Boxesmatrix.YYC,Boxesmatrix.ZZC]=meshgrid(XXCenter,YYCenter,ZZCenter);
[Boxesmatrix.XX,Boxesmatrix.YY,Boxesmatrix.LZ]=meshgrid(XX,YY,ZZ);

Boxesmatrix.ZZ=VerticalVertices;

BoxTot=Boxnum;

for box_n=0:BoxTot
    count=1;BoxIDp1=box_n+1;
    
 for i=1:rg
   for j=1:cg
      for k=1:zlevs-1
          if Boxesmatrix.Value(i,j, k)==box_n
              
               Box(BoxIDp1).i(count)=i;
               Box(BoxIDp1).j(count)=j;
               Box(BoxIDp1).k(count)=k;

              count=count+1;
          end
      end
    end
  end
    
end

for box_n=0:BoxTot
    BoxIDp1=box_n+1;
     di =min(Box(BoxIDp1).i) -1;
     dj =min(Box(BoxIDp1).j) -1;
     dk =min(Box(BoxIDp1).k) -1;
     min_i=min(Box(BoxIDp1).i);
     max_i=max(Box(BoxIDp1).i);
     min_j=min(Box(BoxIDp1).j);
     max_j=max(Box(BoxIDp1).j);
     min_k=min(Box(BoxIDp1).k);
     max_k=max(Box(BoxIDp1).k);
     sizei=length(min_i:max_i+1);
     sizej=length(min_j:max_j+1);
     sizek=length(min_k:max_k+1);
  for i=min_i:max_i
      for j=min_j:max_j
          for k=min_k:max_k
           if Boxesmatrix.Value(i,j,k)==box_n
               Box(BoxIDp1).Value(i-di,j-dj,k-dk)=box_n;
               
           else
               Box(BoxIDp1).Value(i-di,j-dj,k-dk)=-1;
               
           end
           
          end
      end
  end
      
   %Box(BoxIDp1).Value= Boxesmatrix.Value(min(Box(BoxIDp1).i):max(Box(BoxIDp1).i),min(Box(BoxIDp1).j):max(Box(BoxIDp1).j),min(Box(BoxIDp1).k):max(Box(BoxIDp1).k));

   Box(BoxIDp1).XX= Boxesmatrix.XX(min_i:max_i+1,min_j:max_j+1,min_k:max_k+1);
   Box(BoxIDp1).YY= Boxesmatrix.YY(min_i:max_i+1,min_j:max_j+1,min_k:max_k+1);
   Box(BoxIDp1).ZZ= Boxesmatrix.ZZ(min_i:max_i+1,min_j:max_j+1,min_k:max_k+1);
   Box(BoxIDp1).LZ= Boxesmatrix.LZ(min_i:max_i+1,min_j:max_j+1,min_k:max_k+1);
   Box(BoxIDp1).Value(sizei,:,:)=Box(BoxIDp1).Value(sizei-1,:,:);
   Box(BoxIDp1).Value(:,sizej,:)=Box(BoxIDp1).Value(:,sizej-1,:);
   Box(BoxIDp1).Value(:,:,sizek)=Box(BoxIDp1).Value(:,:,sizek-1);

%    Box(BoxIDp1).XCenter=min(Box(BoxIDp1).XX(1,:,1))+ (max(Box(BoxIDp1).XX(1,:,1))-min(Box(BoxIDp1).XX(1,:,1)))/2;
%    Box(BoxIDp1).YCenter=min(Box(BoxIDp1).YY(:,1,1))+ (max(Box(BoxIDp1).YY(:,1,1))-min(Box(BoxIDp1).YY(:,1,1)))/2;
%    Box(BoxIDp1).LCenter=min(Box(BoxIDp1).LZ(1,1,:))+ (max(Box(BoxIDp1).LZ(1,1,:))-min(Box(BoxIDp1).LZ(1,1,:)))/2;
%    Box(BoxIDp1).ZCenter=nanmin(Box(BoxIDp1).ZZ(1,1,:))+ (nanmax(Box(BoxIDp1).ZZ(1,1,:))-nanmin(Box(BoxIDp1).ZZ(1,1,:)))/2;
   
  
end


 
 
 
Boxnum=0;
% cs is the number of the 2D boxes
for s= 1: cs
    [nlayers,lim]=size(stack(1,s).layers);
    for l=1:nlayers
        Boxnum=Boxnum+1;
        
%         minx1=nanmin(Box(Boxnum+1).XX(1,:,1));
%         minx2=nanmin(Box(Boxnum+1).XX(end,:,1));
%         maxx1=nanmax(Box(Boxnum+1).XX(1,:,1));
%         maxx2=nanmax(Box(Boxnum+1).XX(end,:,1));
%         X11=minx1+(maxx1-minx1)/3;
%         X12=minx1+2*(maxx1-minx1)/3;
%         X21=minx2+(maxx2-minx2)/3;
%         X22=minx2+2*(maxx2-minx2)/3;
%         
%         
%         Xm1=minx1+(maxx1-minx1)/2;
%         Xm2=minx2+(maxx2-minx2)/2;
%         Xm=(Xm1+Xm2)/2;
%         
%         miny1=nanmin(Box(Boxnum+1).YY(:,1,1));
%         miny2=nanmin(Box(Boxnum+1).YY(:,end,1));
%         maxy1=nanmax(Box(Boxnum+1).YY(:,1,1));
%         maxy2=nanmax(Box(Boxnum+1).YY(:,end,1));
%         Y11=miny1+(maxy1-miny1)/3;
%         Y12=miny1+2*(maxy1-miny1)/3;
%         Y21=miny2+(maxy2-miny2)/3;
%         Y22=miny2+2*(maxy2-miny2)/3;
%         Ym1=miny1+(maxy1-miny1)/2;
%         Ym2=miny2+(maxy2-miny2)/2;
%         Ym=(Ym1+Ym2)/2
%         cxmin=max(X11,X21);
%         cxmax=min(X12,X22);
%         cymin=max(Y11,Y21);
%         cymax=min(Y12,Y22);
%         Pts=[Xm cymin
%         Xm cymax
%         cxmin Ym
%         cxmax Ym];
%         
%         
%         Box(Boxnum+1).pointsX=Pts(:,1);
%         Box(Boxnum+1).pointsY=Pts(:,2);
%         Box(Boxnum+1).pointsZ=ones(size(Box(Boxnum+1).pointsY));
%         Box(Boxnum+1).pointsZ=Box(Boxnum+1).pointsZ*min(Box(Boxnum+1).LZ(1,1,:))+ (max(Box(Boxnum+1).LZ(1,1,:))-min(Box(Boxnum+1).LZ(1,1,:)))/2;
         indices=find(PointsMatrix(:,3)==s);
         Selected=PointsMatrix(indices,:);
%          Box(Boxnum+1).pointsX=min(Box(Boxnum+1).XX(1,:,1))+ (max(Box(Boxnum+1).XX(1,:,1))-min(Box(Boxnum+1).XX(1,:,1)))/2;;
%          Box(Boxnum+1).pointsY=min(Box(Boxnum+1).YY(:,1,1))+ (max(Box(Boxnum+1).YY(:,1,1))-min(Box(Boxnum+1).YY(:,1,1)))/2;
%          Box(Boxnum+1).pointsZ=ones(size(Box(Boxnum+1).pointsY));
%          Box(Boxnum+1).pointsZ=Box(Boxnum+1).pointsZ*min(Box(Boxnum+1).LZ(1,1,:))+ (max(Box(Boxnum+1).LZ(1,1,:))-min(Box(Boxnum+1).LZ(1,1,:)))/2;
  Box(Boxnum+1).pointsY=Selected(:,2);
 Box(Boxnum+1).pointsX=Selected(:,1);
 Box(Boxnum+1).pointsZ=ones(size(Box(Boxnum+1).pointsY));
 Box(Boxnum+1).pointsZ=Box(Boxnum+1).pointsZ*min(Box(Boxnum+1).LZ(1,1,:))+ (max(Box(Boxnum+1).LZ(1,1,:))-min(Box(Boxnum+1).LZ(1,1,:)))/2;

    
    end
end
%box 0 : it is different because it is not divided into vertical layers
indices=find(PointsMatrix(:,3)==0);
 Selected=PointsMatrix(indices,:);
 Box(1).pointsY=Selected(:,2);
 Box(1).pointsX=Selected(:,1);
 Box(1).pointsZ=ones(size(Box(1).pointsY));
 Box(1).pointsZ=Box(1).pointsZ*min(Box(1).LZ(1,1,:))+ (max(Box(1).LZ(1,1,:))-min(Box(1).LZ(1,1,:)))/2;
 




