
letters = 'abcdefghijklmn'; 
ee = 1.0; 
yy = [50 50 50 100 100 100];
dd = [1 10 100 1 10 100];

set(gcf, 'Position', [48 48 500/0.95 500]);
clf
set(gcf, 'Color', 'w');

p = panel(); 
p.pack(1, 1);
p.de.margin = 3;
p.de.marginleft = 16;
p.de.marginright = 16;

Num = ceil(length(yy)/2);

for n = 1:length(yy)
    p(mod(n-1, 3)+1, ceil(n/Num)).select();
    
    [alpha, M, vort, Hsw, fanning] = ...
            GetSwitchingMode(ee*yy(n), yy(n), yy(n), dd(n), 10);
%     [alpha_r, M_r, vort_r, ~, fanning_r] = ...
%             GetRemanentMode(ee*yy(n), yy(n), yy(n), dd(n), 10);

    h = plot(alpha, Hsw/300, 'o-', ...
             alpha, vort/100, 'p-', ...
             alpha, fanning/pi, 'v-');

    for k = 1:length(h)
         set(h(k), 'MarkerFaceColor', get(h(k), 'Color')); 
    end

    grid on
    if mod(n, 3) == 0
        xlabel('Angle'); 
        xticks(10:10:80); 
        xticklabels({'Parallel', '20', '30', '40', '50', ...
            '60', '70', 'Perpendic.'}); 
    else
        xticklabels([]); 
    end
    ylabel('Arbitrary units'); 
    t = title(sprintf('%s) Grain size %g nm', letters(n), yy(n)), 'units', 'normalized', 'position', [0.5 0.9 0]); 
    t.FontSize = 12; 
%     ylim([0 150]);
%     yticks(0:10:150); 

%     if n == 1
        l = legend('Coercivity', ...
               'Vorticity', ...
               'Fanning', 'location', 'best');
%         set(l, 'Position', get(l, 'Position') - [0 0.03 0 0]);
%     end
    
    drawnow;
end





if onecolumn
    filename = 'SwitchingVsAngle_2'; 
else
    filename = 'SwitchingVsAngle'; 
end
try
    export_fig(sprintf('../output/png/%s.png', filename), '-m4'); 
    export_fig(sprintf('../output/pdf/%s.pdf', filename)); 
catch
    print(gcf, '-dpng', sprintf('../output/png/%s.png', filename)); 
    print(gcf, '-dpdf', sprintf('../output/pdf/%s.pdf', filename)); 
end


