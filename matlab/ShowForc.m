function ShowForc(x, y, z, d, N)
    H = linspace(-0.3, 0.3, 2000);   
    Hforc = linspace(-0.15, 0.15, 80); 
    [M, Mr, Hc, Hsw] = LoadHysteresis(x, y, z, d, N, H);
    Mdown = M; 
    Mup = -M(:,end:-1:1); 
    Hsw = -Hsw; 
    sw = zeros(length(Hsw),1); 
    
    for a = 1:length(Hsw)
        sw(a) = find(H>=Hsw(a), 1); 
    end
            
    [Ha, Hb] = meshgrid(Hforc, Hforc); 
    HHsw = repmat(Hsw', 1, length(H)); 
    Mforc = NaN * zeros(size(Ha)); 
    for n = 1:length(Hforc)
        down = logical(HHsw>=Ha(1,n)); 
        up = ~down; 
        Mforc(:,n) = interp1(H, sum(Mup.*up+Mdown.*down, 1), Hb(:,n));
        Mforc(1:n,n) = NaN;
    end
        
    forc = -diff(diff(Mforc, 1, 1), 1, 2) ...
            ./diff(Ha(1:end-1,:), 1, 2) ...
            ./diff(Hb(:,1:end-1), 1, 1); 
    Hc = (Hb-Ha)/2;
    Hu = (Hb+Ha)/2;
    Hc = Hc(1:end-1,1:end-1); 
    Hu = Hu(1:end-1,1:end-1); 
    
    PlotFORC(forc, Hc, Hu, 0.12, 0.06);
end


