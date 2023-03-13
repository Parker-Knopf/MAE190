%% Input parameters
M_b_mean = input("Enter mean bending moment (N.m): ");
M_b_amp = input("Enter bending moment amplitude (N.m): ");
T_mean = input("Enter mean torsional torque (N.m): ");
T_amp = input("Enter torsional torque amplitude (N.m): ");

%% Material bank
materials = ["A36", "A242", "A514", "A572", "A588", "A709", "A992", "A1011", "A1065"];
Sut_values = [400, 485, 760, 450, 485, 690, 450, 345, 450]; % Ultimate strength in MPa
Sy_values = [250, 345, 690, 345, 345, 485, 345, 205, 345]; % Yield strength in MPa
Se_prime_values = [160, 195, 310, 185, 195, 276, 185, 141, 185]; % Endurance limit in MPa

%% Select material
disp("Select a material from the following options:");
disp(materials);
material_index = input("Enter the index of the selected material: ");
Sut = Sut_values(material_index);
Sy = Sy_values(material_index);
Se_prime = Se_prime_values(material_index);

%% Constants
Kf = 1.5; % Size factor
Ka = 0.85; % Surface factor
Kb = 1; % Size Factor
Kc = 1; % Loading factor
Kd = 1; % Temperature factor
Ke = 0.753; % Temperature factor
Kt = 1; % Temperature factor
Kr = 0.814; % Reliability factor
n = 3; % Slope of the S-N curve
C = 0; % Constant in the S-N curve
Fs = 1.5; % Factor of safety

%% Calculation of bending stress range
M_b_min = M_b_mean - M_b_amp/2; % Minimum bending moment
M_b_max = M_b_mean + M_b_amp/2; % Maximum bending moment
D = 0.01:0.01:100; % Range of diameters to check
sigma_b_range = (32*M_b_max./(pi*D.^3)).^2 + (32*M_b_min./(pi*D.^3)).^2; % Range of bending stress
sigma_b = max(sigma_b_range); % Maximum bending stress

%% Calculation of torsional stress range
T_min = T_mean - T_amp/2; % Minimum torque
T_max = T_mean + T_amp/2; % Maximum torque
tau_t_range = (16*T_max./(pi*D.^3)).^2 + (16*T_min./(pi*D.^3)).^2; % Range of torsional stress
tau_t = max(tau_t_range); % Maximum torsional stress

%% Calculation of equivalent alternating stress
sigma_a_prime = sqrt(sigma_b^2 + 3*tau_t^2); % Equivalent alternating stress

%% Calculation of corrected endurance limit
Se = Se_prime*Ka*Kb*Kc*Kd*Ke*Kf*Kt; % Corrected endurance limit
Kd = 0.85; % Surface finish correction factor
Ke = 1; % Reliability correction factor

%% Calculation of fatigue strength reduction factor
q = (sigma_a_prime/(Se/1e6))^n; % Fatigue strength reduction factor
if q <= 1
    q_prime = 1;
else
    q_prime = 1/(q^(1/n));
end

%% Calculation of minimum diameter
d_guess = 1; % Initial guess of diameter in mm
d_old = 0; % Initialize old diameter
while abs(d_guess - d_old) > 0.001 % Loop until convergence
    d_old = d_guess;
    Kb = 1.355*(d_guess^(-0.15)); % Size correction factor
    Se =Se_prime*Ka*Kb*Kc*Kd*Ke*Kf*Kt;
    d_guess = (16*n/pi * (4*(Kf*M_b_amp/Se)^2 + 3*(Kf*T_amp/Se)^2 + 4*(Kf*M_b_mean/Sy)^2 + 4*(Kf*M_b_mean/Sy)^2 + 3*(Kf*T_mean/Sy)^2 )^(1/2) )^(1/3);
end

%% Output results
fprintf('Minimum diameter: %.2f mm\n', d_guess);