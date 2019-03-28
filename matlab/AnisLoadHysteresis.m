function [M, Mr, Hc, Hsw, spec] = AnisLoadHysteresis(x, y, z, d, N, H)
    M = zeros(size(H)); 
    Hc = []; 
    Hsw = []; 
    Mr = []; 
    spec = zeros(size(H)); 
        
    for a = 1:100
        [MM, ~, ~, MMr, HHc, HHsw, sspec] = AnisLoadOneHysteresis(x, y, z, d, N, a, H); 
        M(a,:) = MM;
        if ~isnan(MMr)
            Mr(a) = MMr;
            Hc(a) = HHc; 
            Hsw(a) = HHsw; 
            spec(a,:) = sspec; 
        else 
            break;
        end
    end
end