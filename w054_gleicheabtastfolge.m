function gleicheabtastfolge()
% Alias: Verschiedene Signale mit gleicher Abtastfolge
close all
f=@(t) cos(2*pi*90*t);
g=@(t) cos(2*pi*110*t);
TS=0.005;
k=0:50;
TM = k(end)*TS;
figure(1); set(gcf,'units','normalized','position',[0.08 0.4 0.7 0.5])
plot(k'*TS,f(k*TS)','o-', k*TS, g(k*TS)','x-','linewidth',2)
hold on
fplot(f,[0,TM],'b')
fplot(g,[0,TM],'r')
hold off
title('$ f(t)=\cos(2\pi\cdot 90 t)\ und\ g(t)=\cos(2\pi\cdot 110 t)\ mit\ f_S=200\,Hz\ abgetastet $',...
    'interpreter','latex','fontsize',16)
