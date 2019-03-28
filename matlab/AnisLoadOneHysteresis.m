function [M, H, Mvec, Mr, Hc, Hsw, spec, Hsw_file1, Hsw_file2, Mr_vec] = AnisLoadOneHysteresis(x, y, z, d, N, a, Hinter)
    hys_path = 'D:/magnetosomes/hysteresis_anis'; 
    filename = sprintf('%s/%dx_%dy_%dz_%dd_%dN_%da.hyst', hys_path, x, y, z, d, N, a);
    
    fid = fopen(filename); 
    if fid == -1
        M = NaN; 
        H = NaN; 
        Mvec = NaN; 
            Mr_vec = [NaN NaN NaN];
        Mr = NaN;
        Hc = NaN;
        Hsw = NaN;
        Hsw_file1 = NaN;
        Hsw_file2 = NaN;
        spec = NaN; 
        if nargin >= 7
            M = NaN(size(Hinter));
            H = NaN(size(Hinter));
            Mvec = NaN(length(Hinter), 3);
            Mr_vec = NaN(length(Hinter), 3);
            spec = NaN(size(Hinter));
        end
    else
        textscan(fid, ' %s %s %s %s %s %s ', 1); 
        C = textscan(fid, ' %f %f %f %f %f'); 
        fclose(fid); 
        M = C{1}; 
        H = C{2}; 
        Mvec = [C{3} C{4} C{5}]; 
        
        idx = find(H==0.1, 2); 
        if length(idx) == 2 
            prob = idx(2); 
            M = [M(1:prob-1); M(prob+1:end)]; 
            H = [H(1:prob-1); H(prob+1:end)]; 
            Mvec = [Mvec(1:prob-1,:); Mvec(prob+1:end,:)]; 
        end
        
        idx = find(H==0, 2); 
        if length(idx) == 2 
            prob = idx(2); 
            M = [M(1:prob-1); M(prob+1:end)]; 
            H = [H(1:prob-1); H(prob+1:end)]; 
            Mvec = [Mvec(1:prob-1,:); Mvec(prob+1:end,:)]; 
        end
        
        idx = find(H==-0.1, 2); 
        if length(idx) == 2 
            prob = idx(2); 
            M = [M(1:prob-1); M(prob+1:end)]; 
            H = [H(1:prob-1); H(prob+1:end)]; 
            Mvec = [Mvec(1:prob-1,:); Mvec(prob+1:end,:)]; 
        end
        
        if nargin >= 7 && length(H) > 5
            Mvec_file = Mvec; 
            Mvec1 = interp1(H, Mvec(:,1), Hinter(:));
            Mvec2 = interp1(H, Mvec(:,2), Hinter(:));
            Mvec3 = interp1(H, Mvec(:,3), Hinter(:)); 
            Mvec = [Mvec1 Mvec2 Mvec3]; 
            M_file = M; 
            H_file = H; 
            M = interp1(H, M, Hinter);
            H = Hinter; 
        end
        
        spec = -M(1:end) - M(end:-1:1); 
        if H(end) >= 0.3 && ~isnan(M(end))
            Hc = H(find(M>0, 1)); 
            sw = find(sign(Mvec(1,1))*Mvec(:,1)>0,1,'last');
            Hsw = H(sw); 
            sw_file = find(sign(Mvec_file(1,1))*Mvec_file(:,1)>0,1,'last');
            if ~isempty(sw_file) && sw_file < length(H_file)
                Hsw_file1 = H_file(sw_file) * 1e3; 
                Hsw_file2 = H_file(sw_file+1) * 1e3; 
            else
                Hsw_file1 = NaN;
                Hsw_file2 = NaN;
            end
            Mr = M(find(H>=0, 1)); 
            Mr_vec = Mvec(find(H>=0, 1),:); 
        else 
            Mr = NaN;
            Mr_vec = [NaN NaN NaN];
            Hc = NaN;
            Hsw = NaN;
            Hsw_file1 = NaN;
            Hsw_file2 = NaN;
        end
    end
end