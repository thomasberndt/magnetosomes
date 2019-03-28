function [Mavg, Hc, Mr] = LoadAverageHysteresis(x, y, z, d, N, H)
    M = LoadHysteresis(x, y, z, d, N, H);
    n = size(M,1);
    
    Mavg = sum(M) ./ n;
    
    idx = find(Mavg >= 0, 1, 'first');
    if isempty(idx) || idx < 2
        Hc = [];
    else
        Hc = H(idx); 
    end
    
    idx = find(H>=0, 1, 'first'); 
    Mr = -Mavg(idx); 
end