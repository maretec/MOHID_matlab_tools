function [pclose,ind]=find_mohid_points(Xnew,Ynew,xp,yp)
m=length(xp);
n=length(yp);
pclose=zeros(m,2);
ind=zeros(m,2);
k1 = dsearchn(Xnew(1,:)',xp');
k2 = dsearchn(Ynew(:,1),yp');
px=Xnew(k2,k1);
py=Ynew(k2,k1);
 for i=1:m
     pclose(i,:)=[px(i,i),py(i,i)];
     ind(i,:)=[k2(i),k1(i)];
 end
