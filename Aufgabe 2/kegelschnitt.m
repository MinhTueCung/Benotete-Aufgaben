function [zmin,zmax] = kegelschnitt(R)
% (23.12.2020) von Cung, Minh Tue (5081738)
    if nargin == 0, R = 2; end % Default-Wert des Radius
    
    % Kegelmantel: Parameterform (Herleitung: siehe Aufg. 1)
    x_kegel = @(t,phi) (R - t./4).*cos(phi);
    y_kegel = @(t,phi) (R - t./4).*sin(phi);
    z_kegel = @(t,phi) t;
    
    % Ebene: Parameterform (Herleitung: siehe Aufg. 1)
    x_ebene = @(u,v) v;
    y_ebene = @(u,v) (3/2)*R.*(1-u);
    z_ebene = @(u,v) 3*R.*u;
    
    % Schnittlinie: Eine Ellipse der Form (Herleitung: siehe Aufg. 1)
    x_ellipse = @(t) t;
    % Hier Fallunterscheidung für y
    y_ellipse_fall_1 = @(t) (2/sqrt(3)).*((R/4/sqrt(3)) + sqrt(R^2/12 - x_ellipse(t).^2));
    y_ellipse_fall_2 = @(t) (2/sqrt(3)).*((R/4/sqrt(3)) - sqrt(R^2/12 - x_ellipse(t).^2));
    % Entsprechende Fallunterscheidung für z
    z_ellipse_fall_1 = @(t) 3*R - 2.*y_ellipse_fall_1(t);
    z_ellipse_fall_2 = @(t) 3*R - 2.*y_ellipse_fall_2(t);
    
    % Z von tiefstem Punkt der Schnittlinie = z_N = 2*R (siehe Herleitung Aufg. 1)
    zmin = 2*R;
    % Z von höchstem Punkt der Schnittlinie = z_H = 10*R/3 (siehe Herleitung Aufg. 1)
    zmax = 10*R/3;
    
    % Die Figur!
    figure(1);
    clf;
    set(gcf,'units','normalized','position',[0.05, 0.4, 0.7, 0.5]);
    
    % Linkes Diagramm (3D)
    subplot(1,2,1);
    % 't' hier spielt die Rolle von 'z' --> Intervall [0;4R] (4R = Höhe der Kegel)
    fsurf(x_kegel,y_kegel,z_kegel,[0 4*R 0 2*pi]);
    % Die Kegel durchsichtig machen!
    alpha 0.5;
    % gleichmäßig skalieren
    axis equal;
    xlabel('X');
    ylabel('Y');
    zlabel('Z');
    hold on;
    % Hier Intervall für 2 Parameter u,v für die Ebene angemessen wählen
    fsurf(x_ebene,y_ebene,z_ebene,[0 2 -4 4]);
    % durchsichtig machen!
    alpha 0.5;
    % Die erste Hälfte der Schnittlinie (Fall 1) plotten
    % X-Intervall eigentlich [-R/(2*sqrt(3)) R/(2*sqrt(3))], aber [-R R],
    % um größere Strecke von Werten zu decken
    fplot3(x_ellipse,y_ellipse_fall_1,z_ellipse_fall_1,[-R R],'linewidth',8,'color','r');
    % Die zweite Hälfte der Schnittlinie (Fall 2) plotten
    fplot3(x_ellipse,y_ellipse_fall_2,z_ellipse_fall_2,[-R R],'linewidth',8,'color','r');
    
    % Höchster Punkt H(0,-R/6,10R/3) hervorheben (Herleitung: siehe Aufg. 1)
    plot3(0,-R/6,10*R/3,'r*','linewidth',8,'color','y');
    % Tiefster Punkt N(0,R/2,2R) hervorheben (Herleitung: siehe Aufg. 1)
    plot3(0,R/2,2*R,'r*','linewidth',8,'color','y');
    
    % Ansicht wählen
    view(-40,-20);
    title('3D Figur (Kegel, Ebene, Schnittstelle)');
    hold off;
    
    
    % Rechtes Diagramm (2D)
    subplot(1,2,2);
    % X-Intervall diesmal genau [-R/(2*sqrt(3)) R/(2*sqrt(3))]
    % 1. Hälfte der Ellipse (Projektion in x-y Ebene)
    fplot(x_ellipse,y_ellipse_fall_1,[-R/(2*sqrt(3)) R/(2*sqrt(3))],'linewidth',5,'color','r');
    xlabel('X');
    ylabel('Y');
    hold on;
    % 2. Hälfte der Ellipse (Projektion in x-y Ebene)
    fplot(x_ellipse,y_ellipse_fall_2,[-R/(2*sqrt(3)) R/(2*sqrt(3))],'linewidth',5,'color','r');
    axis equal;
    % Die zu X-Achse parallele Hauptachse der Ellipse: CD! (Herleitung Aufg. 1)
    % x wird übergeben als Intervall, und y bleibt konstant bei R/6
    x_CD_hauptachse = @(x) R/6;
    % Die zu Y-Achse parallele Hauptachse der Ellipse: NH! (Herleitung Aufg. 1)
    % Hier in diesem Fall ist NH in der Y-Achse enthalten!
    % Array von Y-Werten wird übergeben, x bleibt dabei konstant bei 0
    y_NH_array = (-R/6:0.002:R/2); % -R/6 = yH (y von höchstem Punkt) | R/2 = yN (y von niedrigstem Punkt)
    x_NH_array = zeros(1,length(y_NH_array));
    
    % CD plotten 
    fplot(x_CD_hauptachse,[-R/(2*sqrt(3)) R/(2*sqrt(3))],'linewidth',5,'color','r');
    % NH plotten
    plot(x_NH_array,y_NH_array,'linewidth',5,'color','r');
    
    % H markieren
    plot(0,-R/6,'r*','linewidth',10,'color','y');
    % N markieren
    plot(0,R/2,'r*','linewidth',10,'color','y');
    % M markieren
    plot(0,R/6,'r*','linewidth',10,'color','y');
    % C markieren
    plot(-R/(2*sqrt(3)),R/6,'r*','linewidth',10,'color','y');
    % D markieren
    plot(R/(2*sqrt(3)),R/6,'r*','linewidth',10,'color','y');
    
    title('2D Projektion der Schnittlinie in x-y Ebene');
    hold off;
    