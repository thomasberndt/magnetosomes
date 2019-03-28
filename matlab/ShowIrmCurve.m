function [M, H] = ShowIrmCurve(x, y, z, d, N)
    [M, H, Hcr] = GetIrmCurve(x, y, z, d, N);
    
    plot(-H*1e3, M, 'o-');
    xlabel('Backfield [mT]');
    ylabel('M_r [Am^2]'); 
    title(sprintf('H_{cr}=%g mT', Hcr*1000));
    grid on
    axis([-300, 0, -1, 1]); 
    
end