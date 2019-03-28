function [Mr, Hc, Hcr] = InterpolateDay(y, e, d)
    len = max([length(y), length(e), length(d)]); 
    if length(y) == 1
        y = y * ones(len,1); 
    end
    if length(e) == 1
        e = e * ones(len,1); 
    end
    if length(d) == 1
        d = d * ones(len,1); 
    end
    y = y(:);
    e = e(:);
    d = d(:);

    day_param_file = '../data/day_params.csv'; 
    T = readtable(day_param_file); 
    T.e = T.x ./ T.y; 

    id = logical(T.N == 10 & ...
        T.e>=0.9 & T.e<=2.0 & ...
        T.x>=20 & T.y>=20 & ...
        T.x<=140 & T.y<=100); 

    T = T(id,:);
    e(e<1) = 1;
    
    Hcr = griddatan([log10(T.d), T.y, T.e], T.Hcr, [log10(d), y, e]); 
    Hc  = griddatan([log10(T.d), T.y, T.e], T.Hc,  [log10(d), y, e]); 
    Mr  = griddatan([log10(T.d), T.y, T.e], T.Mr,  [log10(d), y, e]); 
end