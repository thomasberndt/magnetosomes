

[x, y, z, d, N, ~] = GetMagnetosomeParameters(); 
[~, ~, xang, yang, zang] = LoadRandomAngles();

parfor n = 1:length(x)
    try 
        [HH, aa, domain, MM, vortt] = LoadDomainStates(...
                        x(n), y(n), z(n), d(n), N(n));
        domainstate_file = sprintf('D:/magnetosomes/domain_states/domain_states_%gx_%gy_%gz_%gd_%gN.csv', ...
                        x(n), y(n), z(n), d(n), N(n)); 
        if ~exist(domainstate_file, 'file')
            fout = fopen(domainstate_file, 'w'); 
            fprintf(fout, 'H, a, domain, Mx, My, Mz, vortx, vorty, vortz \n');
            fclose(fout); 
        end

        domainfiles = dir(sprintf('D:/magnetosomes/domainstates/%gx_%gy_%gz_%gd_%gN/*.dat', ...
                        x(n), y(n), z(n), d(n), N(n))); 
        domainfiles = {domainfiles.name}; 

        AlreadyCalculated = [aa, HH];
        Domains = ExtractParametersFromFilename(domainfiles);
        total = length(Domains(:,6)); 

        if ~isempty(aa)
            DomainsTodo = setdiff(Domains(:,6:7), AlreadyCalculated, 'rows'); 
            a = DomainsTodo(:,1); 
            H = DomainsTodo(:,2); 
            done = length(aa)/N(n); 
        else 
            a = Domains(:,6);
            H = Domains(:,7);
            done = 0;
        end

        for m = 1:length(a)
            try
                fout = fopen(domainstate_file, 'a'); 
                [M, vort] = CalculateDomainState(x(n), y(n), z(n), d(n), N(n), a(m), H(m)); 
                for i = 1:N(n)
                    fprintf(fout, '%g, %g, %g, %g, %g, %g, %g, %g, %g \n', ...
                            H(m), a(m), i, ...
                            M(i,1), M(i,2), M(i,3), ...
                            vort(i,1), vort(i,2), vort(i,3)); 
                end
                fprintf('(%g/%g) (%g/%g) %g, %g, %g, %g, %g \n', ...
                            m, length(a), done, total, ...
                            x(n), y(n), z(n), d(n), N(n)); 
            catch
                fprintf('didnt work: %g, %g, %g, %g, %g, %g, %g, %g \n', ...
                            x(n), y(n), z(n), d(n), N(n), H(m), a(m), i); 
            end
            try
                fclose(fout);    
            catch
            end
        end
    catch ME
        fprintf('didnt work at all: %g, %g, %g, %g, %g, %s \n', ...
                    x(n), y(n), z(n), d(n), N(n), ME.message); 
        
    end
    
end


