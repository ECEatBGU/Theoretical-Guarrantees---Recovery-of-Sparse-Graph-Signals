function [hat_Omega,hat_x,lambda] = ell_1(y,F,N,s,var_n)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

% y - measurements
% F - sensing matrix
% N - graph size
% s  - assumed support cardinality 
% var_n - noise variance

lambda=1;
[m,n]=size(F);

M=@(S) F(:,S);
Psu=@(S) (M(S).'*M(S))^(-1)*M(S).';
P=@(S) M(S)*(M(S).'*M(S))^(-1)*M(S).';
pre= @(y,S) y.'*P(S)*y;
IP=@(S) eye(m)-P(S);


%epsilon=N*trial.var_n;  %defining a new condition 

A=F;
b=y;
rho=1; 
itr=100;


hat_x=ADMM_lasso(A,b,rho,lambda,itr);

[x,ind_x]=sort(abs(hat_x),'descend');
%gal_x{i_l}=[x(1:10),ind_x(1:10)]; 
ind_x(x==0)=[];
hat_Omega=ind_x;
r=IP(hat_Omega)*y;
 
%smart thresholding  %this has been changed - made as a remark
%val_ref=0; 
%for i=1:length(hat_Omega)
%    val_new=pre(y,hat_Omega(1:i)); 
%    if val_new-val_ref<epsilon
%        hat_Omega=hat_Omega(1:i);
%        break
%    end
%end 

%Anyway we need to fit the sparsity restrictio
if length(hat_Omega)>s
 hat_Omega=hat_Omega(1:s);
end

hat_Omega=sort(hat_Omega,'ascend');
%final result for hat_x
hat_x=zeros(size(F,2),1);
hat_x(hat_Omega)=Psu(hat_Omega)*y;

end

