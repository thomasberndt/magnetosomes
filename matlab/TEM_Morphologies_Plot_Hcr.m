

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


[pol, S] = polyfit(log(T.y_mean), log(T.d_mean), 1); 
w = linspace(20,180,1000); 
[Y,DELTA] = polyval(pol, log(w), S); 
h1 = patch([w w(end:-1:1)], [exp(Y+DELTA), exp(Y(end:-1:1)-DELTA(end:-1:1))], ...
     0.8*[1 1 1], ...
     'EdgeColor', 'none', ...
     'Displayname', 'fit stdev'); 
hold on
h2 = plot(w, exp(Y), '-', ...
    'Displayname', 'log-fit', ...
    'Color', 0*[1 1 1]); 
 
h = []; 
for n = 1:height(T)
    
    h(n) = errorbar(T.y_mean(n), T.d_mean(n), ...
             -T.d_std(n), T.d_std(n), ...
             -T.y_std(n), T.y_std(n), ...
             markers(1+mod(n,length(markers))), ...
            'DisplayName', T.strains{n}, ...
            'Color', cc(n,:), ...
            'MarkerSize', 12, ...
            'CapSize', 0);
         
    set(h(n), 'markerfacecolor', get(h(n), 'color'));
    hold on
end

xlim([0 170]); 
ylim([0 15]); 
hlegend = legend([h h1 h2]);
hlegend.NumColumns=2;
legend boxoff

hold off

xlabel('Mean grain size (width) [nm]'); 
ylabel('Mean intra-chain spacing [nm]'); 

text(-15, 15, 'a)', 'FontSize',18); 
set(gca,'FontSize',18);
drawnow

%%

p(2, 1).select(); 
w = linspace(30,180,100); 

[Mr1, Hc1, Hcr1] = InterpolateDay(w, 1.0, exp(polyval(pol, log(w)))); 
[Mr2, Hc2, Hcr2] = InterpolateDay(w, 1.1, exp(polyval(pol, log(w)))); 
Hcr3 = [Hcr1' Hcr2(end:-1:1)']; 
ww = [w w(end:-1:1)];
good = ~isnan(Hcr3); 
h1 = patch(ww(good), Hcr3(good)*1000, [.75 .75 1], ...
        'EdgeColor', 'none');
hold on


[Mr1, Hc1, Hcr1] = InterpolateDay(w, 1.2, exp(polyval(pol, log(w)))); 
[Mr2, Hc2, Hcr2] = InterpolateDay(w, 1.4, exp(polyval(pol, log(w)))); 
Hcr3 = [Hcr1' Hcr2(end:-1:1)']; 
ww = [w w(end:-1:1)];
good = ~isnan(Hcr3); 
h2 = patch(ww(good), Hcr3(good)*1000, [.75 1 .75], ...
        'EdgeColor', 'none');

e = 1.05; 
[Mr, Hc, Hcr] = InterpolateDay(w, e, exp(polyval(pol, log(w)))); 
h1a = plot(w, Hcr*1000, '-', ...
         'DisplayName', sprintf('H_c (e=%.1f)', e), ...
         'Color', [0 0 .5]); 
e = 1.3; 
[Mr, Hc, Hcr] = InterpolateDay(w, e, exp(polyval(pol, log(w)))); 
h2a = plot(w, Hcr*1000, '-', ...
         'DisplayName', sprintf('H_c (e=%.1f)', e), ...
         'Color', [0 .5 0]); 

% for e = 1:0.1:1.4
%     [Mr, Hc, Hcr] = InterpolateDay(w, e, exp(polyval(pol, log(w)))); 
%     h = plot(w, Hcr, '-', ...
%              'DisplayName', sprintf('H_c (e=%.1f)', e), ...
%              'Color', (1.4-e)*[1 1 1]); 
%     hold on
% end
legend([h2 h2a h1 h1a], ...
    'Elongated (e=1.2-1.4)', ...
    'Elongated (e=1.3)', ...
    'Near equant (e=1.0-1.1)', ...
    'Near equant (e=1.05)'); 

for n = 1:height(T)
    [Mr, Hc, Hcr] = InterpolateDay(T.y_mean(n), T.e(n), T.d_mean(n)); 
    h = plot(T.y_mean(n), Hcr*1000, ...
            markers(1+mod(n,length(markers))), ...
            'HandleVisibility','off', ...
            'Color', cc(n,:), ...
            'MarkerSize', 12);
    set(h, 'markerfacecolor', get(h, 'color'));
end

xlim([0 170]);
text(-15, 90, 'b)', 'FontSize',18); 
set(gca,'FontSize',18);
xlabel('Mean grain size (width) [nm]'); 
ylabel('Coercivity of remanence H_{cr} [mT]'); 
hold off

%%

filename = 'TEM_morphology_Hcr'; 

try
    export_fig(sprintf('../output/png/%s.png', filename), '-m4'); 
    export_fig(sprintf('../output/pdf/%s.pdf', filename)); 
catch
    print(gcf, '-dpng', sprintf('../output/png/%s.png', filename)); 
    print(gcf, '-dpdf', sprintf('../output/pdf/%s.pdf', filename)); 
end




