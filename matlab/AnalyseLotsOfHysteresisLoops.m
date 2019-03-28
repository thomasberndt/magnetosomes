

H = linspace(-0.3, 0.3, 6001);     

[xx, yy, zz, dd, NN, aa] = GetMagnetosomeParameters(); 

hys_param_file = '../data/hys_params.csv'; 



magnetosomes = GetMagnetosomeParameters(); 
[x, y, z, d, N, a, Mr, Mrx, Mry, Mrz, Hc, Hsw, Hsw_file1, Hsw_file2] = GetHysteresisParameters();

k = length(x); 
for n = 1:length(xx)
    for an = 1:aa
        if ~any(x==xx(n) & y==yy(n) & z==zz(n) & ...
                d==dd(n) & N==NN(n) & a==an)
            if k==0 || xx(n)~=x(k) || yy(n)~=y(k) || zz(n)~=z(k) || ...
                        dd(n)~=d(k) || NN(n)~=N(k)
                fprintf('Analysing (%g/%g) hysteresis for %g %g %g %g %g \n', ...
                        n, length(xx), xx(n), yy(n), zz(n), dd(n), NN(n)); 
            end
            [~,~,~, MMr, HHc, HHsw, ~, HHsw_file1, HHsw_file2, Mr_vec] = LoadOneHysteresis(xx(n), yy(n), zz(n), dd(n), NN(n), an, H);
            if ~isnan(MMr)
                k = k + 1; 
                x(k) = xx(n); 
                y(k) = yy(n);
                z(k) = zz(n); 
                d(k) = dd(n); 
                N(k) = NN(n); 
                a(k) = an; 
                Mr(k) = MMr; 
                Mrx(k) = Mr_vec(1); 
                Mry(k) = Mr_vec(2); 
                Mrz(k) = Mr_vec(3); 
                Hc(k) = HHc; 
                Hsw(k) = HHsw; 
                Hsw_file1(k) = HHsw_file1; 
                Hsw_file2(k) = HHsw_file2; 
            end
        end
    end
end

x = x(:); 
y = y(:);
z = z(:);
d = d(:); 
N = N(:);
a = a(:);
Mr = Mr(:);
Mrx = Mrx(:);
Mry = Mry(:);
Mrz = Mrz(:);
Hc = Hc(:);
Hsw = Hsw(:);
Hsw_file1 = Hsw_file1(:); 
Hsw_file2 = Hsw_file2(:); 


writetable(table(x, y, z, d, N, a, Mr, Mrx, Mry, Mrz, Hc, Hsw, Hsw_file1, Hsw_file2), hys_param_file); 
