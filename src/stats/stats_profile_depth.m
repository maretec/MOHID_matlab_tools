function [bias,RMSE, R_t,yfit,x,mdl]=stats_profile_depth(obs,model)
bias= mean(obs-model);
RMSE= rms(obs-model);
for k=1:length(obs(1,:))
 R = corrcoef(obs(:,k),model(:,k),'rows','pairwise');
 R_t(k) = abs(R(1,2));
 
end
 x = min(obs(:)):0.1:max(obs(:));
 mdl = fitlm(obs(:),model(:));
 yfit=feval(mdl,x);