function [x_ADMM] = ADMM_lasso(A,b,rho,lambda,itr)
%%%------------ADMM Lasso-------------%%%
%Version 1
%By Ashkan Ghanbarzadeh-Dagheyan, PhD, 12-06-2020.
%Citation: Will be announced soon.
%Temporary: "Ashkan Ghanbarzadeh-Dagheyan (2020). ADMM Lasso,  MATLAB Central File Exchange. Retrieved [Date]."
%-------------------------------------------------------%
% A: sensing matrix, size m*n
% b: measurement vector, size m
% rho: augmented Lagrangian parameter
% lambda: norm-1 regularizier (sparcifier)
%itr: maximum  number of iterations
%--------------Background----------------
%Based on Section 6.4 of
%Boyd, S., Parikh, N., & Chu, E. (2011). "Distributed optimization
%and statistical learning via the alternating direction method of multipliers". Now Publishers Inc.
%This code applies ADMM for the lasso problem,
%-------------------------------------------------
%---(1/2)*||Ax-b||_l2^2+\lambda*||x||_l1
%-------------------------------------------------
%as follows:
%x_{k+1}=(A'*A+rho*I)^-1*(A'*b+\rho(z_{k}-u_{k})
%z_{k+1}=S_{\lambda/\rho}*(x_{k+1}+u_{k})
%u_{k+1}=u_{k}+x_{k+1}-z_{k+1}
%where the term  psi_inv=(A'*A+rho*I)^-1 is calculated
%not directly, but by the Sherman-Morrison-Woodbury
%(SMW) matrix inversion formula, to avoid the memory-
%intensive multiplication A'*A:
%(A'*A+rho*I)^-1=(I*A'*A*I+rho*I)^-1
%=1/rho*(I - A'*(A*A'+rho*I)^-1 * A)
%=1\rho*I - 1/rho^2*(1/rho*A*A'+I)^-1 * A
%the above formula is adopted from an equation in Page 6 of
%Afonso, M. V., Bioucas-Dias, J. M., & Figueiredo, M. A. (2010). 
%"Fast image recovery using variable splitting and constrained optimization.
% IEEE transactions on image processing, 19(9), 2345-2356.
%suggested by Boyd et al. in the aforementioned reference.
%--------------Suggested Use----------------
%First set lambda=0 and change rho
%from small to large values, until
%the desired solution (image) for a known
%problem (geometry) is obtained.
%Then, gradually increase lambda until
%the most sparse (desired) solution is achieved.
%The value of rho obtained by this method will most probably
%work for problems of the same type.
%*If the nature of the solution
%---------------------------------------------------
%Copyright: Free to use to solve problems for the benift of humanity based
%on compassion, authenticity, justice, and objectivity. 
%Last Edited: 12/06/2020
%-------------------------------------------------------%
%Final Solution
x_ADMM = [];    
[m,n] = size(A);
%Initializing vectors z and u
z = zeros(n,1);   
u = zeros(n,1); 
%%% Inversion of Psi
psi_inv=inv(1/rho*(A*A')+eye(m));
tic
% Iterations
for k=1:itr   
    
    %x_{k+1}
    x=(1/rho*A'*b) + (z-u) - 1/rho^2*A'*(psi_inv*((A*A')*b)) - 1/rho*A'*(psi_inv*(A*(z-u)));
           
    %Regularization (Applying soft-thresholding S{lambda/rho}) [Boyd et al., Above]
    xu=x+u;
    indices_0=find(abs(xu)>(lambda/rho));
    %z_{k+1}
    z(indices_0)=xu(indices_0)-(lambda/rho)*sign(xu(indices_0));
    
    %u_{k+1}
    u = u + x - z;
    %Solution
    x_ADMM = z;
end
time_itr = toc;
%disp(['Time for ' num2str(itr) ' iterations: ' num2str(time_itr) ' s']);
