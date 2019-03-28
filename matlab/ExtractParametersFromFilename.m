function [x, y, z, d, N, a, H] = ExtractParametersFromFilename(filename)
    if ~iscell(filename)
        filename = {filename}; 
    end
    x = NaN * zeros(numel(filename),7); 

    for n = 1:numel(filename)
        C = sscanf(filename{n}, '%dx_%dy_%dz_%dd_%dN_%f_mT_%da'); 
        if length(C) == 5
            x(n,[1:5]) = C;
        elseif length(C) == 6
            x(n,[1:5 7]) = C; 
        else
            x(n,[1:5 7 6]) = C; 
        end
    end
    
    if nargout > 1 
        y = x(:,2); 
        z = x(:,3); 
        d = x(:,4); 
        N = x(:,5); 
        a = x(:,6); 
        H = x(:,7); 
        x = x(:,1); 
    end
end