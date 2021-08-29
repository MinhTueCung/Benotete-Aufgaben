% Testskript
% Einführungsübung Matlab - ELMESS WiSe 20/21
% Minh Tue Cung, 16.09.1999

figure(1); 
clf;
set(gcf,'units','normalized','position',[0.05 0.4 0.3 0.5]);
ax1 = subplot(2,1,1);
hold on;
col = {'b';'g';'r';'c';'m';'y'};
xymax = [-2 5];
fsin = @(x) sin(x);
hdl0 = fplot(fsin, xymax);
grid on; 
set(hdl0,'color',col{1},'linewidth',1.5);
% Taylor-Polynome
x_0 = 0;
hdls = plot_taylor_sin(x_0, xymax, col);
legend([hdl0,hdls],'f(x) = sin(x)','t1(x) = x', 't3(x) = x-x^3/6', ... 
     't5(x) = x-x^3/6+x^5/120', 'location', 'south')
ax1.XAxisLocation = 'origin'; 
ax1.YAxisLocation = 'origin';
xlabel('x'), 
ylabel('y');
title('Approximation der Sinusfunktion, Entwicklung um x=0');
hold off;


ax2 = subplot(2,1,2);
hold on;
fsin = @(x) sin(x);
hdl0 = fplot(fsin, xymax);
grid on; 
set(hdl0,'color',col{1},'linewidth',1.5);
% Taylor-Polynome
x_0 = pi;
hdls = plot_taylor_sin(x_0, xymax, col);
legend([hdl0,hdls],'f(x) = sin(x)','t1(x) = -(x-\pi)', ...
 't3(x) = -(x-\pi)+(x-\pi)^3/6', ...
 't5(x) = -(x-\pi)+(x-\pi)^3/6-(x-\pi)^5/120', 'location', 'south');
ax2.XAxisLocation = 'origin'; 
ax2.YAxisLocation = 'origin';
xlabel('x'), ylabel('y');
title('Approximation der Sinusfunktion, Entwicklung um x=\pi');
set([ax1,ax2],'ylim',[-3,3]);
hold off;


function hdls = plot_taylor_sin(x_0, xymax, col)
     % Taylor-Approximationen
     % Glieder mit i = 0, 2, 4, ... treten bei sin(x) nicht auf.
     % Polynom 1. Ordnung
     tfun1 = @(x) cos(x_0)*(x-x_0);
     hdls(1) = fplot(tfun1, xymax);
     set(hdls(1),'color',col{2});
     % Polynom 3. Ordnung
     tfun3 = @(x) tfun1(x) - cos(x_0)/6*(x-x_0).^3;
     hdls(2) = fplot(tfun3,xymax);
     set(hdls(2),'color',col{3});
     % Polynom 5. Ordnung
     tfun5 = @(x) tfun3(x) + cos(x_0)/factorial(5)*(x-x_0).^5;
     hdls(3) = fplot(tfun5,xymax);
     set(hdls(3),'color',col{4});
end


