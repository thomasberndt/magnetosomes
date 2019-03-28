function [H, a, domain, M, vort] = AnisLoadDomainStates(x, y, z, d, N)
    
    domain_file = sprintf('D:/magnetosomes/domain_states_anis/domain_states_%gx_%gy_%gz_%gd_%gN.csv', ...
                    x, y, z, d, N); 
    if exist(domain_file, 'file')
        C = csvread(domain_file, 1); 

        [~, i] = unique(C(:,1:3), 'rows');        
        
        H = C(i,1); 
        a = C(i,2); 
        domain = C(i,3); 
        M = C(i,4:6);
        vort = C(i,7:9);         
    else
        H = []; 
        a = []; 
        domain = []; 
        M = [];
        vort = [];
    end
    
end