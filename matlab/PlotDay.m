function h = PlotDay(Mr, Ms, Hcr, Hc, siz, color, style, poster)
    if nargin < 5
        siz = [];
    end
    if nargin < 6 
        color = [];
    end
    if nargin < 7
        style = 'o'; 
    end
    if nargin < 8
        poster = false;
    end
	
    x = Hcr ./ Hc; 
    y = Mr ./ Ms; 
    hol = ishold(); 
    if ischar(siz)
        h = plot(x, y, siz); 
    else
        if isempty(color)
            h = scatter(x, y, siz, style, 'filled'); 
        else
            h = scatter(x, y, siz, color, style, 'filled'); 
        end
    end
    hold on
    xlabel('H_{cr}/H_c'); 
    ylabel('M_{rs}/M_s'); 
    
    if poster 
        lincol = '-w'; 
        texcol = 'w';
    else
        lincol = '-k'; 
        texcol = 'k';
    end
    
    if ~hol 
        text(1.2, 0.55, 'SD', 'Color', texcol, 'Fontsize', 16);
        text(1.7, 0.33, 'PSD', 'Color', texcol, 'Fontsize', 16); 
        text(4.3, 0.03, 'MD', 'Color', texcol, 'Fontsize', 16); 
        

        plot([1.5, 1.5], [1e-9,1], lincol,'HandleVisibility','off');
        plot([4, 4], [1e-9,0.65], lincol,'HandleVisibility','off');
        plot([1e-9, 5], [0.05, 0.05], lincol,'HandleVisibility','off');
        plot([1e-9, 5], [0.5, 0.5], lincol,'HandleVisibility','off');
        axis([1, 5, 0, 1]);
    end
    set(gca, 'xscale', 'log');
%     set(gca, 'yscale', 'log');
    if hol
        hold on
    else
        hold off
    end
end