clear; clc;

Ws = [1.1,1.2,1.4,1.8];
gain_mean = nan(length(Ws),3);
for iW = 1:length(Ws)
    W = Ws(iW);
    load(['fig-PR-theta-W',strrep(num2str(W),'.','')]);
    gain_mean(iW,1) = mean(max(gain_w_opt,[],2));
    gain_mean(iW,2) = mean(max(gain_w_fix,[],2));
    gain_mean(iW,3) = mean(gain_w_opt(:,1));
end

%% Plot
figure('defaultaxesfontsize',14,'defaulttextinterpreter','latex','defaultAxesTickLabelInterpreter','latex','defaultLegendInterpreter','latex');
LineW = 1.8; MarkS = 8;
hold on;
yline(1e6*((c/f_min)/(4*pi*d))^2*N,'-k','linewidth',LineW,'DisplayName','Upper bound');
plot(Ws,1e6*gain_mean(:,1),'--h','linewidth',LineW,'color',[0.4660, 0.6740, 0.1880],'MarkerSize',MarkS,'DisplayName','Movable signals + EGT');
plot(Ws,1e6*gain_mean(:,2),'-d', 'linewidth',LineW,'color',[0.8500, 0.3250, 0.0980],'MarkerSize',MarkS,'DisplayName','Movable signals');
plot(Ws,1e6*gain_mean(:,3),'-o', 'linewidth',LineW,'color',[0.0000, 0.4470, 0.7410],'MarkerSize',MarkS,'DisplayName','EGT');
grid on; box on;
set(gca,'GridLineStyle',':','GridAlpha',0.5,'LineWidth',1.2);
xlim([1 1.8])
ylim([0 6])
xticks(Ws)
xlabel('Frequency range width $W=f_{\textrm{max}}/f_{\textrm{min}}$');
ylabel('Received power $P_R$ [uW]');
legend('location','northwest');
set(gcf, 'Color', [1,1,1]);
set(gca, 'LineWidth',1.5);