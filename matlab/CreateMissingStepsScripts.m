function filename_fine = CreateMissingStepsScripts(x, y, z, d, N)

    path = 'mesh'; 
    domainpath = 'domainstates'; 
    merrillpath = 'D:/magnetosomes'; 
    scriptpath = 'D:/magnetosomes/scripts/hysteresis'; 
    hysteresispath = 'hysteresis_fine'; 
    filename = sprintf('%dx_%dy_%dz_%dd_%dN', x, y, z, d, N);
    filename_fine = sprintf('%s_fine', filename);
    fileID = fopen(sprintf('%s/%s.script', scriptpath, filename_fine),'w');
        
    [theta, phi] = LoadRandomAngles();
    [H, a, Mr, Hc, Hsw] = IdentifyMissingSteps(x, y, z, d, N);
    if isempty(H)
        filename_fine = []; 
    else 
        fprintf(fileID,'magnetite   20 C \n');
        meshname = sprintf('magnetosome_%dx_%dy_%dz_%dd_%dN', x, y, z, d, N);
        fprintf(fileID, 'ReadMesh 1 %s/%s.pat \n', path, meshname);

        for angle = 1:length(a)
            angx = cos(theta(angle)/180*pi);
            angy = sin(theta(angle)/180*pi)*cos(phi(angle)/180*pi);
            angz = sin(theta(angle)/180*pi)*sin(phi(angle)/180*pi);

            H1 = H(angle, 1) * 1000;
            H2 = H(angle, 2) * 1000;
            Hstep = (H2 - H1)/10; 

            fprintf(fileID, '!angle #%d (theta=%d, phi=%d) \n', ...
                        angle, round(theta(angle)), round(phi(angle))); 
            fprintf(fileID, 'external field direction %1.3f %1.3f %1.3f \n', angx, angy, angz);
            fprintf(fileID, 'ReadMagnetization %s/%s/%s_%g_mT_%da.dat \n', ...
                domainpath, filename, filename, H1, angle); 
            MerrillLoopE(fileID, hysteresispath, domainpath, filename, ...
                angle, H1 + Hstep, H2 - Hstep, Hstep);

            fprintf(fileID, '\n'); 

        end


        fclose(fileID);
    end
end