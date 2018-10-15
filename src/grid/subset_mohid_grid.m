function [indx,indy,x_moh_sub,y_moh_sub]=subset_mohid_grid(x_moh,y_moh,xmin,xmax,ymin,ymax)
indx= find((x_moh(:,1)<=xmax & x_moh(:,1)>=xmin ));
indy= find((y_moh(1,:)<=ymax & y_moh(1,:)>=ymin ));
x_moh_sub=x_moh(indx,indy);
y_moh_sub=y_moh(indx,indy);