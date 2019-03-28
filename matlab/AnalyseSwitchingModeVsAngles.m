
letters = 'abcdefghijklmn'; 
ee = [1.0 1.4];
yy = [40 50 70 80 100];
dd = [1 5 10 20 30 50];


for k = 1:length(yy)
    y = yy(k);
    
    figure
    set(gcf, 'Position', [48 48 900/0.95 1200]);
    clf
    set(gcf, 'Color', 'w');
    p = panel(); 
    p.pack(3,2);
    p.marginleft = 15;
    p.marginbottom = 15;
    p.de.margin = 3;
    p.de.marginleft = 16;
    p.de.marginright = 16;
    
    for kk = 1:length(ee)
        e = ee(kk);

        Num = ceil(length(y)/2);
        colors = 0.5*hsv(length(dd));

        for n = 1:length(dd)
            [alpha, M, vort, Hsw, fanning] = ...
                    GetSwitchingMode(e*y, y, y, dd(n), 10);

            p(1, kk).select(); 
            h_H = plot(alpha, Hsw, 'o-', ...
                       'Color', colors(n,:), ...
                       'DisplayName', sprintf('d=%g nm', dd(n))); 
            set(h_H, 'MarkerFaceColor', get(h_H, 'Color')); 
            ylim([0 250]);
            grid on
            hold on; 
            legend('location', 'northwest');

            xlabel(''); 
            xticks(10:10:80); 
            xticklabels([]); 
            ylabel('Mean switching field H_{sw} [mT]'); 

            p(2, kk).select(); 
            h_v = plot(alpha, vort*2.6, 'p-', ...
                       'Color', colors(n,:)); 
            set(h_v, 'MarkerFaceColor', get(h_v, 'Color')); 
            grid on
            hold on;

            xlabel(''); 
            xticks(10:10:80); 
            xticklabels([]); 
            ylabel('Vorticity at switching [Arbitrary units]'); 
            ylim([0 100]);

            p(3, kk).select(); 
            h_f = plot(alpha, fanning/pi*150, 'v-', ...
                       'Color', colors(n,:)); 
            set(h_f, 'MarkerFaceColor', get(h_f, 'Color')); 
            grid on
            hold on

            xlabel('Angle'); 
            xticks(10:10:80); 
            xticklabels({'Parallel', '20', '30', '40', '50', ...
                '60', '70', 'Perpendic.'}); 
            ylabel('Fanning at switching [Arbitrary units]'); 
            ylim([0 100]);

            hold on
            drawnow;
        end
        
        p(1, kk).select(); 
        t = title(sprintf('%s) Coercivity\nGrain size %g nm, e=%g', ...
            letters(3*kk-2), y, e), ...
            'units', 'normalized', 'position', [0.5 0.9 0]); 
        t.FontSize = 12; 
        p(2, kk).select(); 
        t = title(sprintf('%s) Vorticity\nGrain size %g nm, e=%g', ...
            letters(3*kk-1), y, e), ...
            'units', 'normalized', 'position', [0.5 0.9 0]); 
        t.FontSize = 12; 
        p(3, kk).select(); 
        t = title(sprintf('%s) Fanning\nGrain size %g nm, e=%g', ...
            letters(3*kk), y, e), ...
            'units', 'normalized', 'position', [0.5 0.9 0]); 
        t.FontSize = 12; 
    end

    

    filename = sprintf('SwitchingVsAngle_%gy', y); 
    try
        export_fig(sprintf('../output/png/%s.png', filename), '-m4'); 
        export_fig(sprintf('../output/pdf/%s.pdf', filename)); 
    catch
        print(gcf, '-dpng', sprintf('../output/png/%s.png', filename)); 
        print(gcf, '-dpdf', sprintf('../output/pdf/%s.pdf', filename)); 
    end
    
end


