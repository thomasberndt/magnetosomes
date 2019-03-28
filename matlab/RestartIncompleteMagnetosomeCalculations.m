function RestartIncompleteMagnetosomeCalculations()
    batch_path = 'D:/magnetosomes/batch'; 
    [x, y, z, d, N, a] = GetIncompleteMagnetosomeParameters(); 
    for n = 1:length(x)
        batch_file = sprintf('%s/%gx_%gy_%gz_%gd_%gN.bat &', ...
            batch_path, round(x(n)), round(y(n)), round(z(n)), round(d(n)), round(N(n))); 
        system(['D: && cd ' batch_path ' && ' batch_file]);
    end
end