function [x, y, z, d, N, a, Mr, Mrx, Mry, Mrz, Hc, Hsw, Hsw_file1, Hsw_file2] = AnisGetHysteresisParameters()

    hys_param_file = '../data/anis_hys_params.csv'; 
    
    if exist(hys_param_file, 'file')
        C = csvread(hys_param_file, 1); 

        x = C(:,1);
        y = C(:,2); 
        z = C(:,3); 
        d = C(:,4); 
        N = C(:,5); 
        a = C(:,6); 
        Mr = C(:,7); 
        Mrx = C(:,8); 
        Mry = C(:,9); 
        Mrz = C(:,10); 
        Hc = C(:,11); 
        Hsw = C(:,12); 
        Hsw_file1 = C(:,13); 
        Hsw_file2 = C(:,14); 
    else
        x = [];
        y = []; 
        z = []; 
        d = []; 
        N = []; 
        a = []; 
        Mr = []; 
        Mrx = []; 
        Mry = []; 
        Mrz = []; 
        Hc = []; 
        Hsw = []; 
        Hsw_file1 = []; 
        Hsw_file2 = []; 
    end
    
    if nargout == 1
        x = [x, y, z, d, N, a, Mr, Mrx, Mry, Mrz, Hc, Hsw, Hsw_file1, Hsw_file2];
    end
end