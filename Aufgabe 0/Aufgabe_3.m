% Taylor Approximation von cos(x) bis 5. Ordnung
% Minh Tue Cung - 5081738 - 12.11.2020

% Default: x0 = 0
x0 = 0;
array_von_Grafiken = taylor_cos(x0);

function array_von_Grafiken_von_1_bis_5_Ordnung = taylor_cos(x0)
    x_Intervall = [-2 5]; % Als Default
    color = {'b';'g';'r';'c';'m';'y'};
    
    % 1. Ordnung
    func_1 = @(x) cos(x0) - sin(x0)*(x-x0);
    array_von_Grafiken_von_1_bis_5_Ordnung(1) = fplot(func_1, x_Intervall);
    set(array_von_Grafiken_von_1_bis_5_Ordnung(1),'color',color{1},'linewidth',1.5);
    
    % Bisschen Settings
    hold on;
    grid on;
    xlabel('x');
    ylabel('y');
    title('Approximation der Cosinusfunktion bis 5. Ordnung, Entwicklung um x = x0');
    
    % 2. Ordnung
    func_2 = @(x) func_1(x) - cos(x0)/2*((x-x0).^2);
    array_von_Grafiken_von_1_bis_5_Ordnung(2) = fplot(func_2, x_Intervall);
    set(array_von_Grafiken_von_1_bis_5_Ordnung(2),'color',color{2},'linewidth',1.5);
    
    % 3. Ordnung
    func_3 = @(x) func_2(x) + sin(x0)/6*((x-x0).^3);
    array_von_Grafiken_von_1_bis_5_Ordnung(3) = fplot(func_3, x_Intervall);
    set(array_von_Grafiken_von_1_bis_5_Ordnung(3),'color',color{3},'linewidth',1.5);
    
    % 4. Ordnung
    func_4 = @(x) func_3(x) + cos(x0)/24*((x-x0).^4);
    array_von_Grafiken_von_1_bis_5_Ordnung(4) = fplot(func_4, x_Intervall);
    set(array_von_Grafiken_von_1_bis_5_Ordnung(4),'color',color{4},'linewidth',1.5);
    
    % 5. Ordnung
    func_5 = @(x) func_4(x) - sin(x0)/120*((x-x0).^5);
    array_von_Grafiken_von_1_bis_5_Ordnung(5) = fplot(func_5, x_Intervall);
    set(array_von_Grafiken_von_1_bis_5_Ordnung(5),'color',color{5},'linewidth',1.5);
    
    % Wieder bisschen Settings
    legend(array_von_Grafiken_von_1_bis_5_Ordnung,'f1(x) = cos(x0) - sin(x0)(x-x0)',...
           'f2(x) = f1(x) - (cos(x0)/2) * (x-x0)^2', ...
           'f3(x) = f2(x) + (sin(x0)/6)*(x-x0)^3', ...
           'f4(x) = f3(x) + (cos(x0)/24) * (x-x0)^4', ...
           'f5(x) = f4(x) - (sin(x0)/120) * (x-x0)^5', ...
           'location', 'south');
    hold off;
end