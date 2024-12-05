
addAllSubfoldersToPath()
select_graph={'erdus','sensor'};

for sim=1:length(select_graph)
par.type=select_graph{sim};
par=RecoveryConfigurations(par);
R=RunRecoverySlave(par); 
str_folder=sprintf('Results');
S.R=R; 
S.par=par; 

% save simulations
str_save=sprintf('%s/recovery_%s',str_folder,par.type);        
save(str_save,'S')

end




 