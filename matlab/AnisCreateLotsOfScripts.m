
a = [40 45 50 55 60:10:200];
e = 1:0.1:2; 
d = [1:1:10 15 20:10:100 200 300]; 


%%

for i = 1:length(a)
    disp(a(i));
    for j = 1:length(e)
        AnisCreateAllScriptFiles(round(e(j)*a(i)), a(i), a(i), 0, 1); 
        AnisCreateAllScriptFiles(round(e(j)*a(i)*10), a(i), a(i), 0, 1); 
    end
end


%%

for N = 1:30
    disp(N);
    AnisCreateAllScriptFiles(40, 40, 40, 10, N); 
    AnisCreateAllScriptFiles(50, 50, 50, 10, N); 
    AnisCreateAllScriptFiles(100, 100, 100, 10, N); 
end


%%

for i = 1:length(a)
    disp(a(i));
    for j = 1:length(e)
        for k = 1:length(d)
            AnisCreateAllScriptFiles(round(e(j)*a(i)), a(i), a(i), d(k), 10); 
        end
    end
end
