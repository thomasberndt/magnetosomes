
[x, y, z, d, N, a] = GetMagnetosomeParameters();
    
for n = 1:length(x)
    filename_fine = CreateMissingStepsScripts(x(n), y(n), z(n), d(n), N(n));
    if ~isempty(filename_fine)
        CreateMerrillBatch(filename_fine); 
    end
end