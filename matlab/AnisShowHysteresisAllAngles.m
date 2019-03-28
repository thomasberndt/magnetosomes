function [handler, theta] = AnisShowHysteresisAllAngles(x, y, z, d, N)
    
    H = linspace(-0.3, 0.3, 6001);     
    [M, Mr, Hc, Hsw, spec] = AnisLoadHysteresis(x, y, z, d, N, H);
        
    [handler, theta] = PlotHysteresis(H, M, Hc, Hsw, 'bluegreen'); 
    
    holding = ishold; 
    hold on
    
    Mavg = sum(M) ./ size(M,1);
%     plot(H*1000, Mavg, 'b-', 'linewidth', 3);
%     plot(-H*1000, -Mavg, 'b-', 'linewidth', 3);
    if holding 
        hold on
    else 
        hold off
    end
    
    drawnow;
    
%     if isempty(f2)
%         f2 = figure;
%     else
%         figure(f2);
%     end
%     PlotRemanenceSpectrum(H, spec, Hc, Hsw); 
%     
%     holding = ishold; 
%     hold on
%     
%     specavg = sum(spec) ./ size(spec,1);
%     plot(H*1000, specavg, 'b-', 'linewidth', 3);
%     if holding 
%         hold on
%     else 
%         hold off
%     end
%     drawnow;
end