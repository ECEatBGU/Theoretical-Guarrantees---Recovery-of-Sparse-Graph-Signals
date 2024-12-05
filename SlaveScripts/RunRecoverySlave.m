
function [R]=RunRecoverySlave(par)

    R=zeros(length(par.k_range),2,2);
    
    for k=1:length(par.k_range)
    par.k=par.k_range(k);

    for j=1:2
    
    for t_out=1:par.MC.out
    
        %[mu,mu_upper,mu_lower,min_deg]=deal(zeros(par.workers,1));
        clear out;
        parfor (i=1:par.workers,par.workers)
        %for i=1:par.workers
        out(i)= FindMu(j,par); 
        end
        for i=1:par.workers
        %s - save results
        R(k,j,1)=R(k,j,1)+(1/par.MC.tot)*out(i).recovery_omp;
        R(k,j,2)=R(k,j,2)+(1/par.MC.tot)*out(i).recovery_lasso;
        
        

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
G=ConstructGraph(par,j);
%check if graph is connected
eigs=eig(G.L);
if eigs(2)>1e-5
    flag=1; 
end
end


%********  sparse recovery ******

%-measurement model 
supp=randperm(par.N).';
%supp=supp(1:ceil(par.sig.supp_pre*par.N));
supp=supp(1:par.k);
sig=zeros(par.N,1);
sig(supp)=sqrt(par.sig.var)*randn(length(supp),1);
noise=sqrt(par.noise.var)*randn(par.N,1);
%meas=G.L*sig+noise;
meas=G.L*sig; %  no noise


%-estimation methods
[omp_supp,omp_sig] = OMP(meas,G.L,par.N,length(supp),par.noise.var);
[lasso_supp,lasso_sig] = ell_1(meas,G.L,par.N,length(supp),par.noise.var);

fn=@(x,x_hat) length(setdiff(x,(intersect(x,x_hat))));
fp=@(x,x_hat) length(setdiff(x_hat,(intersect(x,x_hat))));
tp=@(x,x_hat) length(intersect(x,x_hat));
fscore= @(x,x_hat)  (2*tp(x,x_hat))/(2*tp(x,x_hat)+fn(x,x_hat)+fp(x,x_hat));
recovery=@(x, x_hat) isequal(sort(x),sort(x_hat));

nmse=@(x,x_hat) sqrt(sum((1/norm(x))*(x-x_hat)).^2);     % normalized by the size of the signalf


mse_omp=nmse(sig,omp_sig);
FS_omp=fscore(supp,omp_supp);
mse_lasso=nmse(sig,lasso_sig);
FS_lasso=fscore(supp,lasso_supp);
recovery_omp=recovery(supp,omp_supp);
recovery_lasso=recovery(supp,lasso_supp);

%nmse=@(x,x_hat) (sum(x-x_hat).^2)/(sum(x-mean(x)).^2);     



[out.recovery_omp,out.recovery_lasso]=...
    deal(recovery_omp,recovery_lasso);


end



function G=ConstructGraph(par,j)

%G=GraphConfigurations(par);
G.N=par.N;
G.quiet=1;
G.theta=0.2;
switch par.type
    case 'erdus'
    G.p=par.p(j);
    param.connected=1;
    G.L= erdos_reyni( G );
    G.W=-G.L+diag(diag(G.L));
    
    case 'sensor'
    gamma=par.gamma(j);
    [G.L,G.W]=SensorGraph(par.N, gamma, G.theta);
    G.W=-G.L+diag(diag(G.L));
    
  
    

end 

end



