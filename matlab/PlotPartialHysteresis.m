function PlotPartialHysteresis(H, M)
    mycolor = [0 0 0];

    handler = plot(H*1000, M, 'Color', mycolor); 
    set(handler, 'ButtonDownFcn', {@LineSelected, handler})

    grid on;

    xlabel('Field H (mT)');
    ylabel('Moment M'); 

    function LineSelected(ThisLine, EventData, Lines)      
        set(ThisLine, 'LineWidth', 2.5);
        set(Lines(Lines ~= ThisLine), 'LineWidth', 0.1);
    end

end