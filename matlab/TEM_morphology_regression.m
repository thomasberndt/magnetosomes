
T = readtable('../TEM/statistics.csv'); 

x1 = log10(T.y_mean); 
x2 = T.e; 
y = log10(T.d_mean); 
X = [ones(size(x1)) x1 x2 x1.*x2];

b = regress(y,X); 

scatter3(x1, x2, y, 'filled')
hold on
x1fit = linspace(min(x1), max(x1));
x2fit = linspace(min(x2), max(x2));
[X1FIT,X2FIT] = meshgrid(x1fit,x2fit);
YFIT = b(1) + b(2)*X1FIT + b(3)*X2FIT + b(4)*X1FIT.*X2FIT;
mesh(X1FIT,X2FIT,YFIT);
xlabel('log10(y)')
ylabel('e');
zlabel('log10(d)')
hold off
