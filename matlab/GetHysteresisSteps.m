function H = GetHysteresisSteps(x, y, z, d, N, a)
    magnetosome = sprintf('%dx_%dy_%dz_%dd_%dN', x, y, z, d, N); 
    domainfiles = dir(sprintf(...
        'D:/magnetosomes/domainstates/%s/%s_*_mT_%da.dat', ...
        magnetosome, magnetosome, a)); 
    H = zeros(length(domainfiles), 1);
    for h = 1:length(H)
        C = textscan(domainfiles(h).name, ...
            [magnetosome '_%d_mT_' num2str(a) 'a.dat']); 
        H(h) = double(C{1}) / 1000; 
    end
    H = sort(H);
end