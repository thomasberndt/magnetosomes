
H = linspace(-0.3, 0.3, 6001);    
[x, y, z, d, N, a] = GetMagnetosomeParameters(); 
x(a<100) = [];
y(a<100) = [];
z(a<100) = [];
d(a<100) = [];
N(a<100) = [];

day_param_file = '../data/day_params.csv'; 

Hcr = NaN(size(x)); 
Hc = NaN(size(x)); 
Mr = NaN(size(x)); 

parfor n = 1:length(x)
    fprintf('Analysing (%g/%g) hysteresis for %g %g %g %g %g \n', ...
            n, length(x), x(n), y(n), z(n), d(n), N(n)); 
                    
    [~, ~, Hcr1] = GetIrmCurve(x(n), y(n), z(n), d(n), N(n));
    if ~isempty(Hcr1)
        Hcr(n) = Hcr1; 
    end
    
    [~, Hc1, Mr1] = LoadAverageHysteresis(x(n), y(n), z(n), d(n), N(n), H);
    if ~isempty(Hc1)
        Hc(n) = Hc1; 
    end
    Mr(n) = Mr1; 
end


writetable(table(x, y, z, d, N, Mr, Hc, Hcr), day_param_file); 
