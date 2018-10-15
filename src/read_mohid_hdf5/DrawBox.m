function h=DrawBox(Box,BOXID,varargin)
% default vertical representation is by number of layers
%% evaluate property specifications
for argno = 1:2:nargin-2
    switch varargin{argno}
        case 'contour'
        option = varargin{argno+1};
        case 'color'
        scale = varargin{argno+1};
        case 'VerticalZ'
        Vertical = varargin{argno+1};
        case 'number'
        number = varargin{argno+1};
    end
end
%% default parameters
if ~exist('Vertical','var')
    Vertical='layer';
end
if ~exist('scale','var')
    scale='default';
end
if ~exist('number','var')
    number='off';
end

if ~exist('option','var')
    option='on';
end

colors=mycolormap;
BOXVAL=BOXID;
BOXINTERNALID=BOXID+1;
legendstring=cat(2,'Box ',num2str(BOXVAL));

%% contours

if strcmp(Vertical,'depth')
    VerticalCoord=Box(BOXINTERNALID).ZZ;
elseif strcmp(Vertical,'layer')
    VerticalCoord=Box(BOXINTERNALID).LZ;
end

if strcmp(option,'on')
    
    if strcmp(Vertical,'layer')
       minl=min(min(min(VerticalCoord)));
       maxl=max(max(max(VerticalCoord)));
    elseif strcmp(Vertical,'depth')
       minl=nanmin(nanmin(nanmin(VerticalCoord)));
       maxl=nanmax(nanmax(nanmax(VerticalCoord)));
    end
    
    minx=min(min(min(Box(BOXINTERNALID).XX)));
    maxx=max(max(max(Box(BOXINTERNALID).XX)));
    miny=min(min(min(Box(BOXINTERNALID).YY)));
    maxy=max(max(max(Box(BOXINTERNALID).YY)));
% draw irregular contours (not implemented for depth option)
if strcmp(Vertical,'layer')
   h1=contourslice(Box(BOXINTERNALID).XX,Box(BOXINTERNALID).YY,VerticalCoord,Box(BOXINTERNALID).Value,[minx maxx],[miny maxy],[minl maxl],1);
   set(h1,'Linewidth',0.5)
   hold on
end
% draw regular contoours
% 1
i=Box(BOXINTERNALID).Value(:,1,1)>-1;
xi=Box(BOXINTERNALID).XX(:,1,1);xi(i==0)=NaN;
yi=Box(BOXINTERNALID).YY(:,1,1);yi(i==0)=NaN;
zi=VerticalCoord(:,1,1);zi(i==0)=NaN;
plot3(xi,yi,zi,'Linewidth',0.5)

%2
i=Box(BOXINTERNALID).Value(:,end,1)>-1;
i=i(:);
xi=Box(BOXINTERNALID).XX(:,end,1);xi=xi(:);xi(i==0)=NaN;
yi=Box(BOXINTERNALID).YY(:,end,1);yi=yi(:);yi(i==0)=NaN;
zi=VerticalCoord(:,end,1);zi=zi(:);zi(i==0)=NaN;
plot3(xi,yi,zi,'Linewidth',0.5)

% 3
i=Box(BOXINTERNALID).Value(1,:,1)>-1;
i=i(:);
xi=Box(BOXINTERNALID).XX(1,:,1);xi=xi(:);xi(i==0)=NaN;
yi=Box(BOXINTERNALID).YY(1,:,1);yi=yi(:);yi(i==0)=NaN;
zi=VerticalCoord(1,:,1);zi=zi(:);zi(i==0)=NaN;
plot3(xi,yi,zi,'Linewidth',0.5)

%4
i=Box(BOXINTERNALID).Value(end,:,1)>-1;
i=i(:);
xi=Box(BOXINTERNALID).XX(end,:,1);xi=xi(:);xi(i==0)=NaN;
yi=Box(BOXINTERNALID).YY(end,:,1);yi=yi(:);yi(i==0)=NaN;
zi=VerticalCoord(end,:,1);zi=zi(:);zi(i==0)=NaN;
plot3(xi,yi,zi,'Linewidth',0.5)
%5
i=Box(BOXINTERNALID).Value(end,:,end)>-1;
i=i(:);
xi=Box(BOXINTERNALID).XX(end,:,end);xi=xi(:);xi(i==0)=NaN;
yi=Box(BOXINTERNALID).YY(end,:,end);yi=yi(:);yi(i==0)=NaN;
zi=VerticalCoord(end,:,end);zi=zi(:);zi(i==0)=NaN;
plot3(xi,yi,zi,'Linewidth',0.5)
%6
i=Box(BOXINTERNALID).Value(1,:,end)>-1;
i=i(:);
xi=Box(BOXINTERNALID).XX(1,:,end);xi=xi(:);xi(i==0)=NaN;
yi=Box(BOXINTERNALID).YY(1,:,end);yi=yi(:);yi(i==0)=NaN;
zi=VerticalCoord(1,:,end);zi=zi(:);zi(i==0)=NaN;
plot3(xi,yi,zi,'Linewidth',0.5)
%7
i=Box(BOXINTERNALID).Value(:,end,end)>-1;
i=i(:);
xi=Box(BOXINTERNALID).XX(:,end,end);xi=xi(:);xi(i==0)=NaN;
yi=Box(BOXINTERNALID).YY(:,end,end);yi=yi(:);yi(i==0)=NaN;
zi=VerticalCoord(:,end,end);zi=zi(:);zi(i==0)=NaN;
plot3(xi,yi,zi,'Linewidth',0.5)
%8
i=Box(BOXINTERNALID).Value(:,1,end)>-1;
i=i(:);
xi=Box(BOXINTERNALID).XX(:,1,end);xi=xi(:);xi(i==0)=NaN;
yi=Box(BOXINTERNALID).YY(:,1,end);yi=yi(:);yi(i==0)=NaN;
zi=VerticalCoord(:,1,end);zi=zi(:);zi(i==0)=NaN;
plot3(xi,yi,zi,'Linewidth',0.5)

