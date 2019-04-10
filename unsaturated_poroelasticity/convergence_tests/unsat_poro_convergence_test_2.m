% Determining the source term expression corresponding to the
% unsaturated Biot equations test #2

syms x     % first cartesian component
syms y     % second cartesian component
syms t     % time 
syms z     % aux
%% Domain length
a = 1;
b = 1;

%% The displacement solution
u = [t*x*(a-x)*y*(b-y), -t*x*(a-x)*y*(b-y)];
p = -t*x*(a-x)*y*(b-y)-1;

%% Constants 

% Elasticity
mu_s = 1;           % [Pa] First Lamé parameter
lambda_s = 1;       % [Pa] Second Lamé parameter

% Rock
n  = 0.5;            % [-] Porosity
K = 1;               % [m^2] Permeability
C_s = 1;             % [1/Pa] Solid compressibility

% Fluid
rho_f = 1;           % [kg/m^3] Density
g = 1;               % [m/s^2] Gravity acceleration
mu_f = 1;            % [Pa s] Viscosity
C_f = 1;             % [1/Pa] Fluid compressibility
    

% Medium
alpha = 1;           % [-] Biot's coefficient

% vanGenuchten
alpha_v = 6;             % [1/m] van Genuchten parameter
a_v = alpha_v/(rho_f*g); % [ms^2/kg] similar to alpha, but more convinient
n_v = 1.5;               % [-] van Genuchten parameter
m_v = 1-(1/n_v);         % [-] van Genuchten parameter
S_r = 0.25;              % [-] Residual saturation

%% Consitutive relationships
S = ((1-S_r)/(1+(a_v*abs(p))^n_v)^m_v) + S_r;
krw = (1 - (a_v*abs(p))^(n_v-1) * (1 + (a_v*abs(p))^n_v)^(-m_v))^2/(1 + (a_v*abs(p))^n_v)^(m_v/2);
C = (-m_v*n_v*(1-S_r)*p*(a_v * abs(p))^n_v)/(abs(p)^2 * ((a_v * abs(p))^n_v + 1)^(m_v+1));

%% Constant terms
chi_p = (alpha-n)*C_s*S^2 + n*C_f*S;
chi_S = (alpha-n)*C_s*S*p + n;

%% Useful data
gradient_u = [diff(u(1),x),diff(u(1),y)
              diff(u(2),x),diff(u(2),y)];
divergence_u = diff(u(1),x) + diff(u(2),y); 
sw_times_p = S * p;

gradient_p = [diff(p,x),diff(p,y)];
gradient_y = [diff(rho_f*g*y,x),diff(rho_f*g*y,y)];
gradient_sw_times_p = [diff(sw_times_p,x),diff(sw_times_p,y)];

%% Mechanical terms

% The strain tensor          
epsilon = 0.5 * (gradient_u + transpose(gradient_u));

% The effective stress
sigma_eff = 2*mu_s*epsilon +lambda_s*divergence_u*eye(2);

% Divergence of the effective stress
div_sigma_eff = [diff(sigma_eff(1,1),x) + diff(sigma_eff(2,1),y),...
                 diff(sigma_eff(1,2),x) + diff(sigma_eff(2,2),y)];

% The momentum equation
momentum_eq = div_sigma_eff - alpha*gradient_sw_times_p;          

%% Flow terms

% Darcy's law
qw = - (K/mu_f) * krw * (gradient_p + gradient_y);

% Divergence of Darcy's velocity
div_qw = diff(qw(1),x) + diff(qw(2),y);

% Time derivative divergence of u
time_deriv_div_u = diff(divergence_u,t);

% Time derivative of pressure
partial_p_partial_t = diff(p,t);

% Time derivative of the saturation
partial_s_partial_t = diff(S,t);

% Mass conservation equation
mass_eq = chi_p * partial_p_partial_t   ...
          + chi_S * partial_s_partial_t ...
          + alpha * S * time_deriv_div_u + div_qw;

%% The source terms
F = transpose(momentum_eq);
f = mass_eq;

%%
G= cartGrid([20,20],[1,1]);
G = computeGeometry(G);
x_cntr = G.cells.centroids(:,1);
y_cntr = G.cells.centroids(:,2);


f_fun = matlabFunction(f);
F_fun = matlabFunction(F);

f_source = f_fun(1,x_cntr,y_cntr);
F_source = F_fun(1,x_cntr,y_cntr);

S_fun = matlabFunction(S);