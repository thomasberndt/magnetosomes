
filepath = '../TEM/data/'; 
strains = dir(filepath); 
strains = strains(3:end);
strains = {strains.name}; 
strains = strains'; 

d = cell(length(strains), 1); 
x = cell(length(strains), 1); 
y = cell(length(strains), 1); 

Tout = table(strains); 

for s = 1:length(strains)
    strainpath = [filepath strains{s} '/']; 
    files = dir([strainpath '*-g.csv']); 
    for n = 1:length(files)
        T = readtable([strainpath files(n).name]); 
        good = strcmpi(T.Label, ''); 
        dc = T.Length(good);
        d{s} = [d{s}; dc]; 
    end
    files = dir([strainpath '*-x.csv']); 
    for n = 1:length(files)
        T = readtable([strainpath files(n).name]); 
        good = strcmpi(T.Label, ''); 
        xc = T.Length(good);
        x{s} = [x{s}; xc]; 
    end
    files = dir([strainpath '*-y.csv']); 
    for n = 1:length(files)
        T = readtable([strainpath files(n).name]); 
        good = strcmpi(T.Label, ''); 
        yc = T.Length(good);
        y{s} = [y{s}; yc]; 
    end
    
    
    Tout.x_mean(s) =  mean(x{s}); 
    Tout.x_std(s) =  std(x{s}); 
    Tout.x_num(s) =  length(x{s}); 
    Tout.y_mean(s) =  mean(y{s}); 
    Tout.y_std(s) =  std(y{s}); 
    Tout.y_num(s) =  length(y{s}); 
    Tout.d_mean(s) =  mean(d{s}); 
    Tout.d_std(s) =  std(d{s}); 
    Tout.d_num(s) =  length(d{s}); 
    Tout.e(s) =  mean(x{s})/mean(y{s}); 
end

writetable(Tout, '../TEM/statistics.csv'); 