
clf
set(gcf, 'Color', 'w');

T = readtable('../TEM/TEM_morphologies.csv'); 
cc=hsv(max(T.Strain_id))*0.7;
markers = 'osd^v><'; 

for n = 1:max(T.Strain_id)
    id = (T.Strain_id == n);
    strain = T.Strain_name(id); 
	h = plot(T.Width_mean(id), T.Spacing_mean(id), markers(1+mod(n,length(markers))), ...
        'DisplayName', strain{1}, ...
        'Color', cc(n,:)); 
    set(h, 'markerfacecolor', get(h, 'color'));
    hold on
end

p = polyfit(log(T.Width_mean), log(T.Spacing_mean), 1); 
w = linspace(20,180,1000); 
plot(w, exp(polyval(p, log(w))), '-', ...
    'Displayname', 'log-fit', ...
    'Color', [.5 .5 .5]); 

legend 
hold off

xlabel('Mean grain size (width) [nm]'); 
ylabel('Mean intra-chain spacing [nm]'); 

filename = 'TEM_morphology'; 

try
    export_fig(sprintf('../output/png/%s.png', filename), '-m4'); 
    export_fig(sprintf('../output/pdf/%s.pdf', filename)); 
catch
    print(gcf, '-dpng', sprintf('../output/png/%s.png', filename)); 
    print(gcf, '-dpdf', sprintf('../output/pdf/%s.pdf', filename)); 
end




