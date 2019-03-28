

set(gcf, 'Position', [230   130   900   800]);
clf
set(gcf, 'Color', 'w');

p = panel(); 
p.pack(1,1);
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


filename = 'TEM_morphology_y_d'; 

try
    export_fig(sprintf('../output/png/%s.png', filename), '-m4'); 
    export_fig(sprintf('../output/pdf/%s.pdf', filename)); 
catch
    print(gcf, '-dpng', sprintf('../output/png/%s.png', filename)); 
    print(gcf, '-dpdf', sprintf('../output/pdf/%s.pdf', filename)); 
end




