clear; clc;

thetaTs = linspace(-pi/2,pi/2,1e3);
Fs = [1.1, 1.2, 1.4, 1.8];

Cov = zeros(length(thetaTs),length(Fs));
for iThetaT = 1:length(thetaTs)
    thetaT = thetaTs(iThetaT);
    for iF = 1:length(Fs)
        F = Fs(iF);
        if thetaT <=0
            Cov(iThetaT,iF) = func_coverage(thetaT, F);
        else
            Cov(iThetaT,iF) = func_coverage(-thetaT, F);
        end
    end
end

%% Plot
figure('defaultaxesfontsize',14,'defaulttextinterpreter','latex','defaultAxesTickLabelInterpreter','latex','defaultLegendInterpreter','latex');
LineW = 1.8; MarkS = 8;
hold on;
plot(thetaTs,Cov(:,4),'-','linewidth',LineW,'MarkerSize',MarkS,'DisplayName','$W=1.8$');
plot(thetaTs,Cov(:,3),'-','linewidth',LineW,'MarkerSize',MarkS,'DisplayName','$W=1.4$');
plot(thetaTs,Cov(:,2),'-','linewidth',LineW,'MarkerSize',MarkS,'DisplayName','$W=1.2$');
plot(thetaTs,Cov(:,1),'-','linewidth',LineW,'MarkerSize',MarkS,'DisplayName','$W=1.1$');
grid on; box on;
set(gca,'GridLineStyle',':','GridAlpha',0.5,'LineWidth',1.2);
xlim([-pi/2 pi/2])
xticks(-pi/2:pi/4:pi/2)
xticklabels({'$-\frac{\pi}{2}$','$-\frac{\pi}{4}$','$0$','$\frac{\pi}{4}$','$\frac{\pi}{2}$'})
ylim([0 0.7*pi])
yticks(0:0.1*pi:0.7*pi)
yticklabels({'$0$','$0.1\pi$','$0.2\pi$','$0.3\pi$','$0.4\pi$','$0.5\pi$','$0.6\pi$','$0.7\pi$'})
xlabel('Transmitter direction $\theta_T$ [rad]');
ylabel('Coverage $C$ [rad]');
legend('location','southwest');
set(gcf, 'Color', [1,1,1]);
set(gca, 'LineWidth',1.5);

%% Function
function Cov = func_coverage(thetaT, F)

    thetaR_L = -asin((1+(F-1)*sin(thetaT))/F);
    thetaR_R = +asin((1-(F+1)*sin(thetaT))/F);

    if thetaT <= asin((1-F)/(1+F))
        Cov = thetaR_L + pi/2;
    elseif thetaT > asin((1-F)/(1+F)) && thetaT<=0
        Cov = pi + thetaR_L - thetaR_R;
    end

end