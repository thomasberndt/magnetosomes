

subplot(2,4,1);


x = [40 50 60 70 80 100]; 
y = x; 
z = x; 
d = 10; 
N = 10;

M = NaN(size(x));
vort = NaN(size(x));
Hsw = NaN(size(x)); 
fanning = NaN(size(x));

for n = 1:length(x)
    try
        [alpha1, M1, vort1, Hsw1, fanning1] = GetSwitchingMode(x(n), y(n), z(n), d, N);
        M(n) = mean(M1); 
        vort(n) = mean(vort1); 
        Hsw(n) = mean(Hsw1); 
        fanning(n) = mean(fanning1); 
    catch
    end
end


gd = ~isnan(M);
plot(x(gd), M(gd), 'o-', ...
     x(gd), vort(gd)/50, 's-', ...
     x(gd), Hsw(gd)/100, 'x-', ...
     x(gd), fanning(gd)/pi, '*-');
grid on
legend('M', 'Vorticity/50', 'H_{sw}/100', 'ang/pi', 'location', 'best');
xlabel('Grain size x [nm]'); 
title('Switching mode');




xx = [50 70 100]; 

for nx = 1:length(xx)
subplot(2,4,1+nx);


    x = xx(nx); 
    y = x; 
    z = x; 
    d = [1 2 3 5 7 10 15 20 30 50 70 100]; 
    N = 10;

    M = NaN(size(x));
    vort = NaN(size(x));
    Hsw = NaN(size(x)); 
    fanning = NaN(size(x));

    for n = 1:length(d)
        try
            [alpha1, M1, vort1, Hsw1, fanning1] = GetSwitchingMode(x, y, z, d(n), N);
            M(n) = mean(M1); 
            vort(n) = mean(vort1); 
            Hsw(n) = mean(Hsw1); 
            fanning(n) = mean(fanning1); 
        catch
        end
    end


    gd = ~isnan(M);
    semilogx(d(gd), M(gd), 'o-', ...
         d(gd), vort(gd)/50, 's-', ...
         d(gd), Hsw(gd)/100, 'x-', ...
         d(gd), fanning(gd)/pi, '*-');
    grid on
    legend('M', 'Vorticity/50', 'H_{sw}/100', 'ang/pi', 'location', 'best');
    title(sprintf('Grain size %g', x));
    xlabel('Spacing [nm]');
    drawnow;
end




















subplot(2,4,5);

x = [40 50 60 70 80 100]; 
y = x; 
z = x; 
d = 10; 
N = 10;

M = NaN(size(x));
vort = NaN(size(x));
Hsw = NaN(size(x)); 
fanning = NaN(size(x));

for n = 1:length(x)
    try
        [alpha1, M1, vort1, Hsw1, fanning1] = GetRemanentMode(x(n), y(n), z(n), d, N);
        M(n) = mean(M1); 
        vort(n) = mean(vort1); 
        Hsw(n) = mean(Hsw1); 
        fanning(n) = mean(fanning1); 
    catch
    end
end


gd = ~isnan(M);
plot(x(gd), M(gd), 'o-', ...
     x(gd), vort(gd)/50, 's-', ...
     x(gd), Hsw(gd)/100, 'x-', ...
     x(gd), fanning(gd)/pi, '*-');
grid on
legend('M', 'Vorticity/50', 'H_{sw}/100', 'ang/pi', 'location', 'best');
xlabel('Grain size x [nm]'); 
title('Remanent mode');
drawnow;



xx = [50 70 100]; 

for nx = 1:length(xx)
subplot(2,4,5+nx);


    x = xx(nx); 
    y = x; 
    z = x; 
    d = [1 2 3 5 7 10 15 20 30 50 70 100]; 
    N = 10;

    M = NaN(size(x));
    vort = NaN(size(x));
    Hsw = NaN(size(x)); 
    fanning = NaN(size(x));

    for n = 1:length(d)
        try
            [alpha1, M1, vort1, Hsw1, fanning1] = GetRemanentMode(x, y, z, d(n), N);
            M(n) = mean(M1); 
            vort(n) = mean(vort1); 
            Hsw(n) = mean(Hsw1); 
            fanning(n) = mean(fanning1); 
        catch
        end
    end


    gd = ~isnan(M);
    semilogx(d(gd), M(gd), 'o-', ...
         d(gd), vort(gd)/50, 's-', ...
         d(gd), Hsw(gd)/100, 'x-', ...
         d(gd), fanning(gd)/pi, '*-');
    grid on
    legend('M', 'Vorticity/50', 'H_{sw}/100', 'ang/pi', 'location', 'best');
    title(sprintf('Grain size %g', x));
    xlabel('Spacing [nm]');
    drawnow;
end

