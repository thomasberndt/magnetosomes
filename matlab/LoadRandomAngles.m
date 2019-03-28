function [theta, phi, x, y, z] = LoadRandomAngles()
    persistent angles;
    if isempty(angles)
        angles = load('RandomAngles.csv'); 
    end
    theta = angles(:,1); 
    phi = angles(:,2); 
    x = cos(theta/180*pi);
    y = sin(theta/180*pi).*cos(phi/180*pi);
    z = sin(theta/180*pi).*sin(phi/180*pi);
end