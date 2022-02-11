close all
clear all
clc
format
% ===================================================================
% File: step_of_5th_order_system
% Purpose: Uses the matlab function rltool() to study the behavior of
% the system KL(s)/(1+KL(s)) where K is the gain factor.
% Note: This is for HW6 Problem 5.13. rltool gives both the root locus
% and the step response
% ===================================================================
% Parameters
% -------------------------------------------------------------------
% Enter Gain Factor K
K = 34;
% Enter numerator (factored) and denominator (factored) of L(s)
n1 = [1 1];
n2 = [1 0 81];
d1 = [1 0 0];
d2 = [1 13];
d3 = [1 0 100];
% -------------------------------------------------------------------
% Function
% -------------------------------------------------------------------
% Solve
n = conv(n1,n2);
d4 = conv(d1,d2);
d = conv(d3,d4);
L = tf(n,d);
% Display Results
rltool(L)