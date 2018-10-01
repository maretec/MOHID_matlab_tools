function h=patchcoastline(Coastline,color,height)
pos=find(isnan(Coastline(:,1)));
n=length(pos);
for i=1:n-1
    X=Coastline(pos(i)+1:pos(i+1)-1,1);
    Y=Coastline(pos(i)+1:pos(i+1)-1,2);
    Z=height*ones(size(Coastline(pos(i)+1:pos(i+1)-1,2)));
    h(i)=fill3(X,Y,Z,color);
  
    view(2)
    hold on
    
end
  