

set(gcf, 'Position', [230   130   900   1150]);
clf
set(gcf, 'Color', 'w');

p = panel(); 
p.pack(2,1);
p.de.margin = 20;
p.marginleft = 24;
p.marginbottom = 20;
p(1,1).select(); 

T = readtable('../TEM/statistics.csv'); 
cc=hsv(height(T))*0.5;
markers = 'osd^v><'; 

for n = 1:height(T)
    
    h = errorbar(T.y_mean(n), T.d_mean(n), ...
             -T.d_std(n), T.d_std(n), ...
             -T.y_std(n), T.y_std(n), ...
             markers(1+mod(n,length(markers))), ...
            'DisplayName', T.strains{n}, ...
            'Color', cc(n,:), ...
            'MarkerSize', 12, ...
            'CapSize', 0);
         
    set(h, 'markerfacecolor', get(h, 'color'));
    hold on
end

pol = polyfit(log(T.y_mean), log(T.d_mean), 1); 
w = linspace(20,180,1000); 
plot(w, exp(polyval(pol, log(w))), '-', ...
    'Displayname', 'log-fit', ...
    'Color', [.5 .5 .5]); 

xlim([0 170]); 
ylim([0 15]); 
hlegend = legend;
hlegend.NumColumns=2;
legend boxoff

hold off

xlabel('Mean grain size (width) [nm]'); 
ylabel('Mean intra-chain spacing [nm]'); 

set(gca,'FontSize',18);


%%

p(2, 1).select(); 
w = linspace(30,180,100); 

[Mr1, Hc1, Hcr1] = InterpolateDay(w, 1.0, exp(polyval(pol, log(w)))); 
[Mr2, Hc2, Hcr2] = InterpolateDay(w, 1.1, exp(polyval(pol, log(w)))); 
Hc3 = [Hc1' Hc2(end:-1:1)']; 
ww = [w w(end:-1:1)];
good = ~isnan(Hc3); 
h1 = patch(ww(good), Hc3(good)*1000, [.75 .75 1], ...
        'EdgeColor', 'none');
hold on


[Mr1, Hc1, Hcr1] = InterpolateDay(w, 1.2, exp(polyval(pol, log(w)))); 
[Mr2, Hc2, Hcr2] = InterpolateDay(w, 1.4, exp(polyval(pol, log(w)))); 
Hc3 = [Hc1' Hc2(end:-1:1)']; 
ww = [w w(end:-1:1)];
good = ~isnan(Hc3); 
h2 = patch(ww(good), Hc3(good)*1000, [.75 1 .75], ...
        'EdgeColor', 'none');

[Mr, Hc, Hcr] = InterpolateDay(w, 1.05, exp(polyval(pol, log(w)))); 
h = plot(w, Hc*1000, '-', ...
         'DisplayName', sprintf('H_c (e=%.1f)', e), ...
         'Color', [0 0 .5]); 
[Mr, Hc, Hcr] = InterpolateDay(w, 1.3, exp(polyval(pol, log(w)))); 
h = plot(w, Hc*1000, '-', ...
         'DisplayName', sprintf('H_c (e=%.1f)', e), ...
         'Color', [0 .5 0]); 

legend([h2 h1], 'Elongated (e=1.2-1.4)', 'Equant (e=1.0-1.1)'); 

for n = 1:height(T)
    [Mr, Hc, Hcr] = InterpolateDay(T.y_mean(n), T.e(n), T.d_mean(n)); 
    h = plot(T.y_mean(n), Hc*1000, ...
            markers(1+mod(n,length(markers))), ...
            'HandleVisibility','off', ...
            'Color', cc(n,:), ...
            'MarkerSize', 12);
    set(h, 'markerfacecolor', get(h, 'color'));
end

xlim([0 170]);
set(gca,'FontSize',18);
xlabel('Mean grain size (width) [nm]'); 
ylabel('Coercivity H_{c} [mT]'); 
hold off

%%

filename = 'TEM_morphology_Hc'; 

try
    export_fig(sprintf('../output/png/%s.png', filename), '-m4'); 
    export_fig(sprintf('../output/pdf/%s.pdf', filename)); 
catch
    print(gcf, '-dpng', sprintf('../output/png/%s.png', filename)); 
    print(gcf, '-dpdf', sprintf('../output/pdf/%s.pdf', filename)); 
end




