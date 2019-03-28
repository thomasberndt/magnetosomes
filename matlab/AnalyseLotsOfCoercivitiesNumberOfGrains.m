

magnetosomes = GetMagnetosomeParameters(); 
hysteresis = GetHysteresisParameters(); 
magnetosomes = magnetosomes(magnetosomes(:,1) >= magnetosomes(:,2),:); 
magnetosomes = magnetosomes(magnetosomes(:,2) <= 100,:); 
magnetosomes = magnetosomes(magnetosomes(:,6) >= 100,:); 

Mr_mean  = NaN * zeros(length(magnetosomes(:,1)),1);
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
    Hc = hysteresis(idx, 11) * 1000; 
    Hsw = hysteresis(idx, 12) * 1000; 

    Mr_mean(n) = mean(Mr); 
    Hsw_mean(n) = mean(Hsw); 
    Hsw_std(n) = std(Hsw); 
end


letters = 'abcdefghijklmn'; 
ee = [1.0 1.1 1.2 1.3 1.4 2]; 
yy = [40 50 60 70 80 100]; 


%%


figure(1)

set(gcf, 'Position', [48 48 650/0.95 550]);
clf
set(gcf, 'Color', 'w');
p = panel(); 
p.pack(1,1);
p.margintop = 10;
p.marginleft = 20;
p.marginbottom = 20;
p.de.margin = 3;
p.de.marginleft = 16;
p.de.marginright = 16;
p(1,1).select(); 


h = plot(N(e == 1 & d == 10 & y == 40), Hsw_mean(e == 1 & d == 10 & y == 40), '-s', ...
         N(e == 1 & d == 10 & y == 50), Hsw_mean(e == 1 & d == 10 & y == 50), '-d', ...
         N(e == 1 & d == 10 & y ==100), Hsw_mean(e == 1 & d == 10 & y ==100), '-o'); 

for n = 1:length(h)
	set(h(n), 'markerfacecolor', get(h(n), 'color'));
	set(h(n), 'markersize', 12);
	set(h(n), 'linewidth', 2);
end
     
xlabel('Number of grains'); 
ylabel('Switching field H_{sw} [mT]'); 
grid on
grid minor
title('Chain length'); 
set(gca, 'fontsize', 14);
legend(h, '40 nm', '50 nm', '100 nm', 'location', 'southeast'); 
drawnow;


%%
filename = 'ChainLength'; 

try
    export_fig(sprintf('../output/png/%s.png', filename), '-m4'); 
    export_fig(sprintf('../output/pdf/%s.pdf', filename)); 
catch
    print(gcf, '-dpng', sprintf('../output/png/%s.png', filename)); 
    print(gcf, '-dpdf', sprintf('../output/pdf/%s.pdf', filename)); 
end

