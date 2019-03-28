function MerrillLoop(fileID, hysteresispath, domainpath, filename, angle, H_start, H_end, H_step)
    fprintf(fileID, 'loop field %f %f %f \n', H_start, H_end, H_step); 
    fprintf(fileID, '    Randomize Magnetization 10 \n'); 
    fprintf(fileID, '    External field strength %%field mT  \n'); 
    fprintf(fileID, '    Minimize \n'); 
    fprintf(fileID, '    WriteMagnetization %s/%s/%s_#field_mT_%da \n', ...
            domainpath, filename, filename, angle); 
    fprintf(fileID, '    WriteHyst %s/%s_%da \n', hysteresispath, filename, angle); 
    fprintf(fileID, 'EndLoop \n'); 
end