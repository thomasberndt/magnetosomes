function [handler, theta] = PlotHysteresis(H, M, Hc, Hsw, colortheme)
    if nargin < 5
        colortheme = 'redgreen';
    end
    if nargin < 3
        Hc = [];
        Hsw = [];
    end

    mycolor = [0.5 0.5 0.5];
    
    [theta, phi, x, y, z] = LoadRandomAngles();
    
    handler = plot([H -H]*1000, [M -M], 'Color', mycolor); 
    set(handler, 'ButtonDownFcn', {@LineSelected, handler})
    for n = 1:length(handler)
        ang = abs(theta(n)-90)/90;
        if strcmpi(colortheme, 'redgreen')
            set(handler(n), 'Color', [ang 1-ang 0]); 
        elseif strcmpi(colortheme, 'bluegreen')
            set(handler(n), 'Color', [0 .5*ang 1-sqrt(ang)]); 
        elseif strcmpi(colortheme, 'redorange')
            set(handler(n), 'Color', [0.5+0.5*ang 0.5-0.5*ang 0]); 
        end
    end

    grid on;

    xlabel('Field H (mT)');
    ylabel('Moment M'); 

    function LineSelected(ThisLine, EventData, Lines)        
        for m = 1:length(Lines)
            ang = abs(theta(m)-90)/90;
            if strcmpi(colortheme, 'redgreen')
                set(handler(n), 'Color', [ang 1-ang 0]); 
            elseif strcmpi(colortheme, 'bluegreen')
                set(handler(n), 'Color', [0 0.5*ang 1-ang]); 
            end
        end
        set(ThisLine, 'LineWidth', 2.5);
        set(ThisLine, 'Color', [1 0 0]);
        set(Lines(Lines ~= ThisLine), 'LineWidth', 0.1);
        a = find(Lines == ThisLine); 
        title(sprintf('Angle: %d, Theta-90: %d°, Phi: %d°, Coercivity: %d mT, Switching: %d mT, Hx: %d, Hy: %d, Hz: %d', ...
                a, round(90-abs(theta(a)-90)), round(phi(a)), ...
                round(Hc(a)*1000), round(Hsw(a)*1000), ...
                round(100*x(a)), round(100*y(a)), round(100*z(a))));
    end

end