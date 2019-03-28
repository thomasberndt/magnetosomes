function [M, vort] = CalculateDomainState(x, y, z, d, N, a, field)
    domain_path = 'D:/magnetosomes/domainstates'; 
    magnetosome = sprintf('%dx_%dy_%dz_%dd_%dN', x, y, z, d, N);    
    filename = sprintf('%s/%s/%s_%d_mT_%da.dat', ...
                    domain_path, magnetosome, magnetosome, field, a);
    if ~exist(filename, 'file')
        M = []; 
        vort = [];
        return; 
    end
    
    state = load(filename); 
    rm = [state(:,1), state(:,2), state(:,3)]; 
    Mm = [state(:,4), state(:,5), state(:,6)]; 
    
    M = zeros(N, 3); 
    vort = zeros(N, 3); 
    
    for n = 1:N
        grain = and(rm(:,1)>= -(x+d)/2000 + (x+d)*(n-1)/1000, ...
                    rm(:,1)<= -(x+d)/2000 + (x+d)*n/1000);
        [rx, ry, rz] = meshgrid(...
                      linspace(-x/2000, x/2000, 10)+(x+d)*(n-1)/1000, ...
                      linspace(-y/2000, y/2000, 10), ...
                      linspace(-z/2000, z/2000, 10)); 
        Fx = scatteredInterpolant(rm(grain,:), Mm(grain,1)); 
        Fy = scatteredInterpolant(rm(grain,:), Mm(grain,2)); 
        Fz = scatteredInterpolant(rm(grain,:), Mm(grain,3)); 
        Mx = Fx(rx, ry, rz);
        My = Fy(rx, ry, rz);
        Mz = Fz(rx, ry, rz);
        
        M(n,:) = [sum(Mx(:)), sum(My(:)), sum(Mz(:))] / numel(Mx); 
        [vx, vy, vz] = curl(rx, ry, rz, Mx, My, Mz); 
        vort(n,1) = sum(vx(:)) / numel(Mx); 
        vort(n,2) = sum(vy(:)) / numel(Mx); 
        vort(n,3) = sum(vz(:)) / numel(Mx); 
    end
end