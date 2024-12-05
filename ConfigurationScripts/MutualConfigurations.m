
function par=MutualConfigurations(par)

% Monte Carlo paramters using parfor loops
par.workers=10;
par.MC.out=10; 
par.MC.tot=par.MC.out*par.workers; 

% measures examined
par.measures={'upper','mu','lower','min_deg'};


% x axis - option A - graph sparsity
% for Erdus Reyni
par.p.base=0.1; %lowest value        
par.p.add=0.05; % addition
% for Sensor Graph
par.gamma.base=0.05; %lowest value
par.gamma.add=0.245; %addition
% number of elements
par.J=19; 

% x axis - option B - graph size
par.N_range=10:20:100;  

end
