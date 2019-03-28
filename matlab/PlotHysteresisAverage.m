function PlotHysteresisAverage(H, M, x, y, z, d, N)

    mycolor = [0 0 0];
    
    handler = plot([H -H]*1000, [M -M], 'Color', mycolor); 
    set(handler, 'ButtonDownFcn', {@LineSelected, handler})

    grid on;

    xlabel('Field H (mT)');
    ylabel('Moment M'); 

    function LineSelected(ThisLine, EventData, Lines)
        set(ThisLine, 'LineWidth', 2.5);
        set(ThisLine, 'Color', [1 0 0]);
        set(Lines(Lines ~= ThisLine), 'LineWidth', 0.1);
        set(Lines(Lines ~= ThisLine), 'Color', mycolor);
        a = find(Lines == ThisLine); 
        coercivity = H(find(M(a,:)>0, 1)); 
        [~, maxi] = max(diff(M(a,:))); 
        switching = H(maxi); 
        title(sprintf('x: %d, y: %d, z: %d, d: %d, N: %d, Coercivity: %d mT, Switching: %d mT', ...
                round(x(a)), round(y(a)), round(z(a)), ...
                round(d(a)), round(N(a)), ...
                round(coercivity*1000), round(switching*1000)));
    end

end