function [H, a, Mr, Hc, Hsw] = IdentifyMissingSteps(x, y, z, d, N)
    hys_file = sprintf('../data/hys_param_%dx_%dy_%dz_%dd_%dN.csv', ...
            round(x), round(y), round(z), round(d), round(N)); 
    try
        hys = csvread(hys_file); 
        a = hys(:,1); 
        Mr = hys(:,2);
        Hc = hys(:,3); 
        Hsw = hys(:,4); 
        H = zeros(length(a), 2); 

        for k = 1:length(a)
            H1 = GetHysteresisSteps(x, y, z, d, N, a(k));
            idx = find(H1 > Hsw(k), 1); 
            H(k,1) = H1(idx-1); 
            H(k,2) = H1(idx);
        end
    catch
        H = []; 
        a = []; 
        Mr = []; 
        Hc = []; 
        Hsw = [];
    end
end