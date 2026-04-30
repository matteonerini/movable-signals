clear; clc;

thetaT = 0; % Tx angle [rad] 0 or -pi/2
Ws = [1.1,1.2,1.4,1.8];
gain_mean = nan(length(Ws),3);
for iW = 1:length(Ws)
    W = Ws(iW);
    load(['fig-PR-thetaR-W',strrep(num2str(W),'.',''),'-thetaT',strrep(num2str(thetaT*(-2/pi)),'.','')]);
    gain_mean(iW,1) = mean(max(gain_T_opt,[],2));
    gain_mean(iW,2) = mean(max(gain_T_fix,[],2));
    gain_mean(iW,3) = mean(gain_T_opt(:,1));
end

%% Plot
figure('defaultaxesfontsize',14,'defaulttextinterpreter','latex','defaultAxesTickLabelInterpreter','latex','defaultLegendInterpreter','latex');
LineW = 1.8; MarkS = 8;
hold on;
yline(1e9*((c/f_min)^2/((4*pi*dR)*(4*pi*dT))).^2*4*N^2,'-k','linewidth',LineW,'DisplayName','Upper bound');
plot(Ws,1e9*gain_mean(:,1),'--h','linewidth',LineW,'color',[0.4660, 0.6740, 0.1880],'MarkerSize',MarkS,'DisplayName','Movable signals + RIS');
plot(Ws,1e9*gain_mean(:,2),'-d', 'linewidth',LineW,'color',[0.8500, 0.3250, 0.0980],'MarkerSize',MarkS,'DisplayName','Movable signals + FIS');
plot(Ws,1e9*gain_mean(:,3),'-o', 'linewidth',LineW,'color',[0.0000, 0.4470, 0.7410],'MarkerSize',MarkS,'DisplayName','RIS');
grid on; box on;
set(gca,'GridLineStyle',':','GridAlpha',0.5,'LineWidth',1.2);
xlim([1 1.8])
ylim([0 0.6])
xticks(Ws)
xlabel('Frequency range width $W=f_{\textrm{max}}/f_{\textrm{min}}$');
ylabel('Received power $P_R$ [nW]');
legend('location','northwest');
set(gcf, 'Color', [1,1,1]);
set(gca, 'LineWidth',1.5);