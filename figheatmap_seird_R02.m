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
gamma_a=1/5;  % Asymptomatic
gamma_s=1/10; % Symptomatic
r=1/7;        % Speed

% Odds ratio
qodds = p_mat./(1-p_mat).*beta_mat*(r+gamma_s)/(r+gamma_a);
qval = qodds./(1+qodds);
% Generating moment
Me_r  = @(r) gamma_e/(gamma_e-r);
MIa_r = @(r) gamma_a/(gamma_a-r);
MIs_r = @(r) gamma_s/(gamma_s-r);
Me_val=Me_r(-r);
MIa_val=MIa_r(-r);
MIs_val=MIs_r(-r);
% R0
Mtot = qval*Me_val*MIa_val+(1-qval)*Me_val*MIs_val;
R0=1./(Mtot);
tmpa=image(beta_vec,p_vec,64*flipud(R0)/5) 
yvals = [0.05 0.1:0.1:0.9 0.95];
set(gca,'ytick',yvals)
yvals = yvals(end:-1:1);
set(gca,'yticklabel',num2str(yvals',3));
hold on
[tmpc,tmph]=contour(beta_vec,p_vec,flipud(R0),[2:0.1:3.2]);
clabel(tmpc,tmph);
set(tmph(1),'color','w','linewidth',2);
tmpc=colorbar;
R0ticks = [1 2 3 4 5];
vticks = R0ticks*64/5;
set(tmpc,'ticks',vticks);
set(tmpc,'ticklabels',{'1';'2';'3';'4';'5'});
axis equal
ylim([min(p_vec) max(p_vec)]);
xlim([0 1]);
     

set(gca,'fontsize',20);


xlabel('Transmission rate, $\beta_a/\beta_s$','fontsize',20,'verticalalignment','top','interpreter','latex');
ylabel('Asymptomatic probability, $p$','fontsize',20,'verticalalignment','bottom','interpreter','latex');
title({'Basic reproduction number ${\cal{R}}_0$';'$T_s=10$ days and $T_a=5$ days'},'fontsize',20,'interpreter','latex')

clear tmp*
