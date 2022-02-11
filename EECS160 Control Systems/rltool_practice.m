close all
clear all
clc
format
% ===================================================================
% File: rltool_practice.m
% Purpose: Uses the matlab function rltool to study the behavior of
% the root locus of 1 + KL(s) where K = 1 and L(s)=b(s)/a(s) for 
% b(s) = (s+a) and a(s) = s(s+1)(s^2+8s+52) as the parameter a is 
% varied from 0 to 10. Also verifies that a multiple root occurs at 
% a complex valus of s for some value of a in this range.
% Note: Prepared for HW 5. The adjustable zero must be added in the
% rltool interface under: Right click -> Edit Compensator -> Add Real
% zero. Make sure C = 1 for K = 1. Pay particular attention between
% a = 2.5 and 3.5.
% ===================================================================
% Parameters
% -------------------------------------------------------------------
% Enter numerator and denominator (in factored form) of L(s)
n = 1;
d1 = [1 0];
d2 = [1 1];
d3 = [1 8 52];
% -------------------------------------------------------------------
% Function
% -------------------------------------------------------------------
% Solve
d4 = conv(d1,d2);
d = conv(d4,d3);
L = tf(n,d)
% Display Results
rltool(L)

