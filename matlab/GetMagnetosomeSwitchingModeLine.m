function GetMagnetosomeSwitchingModeLine(x, y, z, d, N)
    x = xx(nx); 
    y = x; 
    z = x; 
    d = [1 2 3 5 7 10 15 20 30 50 70 100]; 
    N = 10;

    M = NaN(size(x));
    vort = NaN(size(x));
    Hsw = NaN(size(x)); 
    fanning = NaN(size(x));

    for n = 1:length(d)
        try
            [alpha1, M1, vort1, Hsw1, fanning1] = GetSwitchingMode(x, y, z, d(n), N);
            M(n) = mean(M1); 
            vort(n) = mean(vort1); 
            Hsw(n) = mean(Hsw1); 
            fanning(n) = mean(fanning1); 
        catch
        end
    end


    gd = ~isnan(M);
    semilogx(d(gd), M(gd), 'o-', ...
         d(gd), vort(gd)/50, 's-', ...
         d(gd), Hsw(gd)/100, 'x-', ...
         d(gd), fanning(gd)/pi, '*-');
     
end