%9
i=Box(BOXINTERNALID).Value(end,1,:)>-1;
i=i(:);
xi=Box(BOXINTERNALID).XX(end,1,:);xi=xi(:);xi(i==0)=NaN;
yi=Box(BOXINTERNALID).YY(end,1,:);yi=yi(:);yi(i==0)=NaN;
zi=VerticalCoord(end,1,:);zi=zi(:);zi(i==0)=NaN;
plot3(xi,yi,zi,'Linewidth',0.5)
%10
i=Box(BOXINTERNALID).Value(1,1,:)>-1;
i=i(:);
xi=Box(BOXINTERNALID).XX(1,1,:);xi=xi(:);xi(i==0)=NaN;
yi=Box(BOXINTERNALID).YY(1,1,:);yi=yi(:);yi(i==0)=NaN;
zi=VerticalCoord(1,1,:);zi=zi(:);zi(i==0)=NaN;
plot3(xi,yi,zi,'Linewidth',0.5)
%11
i=Box(BOXINTERNALID).Value(1,end,:)>-1;
i=i(:);
xi=Box(BOXINTERNALID).XX(1,end,:);xi=xi(:);xi(i==0)=NaN;
yi=Box(BOXINTERNALID).YY(1,end,:);yi=yi(:);yi(i==0)=NaN;
zi=VerticalCoord(1,end,:);zi=zi(:);zi(i==0)=NaN;
plot3(xi,yi,zi,'Linewidth',0.5)
%12
i=Box(BOXINTERNALID).Value(end,end,:)>-1;
i=i(:);
xi=Box(BOXINTERNALID).XX(end,end,:);xi=xi(:);xi(i==0)=NaN;
yi=Box(BOXINTERNALID).YY(end,end,:);yi=yi(:);yi(i==0)=NaN;
zi=VerticalCoord(end,end,:);zi=zi(:);zi(i==0)=NaN;
plot3(xi,yi,zi,'Linewidth',0.5)
end

if strcmp(number,'on')
    
    text(Box(BOXINTERNALID).pointsX(1),Box(BOXINTERNALID).pointsY(1),Box(BOXINTERNALID).pointsZ(1),num2str(BOXID))
end

    
if strcmp(Vertical,'layer')
    ZZ=Box(BOXINTERNALID).LZ;
    Boxvalue=Box(BOXINTERNALID).Value;
elseif strcmp(Vertical,'depth')
    Boxvalue=inpaint_nans3(Box(BOXINTERNALID).Value);
    ZZ=inpaint_nans3(Box(BOXINTERNALID).ZZ);
    hold on
end
%% colors

if strcmp(scale,'default')
 
    rgbval=[153 204 255]/256;
elseif strcmp(scale,'variable')
    rgbval= boxcol();
    rgbval=rgbval(BOXINTERNALID,:);
else
    rgbval=scale;
end

h=patch(isosurface(Box(BOXINTERNALID).XX,Box(BOXINTERNALID).YY,ZZ,Boxvalue),...
    'FaceVertexCData',BOXVAL,'FaceColor',rgbval,'Edgecolor','none','FaceAlpha',0.1,'DisplayName',legendstring);


hobj=patch(isocaps(Box(BOXINTERNALID).XX,Box(BOXINTERNALID).YY,ZZ,Boxvalue),...
    'FaceVertexCData',BOXVAL,'FaceColor',rgbval,'Edgecolor','none','FaceAlpha',0.1);


hAnnotation = get(hobj,'Annotation');
hLegendEntry = get(hAnnotation,'LegendInformation');
set(hLegendEntry,'IconDisplayStyle','off')
%legend('-DynamicLegend');

