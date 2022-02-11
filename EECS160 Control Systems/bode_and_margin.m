close all
clear all
clc
format
% ===================================================================
% File   : gain_and_phase_margin.m
% Purpose: Plots the bode plot and measures the gain/phase margins 
%          (or stability margins) of an open loop system using the
%          margin() function.
%     G(jw) = Ko*[(jw*T1+1)*(jw*T2+1)*...]/[(jw*Ta+1)*(jw*Tb+1)*...]
% Note   : Add compensation in the compensator section. Form:
%          Dc(s) = Kc*(T*s+1)/(a*T*s+1) , Lead: a < 1 or Lag: a > 1
% Lag Tip: Start with T = 1/0.1 for a corner frequency of 0.1 rad/s
%          for the zero term and adjust a depending on specs
% ===================================================================
% Parameters
% -------------------------------------------------------------------
% Enter Plant Gain
Ko = 1400/350;
% Enter numerator and denominator of G(s)
n1 = 1;
d1 = [1/7 1 0];
d2 = [1/50 1];

% Enter Compensator Parameters (For no comensation: Kc = 1 & T = 0)
Kc = 25;
T = 2;
a = 25;
% -------------------------------------------------------------------
% Function
% -------------------------------------------------------------------
% Solve for Plant Transfer Function
n = Ko*n1;
d = conv(d1,d2);
G = tf(n,d);
% Solve for Compensator Transfer Function
nc1 = [T 1];
dc = [a*T 1];
nc = Kc*nc1;
D = tf(nc,dc);
% Total Open Loop Transfer Function
Gol = D*G;

% Display Results
subplot(3,1,1)
margin(G)
subplot(3,1,2)
margin(D)
subplot(3,1,3)
margin(Gol)