function [TableOfFluxes]=ReadResidualFlux(filename, conversion_factor)
[M,names_list]= ReadBoxTimeSerie(filename,'<BeginResidual>','<EndResidual>');
parts = regexp(names_list,'\s+','split');
parts=char(parts); 
[rp,cp]=size(parts);
for i=1:rp
    if strcmp('Seconds',regexprep(parts(i,:),'[^\w'']',''))
        indexstart=i;
    end
end
names=parts(indexstart+7:end,:);
[r,c]=size(M);
n_tot=c-7;
Total_Time=M(:,1);
for i=1:r
Total_Fluxes(i,:)=M(i,8:c)*Total_Time(i)/conversion_factor;  % Total Flux in Tons
end
if r>1
    Total_Fluxes=mean(Total_Fluxes);
end
[r,c]=size(names);
for i=1:r
parts = regexp(names(i,:),'_','split');
TableOfFluxes(i,1)=str2num(char(parts(2)));
TableOfFluxes(i,2)=str2num(char(parts(3)));
TableOfFluxes(i,3)=Total_Fluxes(i);
end
TableOfFluxes(:,4)=1; %flag duplicated rows
for i=1:length(TableOfFluxes)
    rowtocheck=TableOfFluxes(i,:);
     for j=1:length(TableOfFluxes)
     if j~=i & TableOfFluxes(j,4)==1
         if fliplr(TableOfFluxes(j,1:2))==TableOfFluxes(i,1:2)
             TableOfFluxes(i,4)=0;
         end
     end
end
end
% clean table from repeated 
TableOfFluxes=TableOfFluxes(find(TableOfFluxes(:,4)==1),:);
