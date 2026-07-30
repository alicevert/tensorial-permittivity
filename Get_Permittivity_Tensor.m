% Last Updated: 2026-07-29 by Alice Calvert
% This is a script that simulates the wavelength-dependent dielectric permittivity tensor of a magneto-optically (gyrotropic) 
% anisotropic material across different wavelengths using the Maxwell-Garnett effective medium approximation (EMA).
% See the Tensorial_Permittivity_Simulation file for more details on the inputs.
% The εxx and εxy components of the permittivity tensor are formatted into an excel table. 
% The real and imaginary parts of the effective permittivity, εeff = εxx are plotted.

% ------------------------------------------------------------- %
% ----------------------- Initialization ---------------------- %
% ------------------------------------------------------------- %
close all;
clc
clear 

% ---------------- Define constants & variables --------------- %

filename = input("Enter the name of the excel file:", 's');
lambda = input("Enter the range of wavelengths [m] in the format 'start:step:stop':");

% Parameters of gryotropic nanoparticles

while true
    material = input('Enter the nanoparticle material ("sno2", "fe2o3", or "other"):', 's');
    if strcmpi(material, 'sno2')
        break;
    elseif strcmpi(material, 'fe2o3')
        break;
    elseif strcmpi(material, 'other')
        break;
    else
        fprintf('Invalid input. Please enter "sno2", "fe2o3", or "other".\n\n');
    end
end

b = input("Enter the nanoparticle radius [nm]:");
B = input("Enter the magnitude of the magnetic flux density applied to the sample [T]:");

% ------------------------------------------------------------- %
% --------- Wavelength-dependent permittivity tensor  --------- %
% ------------------------------------------------------------- %

[wavelength,eps_XX_lambda,eps_XY_lambda]=Tensorial_Permittivity_Simulation(b,material,B,lambda);

% --------------------- Format excel table -------------------- %

wavelength_um = wavelength * 1e6;

T = table( ...
    wavelength_um(:), ...
    real(eps_XX_lambda(:)), ...
    wavelength_um(:), ...
    imag(eps_XX_lambda(:)), ...
    real(eps_XY_lambda(:)), ...
    imag(eps_XY_lambda(:)), ...
    'VariableNames', ...
    {'wavelength (um)','eps_XX_real','wl (um)','eps_XX_imag','eps_XY_real','eps_XY_imag'});

writetable(T, sprintf('%s.xlsx', filename));

% --------------- Plot effective permittivity ----------------- %

figure(1)

plot(wavelength_um, real(eps_XX_lambda), 'LineWidth', 2)

xlabel('Wavelength (\mum)')
ylabel('Re(\epsilon_{xx})')
title('Real Effective Dielectric Permittivity')

box on

figure(2)

plot(wavelength_um, imag(eps_XX_lambda),'LineWidth', 2)

xlabel('Wavelength (\mum)')
ylabel('Im(\epsilon_{xx})')
title('Imaginary Effective Dielectric Permittivity')

box on
