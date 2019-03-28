

yy = [40 50 100]; 
HH_max = [50 50 100; 150 150 150]; 
HH_ticks = [10 10 20; 50 50 50]; 

for k = 1:length(yy)
    y = yy(k);
    figure
    set(gcf, 'Position', [48 48 900/0.95 1200]);
    clf
    set(gcf, 'Color', 'w');

    H_max = HH_max(1,k);
    H_ticks = HH_ticks(1,k);

    p = panel(); 
    p.pack(3, 2);
    p.margintop = 12;
    p.de.margin = 16;
    p.de.margintop = 22;

    N = [1 10];

    n = 1; 
    p(1, n).select(); 
    [handler, theta] = AnisShowHysteresisAllAngles(y,y,y,0,N(n));
    xlim([-H_max H_max]);
    xticks(-H_max:H_ticks:H_max); 
    t = title(sprintf('a) Hard axes aligned along chain axis\nGrain size %g nm, individual particle', ...
        y), 'units', 'normalized'); 
    ang = abs(theta-90)/90;
    [~, imax] = max(ang); 
    [~, imin] = min(ang); 
    legend([handler(imin), handler(imax)], ...
        'Parallel field', ...
        'Perpendicular field', ...
        'location', 'northwest'); 

    p(2, n).select(); 
    [handler, theta] = ShowHysteresisAllAngles(y,y,y,10,N(n));
    xlim([-H_max H_max]);
    xticks(-H_max:H_ticks:H_max); 
    t = title(sprintf('b) Easy axes aligned along chain axis\nGrain size %g nm, individual particle', ...
        y), 'units', 'normalized'); 
    ang = abs(theta-90)/90;
    [~, imax] = max(ang); 
    [~, imin] = min(ang); 
    legend([handler(imin), handler(imax)], ...
        'Parallel field', ...
        'Perpendicular field', ...
        'location', 'northwest'); 

    p(3, n).select(); 
    AnisShowHysteresisAllAngles(y,y,y,0,N(n));
    hold on
    ShowHysteresisAllAngles(y,y,y,10,N(n));
    hold off
    xticks(-H_max:H_ticks:H_max); 
    xlim([-H_max H_max]);
    t = title(sprintf('c) Comparison\nGrain size %g nm, individual particle', ...
        y), 'units', 'normalized'); 


    H_max = HH_max(2,k);
    H_ticks = HH_ticks(2,k);
    n = 2; 
    p(1, n).select(); 
    [handler, theta] = AnisShowHysteresisAllAngles(y,y,y,10,N(n));
    xlim([-H_max H_max]);
    xticks(-H_max:H_ticks:H_max); 
    t = title(sprintf('d) Hard axes aligned along chain axis\nGrain size %g nm, 10-element chain', ...
        y), 'units', 'normalized'); 
    ang = abs(theta-90)/90;
    [~, imax] = max(ang); 
    [~, imin] = min(ang); 
    legend([handler(imin), handler(imax)], ...
        'Parallel field', ...
        'Perpendicular field', ...
        'location', 'northwest'); 

    p(2, n).select(); 
    [handler, theta] = ShowHysteresisAllAngles(y,y,y,10,N(n));
    xlim([-H_max H_max]);
    xticks(-H_max:H_ticks:H_max); 
    t = title(sprintf('e) Easy axes aligned along chain axis\nGrain size %g nm, 10-element chain', ...
        y), 'units', 'normalized'); 
    ang = abs(theta-90)/90;
    [~, imax] = max(ang); 
    [~, imin] = min(ang); 
    legend([handler(imin), handler(imax)], ...
        'Parallel field', ...
        'Perpendicular field', ...
        'location', 'northwest'); 

    p(3, n).select(); 
    AnisShowHysteresisAllAngles(y,y,y,10,N(n));
    hold on
    ShowHysteresisAllAngles(y,y,y,10,N(n));
    hold off
    xlim([-H_max H_max]);
    xticks(-H_max:H_ticks:H_max); 
    t = title(sprintf('f) Comparison\nGrain size %g nm, 10-element chain', ...
        y), 'units', 'normalized'); 


    filename = sprintf('AnisHysteresis_%gy', y); 
    try
        export_fig(sprintf('../output/png/%s.png', filename), '-m4'); 
        export_fig(sprintf('../output/pdf/%s.pdf', filename)); 
    catch
        print(gcf, '-dpng', sprintf('../output/png/%s.png', filename)); 
        print(gcf, '-dpdf', sprintf('../output/pdf/%s.pdf', filename)); 
    end
end
