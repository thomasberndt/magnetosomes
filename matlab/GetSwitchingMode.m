function [alpha, M, vort, Hsw, fanning] = GetSwitchingMode(x, y, z, d, N)


    [theta, phi, xang, yang, zang] = LoadRandomAngles();
    alpha = theta; 
    alpha(theta>90) = 180-theta(theta>90); 
    
    [xh, yh, zh, dh, Nh, ah, Mr, Mrx, Mry, Mrz, Hc, Hsw, Hsw_file1, Hsw_file2] = GetHysteresisParameters();
    [H, a, domain, M, vort] = LoadDomainStates(x, y, z, d, N);
    
    %%
    
    M_tot = NaN(100,1);
    vort_tot = NaN(100,1);
    Hsw_tot = NaN(100,1);
    ang_tot = NaN(100,1);
    vort_ang_tot = NaN(100,1);
    aa = 1:100; 
    
    for n = 1:length(aa)
        idx = logical(xh==x & yh==y & zh==z & dh==d & Nh==N & ah==aa(n));
        Hsw_tot(n) = Hsw_file1(idx); 
        i = find(H==Hsw_tot(n) & a==aa(n)); 
        M_tot(n) = mean(sqrt(sum(M(i,:).^2, 2))); 
        vort_tot(n) = mean(sqrt(sum(vort(i,:).^2, 2)));
        ang_tot(n) = mean(acos(diag(M(i,:)*M(i,:)',1))); 
        vort_ang_tot(n) = mean(acos(diag(vort(i,:)*vort(i,:)',1))); 
    end
    
    edges = [0 10 20 30:5:90]; 
    centerpoint = (edges(2:end)+edges(1:end-1))/2; 
    [~, ~, i] = histcounts(alpha, edges);
    M_hist = NaN(size(centerpoint)); 
    vort_hist = NaN(size(centerpoint)); 
    Hsw_hist = NaN(size(centerpoint)); 
    ang_hist = NaN(size(centerpoint)); 
    phi_hist = NaN(size(centerpoint)); 
    for n = 1:length(centerpoint)
        M_hist(n) = mean(M_tot(i==n)); 
        vort_hist(n) = mean(vort_tot(i==n)); 
        Hsw_hist(n) = mean(Hsw_tot(i==n)); 
        ang_hist(n) = mean(ang_tot(i==n)); 
    end
        
    alpha = centerpoint; 
    M = M_hist; 
    vort = vort_hist; 
    Hsw = Hsw_hist; 
    fanning = ang_hist; 
    
end