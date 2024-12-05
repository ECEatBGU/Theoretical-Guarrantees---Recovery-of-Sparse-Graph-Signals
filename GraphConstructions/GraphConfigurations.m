
function G=GraphConfigurations(par)
 
G.N=par.N;

switch par.type
    case 'erdus'
    G.p_base=par.p.base;
    G.p_add=par.p.add;
    G.quiet=1;
   
    case 'sensor'
    % not used - if required should be properly defined
    G.base=par.gamma.base;
    G.theta=0.2;
    G.add=par.gamma.add;
    
    case 'regular' 
    % not used - if required should be properly defined
    G.N=80;
    G.base=4;
    G.add=1;
    G.D=G.base+G.add*j;
    G.L=RegularGraph(G);
    G.W=-G.L+diag(diag(G.L));
    

end 

end 