function CleanupHysteresisFiles()

    hyst_files = dir('D:/magnetosomes/hysteresis/*.hyst'); 
    
    filesizes = [hyst_files.bytes];
    rightsize = median(filesizes);
    wrongsize = logical(filesizes<0.95*rightsize | filesizes>1.05*rightsize);
    badfiles = hyst_files(wrongsize);
    
    for n = 1:length(badfiles)
        filename = fullfile(badfiles(n).folder, badfiles(n).name);
        fid = fopen(filename); 
        tline = fgets(fid); 
        lines = {tline};
        H = [];
        t = 1; 
        while ischar(tline)
            t = t + 1;
            tline = fgets(fid); 
            lines{t} = tline; 
            if ischar(tline)
                C = textscan(tline, ' %f %f %f %f %f'); 
                H(t-1) = C{2}; 
            end
        end
        fclose(fid);
        problem = find(diff(H)<0, 1, 'first');
        if -H(1)+H(problem) >= -H(problem+1)+H(end) 
            % first half of the file is better
            goodlines = [1 problem]+1; 
        else
            % second half of the file is better
            goodlines = [problem+1 length(H)]+1; 
        end
        fid = fopen(filename, 'w');        
        fwrite(fid, lines{1}); 
        for t = goodlines(1):goodlines(2)
            fwrite(fid, lines{t});
        end
        fclose(fid); 
        
    end
end