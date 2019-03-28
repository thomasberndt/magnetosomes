
[theta, phi, xang, yang, zang] = LoadRandomAngles();
alpha = theta; 
alpha(theta>90) = 180-theta(theta>90); 

[x, y, z, d, N, a, Mr, Mrx, Mry, Mrz, Hc, Hsw, Hsw_file1, Hsw_file2] = GetHysteresisParameters();

magnetosomes = [x y z d N]; 
mag = unique(magnetosomes, 'rows'); 

H_sw = Hsw_file1; 
M_sw = NaN(size(x));
vort_sw = NaN(size(x));
ang_sw = NaN(size(x));
vort_ang_sw = NaN(size(x));
M_r = NaN(size(x));
vort_r = NaN(size(x));
ang_r = NaN(size(x));
vort_ang_r = NaN(size(x));

for n = 1:length(mag)
    idx = find(ismember(magnetosomes, mag(n,:), 'rows'));
    disp([mag(n,:) round(n/length(mag)*100)]); 
    try
        [H, ad, domain, M, vort] = LoadDomainStates(mag(n,1), mag(n,2), mag(n,3), mag(n,4), mag(n,5));
        for k = 1:length(idx)
            try
            i = find(H==H_sw(idx(k)) & ad==a(idx(k))); 
            M_sw(idx(k)) = mean(sqrt(sum(M(i,:).^2, 2))); 
            vort_sw(idx(k)) = mean(sqrt(sum(vort(i,:).^2, 2)));
            if length(i) == 1
                ang_sw(idx(k)) = 0; 
                vort_ang_sw(idx(k)) = 0; 
            else
                ang_sw(idx(k)) = mean(acos(diag(M(i,:)*M(i,:)',1)./vecnorm(M(i(1:end-1),:),2,2)./vecnorm(M(i(2:end),:),2,2))); 
                vort_ang_sw(idx(k)) = mean(acos(diag(vort(i,:)*vort(i,:)',1)./vecnorm(vort(i(1:end-1),:),2,2)./vecnorm(vort(i(2:end),:),2,2)));       
            end

            i = find(H==0 & ad==a(idx(k))); 
            M_r(idx(k)) = mean(sqrt(sum(M(i,:).^2, 2))); 
            vort_r(idx(k)) = mean(sqrt(sum(vort(i,:).^2, 2)));
            if length(i) == 1
                ang_r(idx(k)) = 0; 
                vort_ang_r(idx(k)) = 0; 
            else
                ang_r(idx(k)) = mean(acos(diag(M(i,:)*M(i,:)',1)./vecnorm(M(i(1:end-1),:),2,2)./vecnorm(M(i(2:end),:),2,2))); 
                vort_ang_r(idx(k)) = mean(acos(diag(vort(i,:)*vort(i,:)',1)./vecnorm(vort(i(1:end-1),:),2,2)./vecnorm(vort(i(2:end),:),2,2))); 
            end
            catch ME
                disp(ME); 
            end
        end
    catch ME
        disp(ME); 
    end
end

writetable(table(x, y, z, d, N, a, M_r, vort_r, ang_r, vort_ang_r, ...
        H_sw, M_sw, vort_sw, ang_sw, vort_ang_sw), '../data/switching_params.csv'); 
