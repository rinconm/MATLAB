close all
clear all
clc

% Arduino Mega 2560 Board

%I/O PINS
Vp=5;               % Voltage Output of I/O Pins in Volts (V)
Ip=0.04;            % Max Current of I/O Pins in Amps (A)
It=0.2;             % Max Current of total I/O pins in Amps (A)
T=0.001;            % Period of I/O Pins in seconds (s)
clockcycle=1/T;     % Refresh Rate of I/O Pins in cycles/second (Hz)

    % Connecting Resistors into I/O Pins
    Vf=3;           % Forward Voltage in Volts (V)
    I=0.02;         % Rated Current
    R=(Vp-Vf)/I;    % Minimum Resistor Needed
    if (Vf)
    display('Resistor Needed:')
    R
    end
    