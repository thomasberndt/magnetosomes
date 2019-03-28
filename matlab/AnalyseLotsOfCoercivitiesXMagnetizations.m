onecolumn = 0;

magnetosomes = GetMagnetosomeParameters(); 
hysteresis = GetHysteresisParameters(); 
magnetosomes = magnetosomes(magnetosomes(:,1) >= magnetosomes(:,2),:); 
magnetosomes = magnetosomes(magnetosomes(:,2) <= 100,:); 
magnetosomes = magnetosomes(magnetosomes(:,6) >= 100,:); 

Mr_mean  = NaN * zeros(length(magnetosomes(:,1)),1);
Mrx_mean  = NaN * zeros(length(magnetosomes(:,1)),1);
Hsw_mean = NaN * zeros(length(magnetosomes(:,1)),1);
Hsw_std  = NaN * zeros(length(magnetosomes(:,1)),1);

x = magnetosomes(:,1);
y = magnetosomes(:,2);
z = magnetosomes(:,3);
d = magnetosomes(:,4);
N = magnetosomes(:,5);
e = x ./ y; 

for n = 1:length(x)
    idx = ismember(hysteresis(:,1:5), magnetosomes(n,1:5), 'rows'); 
    Mr = -hysteresis(idx, 7); 
    Mrx = -hysteresis(idx, 8); 
    Hc = hysteresis(idx, 11) * 1000; 
    Hsw = hysteresis(idx, 12) * 1000; 

    Mr_mean(n) = mean(Mr); 
    Mrx_mean(n) = mean(abs(Mrx)); 
    Hsw_mean(n) = mean(Hsw); 
    Hsw_std(n) = std(Hsw); 
end

%%

letters = 'abcdefghijklmn'; 
ee = [1.0 1.1 1.2 1.3 1.4 2]; 
yy = [40 50 60 70 80 100]; 
Ms0 = 480e3; 

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
            filename = 'GrainsizeMx_1'; 
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
    
    [dd0, Mr0] = GetMagnetosomeLine(Mrx_mean, y, e, d, N, yy(n), 1.0, 10); 
    [dd1, Mr1] = GetMagnetosomeLine(Mrx_mean, y, e, d, N, yy(n), 1.1, 10); 
    [dd2, Mr2] = GetMagnetosomeLine(Mrx_mean, y, e, d, N, yy(n), 1.2, 10); 
    [dd3, Mr3] = GetMagnetosomeLine(Mrx_mean, y, e, d, N, yy(n), 1.3, 10); 
    [dd4, Mr4] = GetMagnetosomeLine(Mrx_mean, y, e, d, N, yy(n), 1.4, 10); 
    
    h = plot(dd0, Mr0, '-o', ...
             dd1, Mr1, '-s', ...
             dd2, Mr2, '-d', ...
             dd3, Mr3, '-v', ...
             dd4, Mr4, '-^'); 
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
    ylabel('Magnetization [Am^2]'); 
    t = title(sprintf('%s) Grain size %g nm', letters(n), yy(n)), 'units', 'normalized', 'position', [0.5 0.9 0]); 
    t.FontSize = 12; 
    ylim([0 1.2]);
    yticks(0:0.1:1); 

    legend(h(end:-1:1), 'a/b=1.4', 'a/b=1.3', 'a/b=1.2', ...
           'a/b=1.1', 'a/b=1.0', 'location', 'best'); 
    
    drawnow;
end





if onecolumn
    filename = 'GrainsizeMx_2'; 
else
    filename = 'GrainsizeMx'; 
end 
try
    export_fig(sprintf('../output/png/%s.png', filename), '-m4'); 
    export_fig(sprintf('../output/pdf/%s.pdf', filename)); 
catch
    print(gcf, '-dpng', sprintf('../output/png/%s.png', filename)); 
    print(gcf, '-dpdf', sprintf('../output/pdf/%s.pdf', filename)); 
end



function [dd, M] = GetMagnetosomeLine(Mr_mean, y, e, d, N, yselect, eselect, Nselect)
    idx = logical(e == eselect & N == Nselect & y==yselect); 
    dd = d(idx);
    M = Mr_mean(idx);
    M_bar = Mr_mean(e == 10*eselect & N == 1 & y==yselect & d==0);
    if ~isempty(M_bar)
        M = [M_bar; NaN; M(:)]; 
        dd = [0.9; 0.95; dd(:)]; 
    end
    M_nonint = Mr_mean(e == eselect & N == 1 & y==yselect & (d==0 | d==10));
    if ~isempty(M_nonint)
        M = [M(:); NaN; M_nonint]; 
        dd = [dd(:); 105; 120]; 
    end
end


