function [M, vorticity] = GetDomainStatesForField(x, y, z, d, N, a, H)

    [r, dd, NN, HH, aa, domain, MM, vort] = LoadDomainStates();
    
    idx = logical((r(:,1) == x) & (r(:,2) == y) & (r(:,3) == z) & ...
                  (dd == d) & (NN == N) & (aa == a)); 
    
    if any(idx)
        HH = HH(idx); 
        domain = domain(idx); 
        MM = MM(idx,:); 
        vort = vort(idx,:); 

        uH = unique(HH); 

        M = zeros(N, 3); 
        vorticity = zeros(N, 3); 
        
        h = find(uH > H, 1, 'first') - 1;
        for n = 1:N
            M(n,:) = MM(HH==uH(h) & domain==n, :);
            vorticity(n,:) = vort(HH==uH(h) & domain==n, :);
        end
    else 
        M = [];
        vorticity = [];
    end
end