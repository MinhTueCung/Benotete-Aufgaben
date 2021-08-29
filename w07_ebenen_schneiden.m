function ebenen_schneiden()

x1=@(x,y) x;
y1=@(x,y) y;
z1=@(x,y) x+2*y-1;

x2=@(x,y) x;
y2=@(x,y) y;
z2=@(x,y) 1-x+y;
limits = [-1,2,-1,2];
fsurf(x1,y1,z1,limits)
hold on
fsurf(x2,y2,z2,limits)
xlabel('X'), ylabel('Y'),zlabel('Z')

%% Schnittlinie
xs=@(x) x;
ys=@(x) 2-2*x;
zs=@(x) 3-3*x;
fplot3(xs,ys,zs,[0,3/2],'y','linewidth',2)
hold off
