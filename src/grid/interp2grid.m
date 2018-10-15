function [qu,qv,qvel,qdeg]=interp2grid(Xnew,Ynew,x,y,u,v,vel,deg)
%Fu   = TriScatteredInterp(x(:),y(:),u(:));
%Fv   = TriScatteredInterp(x(:),y(:),v(:));
%Fvel = TriScatteredInterp(x(:),y(:),vel(:));

Fu   = scatteredInterpolant(x(:),y(:),u(:));
Fv   = scatteredInterpolant(x(:),y(:),v(:));
Fvel = scatteredInterpolant(x(:),y(:),vel(:));
Fdeg = scatteredInterpolant(x(:),y(:),deg(:));
%Interpolate Mohid  into the new mesh
qu = Fu(Xnew,Ynew);
qv = Fv(Xnew,Ynew);
qvel=Fvel(Xnew,Ynew);
qdeg=Fdeg(Xnew,Ynew);