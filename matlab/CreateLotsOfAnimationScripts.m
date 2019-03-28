

mypath = 'D:/magnetosomes/plots/3d'; 
dirs = dir(mypath);

x = []; 
y = []; 
z = []; 
d = []; 
N = []; 
a = []; 
filenames = {}; 

k = 1;
for n = 3:length(dirs)
     if dirs(n).isdir
         filename = dirs(n).name; 
         [x(k), y(k), z(k), d(k), N(k), ~, a(k)] = ...
             ExtractParametersFromFilename(filename); 
         filenames{k} = filename; 
         k = k + 1;
     end
end

magnetosomes = [x(:), y(:), z(:), d(:), N(:)]; 
umagnetosomes = unique(magnetosomes, 'rows'); 

for n = 1:size(umagnetosomes, 1)
    idx = find(ismember(magnetosomes, umagnetosomes(n,:), 'rows')); 
    fid = fopen(sprintf('%s/%gx_%gy_%gz_%gd_%gN-animation.bat', mypath, ...
        umagnetosomes(n,1), umagnetosomes(n,2), umagnetosomes(n,3), ...
        umagnetosomes(n,4), umagnetosomes(n,5)), 'w');
    for k = 1:length(idx)
        fprintf(fid, 'cd %s\n', filenames{idx(k)}); 
        fprintf(fid, 'magick convert -alpha off -delay 8 *.png ../../3d-animation-high/%s.gif\n', filenames{idx(k)});
        fprintf(fid, 'cd ..\n'); 
    end
    for k = 1:length(idx)
        fprintf(fid, 'cd %s\n', filenames{idx(k)}); 
        fprintf(fid, 'magick convert -alpha off -delay 8 *.png -scale 750x500 ../../3d-animation-medium/%s.gif\n', filenames{idx(k)});
        fprintf(fid, 'cd ..\n'); 
    end
    for k = 1:length(idx)
        fprintf(fid, 'cd %s\n', filenames{idx(k)}); 
        fprintf(fid, 'magick convert -alpha off -delay 8 *.png -scale 300x200 ../../3d-animation-low/%s.gif\n', filenames{idx(k)}); 
        fprintf(fid, 'cd ..\n'); 
    end
    fclose(fid); 
end