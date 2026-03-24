clc; clear; close all;

% Ask the user for input
A_x = input('Enter the amplitude of E_x (V/m): ');
A_y = input('Enter the amplitude of E_y (V/m): ');
phi_x = input('Enter the phase of E_x (degrees): ');
phi_y = input('Enter the phase of E_y (degrees): ');

% Convert degrees to radians and Compute delt 
phi_x = deg2rad(phi_x);
phi_y = deg2rad(phi_y);
delt = phi_y - phi_x;


% Define parameters
f = 1; % Frequency (1 Hz)
omega = 2 * pi * f; % Angular frequency
t = linspace(0, 1, 200); % Time samples over one period


% Compute Ex and Ey components
Ex = A_x * cos(omega * t);
Ey = A_y * cos(omega * t + delt);

% Compute ellipticity angle (χ) and rotation angle (γ)
psi_0 = atan(A_y./A_x);

gamma = (1/2) * atan(tan(2*psi_0) * cos(delt));
chi = (1/2) * asin(sin(2*psi_0) * sin(delt));


if cos(delt) < 0 && gamma > 0
    gamma = gamma - pi./2;
end
if cos(delt) > 0 && gamma < 0
    gamma = gamma + pi./2;
end
% Convert angles to degrees for display
gamma_deg = rad2deg(gamma);
chi_deg = rad2deg(chi);


% Create figure
% Animation loop to trace the polarization path
for i = 1:length(t)
    hold on;
    grid on;
    axis equal;
    xlim([-A_x-0.5, A_x+0.5]);
    ylim([-A_y-0.5, A_y+0.5]);
    xlabel('E_x');
    ylabel('E_y');
    title('Polarization of a Uniform Plane Wave');
    set(gca, 'FontSize', 12);
    
    % Plot the polarization ellipse
    plot(Ex, Ey, 'b', 'LineWidth', 1.5);
    
    % Mark the tip of the E-vector at the current time
    plot(Ex(i), Ey(i), 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');

    pause(0.005); % Adjust speed of animation
end



if (abs(delt) == 0) || (abs(delt) == pi)
    % polarization_type = 'Linear';
    handedness = 'N/A (Linear Polarization has no handedness)';    
elseif (A_x == A_y) && (abs(phi_y - phi_x) == pi/2)
    % polarization_type = 'Circular';
    % Determine Right-Handed (RHCP) or Left-Handed (LHCP)
    if (phi_y - phi_x) == pi/2
        handedness = 'Left-Hand Circular Polarization (LHCP)';
    else
        handedness = 'Right-Hand Circular Polarization (RHCP)';
    end
else
    % polarization_type = 'Elliptical';
    % Determine Right-Handed or Left-Handed
    if (chi_deg) > 0
        handedness = 'Left-Hand Elliptical Polarization';
    else
        handedness = 'Right-Hand Elliptical Polarization';
    end
end



% Display results
disp('--------------------------------------');
disp('Polarization animation completed.');
disp(['Rotation Angle (γ): ', num2str(round(gamma_deg,2)), ' degrees']);
disp(['Ellipticity Angle (χ): ', num2str(round(chi_deg,2)), ' degrees']);
disp(['Handedness: ', handedness]);
disp('--------------------------------------');
