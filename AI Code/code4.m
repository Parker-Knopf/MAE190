% Input parameters
F_min_bending = input('Enter minimum bending force (N): ');
F_max_bending = input('Enter maximum bending force (N): ');
F_min_torsion = input('Enter minimum torsional force (N): ');
F_max_torsion = input('Enter maximum torsional force (N): ');
material = input('Enter the material type (ASIS steel): ', 's');

% Material properties (for ASIS steel)
if strcmpi(material, 'ASIS steel')
    Sut = 460; % Ultimate tensile strength (MPa)
    Sy = 260; % Yield strength (MPa)
    k_shoulder = 2.4; % Stress concentration factor (for shoulder fillet)
    k_fillet = 1.5; % Stress concentration factor (for fillet)
    C = 0.85; % Surface condition factor (machined finish)
else
    error('Unsupported material type.');
end

% Shaft dimensions
d1 = input('Enter the shaft diameter (mm): ');
d2 = input('Enter the shoulder diameter (mm): ');
r1 = d1/2; % Shaft radius
r2 = d2/2; % Shoulder radius
r_fillet = input('Enter the fillet radius (mm): ');

% Calculate equivalent bending and torsional stresses
Fe_bending = (F_min_bending + F_max_bending) / 2; % Mean bending force
delta_F_bending = (F_max_bending - F_min_bending) / 2; % Bending force amplitude
Fe_torsion = (F_min_torsion + F_max_torsion) / 2; % Mean torsional force
delta_F_torsion = (F_max_torsion - F_min_torsion) / 2; % Torsional force amplitude
sigma_bending = sqrt((Fe_bending*k_shoulder/r1)^2 + (Fe_bending*k_fillet)^2 + 3*(delta_F_bending/2)^2); % Equivalent bending stress
tau_torsion = sqrt((Fe_torsion*k_shoulder/r1)^2 + (Fe_torsion*k_fillet)^2 + 3*(delta_F_torsion/2)^2); % Equivalent torsional stress

% Calculate equivalent alternating stress and mean stress
sigma_prime = sqrt(sigma_bending^2 + 3*tau_torsion^2); % Equivalent alternating stress
sigma_m = (sigma_bending + 3*tau_torsion)/2; % Mean stress

% Calculate endurance limit
Se_prime = 0.5*Sut/C; % Endurance limit for rotating bending with surface condition factor
if sigma_prime <= Se_prime
    Se = sigma_prime; % Endurance limit for ASME fatigue failure theory
else
    a = 5*(Se_prime/Sut)^2;
    b = -5*(Se_prime/Sut);
    c = 1 - (Se_prime/sigma_prime)^2;
    delta = b^2 - 4*a*c;
    if delta >= 0
        Se = (-b + sqrt(delta))/(2*a); % Endurance limit for DE-ASME fatigue failure theory
    else
        error('Unable to calculate endurance limit with DE-ASME fatigue failure theory.');
    end
end

% Calculate minimum diameter
d_min = (32*sigma_prime*pi)/(pi*Sy^2 - 8*sigma_m*Sy + 6*sqrt(3)*tau_torsion*Sy);

% Display results