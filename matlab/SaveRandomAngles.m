
numAngles = 100; 
[theta, phi] = CreateRandomAngles(numAngles); 
angles = [theta, phi]; 
save('RandomAngles.csv', 'angles', '-ascii'); 