function [p1pos,p2pos]=mindistance(p1,p2)
[r1,c1]=size(p1);
[r2,c2]=size(p2);
P1_andpos=[p1 [1:r1]'];
PP1=repmat(P1_andpos,r2,1);

P2_andpos=[p2 [1:r2]'];
PP2=sortrows(repmat(P2_andpos,r1,1),1);
% for 2D
distance=sqrt((PP1(:,1)-PP2(:,1)).^2+(PP1(:,2)-PP2(:,2)).^2);
%for 3D
if c1>2
distance=sqrt((PP1(:,1)-PP2(:,1)).^2+(PP1(:,2)-PP2(:,2)).^2+(PP1(:,3)-PP2(:,3)).^2);
end
[dist_matrix,pos]=min(distance);
p1out=PP1(pos,1:end-1);
p2out=PP2(pos,1:end-1);
p1pos=PP1(pos,end);
p2pos=PP2(pos,end);