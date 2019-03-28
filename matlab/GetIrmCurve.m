function [M, H, Hcr] = GetIrmCurve(x, y, z, d, N)

    [xx, yy, zz, dd, NN, aa, MMr, ~, ~, ~, HHc, HHsw] = GetHysteresisParameters();
    
    idx = logical(xx==x & yy==y & zz==z & dd==d & NN==N); 
    
%     x = xx(idx); 
%     y = yy(idx); 
%     z = zz(idx); 
%     d = dd(idx); 
%     N = NN(idx); 
    a = aa(idx); 
    Mr = MMr(idx); 
    Hc = HHc(idx); 
    Hsw = abs(HHsw(idx)); 
    
    H = unique(Hsw); 
    H = [0; H(:)]; 
    M = zeros(size(H)); 
    
    for n = 1:length(H)
        idx = logical(Hsw <= H(n)); 
        M1 = -sum(Mr(~idx)) / length(a); 
        M2 =  sum(Mr(idx)) / length(a); 
        M(n) = M1 + M2; 
    end
    
    idx = find(M <= 0, 1, 'first'); 
    if isempty(idx) || idx < 2
        Hcr = []; 
    else
        Hcr = H(idx-1) - (H(idx) - H(idx-1)) ./ (M(idx) - M(idx-1)) * M(idx-1); 
    end
end