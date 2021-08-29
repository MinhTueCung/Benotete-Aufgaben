Cn = komplex_fourierzerlegung(4, 8);
disp('Cn ist:');
disp(Cn);
x_fuer_xk_2 = (0:0.125:3.875);

stem(X,abs(Cn));
grid on;
xticks(0:0.25:X(end));
hold on;
xk2 = 2 .* x_fuer_xk_2;
Sn2 = dft(32.0, xk2);
disp('Sn2 ist:');
disp(Sn2);

stem(x_fuer_xk_2,abs(Sn2));
hold off;

function list_of_cn = komplex_fourierzerlegung(T, n)
    list_of_cn = [];
    for k=0:n-1
       ft = @(t) 2 .* t .* exp((-1i * k * (2*pi/T)) .* t); 
       wert = 0;
       wert = wert + integral(ft, 0, T);
       wert = wert/T;
       list_of_cn = [list_of_cn, wert];
    end
end

function array_S = dft(N, xk_array)
    array_S = [];
    if N == 0
        disp('Invalid N argument');
    else
        for n=0:(N-1)
            wert = 0;
            for k=0:(N-1)
               wert = wert + xk_array(k+1) * exp(-1i * (2*pi/N) * n * k); 
            end
            wert = wert * (1/N);
            array_S = [array_S, wert];
        end
    end
end