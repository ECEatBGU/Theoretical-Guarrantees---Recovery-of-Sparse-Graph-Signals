
%*******************************************************
%                Run Simulations - Master Script 
%*******************************************************

% This script runs all the simulations conducted and stores them in 
% the folder Results. 

addAllSubfoldersToPath()
select_graph={'erdus','sensor'}; % underlying graph

for sim=1:length(select_graph)
    
    par.type=select_graph{sim};

    % 1. Simulation Hyper Paramters 
    %---------------------------------------------------------
    par=MutualConfigurations(par); 
    
    % 2. Run simulation over selected Graph
    %---------------------------------------------------------
    R=RunMutualSlave(par); 
    
    % 3. Save Result in designated folder
    %---------------------------------------------------------
    str_folder=sprintf('Results');
    S.R=R; 
    S.par=par; 
    str_save=sprintf('%s/Mutual_%s',str_folder,par.type);
    save(str_save,'S')

end

clear all; 



 