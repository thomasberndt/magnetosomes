function scriptfilename = AnisCreateMagnetosomeHysteresisScript(x, y, z, d, N, a, theta, phi)
    path = 'mesh'; 
    domainpath = 'domainstates_anis'; 
    merrillpath = 'D:/magnetosomes'; 
    scriptpath = 'D:/magnetosomes/scripts/hysteresis_anis'; 
    hysteresispath = 'hysteresis_anis'; 
    filename = sprintf('%dx_%dy_%dz_%dd_%dN', x, y, z, d, N);
    scriptfilename = sprintf('%dx_%dy_%dz_%dd_%dN_%ga', x, y, z, d, N, a);
    
    [~,~,~] = mkdir(sprintf('%s/%s', merrillpath, domainpath), filename); 
    
    fileID = fopen(sprintf('%s/%s_%da.script', scriptpath, filename, a),'w');
    
    fprintf(fileID,'magnetite 20 C \n');
    meshname = sprintf('magnetosome_%dx_%dy_%dz_%dd_%dN', x, y, z, d, N);
    fprintf(fileID, 'ReadMesh 1 %s/%s.pat \n', path, meshname);
    
    angx = cos(theta/180*pi);
    angy = sin(theta/180*pi)*cos(phi/180*pi);
    angz = sin(theta/180*pi)*sin(phi/180*pi);

    fprintf(fileID, '!angle #%d (theta=%d, phi=%d) \n', ...
                a, round(theta), round(phi)); 
    fprintf(fileID, 'external field direction %1.3f %1.3f %1.3f \n', angx, angy, angz);
    fprintf(fileID, 'Uniform Magnetization %1.3f %1.3f %1.3f \n', -angx, -angy, -angz); 
    
    fprintf(fileID, 'Cubic Anisotropy \n'); 
    A = eul2rotm([0,-atan(1/sqrt(2)),pi/4]); % Rotation for cubic easy axis along x
    fprintf(fileID, 'Cubic Axes '); 
    fprintf(fileID, '%f ', A(:)); 
    fprintf(fileID, ' \n'); 
        
    MerrillLoop(fileID, hysteresispath, domainpath, filename, ...
        a, -300, -100, 20);
    MerrillLoop(fileID, hysteresispath, domainpath, filename, ...
        a, -90, -0, 10);
    MerrillLoop(fileID, hysteresispath, domainpath, filename, ...
        a, 1, 5, 1);
    MerrillLoop(fileID, hysteresispath, domainpath, filename, ...
        a, 10, 100, 5);
    MerrillLoop(fileID, hysteresispath, domainpath, filename, ...
        a, 120, 300, 20);

    fprintf(fileID, '\n'); 
    
    fclose(fileID);
end