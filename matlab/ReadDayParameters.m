function [x, y, z, d, N, Mr, Hc, Hcr] = ReadDayParameters()

    day_param_file = '../data/day_params.csv'; 

    T = readtable(day_param_file); 

    x = T.x; 
    y = T.y; 
    z = T.z; 
    d = T.d; 
    N = T.N; 
    Mr = T.Mr; 
    Hc = T.Hc; 
    Hcr = T.Hcr; 
    
    if nargout == 1
        x = [x, y, z, d, N, Mr, Hc, Hcr];
    end
    
end