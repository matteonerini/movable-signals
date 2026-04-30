clear; clc;

thetaT = -50; % -50 or -10
dist_over_lambda_min = 1 / (1 - sind(thetaT));
dist_over_lambda = dist_over_lambda_min * (1:0.1:1.8);
thetas = -pi/2:pi/1e3:pi/2;
N = 16;

P = nan(length(thetas),length(dist_over_lambda));
for i = 1: length(dist_over_lambda)
    hT = exp(1i * 2 * pi * (0:(N-1))' * dist_over_lambda(i) * sind(thetaT)) / sqrt(N);
    HR = exp(1i * 2 * pi * (0:(N-1))' * dist_over_lambda(i) * sin(thetas)).' / sqrt(N);
    P(:,i) = HR * hT;
end

%% Plot
figure('defaulttextinterpreter','latex','defaultLegendInterpreter','latex');
LineW = 1.8; MarkS = 8; cmap = jet(9);
polarplot(thetas,abs(P(:,1)).^2,'Color',cmap(9,:),'linewidth',LineW,'MarkerSize',MarkS,'DisplayName','$f = f_\textrm{min}$');
hold on;
polarplot(thetas,abs(P(:,2)).^2,'Color',cmap(8,:),'linewidth',LineW,'MarkerSize',MarkS,'DisplayName','$f = 1.1 f_\textrm{min}$');
polarplot(thetas,abs(P(:,3)).^2,'Color',cmap(7,:),'linewidth',LineW,'MarkerSize',MarkS,'DisplayName','$f = 1.2 f_\textrm{min}$');
polarplot(thetas,abs(P(:,4)).^2,'Color',cmap(6,:),'linewidth',LineW,'MarkerSize',MarkS,'DisplayName','$f = 1.3 f_\textrm{min}$');
polarplot(thetas,abs(P(:,5)).^2,'Color',cmap(5,:),'linewidth',LineW,'MarkerSize',MarkS,'DisplayName','$f = 1.4 f_\textrm{min}$');
polarplot(thetas,abs(P(:,6)).^2,'Color',cmap(4,:),'linewidth',LineW,'MarkerSize',MarkS,'DisplayName','$f = 1.5 f_\textrm{min}$');
polarplot(thetas,abs(P(:,7)).^2,'Color',cmap(3,:),'linewidth',LineW,'MarkerSize',MarkS,'DisplayName','$f = 1.6 f_\textrm{min}$');
polarplot(thetas,abs(P(:,8)).^2,'Color',cmap(2,:),'linewidth',LineW,'MarkerSize',MarkS,'DisplayName','$f = 1.7 f_\textrm{min}$');
polarplot(thetas,abs(P(:,9)).^2,'Color',cmap(1,:),'linewidth',LineW,'MarkerSize',MarkS,'DisplayName','$f = 1.8 f_\textrm{min}$');
grid on; box on;
set(gca,'GridLineStyle',':','GridAlpha',0.5,'LineWidth',1.2);
legend;
set(gca,'ThetaZeroLocation','bottom','TickLabelInterpreter','latex');
set(gca,'ThetaLim',[-90 90]);
if thetaT == -10
    thetaticks([-90,-28.58,0,10,55.66,90]); thetaticklabels({'$-90^\circ$','$-29^\circ$','$0^\circ$','$10^\circ$','$56^\circ$','$90^\circ$'})
elseif thetaT == -50
    thetaticks([-90,-12.42,0,50,90]); thetaticklabels({'$-90^\circ$','$-12^\circ$','$0^\circ$','$50^\circ$','$90^\circ$'})
end
set(gcf, 'Color', [1,1,1]);
set(gca, 'LineWidth',1.5);