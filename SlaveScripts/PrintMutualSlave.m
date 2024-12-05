
function PrintMutualSlave(p)

%inputs---------------------------

[col,mark,Li] = plot_handels;
load(sprintf('Results/Mutual_%s.mat',p.graph));
par=S.par; 
f=figure;

%***********************************
%specify all the required parameters
%***********************************
switch p.graph
        case 'erdus'
            p.base=par.p.base;
            p.add=par.p.add;
            j1=5; j2=15; % p's observed in N axis plot
            leg_str_N={sprintf('\\zeta_{ub}, p=%.1f',p.p(1)),sprintf('\\mu,    p=%.1f',p.p(1)),sprintf('\\zeta_{lb},  p=%.1f',p.p(1)),...
            sprintf('\\zeta_{ub}, p=%.1f',p.p(2)),sprintf('\\mu,    p=%.1f',p.p(2)),sprintf('\\zeta_{lb},  p=%.1f',p.p(2))};

        case 'sensor'
            p.base=par.gamma.base;
            p.add=par.gamma.add;
            j1=5; j2=15;  % gamma's observed in N axis plot
            leg_str_N={sprintf('\\zeta_{ub}, \\gamma=%.1f',p.gamma(1)),sprintf('\\mu,    \\gamma=%.1f',p.gamma(1)),sprintf('\\zeta_{lb},  \\gamma=%.1f',p.gamma(1)),...
            sprintf('\\zeta_{ub}, \\gamma=%.1f',p.gamma(2)),sprintf('\\mu,    \\gamma=%.1f',p.gamma(2)),sprintf('\\zeta_{lb},  \\gamma=%.1f',p.gamma(2))};

end

switch p.x_type

    case 'deg'
    n=find(S.par.N_range==p.N);
    [x,Ord]=sort(S.R(n,:,find(strcmp('min_deg',p.measures)==1)));
    x=x./p.N;
    x_str='$d_{min}/N$';
    leg_str={'\zeta_{ub}','\mu','\zeta_{lb}'};
    leg_location='SouthWest';
    p.x.g=0:0.1:1;
    p.y.g=logspace(-2,0,10);
    range_x=[0,1];
    range_y=[0,1];
    y=squeeze(S.R(n,Ord,1:3)); 
    y_dim=2;
    case 'N'
    p_range=p.base+p.add*(0:par.J); 
    j=[j1;j2];
    x=S.par.N_range;
    x_str='$N$';
   leg_str=leg_str_N;
    leg_location='SouthWest';
    p.x.g=logspace(log(min(x)),log(max(x)),10);
    p.y.g=logspace(-3,1,10);
    range_x=[min(x),max(x)];
    range_y=[0,1];
    y=squeeze(S.R(:,j,1:3)); 
    y_dim=[2,3];  
end

%***********************************
% Plot the results
%***********************************


set(gca,'Fontsize',16);
hold on; 
Plotplots(y_dim,x,y,col,Li,mark)
grid on;

legend(leg_str,'FontSize', 18,'Location',leg_location)
if strcmp(p.x_type,'N')
    hLegend = legend;    
    hLegend.NumColumns = 2;
    hLegend.FontSize=16;
end
%ylim(range_y);
xlim(range_x);

xlabel(x_str,'Interpreter','latex','FontSize', 24);

if strcmp(p.x_type,'N')
    yscale log
    xscale log
end 
if strcmp(p.x_type,'deg')
    yscale log
    xscale linear
end 

%Adds the inset for the Deg axis
if strcmp(p.x_type,'deg')
   [M.x,M.y,M.col,M.Li,M.mark]=deal(p.base+p.add*(0:par.J),x,col,Li,mark);
    MixFigures(M)
end



end

% Auiliary function that adds the plots
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




%Auxiliary function for the addition of the inset
function MixFigures(M)

% Generate some data for the main plot
x = M.x;
y = M.y;

% Position for the inset axis
insetPosition = [0.62, 0.62, 0.25, 0.25]; 
% Create the inset axis
insetAxes = axes('Position', insetPosition);

% Generate some data for the inset plot
x_inset = M.x;
y_inset = M.y;

% Create the inset plot
plot(insetAxes, x_inset, y_inset,'color',M.col{7},'LineWidth',3,'LineStyle',M.Li{7},'Marker',M.mark{7},'MarkerSize',6);
set(gca,'Fontsize',12);
xlabel('$p$','Interpreter','latex','FontSize', 24);
ylabel('$d_{min}/N$','Interpreter','latex','FontSize', 24);
grid on; 
grid minor; 

% Optional: Customize the appearance of the inset axis
set(insetAxes, 'Box', 'on'); % Add a box around the inset axis
end








