function AnisShowHysteresis(x, y, z, d, N, a)
    H = linspace(-0.3, 0.3, 2000);     
    [M, Mr, Hc, Hsw] = AnisLoadHysteresis(x, y, z, d, N, H);
    
    if a < length(Hc)
        PlotHysteresis(H, M(a,:), Hc(a), Hsw(a)); 
    else
        PlotHysteresis(H, M(a,:)); 
    end
    fprintf('Mr: %g \n', Mr(a));
    fprintf('Hc: %g \n', Hc(a));
    fprintf('Hsw: %g \n', Hsw(a));
end