% Minh Tue Cung - 5081738 - Abgabe Mathe 3 - 30.01.2021

function brocken()
    figure(1);  % Der Brocken!
    clf;        % Clear Figure
    H = 1.14;      % H Konstante
    z = @(x,y)H*exp(-(4*x.^2 + y.^2));    % Funktion des Brockens
    weg_1_x = @(t) (1/2)*(1-t);      % x(t) vom Weg 1
    weg_1_y = @(t) 0;             % y(t) vom Weg 1
    weg_1_z = @(t) z(weg_1_x(t), weg_1_y(t));   % z(t) vom Weg 1
    z_strich_1 = @(t) 2*H*(1-t).*exp(-((1-t).^2));  % Ableitung nach t von z(t) (Weg 1)
    % Steigungswinkel Weg 1 (in °)
    alpha_1 = @(t) ((atan(4*H*(1-t).*exp(-((1-t).^2))))/pi)*180;
    % Bahngeschwindigkeit Weg 1
    v_1 = @(t) sqrt(1/4 + (2*H*(1-t).*exp(-((1-t).^2))).^2);
    
    % Weg 2
    weg_2_x = @(t) (1/2)*(1-t)*cos(2*pi*t);
    dx_dt = @(t) (-1/2)*(cos(2*pi*t) + 2*pi*(1-t).*(sin(2*pi*t)));   % Ableitung von x nach t
    dy_dt = @(t) 2*pi*(1-t).*cos(2*pi*t) - sin(2*pi*t); % Ableitung von y nach t
    betrag_vektor_dx_dt_und_dy_dt = @(t) sqrt(dx_dt(t).^2 + dy_dt(t).^2);
    
    weg_2_y = @(t) (1-t)*sin(2*pi*t);
    weg_2_z = @(t) z(weg_2_x(t), weg_2_y(t));
    
    % Ableitung von z nach t (Weg 2)
    z_strich_2 = @(t) 4*weg_2_x(t).*z(weg_2_x(t),weg_2_y(t)).*(cos(2*pi*t) + 2*pi*(1-t).*sin(2*pi*t)) + ... 
                      2*weg_2_y(t).*z(weg_2_x(t),weg_2_y(t)).*(sin(2*pi*t) - 2*pi*(1-t).*cos(2*pi*t));
    z_strich_2_absolut = @(t) abs(z_strich_2(t));
    
    % Bahngeschwindigkeit 
    v_2 = @(t) sqrt((dx_dt(t)).^2 + (dy_dt(t)).^2 + z_strich_2(t).^2); 
    % Steigungswinkel 
    alpha_2 = @(t) atan(z_strich_2_absolut(t) / betrag_vektor_dx_dt_und_dy_dt(t)) / pi * 180;
    
    % Plotte den Brocken 
    hs = fsurf(z, [-4 4 -4 4]);
    xlabel('X Achse');
    ylabel('Y Achse');
    zlabel('Z Achse');
    title('Der Brocken');
    
    view(130,30);
    hold on;
    % Auch die 2 Wege
    fplot3(weg_1_x,weg_1_y,weg_1_z,[0 1],'linewidth',2,'col','r');
    fplot3(weg_2_x,weg_2_y,weg_2_z,[0 1],'linewidth',2,'col','y');   
    
    plot3(1/2,0,z(1/2, 0),'wo','linewidth',8,'col','b'); % Startpunkt
    plot3(0,0,z(0,0),'x','linewidth',8,'col','r'); % Gipfel
    hold off;
    
    
    % Die 6 Diagramme
    figure(2);
    clf;
    
    subplot(2,3,1);
    fplot(z_strich_1, [0 1]);
    grid on;
    xlabel('t (h)');
    ylabel('v (km/h)');
    title('Höhengeschwindigkeit Weg 1');
    
    subplot(2,3,4);
    fplot(z_strich_2, [0 1]);
    grid on;
    xlabel('t (h)');
    ylabel('v (km/h)');
    title('Höhengeschwindigkeit Weg 2');
    
    subplot(2,3,2);
    fplot(alpha_1, [0 1]);
    grid on;
    xlabel('t (h)');
    ylabel('alpha (°)');
    title('Winkel Weg 1');
    
    subplot(2,3,5);
    fplot(alpha_2, [0 1]);
    grid on;
    xlabel('t (h)');
    ylabel('alpha (°)');
    title('Winkel Weg 2');
    
    subplot(2,3,3);
    fplot(v_1, [0 1]);
    grid on;
    xlabel('t (h)');
    ylabel('v (km/h)');
    title('Bahngeschwindigkeit Weg 1');
    
    subplot(2,3,6);
    fplot(v_2, [0 1]);
    grid on;
    xlabel('t (h)');
    ylabel('v (km/h)');
    title('Bahngeschwindigkeit Weg 2');
    
    
    
    