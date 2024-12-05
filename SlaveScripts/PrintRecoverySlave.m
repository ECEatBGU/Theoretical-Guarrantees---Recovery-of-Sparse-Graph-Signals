
function PrintRecoverySlave(p)

%inputs---------------------------

[col,mark,Li] = plot_handels_sparse;
load(sprintf('Results/recovery_%s.mat',p.conf));
par=S.par; 
f=figure;

%***********************************
%specify all the required parameters
%***********************************
switch p.conf
        case 'erdus'
            j1=5; j2=15; % p's observed in N axis plot
            leg_str={sprintf('OMP, p=%.1f',p.p(1)),sprintf('Lasso, p=%.1f',p.p(1)),...
            sprintf('OMP, p=%.1f',p.p(2)),sprintf('Lasso, p=%.1f',p.p(2))};
             


        case 'sensor'
            j1=5; j2=10;  % gamma's observed in N axis plot
            leg_str={sprintf('OMP, \\gamma=%.1f',p.gamma(1)),sprintf('Lasso, \\gamma=%.1f',p.gamma(1)),...
            sprintf('OMP, \\gamma=%.1f',p.gamma(2)),sprintf('Lasso, \\gamma=%.1f',p.gamma(2))};
            
end

y_dim=[2,3];   
j=[j1;j2];
y=squeeze(S.R(:,1:2,1:2)); 
    
par.gal=1;
par=RecoveryConfigurations(par);

x=par.k_range;
x_str='$| \Lambda |$';
 y_str='Support Recovery Rate';
leg_location='SouthWest';


set(gca,'Fontsize',16);
hold on; 
%grid on; 

Plotplots(y_dim,x,y,col,Li,mark)
grid on;
legend(leg_str,'FontSize', 18,'Location',leg_location);
xlabel(x_str,'Interpreter','latex','FontSize', 24);
ylabel(y_str,'Interpreter','latex','FontSize', 24);
xlim([0,66]);
ylim([0,1]);


end


function Plotplots(y_dim,x,y,col,Li,mark)
switch numel(y_dim)
    case 1
    for l=1:size(y,y_dim) 
    plot(x,y(:,l),'color',col{l},'LineWidth',3,'LineStyle',Li{l},'Marker',mark{l},'MarkerSize',10);     
    end
    case 2
    L=size(y,y_dim(1));
    K=size(y,y_dim(2)) ;
    for l=1:L 
        for k=1:K 
        plot(x,y(:,l,k),'color',col{(l-1)*K+k},'LineWidth',3,'LineStyle',Li{(l-1)*K+k},'Marker',mark{(l-1)*K+k},'MarkerSize',10); 
        end
    end
end
end










