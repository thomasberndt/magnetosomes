
set(gcf, 'Position', [48 48 900 700]);
clf
set(gcf, 'Color', 'w');

[x, y, z, d, N, Mr, Hc, Hcr] = ReadDayParameters(); 
%%

x(y<30) = []; 
z(y<30) = []; 
d(y<30) = []; 
N(y<30) = []; 
Mr(y<30) = []; 
Hc(y<30) = []; 
Hcr(y<30) = []; 
y(y<30) = []; 

e = x./y; 

clf
texcol = 'k'; 


yy = [30 40 50 60 70 80 100]; 
ee = [1 1.1 1.2 1.3 1.4]; 
sizoff = 25; 
sizmult = 3; 

mkr = 'o^sph';
for n = 1:length(ee)
    i = logical(e==ee(n) & N==10); 
    color = log10(d(i));
    PlotDay(Mr(i), 1, Hcr(i), Hc(i), (y(i)-sizoff)*sizmult, color, mkr(n), false);
    hold on
end
xoff = 1.65;
xmult = 0.06;
yoff = 0.10; 
ymult = 0.028;
for en = 1:length(ee)
    for yn = 1:length(yy)
        scatter(xoff+en*xmult, yoff+yn*ymult, (yy(yn)-sizoff)*sizmult, texcol, mkr(en), 'filled');
    end
end

for en = 1:length(ee)
    text(xoff+en*xmult, yoff, num2str(ee(en)), ...
            'HorizontalAlignment', 'Center', ...
            'Color', texcol, ...
            'FontSize', 14);
end
text(xoff+xmult*3, yoff-ymult, 'Elongation', ...
    'HorizontalAlignment', 'Center', ...
    'Color', texcol, ...
    'FontSize', 14);
text(xoff-xmult*1.5, yoff+ymult*4, 'Size', ...
    'HorizontalAlignment', 'Center', ...
    'Rotation', 90, ...
    'Color', texcol, ...
    'FontSize', 14);
for yn = 1:length(yy)
    text(xoff-xmult*0.3, yoff+yn*ymult, ...
        sprintf('%g nm', yy(yn)), ...
        'HorizontalAlignment', 'Center', ...
        'Color', texcol, ...
        'FontSize', 14);
end

hold off
c = colorbar;
colormap copper

c.Ticks = log10([1 2 3 5 7 10 15 20 30 50 70 100]); 
c.TickLabels = {'1 nm', '2 nm',  '3 nm', '5 nm', '7 nm', '10 nm', ...
           '15 nm', '20 nm', '30 nm', '50 nm', '70 nm', '100 nm',}; 
ylabel(c, 'Spacing d between elements (Interactions)')

set(gca, 'FontSize', 16);
xlim([1 2]);
ylim([0 0.6]); 

%%

filename = 'DayPlot'; 
try
    export_fig(sprintf('../output/png/%s.png', filename), '-m4'); 
    export_fig(sprintf('../output/pdf/%s.pdf', filename)); 
catch
    print(gcf, '-dpng', sprintf('../output/png/%s.png', filename)); 
    print(gcf, '-dpdf', sprintf('../output/pdf/%s.pdf', filename)); 
end