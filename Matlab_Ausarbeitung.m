load Messung_3_4_3_Matlab_Tue.mat

x = Trace_2(:,1) % Die Zeitdaten;
y = Trace_2(:,2) % Die momentanen Spannungsdaten;

func = @(param,x) (x < param(1))*param(2) + (x >= param(1)).* ...
                        param(3).*(param(4) - exp(((-1) .* x)/param(5)));                           
                           
param_init = [-1.9e-5,0.002,5,1.1,0.00001];

param_opt = lsqcurvefit(func, param_init, x, y);

disp(param_opt(5)) % Zeitkonstante herausnehmen = 3,2838 * 10^(-5);

scatter(x,y);
hold on;
grid on;
plot(x,func(param_opt, x));
hold off;