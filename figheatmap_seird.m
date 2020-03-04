% Joshua Weitz
% Coronavirus model code, 2020
% Asymptomatic case heatmap
% MIT Software License
clf

tmppos= [0.2 0.2 0.7 0.7];
tmpa1 = axes('position',tmppos);

set(gcf,'DefaultLineMarkerSize',10);
% set(gcf,'DefaultLineMarkerEdgeColor','k');
% set(gcf,'DefaultLineMarkerFaceColor','w');
set(gcf,'DefaultAxesLineWidth',2);

set(gcf,'PaperPositionMode','auto');
set(gcf,'Position',[271 275 752 676]);

% main data goes here
beta_vec = 0.01:0.01:0.99; % Transmission ratio
z_vec    = logspace(-1,1,100);
p_vec = z_vec./(1+z_vec);  % prob(asymptomatic) ratios
[beta_mat p_mat]=meshgrid(beta_vec,p_vec);
gamma_e=1/2;  % Exposed
gamma_a=1/20; % Asymptomatic
gamma_s=1/10; % Symptomatic
r=1/7;        % Speed

% Odds ratio
qodds = p_mat./(1-p_mat).*beta_mat*(r+gamma_s)/(r+gamma_a);
qval = qodds./(1+qodds);
tmpa=image(beta_vec,p_vec,64*flipud(qval)) 
% yvals = [0.95 0.9:-0.1:0.1 0.05]./(1-[0.9091 0.9:-0.1:0.1 0.01]);
yvals = [0.05 0.1:0.1:0.9 0.95];
set(gca,'ytick',yvals)
yvals = yvals(end:-1:1);
set(gca,'yticklabel',num2str(yvals',3));
%tmpc=colorbar;
%set(tmpc,'ticks',[0:0.1:1]);
hold on
[tmpc,tmph]=contour(beta_vec,p_vec,flipud(qval));
clabel(tmpc,tmph);
set(tmph(1),'color','w','linewidth',2);
axis equal
ylim([min(p_vec) max(p_vec)]);
xlim([0 1]);
     
set(gca,'fontsize',20);

xlabel('Transmission rate, $\beta_a/\beta_s$','fontsize',20,'verticalalignment','top','interpreter','latex');
ylabel('Asymptomatic probability, $p$','fontsize',20,'verticalalignment','bottom','interpreter','latex');
title({'Relevance of asymptomatic cases, $q$';'$T_s=10$ days and $T_a=20$ days'},'fontsize',20,'interpreter','latex')
% 'horizontalalignment','left');

clear tmp*
