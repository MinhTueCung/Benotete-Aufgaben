func = taylor_wurzel_x_4_te_Ordnung(1); %Entwicklungspunkt x0 = 1
origi_func = @(x) sqrt(x); % Ursprüngliche Funktion
zu_untersuchender_x_Intervall = (0:0.01:3); % X Intervall
% sqrt(x) ist nur gültig mit x >= 0 -> Grund, warum Intervall (0:3) gewählt!
% 0.01 Abstand zwischen den Elementen im Intervall, um die Differenz später
% zu untersuchen ("Einzoomen auf 2 Nachkommastellen")
col = {'b';'g';'r';'c';'m';'y'};

y_origi = origi_func(zu_untersuchender_x_Intervall);
y_taylor = func(zu_untersuchender_x_Intervall);
y_differenz = abs(y_origi - y_taylor);

% 2 Grenzen bestimmen, zwischen denen y_differenz stets < 0.1 ist, mit Hilfe 2 Loops 
grenze_1 = 1;
while grenze_1 <= length(y_differenz)
   if y_differenz(grenze_1) < 0.1
       break
   end
   grenze_1 = grenze_1 + 1;
end

grenze_2 = length(y_differenz);
while grenze_2 >= 1
   if y_differenz(grenze_2) < 0.1
       break
   end
   grenze_2 = grenze_2 - 1;
end

disp(grenze_1);
disp(grenze_2);
disp(y_differenz);

% Definiere die Taylorapproximation 4. Ordnung
function entwicklung_func = taylor_wurzel_x_4_te_Ordnung(x_0)
    entwicklung_func_1 = @(x) sqrt(x_0) + (1 / (2 * sqrt(x_0)))*(x - x_0);
    entwicklung_func_2 = @(x) entwicklung_func_1(x) - ((1/4)*(x_0 ^ (-3/2)))/2 * ((x-x_0).^2);
    entwicklung_func_3 = @(x) entwicklung_func_2(x) + ((3/8)*(x_0 ^ (-5/2)))/6 * ((x-x_0).^3);
    entwicklung_func_4 = @(x) entwicklung_func_3(x) + ((-15/16)*(x_0 ^ (-7/2)))/24 * ((x-x_0).^4);
    entwicklung_func = entwicklung_func_4;
end