function Fourier_DFT()
    T = 2; % Periode
    Ts = 0.25; % Abtastzeit
    Ts_2 = 1/8; % 2. Abtastzeit
    N = 8; % Zahl der Abtastwerte
    c0 = 2 - pi/2; % c0 = a0/2. Gleichanteil der komplexen Fourier-Transformation
    fT = @(t) pi .* sin((pi/4).*t) - (pi/2); % Originalfunktion 
    f = @(t) fT(mod(t, T)); % Periodische Erweiterung der Funktion 
    cn = @(n) (1 - 4*i*n) / (8*(1/16 - n^2)); % cn: Koeffiziente der komplexen Fourier-Transformation
    t_limit_Diagramm_1 = [-1, 5]; % Zeitraster fürs 1. Diagramm
    t_Diagramm_2 = (0:Ts:1.75); % Zeitraster fürs 2. Diagramm (8 Werte)
    x_Abtastfolge = f(t_Diagramm_2); % Xk (Abtastfolge) mit 8 Werten
    % Fourier: Gleichanteil + Grundschwingung
    f_komplex_fourier_gleich_und_grundschw = @(t) c0 + cn(-1)*exp(-1i*(2*pi/T)*t) + cn(1)*exp(1i*(2*pi/T)*t);
    % Fourier: bis 3. Ornung
    f_komplex_fourier_bis_dritter_Harm = @(t) f_komplex_fourier_gleich_und_grundschw(t) + ...
                                        cn(-2)*exp(-2i*(2*pi/T)*t) + cn(2)*exp(2i*(2*pi/T)*t) + ...
                                        cn(-3)*exp(-3i*(2*pi/T)*t) + cn(3)*exp(3i*(2*pi/T)*t);
    % Array von Cn Werten (Cn: Koeffiziente der komplexen Fourier-Transformation)
    % Array: C0 -> C8 (8. Harmonische)
    cn_array_von_0_bis_8_Harm = [c0];

    for j=1:8
        cj = cn(j);
        cn_array_von_0_bis_8_Harm = [cn_array_von_0_bis_8_Harm, cj];
    end
    % Amplitude A
    A_array_von_0_bis_8_Harm = 2 .* abs(cn_array_von_0_bis_8_Harm);
    
    % Array von Sn: DFT, von 0 -> 7 = N - 1
    Sn_array_von_0_bis_7 = [];
    for m=0:N-1
        Sn = berechne_Sn(m,N,x_Abtastfolge);
        Sn_array_von_0_bis_7 = [Sn_array_von_0_bis_7, Sn];
    end    
    % Amplitude A von Sn
    A_Sn_array_von_0_bis_7 = 2 .* abs(Sn_array_von_0_bis_7);
          

    
    figure(1)
    set(gcf,'units','normalized','position',[0.08,0.1,0.5,0.7])
    clf
    
    % 1. Diagramm
    hax(1) = subplot(3,1,1);
    hf = fplot(f, t_limit_Diagramm_1, 'color','b'); % Die Originalfunktion
    grid on;
    xlabel('Zeit (s)');
    title('Fourierapproximation einer Funktion, Harmonische');
    hold on;
    set(hax(1),'ytick',-2:0.5:2);
    % Fourier: Gleichanteil + Grundschwingung
    hf_1 = fplot(f_komplex_fourier_gleich_und_grundschw, t_limit_Diagramm_1, 'color','g');
    % Fourier: bis 3. Ornung
    hf_2 = fplot(f_komplex_fourier_bis_dritter_Harm, t_limit_Diagramm_1, 'color','r');
    legend('f(t)','Fourier Gleichanteil + Grundschwingung', 'Fourier bis 3. harmonischer Schw.');
    hold off;
    
    % 2. Diagramm
    hax(2) = subplot(3,1,2);
    fn = (0:1:N); % bis 8. Harmonische (Komplexe Fourier Trans.)
    fn = fn./T; % Frequenz: Im Verhältnis zu Abtastrate fs: 9 Werte
    % Es werden nur 8 Werte für Sn berechnet (0 -> N - 1 = 7)
    fn_Sn = fn(:,1:end-1); % --> den letzten Wert von fn abschneiden 
    % Amplitudenspektrum von Cn
    h3 = stem(hax(2),fn,A_array_von_0_bis_8_Harm,'linewidth',2,'color','b');
    grid on;
    xlabel('Frequenz (Hz)');
    title('Amplitudenspektrum (Ts = 0,25 s)');
    set(hax(2),'ylim',[0,2]);
    hold on;
    set(hax(2),'ytick',0:0.25:2);
    % Amplitudenspektrum von Sn
    h4 = stem(hax(2),fn_Sn,A_Sn_array_von_0_bis_7,'linewidth',2,'color','r');
    legend('Amplitude (Cn)','Amplitude (Sn)');
    hold off;
    
    % 3. Diagramm
    hax(3) = subplot(3,1,3);
    N_2 = 16; % Diesmal N = 16
    fn_2 = (0:1:N_2-1); % Diesmal nehmen wir genau 16 Werte
    fn_2 = fn_2./T; 
    t_Diagramm_3 = (0:Ts_2:1.875); % Zeitraster fürs 3. Diagramm
    x_Abtastfolge_2 = f(t_Diagramm_3); % Xk (Abtastfolge) mit 16 Werten
    Sn_array_von_0_bis_15 = []; % Neuer Sn Array
    for m=0:N_2-1
        % Wir berücksichtigen nur die DFT-Werte bis fs/2
        if m <= N_2/2
            Sn = berechne_Sn(m,N_2,x_Abtastfolge_2);
            Sn_array_von_0_bis_15 = [Sn_array_von_0_bis_15, Sn];
        else
            Sn_array_von_0_bis_15 = [Sn_array_von_0_bis_15, NaN];
        end
    end    
    % Amplituden von Sn
    A_Sn_array_von_0_bis_15 = 2 .* abs(Sn_array_von_0_bis_15);
    h5 = stem(hax(3),fn_2,A_Sn_array_von_0_bis_15,'linewidth',2,'color','r');
    hold on;
    set(hax(3),'ytick',0:0.25:1.5);
    grid on;
    xlabel('Frequenz (Hz)');
    title('Amplitudenspektrum (Ts = 1/8 s)');
    set(hax(2),'ylim',[0,2]);
    % Amplituden von Cn
    h6 = stem(hax(3),fn,A_array_von_0_bis_8_Harm,'linewidth',2,'color','b');
    legend('Amplitude (Sn)','Amplitude (Cn)');
    hold off;
    
    
    
    % Funktion, die Sn (DFT) berechnet
    function Sn = berechne_Sn(n,N,x_Abtastfolge) 
        summe = 0;
        for k=0:N-1
            summe = summe + x_Abtastfolge(k+1)*exp(-1i*(2*pi/N)*n*k);
        end
        Sn = (1/N)*summe;
    
    