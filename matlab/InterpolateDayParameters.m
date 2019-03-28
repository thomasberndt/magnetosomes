

day_param_file = '../data/day_params.csv'; 
T = readtable(day_param_file); 
T.e = T.x ./ T.y; 

id = logical(T.N == 10 & ...
    T.e>=1 & T.e<=2 & ...
    T.x>=20 & T.y>=20 & ...
    T.x<=140 & T.y<=100); 


T = T(id,:);

[fd, fy, fe] = ndgrid(linspace(0, 2, 21), ...
                      linspace(30, 100, 31), ...
                      linspace(1, 1.4, 9)); 
                  
fHcr = griddatan([log10(T.d), T.y, T.e], T.Hcr, [fd(:), fy(:), fe(:)]); 
fHcr = reshape(fHcr, size(fd));

fHc = griddatan([log10(T.d), T.y, T.e], T.Hc, [fd(:), fy(:), fe(:)]); 
fHc = reshape(fHc, size(fd));

fMr = griddatan([log10(T.d), T.y, T.e], T.Mr, [fd(:), fy(:), fe(:)]); 
fMr = reshape(fMr, size(fd));

fee = fe(1,1,:); 
fee = fee(:);

for ee = 1:2:length(fee)
    h = surf(fd(:,:,ee), fy(:,:,ee), fHcr(:,:,ee));
    h.FaceAlpha = 0.5;
    hold on;
    h = surf(fd(:,:,ee), fy(:,:,ee), fHc(:,:,ee));
    h.FaceAlpha = 0.5;
end
hold off
zlim([0 0.1]);

xlabel('log10 Gap [nm]');
ylabel('y [nm]');
zlabel(''); 
grid on

