function [skillgrid,rmsgrid,corrgrid] = stat_grid(obs,mod)
%s
IM=size(obs,1);
JM=size(obs,2);
rmsgrid=rms(obs-mod,3);

for i=1:IM
    for j=1:JM
        temp0 =sum(abs( mod(i,j,:)- obs(i,j,:)).^2);
        temp1= abs(mod(i,j,:) -mean(obs(i,j,:)));
        temp2= abs(obs(i,j,:) -mean(obs(i,j,:)));
        skillgrid(i,j)= 1 - temp0/sum((temp1+temp2).^2);
        R=corrcoef(obs(i,j,:),mod(i,j,:));
        corrgrid(i,j)=R(1,2);
    end
end