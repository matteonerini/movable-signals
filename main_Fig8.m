clear; clc;

thetaTs = [-pi/2,-pi/3,-pi/4,-pi/6,0];
thetaRs = linspace(-pi/2,pi/2,1e3);

f_fA = zeros(length(thetaTs),length(thetaRs));
for i = 1:length(thetaTs)
    f_fA(i,:) = 1 ./ abs(sin(thetaTs(i)) + sin(thetaRs));
end

%% Plot
figure('defaultaxesfontsize',14,'defaulttextinterpreter','latex','defaultAxesTickLabelInterpreter','latex','defaultLegendInterpreter','latex');
LineW = 1.8; MarkS = 8;
hold on;
plot(thetaRs,f_fA(5,:),'linewidth',LineW,'MarkerSize',MarkS,'DisplayName','$\theta_T=0$');
%plot(alphaR,f_fA(4,:),'linewidth',LineW,'MarkerSize',MarkS,'DisplayName','$\theta_T=-\pi/6$');
plot(thetaRs,f_fA(3,:),'linewidth',LineW,'MarkerSize',MarkS,'DisplayName','$\theta_T=-\pi/4$');
plot(thetaRs,f_fA(2,:),'linewidth',LineW,'MarkerSize',MarkS,'DisplayName','$\theta_T=-\pi/3$');
plot(thetaRs,f_fA(1,:),'linewidth',LineW,'MarkerSize',MarkS,'DisplayName','$\theta_T=-\pi/2$');
grid on; box on;
set(gca,'GridLineStyle',':','GridAlpha',0.5,'LineWidth',1.2);
xlim([-pi/2 pi/2])
ylim([0 8])
xticks(-pi/2:pi/4:pi/2)
yticks(0:8)
xticklabels({'$-\frac{\pi}{2}$','$-\frac{\pi}{4}$','$0$','$\frac{\pi}{4}$','$\frac{\pi}{2}$'})
xtickangle(0)
xlabel('Receiver direction $\theta_R$ [rad]');
ylabel('Optimal frequency $f^\star/f_A$');
legend('location','northwest');
set(gcf, 'Color', [1,1,1]);
set(gca, 'LineWidth',1.5);