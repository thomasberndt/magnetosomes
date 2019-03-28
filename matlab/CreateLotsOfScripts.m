
a = [20:5:55 60:10:200];
e = [0.9]; 
d = [1:1:10 15 20:10:100 200 300]; 


%%

for i = 1:length(a)
    disp(a(i));
    for j = 1:length(e)
        CreateAllScriptFiles(round(e(j)*a(i)), a(i), a(i), 0, 1); 
        CreateAllScriptFiles(round(e(j)*a(i)*10), a(i), a(i), 0, 1); 
    end
end


%%

for N = 2:30
    disp(N);
    CreateAllScriptFiles(20, 20, 20, 10, N); 
    CreateAllScriptFiles(30, 30, 30, 10, N); 
%     CreateAllScriptFiles(40, 40, 40, 10, N); 
%     CreateAllScriptFiles(50, 50, 50, 10, N); 
%     CreateAllScriptFiles(100, 100, 100, 10, N); 
end


%%

for i = 1:length(a)
    disp(a(i));
    for j = 1:length(e)
        for k = 1:length(d)
            CreateAllScriptFiles(round(e(j)*a(i)), a(i), a(i), d(k), 10); 
        end
    end
end
