
[alpha, M, vort, Hsw, fanning] = GetSwitchingMode(100,100,100, 10, 10);

plot(alpha, M, 'o-', ...
     alpha, vort/100, 's-', ...
     alpha, Hsw/300, 'x-', ...
     alpha, fanning/pi, '*-');
legend('M', 'Vorticity/100', 'H_{sw}/300', 'ang/pi', 'location', 'best');
grid on
hold on
xlabel('Angle theta')
