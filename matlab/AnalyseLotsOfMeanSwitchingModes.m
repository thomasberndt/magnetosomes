

magnetosomes = GetMagnetosomeParameters(); 

x = magnetosomes(:,1);
y = magnetosomes(:,2);
z = magnetosomes(:,3);
d = magnetosomes(:,4);
N = magnetosomes(:,5);
e = x ./ y; 

M_r  = NaN * zeros(length(x),1);
vort_r  = NaN * zeros(length(x),1);
ang_r  = NaN * zeros(length(x),1);
vort_ang_r  = NaN * zeros(length(x),1);

H_sw  = NaN * zeros(length(x),1);
M_sw  = NaN * zeros(length(x),1);
vort_sw  = NaN * zeros(length(x),1);
ang_sw  = NaN * zeros(length(x),1);
vort_ang_sw  = NaN * zeros(length(x),1);

modes = GetSwitchingModes(); 

for n = 1:length(x)    
    idx = ismember(modes(:,1:5), magnetosomes(n,1:5), 'rows'); 
    M_r(n) = mean(modes(idx,7));
    vort_r(n) = mean(modes(idx,8));
    ang_r(n) = mean(modes(idx,9));
    vort_ang_r(n) = mean(modes(idx,10));
    H_sw(n) = mean(modes(idx,11));
    M_sw(n) = mean(modes(idx,12));
    vort_sw(n) = mean(modes(idx,13));
    ang_sw(n) = mean(modes(idx,14));
    vort_ang_sw(n) = mean(modes(idx,15));
end


writetable(table(x, y, z, d, N, ...
    M_r, vort_r, ang_r, vort_ang_r, ...
    H_sw, M_sw, vort_sw, ang_sw, vort_ang_sw), '../data/mean_switching_params.csv'); 


