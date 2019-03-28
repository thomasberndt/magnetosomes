function [x, y, z, d, N, M_r, vort_r, ang_r, vort_ang_r, ...
        H_sw, M_sw, vort_sw, ang_sw, vort_ang_sw] = AnisGetMeanSwitchingModes()
    C = csvread('../data/anis_mean_switching_params.csv', 1, 0); 
    if nargout > 1
        x = C(:,1); 
        y = C(:,2); 
        z = C(:,3); 
        d = C(:,4); 
        N = C(:,5); 
        M_r = C(:,6); 
        vort_r = C(:,7); 
        ang_r = C(:,8); 
        vort_ang_r = C(:,9); 
        H_sw = C(:,10); 
        M_sw = C(:,11); 
        vort_sw = C(:,12); 
        ang_sw = C(:,13); 
        vort_ang_sw = C(:,14); 
    else 
        x = C; 
    end
end