function [qssh]=interp2gridsolo(Xnew,Ynew,x,y,ssh)
%Fssh   = TriScatteredInterp(x(:),y(:),ssh(:));
Fssh   = scatteredInterpolant(x(:),y(:),ssh(:));
qssh=Fssh(Xnew,Ynew);