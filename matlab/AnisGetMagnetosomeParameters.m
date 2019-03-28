function [x, y, z, d, N, a] = AnisGetMagnetosomeParameters()

    domainfiles = dir('D:/magnetosomes/hysteresis_anis/*.hyst'); 


    x = []; 
    y = []; 
    z = []; 
    d = []; 
    N = []; 
    a = []; 

    k = 0;

    for n = 1:length(domainfiles)
        [xx, yy, zz, dd, NN] = ExtractParametersFromFilename(domainfiles(n).name); 
        idx = find(x == xx & y == yy & z == zz & d == dd & N == NN, 1);
        if isempty(idx)
            k = k + 1;
            x(k) = xx; 
            y(k) = yy;
            z(k) = zz; 
            d(k) = dd;
            N(k) = NN;
            a(k) = 1; 
        else
            a(idx) = a(idx) + 1;
        end
    end
    
    
    parameters = [x' y' z' d' N' a']; 
    parameters = sortrows(parameters); 
    x = parameters(:,1);
    y = parameters(:,2);
    z = parameters(:,3);
    d = parameters(:,4);
    N = parameters(:,5);
    a = parameters(:,6);
    
    if nargout <= 1
        x = parameters; 
    end
    
end