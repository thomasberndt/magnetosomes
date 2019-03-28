function CreateAllScriptFiles(x, y, z, d, N) 
    meshsize = 9e-3;
    [theta, phi] = LoadRandomAngles();
    CreateMagnetosomeMesh(x, y, z, d, N, meshsize);
    scriptfiles = cell(size(theta)); 
    for a = 1:length(theta)
        scriptfiles{a} = CreateMagnetosomeHysteresisScript(x, y, z, d, N, a, theta(a), phi(a)); 
    end
    CreateMerrillBatch(x, y, z, d, N, scriptfiles); 
end
