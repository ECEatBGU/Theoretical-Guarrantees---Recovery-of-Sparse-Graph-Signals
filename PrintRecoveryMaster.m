

addAllSubfoldersToPath()
conf={'erdus','sensor'};

for i=1:numel(conf)
    p.FigName=sprintf('recovery_%s',conf{i});
    p.x_type=conf{i};
    p.save='yes';
    str_fig=sprintf('Figures/%s.fig',p.FigName);
    str_eps=sprintf('Figures/%s',p.FigName);
    p.measures={'recovery_omp','recovery_lasso'};
    p.N=70;
    p.conf=conf{i};
    p.p=[0.3,0.8];
    p.gamma=[1.275,2.5];

    %Run
    PrintRecoverySlave(p);
    if strcmp(p.save,'yes')
        savefig(str_fig)
        saveas(gcf,str_eps,'epsc')
        saveas(gcf,str_eps,'png')

    end


end

