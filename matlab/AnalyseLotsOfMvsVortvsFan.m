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

[xr, yr, zr, dr, Nr, M_r, vort_r, ang_r, vort_ang_r, ...
        H_sw, M_sw, vort_sw, ang_sw, vort_ang_sw] = GetMeanSwitchingModes();

er = xr ./ yr; 


%%

letters = 'abcdefghijklmn'; 
Ms0 = 480e3; 

set(gcf, 'Position', [48 48 500/0.95 500]);
clf
set(gcf, 'Color', 'w');

p = panel(); 
p.pack(1, 1);
p.de.margin = 3;
p.de.marginleft = 16;
p.de.marginright = 16;

Num = ceil(length(yy)/2);

p(1, 1).select();

[dd0, Mr0] = GetMagnetosomeLine(Mrx_mean, y, e, d, N, 40, 1.0, 10); 
[dd1, Mr1] = GetMagnetosomeLine(Mrx_mean, y, e, d, N, 40, 1.4, 10); 
[dd2, Mr2] = GetMagnetosomeLine(Mrx_mean, y, e, d, N, 70, 1.0, 10); 
[dd3, Mr3] = GetMagnetosomeLine(Mrx_mean, y, e, d, N, 70, 1.4, 10); 
[dd4, Mr4] = GetMagnetosomeLine(Mrx_mean, y, e, d, N, 100, 1.0, 10); 
[dd5, Mr5] = GetMagnetosomeLine(Mrx_mean, y, e, d, N, 100, 1.4, 10); 

h = plot(dd0, Mr0, '-', ...
         dd2, Mr2, '-', ...
         dd3, Mr3, '-', ...
         dd4, Mr4, '-'); 
% h(1).Color = [  0    0.4470    0.7410];
% h(2).Color = [  0.4660    0.6740    0.1880];
for k = 1:length(h)
%      set(h(k), 'MarkerFaceColor', 'w');%get(h(k), 'Color')); 
     set(h(k), 'LineWidth', 2);
end

hh = h; 

hold on
vort_norm = 50; 
[dd0, Hsw0] = GetMagnetosomeLine(vort_r/vort_norm, yr, er, dr, Nr, 40, 1.0, 10); 
[dd1, Hsw1] = GetMagnetosomeLine(vort_r/vort_norm, yr, er, dr, Nr, 40, 1.4, 10); 
[dd2, Hsw2] = GetMagnetosomeLine(vort_r/vort_norm, yr, er, dr, Nr, 70, 1.0, 10); 
[dd3, Hsw3] = GetMagnetosomeLine(vort_r/vort_norm, yr, er, dr, Nr, 70, 1.4, 10); 
[dd4, Hsw4] = GetMagnetosomeLine(vort_r/vort_norm, yr, er, dr, Nr, 100, 1.0, 10); 
[dd5, Hsw5] = GetMagnetosomeLine(vort_r/vort_norm, yr, er, dr, Nr, 100, 1.4, 10); 

h = plot(dd2, Hsw2, '-*', ...
         dd3, Hsw3, '-*', ...
         dd4, Hsw4, '-*'); 
     
% h(1).Color = [  0    0.4470    0.7410];
% h(2).Color = [  0.4660    0.6740    0.1880];
hold off

for k = 1:length(h)
    set(h(k), 'Color', get(hh(k+1), 'Color')); 
    set(h(k), 'MarkerFaceColor', 'w');%get(h(k), 'Color')); 
    set(h(k), 'MarkerSize', 10);
%     set(h(k), 'LineWidth', 2);
end

hold on
ang_norm = 2;
[dd0, Hsw0] = GetMagnetosomeLine(ang_r/ang_norm, yr, er, dr, Nr, 40, 1.0, 10); 
[dd1, Hsw1] = GetMagnetosomeLine(ang_r/ang_norm, yr, er, dr, Nr, 40, 1.4, 10); 
[dd2, Hsw2] = GetMagnetosomeLine(ang_r/ang_norm, yr, er, dr, Nr, 70, 1.0, 10); 
[dd3, Hsw3] = GetMagnetosomeLine(ang_r/ang_norm, yr, er, dr, Nr, 70, 1.4, 10); 
[dd4, Hsw4] = GetMagnetosomeLine(ang_r/ang_norm, yr, er, dr, Nr, 100, 1.0, 10); 
[dd5, Hsw5] = GetMagnetosomeLine(ang_r/ang_norm, yr, er, dr, Nr, 100, 1.4, 10); 

h2 = plot(dd0, Hsw0, '-^'); 
% h(1).Color = [  0    0.4470    0.7410];
% h(2).Color = [  0.4660    0.6740    0.1880];
hold off

for k = 1:length(h2)
    set(h2(k), 'Color', get(hh(k), 'Color')); 
    set(h2(k), 'MarkerFaceColor', 'w');%get(h2(k), 'Color')); 
    set(h2(k), 'MarkerSize', 10);
%      set(h2(k), 'LineWidth', 2);
end

set(gca, 'XScale', 'log');
grid on
if mod(n, 3) == 0
    xlabel('Spacing [nm]'); 
else
    xticklabels([]); 
end
ylabel('Remanent Magnetization M_r [Am^2]'); 
% t = title(sprintf('%s) Grain size %g nm', letters(n), yy(n)), 'units', 'normalized', 'position', [0.5 0.9 0]); 
% t.FontSize = 12; 
ylim([0 1]);
yticks(0:0.1:1.0); 


    

text(42, 0.975, '70 nm (e=1.4)', 'Rotation', -26);
text(25, 0.95, '70 nm (e=1.0)', 'Rotation', -35);
text(17, 0.90, '40 nm (e=1.0)', 'Rotation', -44);
text(10, 0.82, '100 nm (e=1.0)', 'Rotation', -40);

text(8, 0.34, '100 nm (e=1.0)', 'Rotation', 37);
text(11, 0.16, '40 nm (e=1.0)', 'Rotation', 64);
text(23, 0.16, '70 nm (e=1.0)', 'Rotation', 72);
text(30, 0.12, '70 nm (e=1.0)', 'Rotation', 68);

hold on
hleg = plot([Inf Inf], [Inf Inf], '-k', ...
            [Inf Inf], [Inf Inf], '-^k', ...
            [Inf Inf], [Inf Inf], '-*k'); 
hold off
set(hleg(1), 'LineWidth', 2);
set(hleg(2), 'MarkerFaceColor', 'w'); 
set(hleg(2), 'MarkerSize', 10);
set(hleg(3), 'MarkerFaceColor', 'w'); 
set(hleg(3), 'MarkerSize', 10);
% legend([hh; h2; h], '40 nm', '70 nm (e=1.0)', '70 nm (e=1.4)', '100 nm', ...
%     '40 nm Fanning', '70 nm (e=1.0) Vorticity', '70 nm (e=1.4) Vorticity', '100 nm Vorticity', ...
%     'location', 'west'); 
legend(hleg, 'Remanent Magnetization', ...
             'Fanning (arb. units)', ...
             'Vorticity (arb. units)', ...
             'location', 'west'); 
drawnow;

%%

filename = 'MVortFan'; 
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


