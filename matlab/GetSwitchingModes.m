function [x, y, z, d, N, a, M_r, vort_r, ang_r, vort_ang_r, ...
        H_sw, M_sw, vort_sw, ang_sw, vort_ang_sw] = GetSwitchingModes()
    C = csvread('../data/switching_params.csv', 1, 0); 
    if nargout > 1
        x = C(:,1); 
        y = C(:,2); 
        z = C(:,3); 
        d = C(:,4); 
        N = C(:,5); 
        a = C(:,6); 
        M_r = C(:,7); 
        vort_r = C(:,8); 
        ang_r = C(:,9); 
        vort_ang_r = C(:,10); 
        H_sw = C(:,11); 
        M_sw = C(:,12); 
        vort_sw = C(:,13); 
        ang_sw = C(:,14); 
        vort_ang_sw = C(:,15); 
    else 
        x = C; 
    end
end