function colors=mycolormap()
colors=[0.8125  0  0
0.6875  1  0.3125
0.2500  1  0.7500
0.1875  1  0.8125
1  0.06250  0
1  0.5000  0
0.5625  0  0
0.9375  0  0
0.5000  1  0.5000
0  0  0.7500
1  0.3125  0
0.8125  1  0.1875
1  0.9375  0
0  0.3125  1
1  0.4375  0
0  0.1250  1
0  0.3750  1
0  0  1
0  0  0.8750
1  0.8125  0
0  0.8750  1
0.9375  1  0.06250
0.7500  1  0.2500
0  0.2500  1
0  0.5625  1
0.06250  1  0.9375
0.5000  0  0
1  0  0
1  0.5625  0
0.6250  1  0.3750
0  0.5000  1
1  1  0
0.3125  1  0.6875
1  0.1875  0
0  0  0.6875
0  0.7500  1
0.1250  1  0.8750
0.5625  1  0.4375
0  0.6875  1
1  0.8750  0
0  0.4375  1
1  0.7500  0
1  0.6875  0
1  0.6250  0
0  1  1
0  0.9375  1
0.7500  0  0
0  0  0.8125
0.3750  1  0.6250
0.8750  1  0.1250
0  0.06250  1
0.6875  0  0
1  0.2500  0
0  0.6250  1
0  0  0.9375
0.6250  0  0
0  0  0.5625
1  0.3750  0
0  0.8125  1
0  0.1875  1
0.4375  1  0.5625
0  0  0.6250
0.8750  0  0
1  0.1250  0
0.8125  0  0
0.6875  1  0.3125
0.2500  1  0.7500
0.1875  1  0.8125
1  0.06250  0
1  0.5000  0
0.5625  0  0
0.9375  0  0
0.5000  1  0.5000
0  0  0.7500
1  0.3125  0
0.8125  1  0.1875
1  0.9375  0
0  0.3125  1
1  0.4375  0
0  0.1250  1
0  0.3750  1
0  0  1
0  0  0.8750
1  0.8125  0
0  0.8750  1
0.9375  1  0.06250
0.7500  1  0.2500
0  0.2500  1
0  0.5625  1
0.06250  1  0.9375
0.5000  0  0
1  0  0
1  0.5625  0
0.6250  1  0.3750
0  0.5000  1
1  1  0
0.3125  1  0.6875
1  0.1875  0
0  0  0.6875
0  0.7500  1
0.1250  1  0.8750
0.5625  1  0.4375
0  0.6875  1
1  0.8750  0
0  0.4375  1
1  0.7500  0
1  0.6875  0
1  0.6250  0
0  1  1
0  0.9375  1
0.7500  0  0
0  0  0.8125
0.3750  1  0.6250
0.8750  1  0.1250
0  0.06250  1
0.6875  0  0
1  0.2500  0
0  0.6250  1
0  0  0.9375
0.6250  0  0
0  0  0.5625
1  0.3750  0
0  0.8125  1
0  0.1875  1
0.4375  1  0.5625
0  0  0.6250
0.8750  0  0
1  0.1250  0];


function colorsbox=boxcol()

colorsbox=[0         0    0.5625
         0         0    0.6250
         0         0    0.6875
         0         0    0.7500
         0         0    0.8125
         0         0    0.8750
         0         0    0.9375
         0         0    1.0000
         0    0.0625    1.0000
         0    0.1250    1.0000
         0    0.1875    1.0000
         0    0.2500    1.0000
         0    0.3125    1.0000
         0    0.3750    1.0000
         0    0.4375    1.0000
         0    0.5000    1.0000
         0    0.5625    1.0000
         0    0.6250    1.0000
         0    0.6875    1.0000
         0    0.7500    1.0000
         0    0.8125    1.0000
         0    0.8750    1.0000
         0    0.9375    1.0000
         0    1.0000    1.0000
    0.0625    1.0000    0.9375
    0.1250    1.0000    0.8750
    0.1875    1.0000    0.8125
    0.2500    1.0000    0.7500
    0.3125    1.0000    0.6875
    0.3750    1.0000    0.6250
    0.4375    1.0000    0.5625
    0.5000    1.0000    0.5000
    0.5625    1.0000    0.4375
    0.6250    1.0000    0.3750
    0.6875    1.0000    0.3125
    0.7500    1.0000    0.2500
    0.8125    1.0000    0.1875
    0.8750    1.0000    0.1250
    0.9375    1.0000    0.0625
    1.0000    1.0000         0
    1.0000    0.9375         0
    1.0000    0.8750         0
    1.0000    0.8125         0
    1.0000    0.7500         0
    1.0000    0.6875         0
    1.0000    0.6250         0
    1.0000    0.5625         0
    1.0000    0.5000         0
    1.0000    0.4375         0
    1.0000    0.3750         0
    1.0000    0.3125         0
    1.0000    0.2500         0
    1.0000    0.1875         0
    1.0000    0.1250         0
    1.0000    0.0625         0
    1.0000         0         0
    0.9375         0         0
    0.8750         0         0
    0.8125         0         0
    0.7500         0         0
    0.6875         0         0
    0.6250         0         0
    0.5625         0         0
    0.5000         0         0];
