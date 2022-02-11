close all
clear all
clc
format
% ===================================================================
% File: lead_compensation.m
% Purpose: Uses the matlab function rltool to design a lead
% compensation D(s)= K*(s+z)/(s+p) to be added in series with the
% plant of G(s)= 1/s^2 so that the dominant poles of the unity 
% feedback closed-loop system are located at s = -2 +- j2.
% Note: Lead compensator added in rltool GUI. Right click Graph -> 
% Edit Compensator -> Right click dynamics -> Add lead
% Answer: K = 2.6698, z = 1, p = 6
% ===================================================================
% Parameters
% -------------------------------------------------------------------
% Enter numerator and denominator (in factored form) of G(s)
n = [1];
d = [1 0 0];
% -------------------------------------------------------------------
% Function
% -------------------------------------------------------------------
% Solve
G = tf(n,d);
% Display Results
rltool(G)

