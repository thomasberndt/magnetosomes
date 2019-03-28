function [H, M, vorticity] = GetDomainStates(x, y, z, d, N, a)

    [r, dd, NN, H, aa, domain, MM, vort] = LoadDomainStates();
    
    idx = logical((r(:,1) == x) & (r(:,2) == y) & (r(:,3) == z) & ...
                  (dd == d) & (NN == N) & (aa == a)); 
    
    H = H(idx); 
    domain = domain(idx); 
    MM = MM(idx,:); 
    vort = vort(idx,:); 
        
    [uH, ia, ic] = unique(H); 
    
    M = zeros(N, 3, length(uH)); 
    vorticity = zeros(N, 3, length(uH)); 
    for h = 1:length(uH)
        for n = 1:N
            M(n,:,h) = MM(H==uH(h) & domain==n, :);
            vorticity(n,:,h) = vort(H==uH(h) & domain==n, :);
        end
    end
    
    H = uH; 
end