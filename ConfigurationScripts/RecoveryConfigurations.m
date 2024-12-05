
function par=RecoveryConfigurations(par)


par.workers=10;
par.MC.out=1000; 
par.MC.tot=par.MC.out*par.workers;
par.N=70;

par.measures={'Recovery_omp','Recovery_lasso','rec_con'};

par.p=[0.3,0.8];

par.gamma=[1.275,2.5];


%sparse recovery
par.k_range=[1:5:70,70];
par.sig.var=1;
par.noise.var=0.2;


end
