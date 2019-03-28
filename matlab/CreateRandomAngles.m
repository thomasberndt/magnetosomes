function [theta, phi, x, y, z] = CreateRandomAngles(numAngles)

    r = randn(3, numAngles);
    r = bsxfun(@rdivide, r, sqrt(sum(r.^2,1)));
    
    x = r(1,:)'; 
    y = r(2,:)'; 
    z = r(3,:)';     
    
    theta = acos(x)*180/pi; 
    phi = acos(y./sin(theta/180*pi))*180/pi; 
end