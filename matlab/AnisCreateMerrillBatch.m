function AnisCreateMerrillBatch(x, y, z, d, N, scriptfiles)
    merrillpath = 'D:/magnetosomes'; 
    scriptpath = 'scripts/hysteresis_anis'; 
    batchpath = 'batch_anis'; 
    
    [~,~,~] = mkdir(merrillpath, batchpath); 
    
    for aa = 1:10:length(scriptfiles)
        filename = sprintf('%dx_%dy_%dz_%dd_%dN_%d-%da', x, y, z, d, N, aa, aa+10);
        fileID = fopen(sprintf('%s/%s/%s.bat', ...
                    merrillpath, batchpath, filename),'w');

        fprintf(fileID,'@cd .. \n');

        for a = aa:min(aa+10,length(scriptfiles))
            fprintf(fileID, '@IF EXIST "hysteresis_anis/%s.hyst" (\n', scriptfiles{a}); 
            fprintf(fileID, '@ECHO hysteresis loop already exists\n'); 
            fprintf(fileID, ') ELSE (\n'); 
            fprintf(fileID,'merrill %s/%s.script \n', scriptpath, scriptfiles{a});
            fprintf(fileID, ') \n'); 
        end

        fclose(fileID);
    end
end