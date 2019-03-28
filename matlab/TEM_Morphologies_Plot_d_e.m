

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

T.e_std = sqrt(T.x_std.^2./(T.y_mean.^2) + ...
               T.x_mean.^2./T.y_mean.^4.*T.y_std.^2); 

for n = 1:height(T)
    
    h = errorbar(T.d_mean(n), T.e(n), ...
             -T.e_std(n), T.e_std(n), ...
             -T.d_std(n), T.d_std(n), ...
             markers(1+mod(n,length(markers))), ...
            'DisplayName', T.strains{n}, ...
            'Color', cc(n,:), ...
            'MarkerSize', 12, ...
            'CapSize', 0);
         
    set(h, 'markerfacecolor', get(h, 'color'));
    hold on
end

pol = polyfit(log10(T.d_mean), log(T.e), 1); 
w = linspace(0, 1.1, 1000); 
plot(10.^w, exp(polyval(pol, w)), '-', ...
    'Displayname', 'log-fit', ...
    'Color', [.5 .5 .5]); 

xlim([0 15]); 
ylim([0.9 2]); 
hlegend = legend;
hlegend.NumColumns=2;
legend boxoff

hold off

xlabel('Mean intra-chain spacing [nm]'); 
ylabel('Mean elongation'); 

set(gca,'FontSize',18);



filename = 'TEM_morphology_d_e'; 

try
    export_fig(sprintf('../output/png/%s.png', filename), '-m4'); 
    export_fig(sprintf('../output/pdf/%s.pdf', filename)); 
catch
    print(gcf, '-dpng', sprintf('../output/png/%s.png', filename)); 
    print(gcf, '-dpdf', sprintf('../output/pdf/%s.pdf', filename)); 
end




