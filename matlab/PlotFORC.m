function PlotFORC(forc, Hc, Hu, Hcplot, Huplot)
    lim = max(abs(min(forc(Hc>0.0005))), abs(max(forc(Hc>0.0005))));
    forc = forc / lim; 
    forccolors = ones(101,3); 
    forccolors(1:50,1) = linspace(0, 1, 50); 
    forccolors(1:50,2) = linspace(0, 1, 50); 
    forccolors(52:101,2) = linspace(1, 0, 50); 
    forccolors(52:101,3) = linspace(1, 0, 50); 
    vl = linspace(-1, 1, 20);  
    contourf(Hc*1000, Hu*1000, forc, vl);
    axis([0 Hcplot -Huplot Huplot]*1000);
    title(sprintf('FORC')); 
    xlabel('H_c [mT]'); 
    ylabel('H_u [mT]'); 
    grid on
    colormap(forccolors);
    caxis([-1 1]);
end