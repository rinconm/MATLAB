close all; % Closes all the previously opened windows
clc; % Clears the Command Window
f = 50;
V_mag = 1; % Input voltage magnitude
V_angle = pi/2; % Input voltage phase angle in radian
V = V_mag*exp(1i*V_angle); % Input voltage in Phasor form
R = 1;
C = 1;
Zc = 1/(1i*2*pi*f*C);
Z = R+Zc;
Vc = (V./Z).*(Zc);
disp('Voltage across Capacitor:');
disp(Vc);