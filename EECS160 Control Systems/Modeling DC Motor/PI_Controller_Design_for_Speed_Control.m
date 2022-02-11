close all
clear all
clc
format
% ===================================================================
% File: PI_Controller_Design_for_Speed_Control.m
% Purpose: Verify Overshoot and Rise Time Specifications of Motor
% System. Require Mp = 20% and tr = 0.8s. This was a pre-lab
% assignment: Prelab 4 Q1: PI Controller Design for Speed Control
% ===================================================================
% Parameters
% -------------------------------------------------------------------
% Enter Controller (Op-Amp Configuration) Parameters 
Kp = 0.215;
Ki = 3.04;
% Enter Plant (Motor+Driver) Parameters
C1 = 10;
C2 = 0.6;
% -------------------------------------------------------------------
% Function
% -------------------------------------------------------------------
% Solve
C = tf([Kp Ki],[1 0]);      % Controller Transfer Function
G = tf(C1,[C2 1]);          % Plant Transfer Function
Gol = C*G;                  % Open Loop Gain
T = feedback(Gol,0.1);      % System Transfer Function
% Display Results
disp('The System Transfer Function')
T
step(T)                     % Step Response of System
grid on
disp('Step Response Specifications')
stepinfo(T)                 % Step Response Specifications
