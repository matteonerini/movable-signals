clear; clc;
rng(3);

% Variable parameters
W = 1.1; % Frequency range width 1.1, 1.2, 1.4, or 1.8
thetaT = 0; % Tx angle [rad] 0 or -pi/2

% Fixed parameters
nThetaRs = 1e3; % Number of Rx angles
thetaRs = linspace(-pi/2,pi/2,nThetaRs); % Rx angles [rad]
f_min = 8e9; % Frequency f_min [Hz]
fA = f_min * (1+abs(sin(thetaT))); % Frequency fA [Hz]
c = 299792458; % Speed of light [m/s]
dA = c/fA; % Antenna spacing [m]
dR = 5; dT = 10; % Rx and Tx distance [m]
N = 64; % Number of elements
switch W % Number of subcarriers
    case 1.1, S = 128; case 1.2, S = 256; case 1.4, S = 512; case 1.8, S = 1024;
end
freqs = linspace(f_min,W*f_min,S);

% Main loop
gain_T_fix = nan(length(thetaRs),S);
gain_T_opt = nan(length(thetaRs),S);
for iThetaR = 1:nThetaRs
    thetaR = thetaRs(iThetaR);
    for s = 1:S
        freq = freqs(s);
        lambda = c / freq;

        hR = lambda / (4*pi*dR) * exp(-1i*2*pi*(dR - ((1:N) - (N+1)/2) * dA * sin(thetaR))/lambda);
        hT = lambda / (4*pi*dT) * exp(-1i*2*pi*(dT - ((1:N) - (N+1)/2) * dA * sin(thetaT))/lambda).';

        gain_T_fix(iThetaR,s) = 4 * abs(hR * hT)^2;
        Theta_opt = sign(real(-hR*hT)) * diag(sign(real(hR.*hT.')));
        gain_T_opt(iThetaR,s) = abs(hR*Theta_opt*hT - hR*hT)^2;
    end
end

%% Save Data
save(['fig-PR-thetaR-W',strrep(num2str(W),'.',''),'-thetaT',strrep(num2str(thetaT*(-2/pi)),'.','')], ...
      'W','thetaT','thetaRs','f_min','c','dR','dT','N','gain_T_fix','gain_T_opt');

%% Plot
gain_T_fix_max = max(gain_T_fix,[],2);
gain_T_opt_max = max(gain_T_opt,[],2);
gain_T_opt_1 = gain_T_opt(:,1);

figure('defaultaxesfontsize',18,'defaulttextinterpreter','latex','defaultAxesTickLabelInterpreter','latex','defaultLegendInterpreter','latex');
LineW = 2.8; MarkS = 8;
hold on;
plot(thetaRs,1e9*gain_T_opt_1,'-','linewidth',LineW,'MarkerSize',MarkS,'DisplayName','RIS');
plot(thetaRs,1e9*gain_T_fix_max,'-','linewidth',LineW,'MarkerSize',MarkS,'DisplayName','Movable signals + FIS');
plot(thetaRs,1e9*gain_T_opt_max,'--','linewidth',LineW,'color',[0.4660, 0.6740, 0.1880],'MarkerSize',MarkS,'DisplayName','Movable signals + RIS');
yline(1e9*((c/f_min)^2/((4*pi*dR)*(4*pi*dT))).^2*4*N^2,'-k','linewidth',LineW,'DisplayName','Upper bound');
grid on; box on;
set(gca,'GridLineStyle',':','GridAlpha',0.5,'LineWidth',1.2);
xlim([-pi/2 pi/2])
if thetaT == 0
    thetaR_L = -asin(1/W);
    thetaR_R =  asin(1/W);
    xticks([-pi/2,thetaR_L,-pi/6,0,pi/6,thetaR_R,pi/2])
    xticklabels({'$-\frac{\pi}{2}$','$\theta_R^-$','$-\frac{\pi}{6}$','$0$','$\frac{\pi}{6}$','$\theta_R^+$','$\frac{\pi}{2}$'})
    area([-pi/2 thetaR_L],[0.6 0.6],'FaceColor',[0.9290, 0.6940, 0.1250],'FaceAlpha',0.15,'HandleVisibility','off');
    area([thetaR_R +pi/2],[0.6 0.6],'FaceColor',[0.9290, 0.6940, 0.1250],'FaceAlpha',0.15,'HandleVisibility','off');
elseif thetaT == -pi/2
    thetaR_L = -asin((2-W)/W);
    if thetaR_L < -pi/6
        xticks([-pi/2,thetaR_L,-pi/6,0,pi/6,pi/2])
        xticklabels({'$-\frac{\pi}{2}$','$\theta_R^-$','$-\frac{\pi}{6}$','$0$','$\frac{\pi}{6}$','$\frac{\pi}{2}$'})
    else
        xticks([-pi/2,-pi/6,thetaR_L,0,pi/6,pi/2])
        xticklabels({'$-\frac{\pi}{2}$','$-\frac{\pi}{6}$','$\theta_R^-$','$0$','$\frac{\pi}{6}$','$\frac{\pi}{2}$'})
    end
    area([-pi/2 thetaR_L],[0.6 0.6],'FaceColor',[0.9290, 0.6940, 0.1250],'FaceAlpha',0.15,'HandleVisibility','off');
else
    xticks([-pi/2,-pi/6,0,pi/6,pi/2])
    xticklabels({'$-\frac{\pi}{2}$','$-\frac{\pi}{6}$','$0$','$\frac{\pi}{6}$','$\frac{\pi}{2}$'})
end
yticks(0:0.1:0.6)
xlabel('Receiver direction $\theta_R$ [rad]');
ylabel('Received power $P_R$ [nW]');
children = get(gca, 'Children');
if W == 1.1
    legend(children(1:end),'location','northwest','fontsize',15);
end
set(gcf, 'Color', [1,1,1]);
set(gca, 'LineWidth',1.5);