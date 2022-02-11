close all
clear all
clc
format
% ===================================================================
% File: rlocus_practice.m
% Purpose: Find the root locations that correspond to a compensator
% value of K = 16. The entire system is modeled as KL/(1+KL). Also
% uses step() function to measure rise time, overshoot, and settling
% time. Right click graph -> Characteristics -> Peak Response,
% Settling Time, Rise Time. Then click on dots placed on graph.
% ===================================================================
% Parameters
% -------------------------------------------------------------------
% Enter numerator and denominator of L(s)
n = 1;
d = [1 2 0];
% Enter Compensator Gain K
K = 16;
% -------------------------------------------------------------------
% Function
% -------------------------------------------------------------------
% Solve
L = tf(n,d);
Gol = K*L;
T = feedback(Gol,1);
% Display Results
rlocus(L)
step(T)
