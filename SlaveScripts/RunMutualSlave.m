
function [R]=RunMutualSlave(par)

R=zeros(length(par.N_range),par.J+1,6);

for n=1:1:length(par.N_range)
    par.N=par.N_range(n);              % Set Graph size
    for j=1:(par.J+1)
        for t_out=1:par.MC.out
            clear out;
            parfor (i=1:par.workers,par.workers)
                %for i=1:par.workers         %option to run without parfor
                out(i)= FindMu(j,par);
            end
           %s - save results
            for i=1:par.workers
                R(n,j,1)=R(n,j,1)+(1/par.MC.tot)*out(i).mu_upper;
                R(n,j,2)=R(n,j,2)+(1/par.MC.tot)*out(i).mu;
                R(n,j,3)=R(n,j,3)+(1/par.MC.tot)*out(i).mu_lower;
                R(n,j,4)=R(n,j,4)+(1/par.MC.tot)*out(i).min_deg;
           
            end
        end

    end
end

end



function out=FindMu(j,par)

% Setting

flag=[]; 
while isempty(flag)
%construct graph
G=ConstructGraph(par,j-1);

%check if graph is connected
eigs=eig(G.L);
if eigs(2)>1e-5
    flag=1; 
end
end

% maximal and minimal degree
Deg=diag(G.L);
[d_sort,d_sort_ind]=sort(Deg,'ascend');
d_min=d_sort(1);
d_2min=d_sort(2);
i_1_nei=find(G.W(:,d_sort_ind(1)~=0));
d_min_nei=max(d_sort(i_1_nei));


% mutual coherence upper bound
mu_upper=(d_min+d_2min)/(sqrt(d_min^2+d_min)*sqrt(d_2min^2+d_2min));

% mutual coherence lower bound
mu_lower=(1)/(sqrt(d_min^2+d_min)*sqrt(1+(1/d_min_nei)));


% mutual coherence
mu=mutual_coherence(G.L);



%save the results in the strcuture out
[out.mu,out.mu_upper,out.mu_lower,out.min_deg]=...
    deal(mu,mu_upper,mu_lower,d_min);


end



function G=ConstructGraph(par,j)

G=GraphConfigurations(par);
switch par.type
    case 'erdus'            % Erdus Reyni Graphs
    G.p=G.p_base+G.p_add*(j);
    param.connected=1;
    G.L= erdos_reyni( G );
    G.W=-G.L+diag(diag(G.L));
    
    case 'sensor'         % sensor graphs
    gamma=G.base+G.add*(j);
    [G.L,G.W]=SensorGraph(par.N, gamma, G.theta);
    G.W=-G.L+diag(diag(G.L));
    
    case 'regular'         %regular graphs
    G.N=80;
    G.base=4;
    G.add=1;
    G.D=G.base+G.add*j;
    G.L=RegularGraph(G);
    G.W=-G.L+diag(diag(G.L));
    

end 

end



