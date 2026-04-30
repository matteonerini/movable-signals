clear; clc;

Fs = 1:0.002:1.8;
Cov = pi - 2 * asin(1./Fs);

%% Plot
figure('defaultaxesfontsize',14,'defaulttextinterpreter','latex','defaultAxesTickLabelInterpreter','latex','defaultLegendInterpreter','latex');
LineW = 1.8; MarkS = 8;
hold on;
plot(Fs,Cov,'-','linewidth',LineW,'MarkerSize',MarkS,'DisplayName','Coverage');
grid on; box on;
set(gca,'GridLineStyle',':','GridAlpha',0.5,'LineWidth',1.2);
xlim([1 1.8])
xticks(1:0.1:1.8)
ylim([0 0.7*pi])
yticks(0:0.1*pi:0.7*pi)
yticklabels({'$0$','$0.1\pi$','$0.2\pi$','$0.3\pi$','$0.4\pi$','$0.5\pi$','$0.6\pi$','$0.7\pi$'})
xlabel('Frequency range width $W=f_{\textrm{max}}/f_{\textrm{min}}$');
ylabel('Coverage $C$ [rad]');
%legend('location','southwest');
set(gcf, 'Color', [1,1,1]);
set(gca, 'LineWidth',1.5);