
onecolumn = 0;

[x, y, z, d, N, M_r, vort_r, ang_r, vort_ang_r, ...
        H_sw, M_sw, vort_sw, ang_sw, vort_ang_sw] = GetMeanSwitchingModes();

e = x ./ y; 

letters = 'abcdefghijklmn'; 
ee = [1.0 1.1 1.2 1.3 1.4 2]; 
yy = [40 50 60 70 80 100]; 

set(gcf, 'Position', [48 48 900/0.95/(1+onecolumn) 1200]);
clf
set(gcf, 'Color', 'w');

p = panel(); 
p.pack(3, 2-onecolumn);
p.de.margin = 3;
p.de.marginleft = 16;
p.de.marginright = 16;

Num = ceil(length(yy)/2);

for n = 1:length(yy)
    if onecolumn
        p(mod(n-1, 3)+1, 1).select();
        if n==4
            filename = 'SwitchingModes_1'; 
            try
                export_fig(sprintf('../output/png/%s.png', filename), '-m4'); 
                export_fig(sprintf('../output/pdf/%s.pdf', filename)); 
            catch
                print(gcf, '-dpng', sprintf('../output/png/%s.png', filename)); 
                print(gcf, '-dpdf', sprintf('../output/pdf/%s.pdf', filename)); 
            end
        end
    else
        p(mod(n-1, 3)+1, ceil(n/Num)).select();
    end
    
    
    
    [dd0, Hsw0] = GetMagnetosomeLine(vort_sw, y, e, d, N, yy(n), 1.0, 10); 
    [dd1, Hsw1] = GetMagnetosomeLine(vort_sw, y, e, d, N, yy(n), 1.1, 10); 
    [dd2, Hsw2] = GetMagnetosomeLine(vort_sw, y, e, d, N, yy(n), 1.2, 10); 
    [dd3, Hsw3] = GetMagnetosomeLine(vort_sw, y, e, d, N, yy(n), 1.3, 10); 
    [dd4, Hsw4] = GetMagnetosomeLine(vort_sw, y, e, d, N, yy(n), 1.4, 10); 
    
    h = plot(dd0, Hsw0, '-o', ...
             dd1, Hsw1, '-s', ...
             dd2, Hsw2, '-d', ...
             dd3, Hsw3, '-v', ...
             dd4, Hsw4, '-^'); 
    for k = 1:length(h)
         set(h(k), 'MarkerFaceColor', get(h(k), 'Color')); 
    end

    set(gca, 'XScale', 'log');
    grid on
    xticks([1:10 20:10:100]); 
    if mod(n, 3) == 0
        xlabel('Spacing [nm]'); 
        xticklabels({'1', '2', '3', '', '5', '', '7', '', '', '10', ...
                         '20', '30', '', '50', '', '70', '', '', '100'}); 
    else
        xticklabels([]); 
    end
    ylabel('Vorticity at switching [arbitrary units]'); 
    t = title(sprintf('%s) Grain size %g nm', letters(n), yy(n)), 'units', 'normalized', 'position', [0.5 0.9 0]); 
    t.FontSize = 12; 
    ylim([0 40]);
    yticks(0:5:50); 

    legend(h(end:-1:1), 'a/b=1.4', 'a/b=1.3', 'a/b=1.2', ...
           'a/b=1.1', 'a/b=1.0', 'location', 'northwest'); 
    
    drawnow;
end





if onecolumn
    filename = 'SwitchingModesVorticity_2'; 
else
    filename = 'SwitchingModesVorticity'; 
end
try
    export_fig(sprintf('../output/png/%s.png', filename), '-m4'); 
    export_fig(sprintf('../output/pdf/%s.pdf', filename)); 
catch
    print(gcf, '-dpng', sprintf('../output/png/%s.png', filename)); 
    print(gcf, '-dpdf', sprintf('../output/pdf/%s.pdf', filename)); 
end



function [dd, Hsw] = GetMagnetosomeLine(Hsw_mean, y, e, d, N, yselect, eselect, Nselect)
    idx = logical(e == eselect & N == Nselect & y==yselect); 
    dd = d(idx);
    Hsw = Hsw_mean(idx);
    gd = ~isnan(Hsw); 
    Hsw = Hsw(gd);
    dd = dd(gd);
    Hsw_bar = Hsw_mean(e == 10*eselect & N == 1 & y==yselect & d==0);
    if ~isempty(Hsw_bar)
        Hsw = [Hsw_bar; NaN; Hsw(:)]; 
        dd = [0.9; 0.95; dd(:)]; 
    end    
    Hsw_nonint = Hsw_mean(e == eselect & N == 1 & y==yselect & (d==0 | d==10));
    if ~isempty(Hsw_nonint)
        Hsw = [Hsw(:); NaN; Hsw_nonint]; 
        dd = [dd(:); 105; 120]; 
    end
end


