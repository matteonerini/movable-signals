clear; clc;
rng(3);

% Parameters
nMonte = 1e4;
Ns = 32:32:32*8;

% Other needed parameters not affecting the final result
dA = 0.05;
dR = 7;
dT = 9;

Gain_FIS = zeros(nMonte,length(Ns));
Gain_RIS = zeros(nMonte,length(Ns));
for iMonte = 1:nMonte
    for iN = 1:length(Ns)
        N = Ns(iN);

        ns = 1:N;
        xs = (ns - (N+1)/2) * dA;

        % Generate random angles thetaR and thetaT
        thetaR = pi*rand - pi/2;
        thetaT = pi*rand - pi/2;

        dRs = dR - xs * sin(thetaR);
        dTs = dT - xs * sin(thetaT);
        
        % Channels hR and hT and channel gain with FIS
        lambda_FIS = dA * abs(sin(thetaR) + sin(thetaT));
        hR_FIS = exp(-1i*2*pi*dRs/lambda_FIS);
        hT_FIS = exp(-1i*2*pi*dTs/lambda_FIS).';
        Gain_FIS(iMonte,iN) = 4 * norm(hR_FIS)^2 * norm(hT_FIS)^2;

        % Channels hR and hT and channel gain with RIS
        lambda_RIS = 2*dA;
        hR_RIS = exp(-1i*2*pi*dRs/lambda_RIS);
        hT_RIS = exp(-1i*2*pi*dTs/lambda_RIS).';
        Gain_RIS(iMonte,iN) = (abs(hR_RIS*hT_RIS) + norm(hR_RIS)*norm(hT_RIS)) ^ 2;
    end
end

Gain_FIS_av = squeeze(mean(Gain_FIS));
Gain_RIS_av = squeeze(mean(Gain_RIS));

%% Plot
figure('defaultaxesfontsize',14,'defaulttextinterpreter','latex','defaultAxesTickLabelInterpreter','latex','defaultLegendInterpreter','latex');
LineW = 1.8; MarkS = 8;
hold on;
plot(Ns,Gain_FIS_av,'-h','linewidth',LineW,'MarkerSize',MarkS,'DisplayName','Movable signals + FIS')

plot(Ns,Gain_RIS_av,'-d','linewidth',LineW,'MarkerSize',MarkS,'DisplayName','RIS')
plot(Ns,4*Ns.^2,'--p','linewidth',LineW,'MarkerSize',MarkS,'DisplayName','$4N^2$')
plot(Ns,Ns.^2+sqrt(pi)*sqrt(Ns).*Ns+Ns,'--o','linewidth',LineW,'MarkerSize',MarkS,'DisplayName','$N^2+\sqrt{\pi N}N+N$')
grid on; box on;
set(gca,'GridLineStyle',':','GridAlpha',0.5,'LineWidth',1.2);
xlim([min(Ns) max(Ns)])
xticks([0,Ns])
xlabel('Number of elements $N$');
ylabel('Received power $P_R$');
legend('location','northwest','NumColumns',2);
set(gcf, 'Color', [1,1,1]);
set(gca, 'LineWidth',1.5);