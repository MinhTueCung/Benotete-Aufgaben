function [x_minmax, y_minmax, z_minmax] = kugelbahn(R)

    % Minh Tue Cung - 5081738 
    
    if nargin == 0
       R = 6;   % Default Wert des R
    end
    
    % Die Halbkugel
    z = @(x,y) sqrt(R^2 - (x.^2 + y.^2));
    % Hier wird lediglich die obere Halbkugel betrachtet!
    
    % Die Ellipse
    r_t = @(t) ((2/3)*R) ./ sqrt(1 + 3.*((sin(t + pi/6)).^2)); % r(t)
    x_pt = @(t) r_t(t) .* cos(t); % x(t) (x von p(t))
    y_pt = @(t) r_t(t) .* sin(t); % y(t) (y von p(t))
    z_pt = @(t) 0;     % z(t) = 0 (Ellipse liegt komplett in der xy-Ebene)
    
    c = @(t) z(x_pt(t), y_pt(t));  % Kurve Cf: z(x(t),y(t))
    
    % Die Extrempunkte (Herleitung siehe Aufgabe 1) (auf der oberen Halbkugel)
    A = [R/6, R/(2*sqrt(3)), (2*sqrt(2))*R/3];
    B = [-R/6, -R/(2*sqrt(3)), (2*sqrt(2))*R/3];
    C = [-R/sqrt(3), R/3, sqrt(5)*R/3];
    D = [R/sqrt(3), -R/3, sqrt(5)*R/3];
    
    % Die 4 Extrempunkte auf der unteren Halbkugel werden hier nicht weiter
    % betrachtet!
    % Bei diesen 4 Punkten wird lediglich vor den "z" Koordinaten (von den 4
    % Punkten auf der oberen Halbkugel) ein Minus "-" gesetzt. x und y
    % bleiben dabei unverändert!
    
    % Die 8 Extrempunkte untersuchen!
    x_minmax = [C(1), D(1)]; % X min ist hier = -R/sqrt(3) | X max = R/sqrt(3)
    y_minmax = [D(2), C(2)]; % Y min ist hier = -R/3 | Y max = R/3
    % z_minmax enthält 4 Elemente: z min und max von den 4 Extrempunkten
    % auf der oberen Halbkugel + z min und max von den 4 Punkten auf der
    % unteren
    % Auf der oberen: Z min = sqrt(5)*R/3 | Z max = (2*sqrt(2))*R/3
    % Auf der unteren: Z min = -(2*sqrt(2))*R/3 | Z max = -sqrt(5)*R/3
    % Hier wird z_minmax in Format: [(z min unten), (z min oben), (z max unten), (z max oben)]
    % angegeben!
    z_minmax = [-B(3), C(3), -C(3), B(3)]; 
    
    % Diagramm!
    figure(1);
    clf;
    % Die Halbkugel plotten
    fsurf(z, [-R R -R R]);
    % Titel
    title('Grafik');
    % Transparenz 50%
    alpha(.5);
    hold on;
    % Die Ellipse in der x-y Ebene
    fplot3(x_pt, y_pt, z_pt, [0 2*pi], 'linewidth', 5, 'col', 'r');
    % Die Kurve Cf auf der Halbkugel (hier oberen)
    % 'linewidth' = 5 --> gut hervorgehoben!
    fplot3(x_pt, y_pt, c, [0 2*pi], 'linewidth', 5, 'col', 'r');
    % Nun die Extrempunkte
    % Koordinatenursprung
    plot3(0, 0, 0, 'x', 'linewidth', 10, 'col', 'y');
    % Erstmal die Punkte auf der Halbkugel plotten!
    % Punkt A
    plot3(A(1), A(2), A(3), 'x', 'linewidth', 10, 'col', 'y');
    % Punkt B
    plot3(B(1), B(2), B(3), 'x', 'linewidth', 10, 'col', 'y');
    % Punkt C
    plot3(C(1), C(2), C(3), 'x', 'linewidth', 10, 'col', 'y');
    % Punkt D
    plot3(D(1), D(2), D(3), 'x', 'linewidth', 10, 'col', 'y');
    
    % Nun auf der Ellipse plotten!
    % Punkt A
    plot(A(1), A(2), 'x', 'linewidth', 10, 'col', 'y');
    % Punkt B
    plot(B(1), B(2), 'x', 'linewidth', 10, 'col', 'y');
    % Punkt C
    plot(C(1), C(2), 'x', 'linewidth', 10, 'col', 'y');
    % Punkt D
    plot(D(1), D(2), 'x', 'linewidth', 10, 'col', 'y');
    hold off;
    
    % Anmerkung: Hier wird lediglich die obere Halbkugel betrachtet!
    