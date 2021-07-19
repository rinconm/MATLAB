close all
clear all
clc
format short g
syms
% Step response s[n] for a LTI system from 
% Transfer Function H(z)
% Note: H(z) is represented as num(z)/den(z)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Enter the numerator and denominator polynomial
% coefficients of H(z) in descending order
num=[4 1];
den=[1 -1 0.5];
% Define sample range
n=0:20;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Define Transfer function H(z)
Hz=tf(num,den,-1);
% Define s[n]
sn=dstep(num,den,n+1);
sn=sn.';

% Display Results
disp('Transfer function');
Hz
stem(n, sn, 'filled');grid
title('Discrete-time Impulse Response of LTI System')
ylabel('s[n]')
xlabel('n')
disp('              s[n] Table');
disp('            n           s[n]');
[n' sn']