close all
clear all
clc
format
% ===================================================================
% Function: Modeling_DC_Motor_script.m
% Purpose: This program models a DC Motor by calculating its open-
% and closed- loop transfer functions, calculating pole locations,
% plotting the pole-zero map, and plots the current, torque, and 
% motor speed response with the accompanying simulink models found
% in: Modeling_DC_Motor_simulink.slx
% ===================================================================
% Parameters
% -------------------------------------------------------------------
% Enter
R_a = 0.649;                % Armature resistance [Ohm]
L_a = 528*10^-6;            % Armature inductance [H]
B = (650+16.1)*10^-6;       % Air resistance from shaft and load [N*m/(rad/s)]
J = 8*10^-3+57.8*10^-6;     % Moment of inertia of shaft and load [kg*m^2]
K_t = 0.094;                % Torque coefficient [N*m/A] or [T/A] or [V/w]
K_e = 0.094;                % Back EMF coefficient [V/w]
% -------------------------------------------------------------------
% Function
% -------------------------------------------------------------------
% Solve
G1 = tf(1,[L_a R_a]);       % Electrical Transfer Function [A/V]
G2 = tf(1,[J B]);           % Mechanical Transfer Function [w/T]
G_ol = G1*K_t*G2;           % Open-Loop Gain [w/V]
G_cl = feedback(G_ol,K_e);  % Closed-Loop Gain
p_2  = pole(G2);            % Mechanical Poles
p_ol = pole(G_ol);          % Open-Loop Poles
p_cl = pole(G_cl);          % Closed-Loop Poles
% Display Results
figure(1);
pzmap(G_ol)                 % Pole-Zero map of Open-Loop Gain
figure(2);
pzmap(G_cl)                 % Pole-Zero map of Closed-Loop Gain