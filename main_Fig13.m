clear; clc;
rng(3);
tic;

% Variable parameters
W = 1.1; % Frequency range width 1.1, 1.2, 1.4, or 1.8

% Fixed parameters
nThetas = 1e3; % Number of Rx angles
thetas = linspace(-pi/2,pi/2,nThetas); % Rx angles [rad]
f_min = 8e9; % Frequency f_min [Hz]
fA = f_min; % Frequency fA [Hz]
c = 299792458; % Speed of light [m/s]
dA = c/fA; % Antenna spacing [m]
d = 10; % Rx distance [m]
N = 64; % Number of antennas
switch W % Number of subcarriers
    case 1.1, S = 128; case 1.2, S = 256; case 1.4, S = 512; case 1.8, S = 1024;
end
freqs = linspace(f_min,W*f_min,S);

% Main loop
gain_w_fix = nan(length(thetas),S);
gain_w_opt = nan(length(thetas),S);
for iTheta = 1:nThetas
    theta = thetas(iTheta);
    for s = 1:S
        freq = freqs(s);
        lambda = c / freq;

        h = lambda / (4*pi*d) * exp(-1i*2*pi*(d - ((1:N) - (N+1)/2) * dA * sin(theta))/lambda);


        gain_w_fix(iTheta,s) = abs(h * ones(N,1) / sqrt(N))^2;
        w_opt = sign(real(h)).' / sqrt(N);
        gain_w_opt(iTheta,s) = abs(h * w_opt)^2;
    end
end

%% Save Data
save(['fig-PR-theta-W',strrep(num2str(W),'.','')], ...
      'W','thetas','f_min','c','d','N','gain_w_fix','gain_w_opt');

%% Plot
gain_w_fix_max = max(gain_w_fix,[],2);
gain_w_opt_max = max(gain_w_opt,[],2);
gain_w_opt_1 = gain_w_opt(:,1);

figure('defaultaxesfontsize',18,'defaulttextinterpreter','latex','defaultAxesTickLabelInterpreter','latex','defaultLegendInterpreter','latex');
LineW = 2.8; MarkS = 8;
hold on;
plot(thetas,1e6*gain_w_opt_1,'-','linewidth',LineW,'MarkerSize',MarkS,'DisplayName','EGT');
plot(thetas,1e6*gain_w_fix_max,'-','linewidth',LineW,'MarkerSize',MarkS,'DisplayName','Movable signals');
plot(thetas,1e6*gain_w_opt_max,'--','linewidth',LineW,'color',[0.4660, 0.6740, 0.1880],'MarkerSize',MarkS,'DisplayName','Movable signals + EGT');
yline(1e6*((c/f_min)/(4*pi*d))^2*N,'-k','linewidth',LineW,'DisplayName','Upper bound');
grid on; box on;
set(gca,'GridLineStyle',':','GridAlpha',0.5,'LineWidth',1.2);
xlim([-pi/2 pi/2])
theta_R = asin(1/W);
xticks([-pi/2,-theta_R,-pi/6,0,pi/6,theta_R,pi/2])
xticklabels({'$-\frac{\pi}{2}$','$-\theta^+$','$-\frac{\pi}{6}$','$0$','$\frac{\pi}{6}$','$\theta^+$','$\frac{\pi}{2}$'})
area([-pi/2 -theta_R],[6 6],'FaceColor',[0.9290, 0.6940, 0.1250],'FaceAlpha',0.15,'HandleVisibility','off');
area([+theta_R +pi/2],[6 6],'FaceColor',[0.9290, 0.6940, 0.1250],'FaceAlpha',0.15,'HandleVisibility','off');
yticks(0:1:6)
xlabel('Receiver direction $\theta$ [rad]');
ylabel('Received power $P_R$ [uW]');
children = get(gca, 'Children');
if W == 1.1
    legend(children(1:end),'location','southwest','fontsize',15);
end
set(gcf, 'Color', [1,1,1]);
set(gca, 'LineWidth',1.5);