function CreateMagnetosomeMesh(x, y, z, d, N, meshsize)
    path = 'D:/magnetosomes/mesh'; 
    cubitpath = 'D:/magnetosomes/cubit'; 
    filename = sprintf('magnetosome_%dx_%dy_%dz_%dd_%dN', x, y, z, d, N);
    fileID = fopen(sprintf('%s/%s.jou', cubitpath, filename),'w');
    fprintf(fileID,'set geometry engine acis\n');
    fprintf(fileID,'set default element hex\n');
    for n = 1:N
        fprintf(fileID,'brick x %1.3f y %1.3f z %1.3f\n', ...
                        x/1000, y/1000, z/1000);
        fprintf(fileID,'volume %d move x %1.3f y 0 z 0\n', ...
                        n, (x+d)*(n-1)/1000);
    end
    allvolumes = int2str(1:N); 
    fprintf(fileID,'volume %s size %1.4f\n', allvolumes, meshsize);
    fprintf(fileID,'volume %s scheme Tetmesh\n', allvolumes);
    fprintf(fileID,'mesh volume %s\n', allvolumes);
    fprintf(fileID,'block 1 volume %s\n', allvolumes);
    fprintf(fileID,'block 1 element type tetra4\n');
    fprintf(fileID,'set patran export groups on\n');
    
    fprintf(fileID,'export patran "%s/%s.pat" \n', path, filename);
    fclose(fileID);


end