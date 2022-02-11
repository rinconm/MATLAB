close all
clear all
clc
format
% ===================================================================
% Function: Controller_Design_for_Position_Control.m
% Purpose: 
% ===================================================================
% Parameters
% -------------------------------------------------------------------
% Enter Controller (Op-Amp Configuration) Parameters 
Kp = 200;
Ki = 100;
% Enter Plant (Motor+Driver) Parameters
C1 = 10;
C2 = 0.6;
% -------------------------------------------------------------------
% Function
% -------------------------------------------------------------------
% Solve
D = tf([Kp Ki],[1 0]);    % Controller Transfer Function
G1 = tf(C1,[C2 1]);       % Motor+Driver Transfer Function
G2 = tf(0.026,[1 0]);     % Potentiometer Transfer Function
G_ol = D*G1*G2;           % Open-Loop Transfer Function
T = feedback(G_ol,1);  % Closed-Loop (System) Transfer Function
% Display Results
disp('The System Transfer Function')
T
step(T)                     % Step Response of System
grid on
disp('Step Response Specifications')
stepinfo(T)                 % Step Response Specifications