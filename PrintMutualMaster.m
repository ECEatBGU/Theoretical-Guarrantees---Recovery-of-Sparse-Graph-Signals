


addAllSubfoldersToPath()

graph={'erdus','sensor'};
conf={'deg','N'}; 


for j=1:numel(graph)
p.graph=graph{j};
    for i=1:numel(conf) 
    p.FigName=sprintf('%s_mutual_%s',graph{j},conf{i});
    p.x_type=conf{i};
    p.save='yes';
    str_fig=sprintf('Figures/%s.fig',p.FigName);
    str_eps=sprintf('Figures/%s',p.FigName);
    p.measures={'upper','mu','lower','min_deg'};
    p.N=70;
    p.p=[0.3,0.8];
    p.gamma=[1.275,2.5];
    
    %Run
    PrintMutualSlave(p); 
    if strcmp(p.save,'yes')
    savefig(str_fig)
    saveas(gcf,str_eps,'epsc')
    saveas(gcf,str_eps,'png')
    
    end
    end 
end




