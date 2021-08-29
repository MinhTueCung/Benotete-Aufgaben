function wurfparabel(v0, alpha, t_array)
    x = (v0*cos(alpha)).*t_array;
    y = (v0*sin(alpha)).*t_array - ((1/2)*9.8).*(t_array .^ 2);
    
    figure(1);
    clf;
    plot(x,y,'color','r');
    xlim([0 5]);
    grid on;
    xlabel('x-Achse');
    ylabel('y-Achse');
    