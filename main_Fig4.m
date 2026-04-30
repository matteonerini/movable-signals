clear; clc;

thetas = linspace(-pi/2,pi/2,1e3);
f_fA = 1 ./ abs(sin(thetas));

%% Plot
figure('defaultaxesfontsize',14,'defaulttextinterpreter','latex','defaultAxesTickLabelInterpreter','latex','defaultLegendInterpreter','latex');
LineW = 1.8; MarkS = 8;
hold on;
plot(thetas,f_fA,'linewidth',LineW,'MarkerSize',MarkS,'DisplayName','$\theta_T=0$');
grid on; box on;
set(gca,'GridLineStyle',':','GridAlpha',0.5,'LineWidth',1.2);
xlim([-pi/2 pi/2])
xticks(-pi/2:pi/4:pi/2)
ylim([0 8])
yticks(0:8)
xticklabels({'$-\frac{\pi}{2}$','$-\frac{\pi}{4}$','$0$','$\frac{\pi}{4}$','$\frac{\pi}{2}$'})
xlabel('Receiver direction $\theta$ [rad]');
ylabel('Optimal frequency $f^\star/f_A$');
%legend('location','northwest');
set(gcf, 'Color', [1,1,1]);
set(gca, 'LineWidth',1.5);